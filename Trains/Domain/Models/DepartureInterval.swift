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

    var id: Self { self }

    var title: String {
        switch self {
        case .morning: return "Утро 06:00 - 12:00"
        case .day: return "День 12:00 - 18:00"
        case .evening: return "Вечер 18:00 - 00:00"
        case .night: return "Ночь 00:00 - 06:00"
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

    func contains(hour: Int) -> Bool {
        hours.contains(hour)
    }
}
