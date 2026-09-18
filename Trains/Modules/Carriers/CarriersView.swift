//
//  CarriersView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct CarriersView: View {
    @Binding var filters: TripFilters
    let onRefineTime: () -> Void

    @State private var viewModel: CarriersViewModel

    init(route: RouteQuery, filters: Binding<TripFilters>, onRefineTime: @escaping () -> Void) {
        _filters = filters
        self.onRefineTime = onRefineTime
        _viewModel = State(initialValue: CarriersViewModel(route: route))
    }

    private var trips: [Trip] {
        viewModel.trips(matching: filters)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Dimen.x4) {
            Text(viewModel.route.title)
                .font(.bold24)
                .foregroundStyle(Color.appBlack)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, Dimen.x4)

            if trips.isEmpty {
                Spacer()
                EmptyStateView(title: "Вариантов нет")
                Spacer()
            } else {
                tripsList
            }
        }
        .padding(.top, Dimen.x4)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.appWhite)
        .overlay(alignment: .bottom) {
            PrimaryButton.long(
                "Уточнить время",
                showsIndicator: !filters.isEmpty,
                action: onRefineTime
            )
            .padding(.bottom, Dimen.x6)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }

    private var tripsList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: Dimen.x2) {
                ForEach(trips) { trip in
                    TripCard(trip: trip)
                }
            }
            .padding(.horizontal, Dimen.x4)
            .padding(.bottom, Dimen.x24)
        }
    }
}

#Preview {
    NavigationStack {
        CarriersView(
            route: RouteQuery(
                from: "Москва (Ярославский вокзал)",
                to: "Санкт Петербург (Балтийский вокзал)"
            ),
            filters: .constant(TripFilters()),
            onRefineTime: {}
        )
    }
}
