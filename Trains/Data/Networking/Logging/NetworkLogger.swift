//
//  NetworkLogger.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 03.10.2026.
//

import Foundation
import HTTPTypes
import OpenAPIRuntime
import os
import Synchronization

struct NetworkLogger: Sendable {
    struct Context: Sendable {
        let id: Int
        let operationID: String
    }

    private enum Limits {
        static let messageBytes = 900
    }

    private static let outputLock = Mutex(())

    // MARK: - Properties

    private let logger: Logger
    private let maxBodyLines: Int

    // MARK: - Init

    init(
        subsystem: String = Bundle.main.bundleIdentifier ?? "Trains",
        category: String = "Network",
        maxBodyLines: Int = 60
    ) {
        self.logger = Logger(subsystem: subsystem, category: category)
        self.maxBodyLines = maxBodyLines
    }

    // MARK: - Events

    func logRequest(_ request: HTTPRequest, baseURL: URL, context: Context) {
        var block = LogBlock(title: Self.title("→ REQUEST", context: context))
        block.addSection(Self.requestLines(request, baseURL: baseURL))

        write(block, level: .info)
    }

    func logResponse(
        _ response: HTTPResponse,
        duration: Duration,
        body: CapturedBody?,
        context: Context
    ) {
        var details = [Self.statusText(response.status), Self.format(duration)]
        if let body {
            details.append(Self.format(bytes: body.totalBytes))
        }

        var block = LogBlock(title: Self.title("← RESPONSE", context: context, details: details))
        if let body, body.totalBytes > 0 {
            block.addSection(bodyLines(body))
        }

        let isSuccessful = response.status.kind == .successful
        write(block, level: isSuccessful ? .info : .error)
    }

    func logFailure(_ error: any Error, duration: Duration, context: Context) {
        let details = [Self.format(duration)]

        guard !Self.isCancellation(error) else {
            write(LogBlock(title: Self.title("⊘ CANCELLED", context: context, details: details)), level: .info)
            return
        }

        var block = LogBlock(title: Self.title("✕ FAILED", context: context, details: details))
        block.addSection([Self.describe(error)])

        write(block, level: .error)
    }

    // MARK: - Body

    private func bodyLines(_ body: CapturedBody) -> [String] {
        let output = BodyFormatter.format(body.prefix, maxLines: maxBodyLines)
        guard output.isTruncated || !body.isComplete else { return output.lines }

        let footer = "… показаны первые \(output.lines.count) строк, всего \(Self.format(bytes: body.totalBytes))"
        return output.lines + ["", footer]
    }

    // MARK: - Output

    private func write(_ block: LogBlock, level: OSLogType) {
        let chunks = Self.split(block.rendered(), maxBytes: Limits.messageBytes)

        Self.outputLock.withLock { _ in
            for chunk in chunks {
                logger.log(level: level, "\(chunk, privacy: .public)")
            }
        }
    }
}

// MARK: - Request

private extension NetworkLogger {
    static func requestLines(_ request: HTTPRequest, baseURL: URL) -> [String] {
        let rawURL = baseURL.absoluteString + (request.path ?? "")

        guard var components = URLComponents(string: rawURL) else {
            return ["\(request.method.rawValue) \(rawURL)"]
        }

        let queryItems = components.queryItems ?? []
        components.query = nil

        let address = components.string ?? rawURL
        return ["\(request.method.rawValue) \(address)"] + queryLines(queryItems)
    }

    static func queryLines(_ items: [URLQueryItem]) -> [String] {
        let nameWidth = items.map(\.name.count).max() ?? 0

        return items.map { item in
            let name = item.name.padding(toLength: nameWidth, withPad: " ", startingAt: 0)
            return "  \(name)   \(item.value ?? "")"
        }
    }
}

// MARK: - Formatting

private extension NetworkLogger {
    static func title(_ event: String, context: Context, details: [String] = []) -> String {
        (["\(event) #\(context.id)", context.operationID] + details).joined(separator: " · ")
    }

    static func format(_ duration: Duration) -> String {
        let milliseconds = duration / .milliseconds(1)
        return "\(Int(milliseconds.rounded())) ms"
    }

    static func format(bytes: Int) -> String {
        Int64(bytes).formatted(.byteCount(style: .memory))
    }

    static func statusText(_ status: HTTPResponse.Status) -> String {
        let phrase = status.reasonPhrase.isEmpty
            ? reasonPhrases[status.code] ?? ""
            : status.reasonPhrase

        return phrase.isEmpty ? "\(status.code)" : "\(status.code) \(phrase)"
    }

    static let reasonPhrases: [Int: String] = [
        200: "OK",
        201: "Created",
        204: "No Content",
        301: "Moved Permanently",
        302: "Found",
        304: "Not Modified",
        400: "Bad Request",
        401: "Unauthorized",
        403: "Forbidden",
        404: "Not Found",
        429: "Too Many Requests",
        500: "Internal Server Error",
        502: "Bad Gateway",
        503: "Service Unavailable",
        504: "Gateway Timeout"
    ]

    static func describe(_ error: any Error) -> String {
        switch error {
        case let clientError as ClientError:
            return describe(clientError.underlyingError)

        case let urlError as URLError:
            return "URLError \(urlError.code.rawValue): \(urlError.localizedDescription)"

        case let decodingError as DecodingError:
            return describe(decodingError)

        default:
            return String(describing: error)
        }
    }

    static func describe(_ error: DecodingError) -> String {
        let context: DecodingError.Context

        switch error {
        case .typeMismatch(_, let errorContext),
             .valueNotFound(_, let errorContext),
             .keyNotFound(_, let errorContext),
             .dataCorrupted(let errorContext):
            context = errorContext

        @unknown default:
            return String(describing: error)
        }

        let path = context.codingPath.map(\.stringValue).joined(separator: ".")
        return "DecodingError at \(path.isEmpty ? "<root>" : path): \(context.debugDescription)"
    }

    static func isCancellation(_ error: any Error) -> Bool {
        switch error {
        case is CancellationError:
            return true
        case let urlError as URLError:
            return urlError.code == .cancelled
        case let clientError as ClientError:
            return isCancellation(clientError.underlyingError)
        default:
            return false
        }
    }
}

// MARK: - Splitting

private extension NetworkLogger {
    static func split(_ text: String, maxBytes: Int) -> [String] {
        var chunks: [String] = []
        var current = ""

        for line in text.split(separator: "\n", omittingEmptySubsequences: false) {
            for piece in splitLine(String(line), maxBytes: maxBytes) {
                if !current.isEmpty, current.utf8.count + piece.utf8.count + 1 > maxBytes {
                    chunks.append(current)
                    current = ""
                }

                current += current.isEmpty ? piece : "\n" + piece
            }
        }

        if !current.isEmpty {
            chunks.append(current)
        }
        return chunks
    }

    static func splitLine(_ line: String, maxBytes: Int) -> [String] {
        guard line.utf8.count > maxBytes else { return [line] }

        var pieces: [String] = []
        var current = ""

        for character in line {
            if current.utf8.count + character.utf8.count > maxBytes {
                pieces.append(current)
                current = ""
            }
            current.append(character)
        }

        if !current.isEmpty {
            pieces.append(current)
        }
        return pieces
    }
}
