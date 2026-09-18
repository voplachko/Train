//
//  ScheduleFlowView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct ScheduleFlowView: View {
    @State private var viewModel: ScheduleFlowViewModel

    init(viewModel: ScheduleFlowViewModel = ScheduleFlowViewModel()) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack(path: $viewModel.path) {
            RouteSearchView(viewModel: viewModel)
                .navigationDestination(for: ScheduleRoute.self) { route in
                    destination(for: route)
                }
        }
    }

    @ViewBuilder
    private func destination(for route: ScheduleRoute) -> some View {
        switch route {
        case .citySelection(let field):
            CitySelectionView { city in
                viewModel.selectCity(city, for: field)
            }

        case .stationSelection(let field, let city):
            StationSelectionView(city: city) { station in
                viewModel.selectStation(station, in: city, for: field)
            }

        case .carriers(let route):
            CarriersView(route: route, filters: $viewModel.filters, onRefineTime: viewModel.refineTime)

        case .filters:
            FiltersView(applied: $viewModel.filters)
        }
    }
}

#Preview {
    ScheduleFlowView()
}
