//
//  SettingsViewModel.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 30.09.2026.
//

import Combine
import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    private enum Constants {
        static let versionKey = "CFBundleShortVersionString"
        static let defaultVersion = "1.0"
    }

    // MARK: - Properties

    let apiNotice = Strings.Settings.apiNotice
    let versionText: String

    // MARK: - Init

    init(bundle: Bundle = .main) {
        let version = bundle.object(forInfoDictionaryKey: Constants.versionKey) as? String
        versionText = Strings.Settings.version(version ?? Constants.defaultVersion)
    }
}
