//
//  CitySelectionViewModel.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

@Observable
final class CitySelectionViewModel {
    var query = ""

    private let allCities: [City]

    init(repository: CityRepository = MockCityRepository()) {
        allCities = repository.cities()
    }

    var cities: [City] {
        guard !query.isEmpty else { return allCities }
        return allCities.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }

    var isEmpty: Bool {
        cities.isEmpty
    }
}
