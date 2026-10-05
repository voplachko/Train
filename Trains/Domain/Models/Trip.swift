//
//  Trip.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

struct Trip: Identifiable, Hashable, Sendable {
    // MARK: - Properties

    let id: String
    let carrier: Carrier
    let date: String
    let departure: String
    let arrival: String
    let durationHours: Int
    let transferCity: String?
    let hasTransfer: Bool

    // MARK: - Init

    init(
        id: String = UUID().uuidString,
        carrier: Carrier,
        date: String,
        departure: String,
        arrival: String,
        durationHours: Int,
        transferCity: String? = nil,
        hasTransfer: Bool? = nil
    ) {
        self.id = id
        self.carrier = carrier
        self.date = date
        self.departure = departure
        self.arrival = arrival
        self.durationHours = durationHours
        self.transferCity = transferCity
        self.hasTransfer = hasTransfer ?? (transferCity != nil)
    }

    // MARK: - Presentation

    var departureHour: Int? {
        Int(departure.prefix(2))
    }

    var durationText: String {
        Strings.Carriers.duration(hours: durationHours)
    }

    var transferText: String? {
        guard hasTransfer else { return nil }
        return transferCity.map(Strings.Carriers.transfer(city:)) ?? Strings.Carriers.withTransfer
    }
}
