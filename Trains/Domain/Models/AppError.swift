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

    var id: Self { self }

    var title: String {
        switch self {
        case .server: return "Ошибка сервера"
        case .noInternet: return "Нет интернета"
        }
    }

    var image: ImageResource {
        switch self {
        case .server: return .errorServer
        case .noInternet: return .errorNoInternet
        }
    }
}
