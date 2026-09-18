//
//  City.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

struct City: Identifiable, Hashable {
    let id: UUID
    let name: String
    let stations: [Station]

    init(id: UUID = UUID(), name: String, stations: [Station]) {
        self.id = id
        self.name = name
        self.stations = stations
    }
}
