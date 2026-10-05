//
//  StationSelectionViewModel.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Combine
import Foundation

@MainActor
final class StationSelectionViewModel: ObservableObject {
    // MARK: - Properties

    @Published var query = ""

    private let allStations: [Station]

    // MARK: - Init

    init(city: City) {
        allStations = city.stations
    }

    // MARK: - Output

    var stations: [Station] {
        allStations.filtered(byName: query)
    }

    var isEmpty: Bool {
        stations.isEmpty
    }
}
