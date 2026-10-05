//
//  TripMapper.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 25.09.2026.
//

import Foundation

enum TripMapper {
    private enum Constants {
        static let secondsInHour = 3600.0
        static let timeLength = 5
        static let isoDateLength = 10
        static let timeSeparator: Character = "T"
        static let dateSeparator: Character = "-"
    }

    // MARK: - Mapping

    static func trips(from segments: [Components.Schemas.Segment]) -> [Trip] {
        var seenIDs = Set<String>()

        return segments
            .compactMap { segment -> (departure: Date, trip: Trip)? in
                guard let trip = trip(from: segment) else { return nil }
                return (departureDate(of: segment) ?? .distantFuture, trip)
            }
            .sorted { $0.departure < $1.departure }
            .map(\.trip)
            .filter { seenIDs.insert($0.id).inserted }
    }

    // MARK: - Private

    private static func trip(from segment: Components.Schemas.Segment) -> Trip? {
        guard let departure = segment.departure, let arrival = segment.arrival else { return nil }

        let thread = segment.thread ?? segment.details?.lazy.compactMap(\.thread).first
        let id = "\(thread?.uid ?? UUID().uuidString)-\(departure)"
        let carrier = thread?.carrier.flatMap(CarrierMapper.carrier(from:))
            ?? CarrierMapper.unknownCarrier(id: id)

        let hasTransfers = segment.has_transfers ?? false
        let transferCity = hasTransfers
            ? segment.transfers?.compactMap(\.title).first(where: { !$0.isEmpty })
            : nil

        return Trip(
            id: id,
            carrier: carrier,
            date: displayDate(departure: departure, startDate: segment.start_date),
            departure: time(from: departure),
            arrival: time(from: arrival),
            durationHours: hours(from: segment.duration),
            transferCity: transferCity,
            hasTransfer: hasTransfers
        )
    }

    private static func departureDate(of segment: Components.Schemas.Segment) -> Date? {
        guard let departure = segment.departure else { return nil }
        return try? Date(departure, strategy: .iso8601)
    }

    private static func time(from value: String) -> String {
        guard let separator = value.firstIndex(of: Constants.timeSeparator) else {
            return String(value.prefix(Constants.timeLength))
        }

        return String(value[value.index(after: separator)...].prefix(Constants.timeLength))
    }

    private static func displayDate(departure: String, startDate: String?) -> String {
        let isoDate = departure.contains(Constants.timeSeparator)
            ? String(departure.prefix(Constants.isoDateLength))
            : startDate ?? ""

        let parts = isoDate.split(separator: Constants.dateSeparator).compactMap { Int($0) }
        guard parts.count == 3 else { return "" }

        return Strings.Carriers.date(day: parts[2], month: parts[1])
    }

    private static func hours(from seconds: Int?) -> Int {
        guard let seconds, seconds > 0 else { return 0 }
        return max(1, Int((Double(seconds) / Constants.secondsInHour).rounded()))
    }
}
