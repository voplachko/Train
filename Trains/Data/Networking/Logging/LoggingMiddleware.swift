//
//  LoggingMiddleware.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 02.10.2026.
//

import Foundation
import HTTPTypes
import OpenAPIRuntime
import Synchronization

struct LoggingMiddleware: ClientMiddleware {
    private static let requestCounter = Atomic<Int>(0)

    // MARK: - Properties

    private let logger: NetworkLogger
    private let bodyCaptureLimit: Int
    private let errorBodyLimit: Int

    // MARK: - Init

    init(
        logger: NetworkLogger = NetworkLogger(),
        bodyCaptureLimit: Int = 64 * 1024,
        errorBodyLimit: Int = 1024 * 1024
    ) {
        self.logger = logger
        self.bodyCaptureLimit = bodyCaptureLimit
        self.errorBodyLimit = errorBodyLimit
    }

    // MARK: - ClientMiddleware

    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: @concurrent @Sendable (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        let id = Self.requestCounter.add(1, ordering: .relaxed).newValue
        let context = NetworkLogger.Context(id: id, operationID: operationID)

        logger.logRequest(request, baseURL: baseURL, context: context)
        let startedAt = ContinuousClock.now

        let result: (HTTPResponse, HTTPBody?)
        do {
            result = try await next(request, body, baseURL)
        } catch {
            logger.logFailure(error, duration: startedAt.duration(to: .now), context: context)
            throw error
        }

        let (response, responseBody) = result
        let duration = startedAt.duration(to: .now)

        guard let responseBody else {
            logger.logResponse(response, duration: duration, body: nil, context: context)
            return (response, nil)
        }

        guard response.status.kind == .successful else {
            let (body, captured) = await readErrorBody(responseBody)
            logger.logResponse(response, duration: duration, body: captured, context: context)
            return (response, body)
        }

        let observedBody = observe(responseBody) { [logger] captured in
            logger.logResponse(response, duration: duration, body: captured, context: context)
        }
        return (response, observedBody)
    }

    // MARK: - Private

    private func observe(
        _ body: HTTPBody,
        onFinish: @escaping @Sendable (CapturedBody) -> Void
    ) -> HTTPBody {
        let sequence = CapturingBodySequence(
            upstream: body,
            captureLimit: bodyCaptureLimit,
            onFinish: onFinish
        )
        return HTTPBody(sequence, length: body.length, iterationBehavior: body.iterationBehavior)
    }

    private func readErrorBody(_ body: HTTPBody) async -> (HTTPBody?, CapturedBody?) {
        guard let data = try? await Data(collecting: body, upTo: errorBodyLimit) else {
            return (nil, nil)
        }
        return (HTTPBody(data), CapturedBody(prefix: data, totalBytes: data.count))
    }
}
