//
//  AppError.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

enum AppError: Identifiable, Hashable {
    case server
    case noInternet

    // MARK: - Properties

    var id: Self { self }

    var title: String {
        switch self {
        case .server: return Strings.Errors.server
        case .noInternet: return Strings.Errors.noInternet
        }
    }

    var image: ImageResource {
        switch self {
        case .server: return .errorServer
        case .noInternet: return .errorNoInternet
        }
    }
}
