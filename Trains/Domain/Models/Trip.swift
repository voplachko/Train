//
//  Trip.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

struct Trip: Identifiable, Hashable {
    let id: UUID
    let carrier: Carrier
    let date: String
    let departure: String
    let arrival: String
    let durationHours: Int
    let transferCity: String?

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

    var hasTransfer: Bool {
        transferCity != nil
    }

    var departureHour: Int? {
        Int(departure.prefix(2))
    }

    var durationText: String {
        "\(durationHours) \(Self.hoursWord(for: durationHours))"
    }

    var transferText: String? {
        transferCity.map { "С пересадкой в \($0)" }
    }

    private static func hoursWord(for value: Int) -> String {
        if (11...14).contains(value % 100) { return "часов" }

        switch value % 10 {
        case 1: return "час"
        case 2, 3, 4: return "часа"
        default: return "часов"
        }
    }
}
