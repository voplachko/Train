//
//  ScheduleFlowViewModel.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

@Observable
final class ScheduleFlowViewModel {
    // MARK: - Properties

    var path: [ScheduleRoute] = []
    var filters = TripFilters()

    private(set) var from: String
    private(set) var to: String

    // MARK: - Init

    init(from: String = "", to: String = "") {
        self.from = from
        self.to = to
    }

    // MARK: - Output

    var isRouteFilled: Bool {
        !from.isEmpty && !to.isEmpty
    }

    // MARK: - Intents

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
        let point = Strings.RouteSearch.point(city: city.name, station: station.name)

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
