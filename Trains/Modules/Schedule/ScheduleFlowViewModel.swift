//
//  ScheduleFlowViewModel.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Combine
import Foundation

@MainActor
final class ScheduleFlowViewModel: ObservableObject {
    // MARK: - Properties

    @Published var path: [ScheduleRoute] = []
    @Published var filters = TripFilters()

    @Published private(set) var from: RoutePoint?
    @Published private(set) var to: RoutePoint?

    // MARK: - Init

    init(from: RoutePoint? = nil, to: RoutePoint? = nil) {
        self.from = from
        self.to = to
    }

    // MARK: - Output

    var fromTitle: String {
        from?.title ?? ""
    }

    var toTitle: String {
        to?.title ?? ""
    }

    var isRouteFilled: Bool {
        from != nil && to != nil
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
        let point = RoutePoint(city: city.name, station: station.name, stationCode: station.id)

        switch field {
        case .from: from = point
        case .to: to = point
        }

        path.removeAll()
    }

    func search() {
        guard let from, let to else { return }
        path.append(.carriers(RouteQuery(from: from, to: to)))
    }

    func refineTime() {
        path.append(.filters)
    }

    func showCarrierDetails(_ carrier: Carrier) {
        path.append(.carrierDetails(carrier))
    }
}
