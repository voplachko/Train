//
//  MockData.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 19.09.2026.
//

import Foundation

enum MockData {
    // MARK: - Samples

    static let cities = MockCityRepository.sample
    static let stories = MockStoryRepository().stories()

    static var city: City? {
        cities.first
    }

    static var route: RouteQuery {
        RouteQuery(from: point(cities.first), to: point(cities.dropFirst().first))
    }

    static var trips: [Trip] {
        MockTripRepository.sample
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

    static func point(_ city: City?) -> RoutePoint {
        guard let city, let station = city.stations.first else {
            return RoutePoint(city: "", station: "", stationCode: "")
        }

        return RoutePoint(city: city.name, station: station.name, stationCode: station.id)
    }
}
