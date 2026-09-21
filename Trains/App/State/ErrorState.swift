//
//  ErrorState.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

@Observable
final class ErrorState {
    // MARK: - Properties

    private(set) var current: AppError?

    // MARK: - Methods

    func show(_ error: AppError) {
        current = error
    }

    func clear() {
        current = nil
    }
}
