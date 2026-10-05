//
//  LoadingState.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 28.09.2026.
//

import Foundation

enum LoadingState: Equatable, Sendable {
    case idle
    case loading
    case loaded
    case failed(AppError)

    // MARK: - Output

    var isLoading: Bool {
        self == .loading
    }

    var isLoaded: Bool {
        self == .loaded
    }

    var error: AppError? {
        guard case .failed(let error) = self else { return nil }
        return error
    }

    var needsLoading: Bool {
        switch self {
        case .idle, .failed: return true
        case .loading, .loaded: return false
        }
    }
}
