//
//  MockTripRepository.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

struct MockTripRepository: TripRepository {
    // MARK: - Carriers

    private enum Carriers {
        static let rzd = Carrier(
            name: "ОАО «РЖД»",
            email: "i.lozgkina@yandex.ru",
            phone: "+7 (904) 329-27-71"
        )

        static let fgk = Carrier(
            name: "ФГК",
            email: "info@fgk.ru",
            phone: "+7 (495) 380-15-70"
        )

        static let uralLogistics = Carrier(
            name: "Урал логистика",
            email: "info@ural-logistika.ru",
            phone: "+7 (343) 216-41-00"
        )
    }

    // MARK: - TripRepository

    func trips(for route: RouteQuery) -> [Trip] {
        [
            Trip(
                carrier: Carriers.rzd,
                date: "14 января",
                departure: "22:30",
                arrival: "08:15",
                durationHours: 20,
                transferCity: "Костроме"
            ),
            Trip(
                carrier: Carriers.fgk,
                date: "15 января",
                departure: "01:15",
                arrival: "09:00",
                durationHours: 9
            ),
            Trip(
                carrier: Carriers.uralLogistics,
                date: "16 января",
                departure: "12:30",
                arrival: "21:00",
                durationHours: 9
            ),
            Trip(
                carrier: Carriers.rzd,
                date: "17 января",
                departure: "22:30",
                arrival: "08:15",
                durationHours: 20,
                transferCity: "Костроме"
            ),
            Trip(
                carrier: Carriers.rzd,
                date: "17 января",
                departure: "22:30",
                arrival: "08:15",
                durationHours: 20,
                transferCity: "Костроме"
            )
        ]
    }
}
