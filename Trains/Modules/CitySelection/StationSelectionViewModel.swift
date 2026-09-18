//
//  StationSelectionViewModel.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

@Observable
final class StationSelectionViewModel {
    var query = ""

    private let allStations: [Station]

    init(city: City) {
        allStations = city.stations
    }

    var stations: [Station] {
        guard !query.isEmpty else { return allStations }
        return allStations.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }

    var isEmpty: Bool {
        stations.isEmpty
    }
}
