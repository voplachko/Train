//
//  AuthMiddleware.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 08.09.2026.
//

import Foundation
import HTTPTypes
import OpenAPIRuntime

nonisolated struct AuthMiddleware: ClientMiddleware {
    private let apikey: String

    init(apikey: String) {
        self.apikey = apikey
    }

    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: @concurrent @Sendable (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        request.headerFields[.authorization] = apikey
        return try await next(request, body, baseURL)
    }
}
