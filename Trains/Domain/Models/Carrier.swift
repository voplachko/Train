//
//  Carrier.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

struct Carrier: Identifiable, Hashable, Sendable {
    // MARK: - Properties

    let id: String
    let code: Int?
    let name: String
    let logoURL: URL?
    let email: String
    let phone: String

    // MARK: - Init

    init(
        id: String = UUID().uuidString,
        code: Int? = nil,
        name: String,
        logoURL: URL? = nil,
        email: String = "",
        phone: String = ""
    ) {
        self.id = id
        self.code = code
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

    // MARK: - Updating

    func updated(with other: Carrier) -> Carrier {
        Carrier(
            id: id,
            code: code ?? other.code,
            name: other.name.isEmpty ? name : other.name,
            logoURL: other.logoURL ?? logoURL,
            email: other.hasEmail ? other.email : email,
            phone: other.hasPhone ? other.phone : phone
        )
    }
}
