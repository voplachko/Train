//
//  MockData.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 19.09.2026.
//

import Foundation

enum MockData {
    // MARK: - Samples

    static let cities = MockCityRepository().cities()

    static var city: City {
        cities[0]
    }

    static var route: RouteQuery {
        RouteQuery(from: point(cities[0]), to: point(cities[1]))
    }

    static var trips: [Trip] {
        MockTripRepository().trips(for: route)
    }

    // MARK: - Helpers

    private static func point(_ city: City) -> String {
        Strings.RouteSearch.point(city: city.name, station: city.stations[0].name)
    }
}
