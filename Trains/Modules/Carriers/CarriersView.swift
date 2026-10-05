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
    let onSelectCarrier: (Carrier) -> Void

    @StateObject private var viewModel: CarriersViewModel

    // MARK: - Init

    init(
        route: RouteQuery,
        repository: any TripRepository = AppDependencies.tripRepository,
        filters: Binding<TripFilters>,
        onRefineTime: @escaping () -> Void,
        onSelectCarrier: @escaping (Carrier) -> Void
    ) {
        _filters = filters
        self.onRefineTime = onRefineTime
        self.onSelectCarrier = onSelectCarrier
        _viewModel = StateObject(wrappedValue: CarriersViewModel(route: route, repository: repository))
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

            content
        }
        .padding(.top, Dimen.x4)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.appWhite)
        .overlay(alignment: .bottom) {
            if viewModel.state.isLoaded {
                PrimaryButton.long(
                    Strings.Carriers.refineTime,
                    showsIndicator: !filters.isEmpty,
                    action: onRefineTime
                )
                .padding(.bottom, Dimen.x6)
            }
        }
        .errorOverlay(viewModel.state.error, onTap: viewModel.retry)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .task(id: viewModel.reloadToken) {
            await viewModel.loadTrips()
        }
    }

    // MARK: - Subviews

    @ViewBuilder
    private var content: some View {
        if viewModel.state.isLoading {
            Spacer()
            ProgressView()
                .tint(Color.appBlack)
                .frame(maxWidth: .infinity)
            Spacer()
        } else if viewModel.state.isLoaded && trips.isEmpty {
            Spacer()
            EmptyStateView(title: Strings.Carriers.empty)
            Spacer()
        } else {
            tripsList
        }
    }

    private var tripsList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: Dimen.x2) {
                ForEach(trips) { trip in
                    Button {
                        onSelectCarrier(trip.carrier)
                    } label: {
                        TripCard(trip: trip)
                    }
                    .buttonStyle(.plain)
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
            repository: MockTripRepository(),
            filters: .constant(TripFilters()),
            onRefineTime: {},
            onSelectCarrier: { _ in }
        )
    }
}
