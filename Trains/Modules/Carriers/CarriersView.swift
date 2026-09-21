//
//  CarriersView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct CarriersView: View {
    // MARK: - Properties

    @Binding var filters: TripFilters
    let onRefineTime: () -> Void

    @State private var viewModel: CarriersViewModel

    // MARK: - Init

    init(route: RouteQuery, filters: Binding<TripFilters>, onRefineTime: @escaping () -> Void) {
        _filters = filters
        self.onRefineTime = onRefineTime
        _viewModel = State(initialValue: CarriersViewModel(route: route))
    }

    private var trips: [Trip] {
        viewModel.trips(matching: filters)
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: Dimen.x4) {
            Text(viewModel.route.title)
                .font(.bold24)
                .foregroundStyle(Color.appBlack)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, Dimen.x4)

            if trips.isEmpty {
                Spacer()
                EmptyStateView(title: Strings.Carriers.empty)
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
                Strings.Carriers.refineTime,
                showsIndicator: !filters.isEmpty,
                action: onRefineTime
            )
            .padding(.bottom, Dimen.x6)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }

    // MARK: - Subviews

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

// MARK: - Preview

#Preview {
    NavigationStack {
        CarriersView(
            route: MockData.route,
            filters: .constant(TripFilters()),
            onRefineTime: {}
        )
    }
}
