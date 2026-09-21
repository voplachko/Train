//
//  Trip.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

struct Trip: Identifiable, Hashable {
    // MARK: - Properties

    let id: UUID
    let carrier: Carrier
    let date: String
    let departure: String
    let arrival: String
    let durationHours: Int
    let transferCity: String?

    // MARK: - Init

    init(
        id: UUID = UUID(),
        carrier: Carrier,
        date: String,
        departure: String,
        arrival: String,
        durationHours: Int,
        transferCity: String? = nil
    ) {
        self.id = id
        self.carrier = carrier
        self.date = date
        self.departure = departure
        self.arrival = arrival
        self.durationHours = durationHours
        self.transferCity = transferCity
    }

    // MARK: - Presentation

    var hasTransfer: Bool {
        transferCity != nil
    }

    var departureHour: Int? {
        Int(departure.prefix(2))
    }

    var durationText: String {
        Strings.Carriers.duration(hours: durationHours)
    }

    var transferText: String? {
        transferCity.map(Strings.Carriers.transfer(city:))
    }
}
