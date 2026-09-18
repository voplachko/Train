//
//  ScheduleFlowViewModel.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

@Observable
final class ScheduleFlowViewModel {
    var path: [ScheduleRoute] = []
    var filters = TripFilters()

    private(set) var from: String
    private(set) var to: String

    init(from: String = "", to: String = "") {
        self.from = from
        self.to = to
    }

    var isRouteFilled: Bool {
        !from.isEmpty && !to.isEmpty
    }

    func swapRoute() {
        let departure = from
        from = to
        to = departure
    }

    func selectPoint(for field: RouteField) {
        path.append(.citySelection(field: field))
    }

    func selectCity(_ city: City, for field: RouteField) {
        path.append(.stationSelection(field: field, city: city))
    }

    func selectStation(_ station: Station, in city: City, for field: RouteField) {
        let point = "\(city.name) (\(station.name))"

        switch field {
        case .from: from = point
        case .to: to = point
        }

        path.removeAll()
    }

    func search() {
        guard isRouteFilled else { return }
        path.append(.carriers(RouteQuery(from: from, to: to)))
    }

    func refineTime() {
        path.append(.filters)
    }
}
