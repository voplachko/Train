//
//  ThemeStore.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import SwiftUI

@Observable
final class ThemeStore {
    private enum Key {
        static let isDarkTheme = "isDarkTheme"
    }

    // MARK: - Properties

    private let defaults: UserDefaults

    var isDarkTheme: Bool {
        didSet {
            guard isDarkTheme != oldValue else { return }
            defaults.set(isDarkTheme, forKey: Key.isDarkTheme)
        }
    }

    // MARK: - Init

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.isDarkTheme = defaults.bool(forKey: Key.isDarkTheme)
    }

    // MARK: - Output

    var colorScheme: ColorScheme {
        isDarkTheme ? .dark : .light
    }
}
