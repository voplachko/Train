//
//  CarriersViewModel.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Combine
import Foundation

@MainActor
final class CarriersViewModel: ObservableObject {
    // MARK: - Properties

    let route: RouteQuery

    @Published private(set) var state: LoadingState = .idle
    @Published private(set) var reloadToken = 0
    @Published private var allTrips: [Trip] = []

    private let repository: any TripRepository

    // MARK: - Init

    init(route: RouteQuery, repository: any TripRepository = AppDependencies.tripRepository) {
        self.route = route
        self.repository = repository
    }

    // MARK: - Output

    func trips(matching filters: TripFilters) -> [Trip] {
        allTrips.filter(filters.matches)
    }

    // MARK: - Intents

    func loadTrips() async {
        guard state.needsLoading else { return }

        state = .loading
        do {
            allTrips = try await repository.trips(for: route)
            state = .loaded
        } catch {
            if AppErrorMapper.isCancellation(error) {
                state = .idle
                return
            }
            state = .failed(await AppErrorMapper.map(error))
        }
    }

    func retry() {
        guard state.error != nil else { return }
        reloadToken += 1
    }
}
