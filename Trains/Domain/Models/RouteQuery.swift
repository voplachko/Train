//
//  RouteQuery.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

struct RoutePoint: Hashable, Sendable {
    let city: String
    let station: String
    let stationCode: String

    var title: String {
        Strings.RouteSearch.point(city: city, station: station)
    }
}

struct RouteQuery: Hashable, Sendable {
    let from: RoutePoint
    let to: RoutePoint

    var title: String {
        Strings.Carriers.route(from: from.title, to: to.title)
    }
}
