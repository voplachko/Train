//
//  Carrier.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

struct Carrier: Identifiable, Hashable {
    let id: UUID
    let name: String
    let logoURL: URL?

    init(id: UUID = UUID(), name: String, logoURL: URL? = nil) {
        self.id = id
        self.name = name
        self.logoURL = logoURL
    }
}
