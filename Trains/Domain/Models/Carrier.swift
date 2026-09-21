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

    // MARK: - Init

    init(id: UUID = UUID(), name: String, logoURL: URL? = nil) {
        self.id = id
        self.name = name
        self.logoURL = logoURL
    }
}
