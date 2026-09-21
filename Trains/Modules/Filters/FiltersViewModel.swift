//
//  FiltersViewModel.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

@Observable
final class FiltersViewModel {
    // MARK: - Properties

    private let appliedFilters: TripFilters

    private(set) var draft: TripFilters

    // MARK: - Init

    init(filters: TripFilters) {
        appliedFilters = filters
        draft = filters
    }

    // MARK: - Output

    var isApplyVisible: Bool {
        !draft.isEmpty || draft != appliedFilters
    }

    func isSelected(_ interval: DepartureInterval) -> Bool {
        draft.intervals.contains(interval)
    }

    // MARK: - Intents

    func toggle(_ interval: DepartureInterval) {
        if draft.intervals.contains(interval) {
            draft.intervals.remove(interval)
        } else {
            draft.intervals.insert(interval)
        }
    }

    func isTransfersSelected(_ value: Bool) -> Bool {
        draft.allowsTransfers == value
    }

    func selectTransfers(_ value: Bool) {
        draft.allowsTransfers = value
    }
}
