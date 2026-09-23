//
//  Carrier.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

struct Carrier: Identifiable, Hashable {
    // MARK: - Properties

    let id: UUID
    let name: String
    let logoURL: URL?
    let email: String
    let phone: String

    // MARK: - Init

    init(
        id: UUID = UUID(),
        name: String,
        logoURL: URL? = nil,
        email: String = "",
        phone: String = ""
    ) {
        self.id = id
        self.name = name
        self.logoURL = logoURL
        self.email = email
        self.phone = phone
    }

    // MARK: - Presentation

    var hasEmail: Bool {
        !email.isEmpty
    }

    var hasPhone: Bool {
        !phone.isEmpty
    }
}
