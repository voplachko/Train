//
//  DepartureInterval.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

enum DepartureInterval: CaseIterable, Identifiable, Hashable {
    case morning
    case day
    case evening
    case night

    // MARK: - Properties

    var id: Self { self }

    var title: String {
        switch self {
        case .morning: return Strings.Filters.morning
        case .day: return Strings.Filters.day
        case .evening: return Strings.Filters.evening
        case .night: return Strings.Filters.night
        }
    }

    var hours: Range<Int> {
        switch self {
        case .morning: return 6..<12
        case .day: return 12..<18
        case .evening: return 18..<24
        case .night: return 0..<6
        }
    }

    // MARK: - Methods

    func contains(hour: Int) -> Bool {
        hours.contains(hour)
    }
}
