//
//  AppLinks.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import Foundation

enum AppLinks {
    // MARK: - External

    static let userAgreement = URL(string: "https://yandex.ru/legal/practicum_offer/")

    // MARK: - Contacts

    static func mail(_ address: String) -> URL? {
        URL(string: "mailto:\(address)")
    }

    static func phone(_ number: String) -> URL? {
        let digits = number.filter { $0.isNumber || $0 == "+" }
        return URL(string: "tel:\(digits)")
    }
}
