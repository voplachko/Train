//
//  TripFilters.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

struct TripFilters: Equatable {
    // MARK: - Properties

    var intervals: Set<DepartureInterval>
    var allowsTransfers: Bool?

    // MARK: - Init

    init(intervals: Set<DepartureInterval> = [], allowsTransfers: Bool? = nil) {
        self.intervals = intervals
        self.allowsTransfers = allowsTransfers
    }

    // MARK: - Filtering

    var isEmpty: Bool {
        intervals.isEmpty && allowsTransfers == nil
    }

    func matches(_ trip: Trip) -> Bool {
        if allowsTransfers == false, trip.hasTransfer {
            return false
        }

        guard !intervals.isEmpty else { return true }
        guard let hour = trip.departureHour else { return true }

        return intervals.contains { $0.contains(hour: hour) }
    }
}
