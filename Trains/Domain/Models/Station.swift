//
//  Station.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

struct Station: Identifiable, Hashable, Sendable {
    // MARK: - Properties

    let id: String
    let name: String

    // MARK: - Init

    init(id: String = UUID().uuidString, name: String) {
        self.id = id
        self.name = name
    }
}
