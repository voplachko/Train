//
//  ScheduleRoute.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

enum RouteField: Hashable {
    case from
    case to
}

enum ScheduleRoute: Hashable {
    case citySelection(field: RouteField)
    case stationSelection(field: RouteField, city: City)
    case carriers(RouteQuery)
    case filters
}
