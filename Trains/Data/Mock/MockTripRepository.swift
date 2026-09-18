//
//  MockTripRepository.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

struct MockTripRepository: TripRepository {
    func trips(for route: RouteQuery) -> [Trip] {
        [
            Trip(
                carrier: Carrier(name: "РЖД"),
                date: "14 января",
                departure: "22:30",
                arrival: "08:15",
                durationHours: 20,
                transferCity: "Костроме"
            ),
            Trip(
                carrier: Carrier(name: "ФГК"),
                date: "15 января",
                departure: "01:15",
                arrival: "09:00",
                durationHours: 9
            ),
            Trip(
                carrier: Carrier(name: "Урал логистика"),
                date: "16 января",
                departure: "12:30",
                arrival: "21:00",
                durationHours: 9
            ),
            Trip(
                carrier: Carrier(name: "РЖД"),
                date: "17 января",
                departure: "22:30",
                arrival: "08:15",
                durationHours: 20,
                transferCity: "Костроме"
            ),
            Trip(
                carrier: Carrier(name: "РЖД"),
                date: "17 января",
                departure: "22:30",
                arrival: "08:15",
                durationHours: 20,
                transferCity: "Костроме"
            )
        ]
    }
}
