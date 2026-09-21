//
//  Station.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

struct Station: Identifiable, Hashable {
    // MARK: - Properties

    let id: UUID
    let name: String

    // MARK: - Init

    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
