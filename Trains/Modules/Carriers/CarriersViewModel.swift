//
//  CarriersViewModel.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

@Observable
final class CarriersViewModel {
    let route: RouteQuery

    private let allTrips: [Trip]

    init(route: RouteQuery, repository: TripRepository = MockTripRepository()) {
        self.route = route
        allTrips = repository.trips(for: route)
    }

    func trips(matching filters: TripFilters) -> [Trip] {
        allTrips.filter(filters.matches)
    }
}
