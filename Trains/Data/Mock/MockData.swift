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
    static let stories = MockStoryRepository().stories()

    static var city: City? {
        cities.first
    }

    static var route: RouteQuery {
        RouteQuery(from: point(cities.first), to: point(cities.dropFirst().first))
    }

    static var trips: [Trip] {
        MockTripRepository().trips(for: route)
    }

    static var carrier: Carrier? {
        trips.first?.carrier
    }

    static var story: Story? {
        stories.first
    }

    static var viewedStory: Story? {
        guard var story = stories.dropFirst().first else { return nil }

        story.isViewed = true
        return story
    }

    // MARK: - Helpers

    private static func point(_ city: City?) -> String {
        guard let city, let station = city.stations.first else { return "" }

        return Strings.RouteSearch.point(city: city.name, station: station.name)
    }
}
