//
//  City.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

struct City: Identifiable, Hashable, Sendable {
    // MARK: - Properties

    let id: String
    let name: String
    let stations: [Station]

    // MARK: - Init

    init(id: String = UUID().uuidString, name: String, stations: [Station]) {
        self.id = id
        self.name = name
        self.stations = stations
    }
}
