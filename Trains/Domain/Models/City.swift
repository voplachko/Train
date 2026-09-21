//
//  City.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

struct City: Identifiable, Hashable {
    // MARK: - Properties

    let id: UUID
    let name: String
    let stations: [Station]

    // MARK: - Init

    init(id: UUID = UUID(), name: String, stations: [Station]) {
        self.id = id
        self.name = name
        self.stations = stations
    }
}
