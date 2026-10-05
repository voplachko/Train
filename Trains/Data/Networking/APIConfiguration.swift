//
//  APIConfiguration.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 08.09.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

enum APIConfiguration {
    static let apiKey = "7959d37d-4493-4711-8020-6e8a32fa5543"

    static func makeClient() throws -> Client {
        Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport(),
            middlewares: middlewares
        )
    }

    // MARK: - Private

    private static var middlewares: [any ClientMiddleware] {
        var middlewares: [any ClientMiddleware] = [AuthMiddleware(apikey: apiKey)]

        #if DEBUG
        middlewares.append(LoggingMiddleware())
        #endif

        return middlewares
    }
}
