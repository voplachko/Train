//
//  AppErrorMapper.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 27.09.2026.
//

import Foundation
import OpenAPIRuntime

enum AppErrorMapper {
    private static let connectionErrorCodes: Set<URLError.Code> = [
        .notConnectedToInternet,
        .networkConnectionLost,
        .dataNotAllowed,
        .internationalRoamingOff,
        .cannotFindHost,
        .cannotConnectToHost,
        .timedOut
    ]

    // MARK: - Mapping

    static func map(_ error: any Error) async -> AppError {
        if let code = urlErrorCode(from: error), connectionErrorCodes.contains(code) {
            return .noInternet
        }

        return await NetworkReachability.isConnected() ? .server : .noInternet
    }

    static func isCancellation(_ error: any Error) -> Bool {
        error is CancellationError || urlErrorCode(from: error) == .cancelled
    }

    // MARK: - Private

    private static func urlErrorCode(from error: any Error) -> URLError.Code? {
        if let urlError = error as? URLError {
            return urlError.code
        }

        if let clientError = error as? ClientError {
            return urlErrorCode(from: clientError.underlyingError)
        }

        return nil
    }
}
