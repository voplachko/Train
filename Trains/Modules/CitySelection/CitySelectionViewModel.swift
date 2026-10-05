//
//  CitySelectionViewModel.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Combine
import Foundation

@MainActor
final class CitySelectionViewModel: ObservableObject {
    // MARK: - Properties

    @Published var query = ""
    @Published private(set) var state: LoadingState = .idle
    @Published private(set) var reloadToken = 0
    @Published private var allCities: [City] = []

    private let repository: any CityRepository

    // MARK: - Init

    init(repository: any CityRepository = AppDependencies.cityRepository) {
        self.repository = repository
    }

    // MARK: - Output

    var cities: [City] {
        allCities.filtered(byName: query)
    }

    var isEmpty: Bool {
        state.isLoaded && cities.isEmpty
    }

    // MARK: - Intents

    func loadCities() async {
        guard state.needsLoading else { return }

        state = .loading
        do {
            allCities = try await repository.cities()
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
