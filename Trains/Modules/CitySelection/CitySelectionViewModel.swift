//
//  CitySelectionViewModel.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

@Observable
final class CitySelectionViewModel {
    // MARK: - Properties

    var query = ""

    private let allCities: [City]

    // MARK: - Init

    init(repository: CityRepository = MockCityRepository()) {
        allCities = repository.cities()
    }

    // MARK: - Output

    var cities: [City] {
        allCities.filtered(byName: query)
    }

    var isEmpty: Bool {
        cities.isEmpty
    }
}
