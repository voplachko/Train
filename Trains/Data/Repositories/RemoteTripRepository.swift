//
//  RemoteTripRepository.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 26.09.2026.
//

import Foundation

struct RemoteTripRepository: TripRepository {
    // MARK: - Properties

    private let client: any NetworkClientProtocol
    private let calendar: Calendar

    // MARK: - Init

    init(client: any NetworkClientProtocol, calendar: Calendar = .current) {
        self.client = client
        self.calendar = calendar
    }

    // MARK: - TripRepository

    func trips(for route: RouteQuery) async throws -> [Trip] {
        let today = Date()
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today) ?? today

        async let todaySegments = segments(for: route, on: today)
        async let tomorrowSegments = segments(for: route, on: tomorrow)

        let segments = try await todaySegments + tomorrowSegments
        return TripMapper.trips(from: segments)
    }

    // MARK: - Private

    private func segments(for route: RouteQuery, on date: Date) async throws -> [Components.Schemas.Segment] {
        let response = try await client.scheduleBetweenStations(
            from: route.from.stationCode,
            to: route.to.stationCode,
            date: apiDate(from: date),
            transfers: true
        )
        return response.segments ?? []
    }

    private func apiDate(from date: Date) -> String {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return String(
            format: "%04d-%02d-%02d",
            components.year ?? 0,
            components.month ?? 0,
            components.day ?? 0
        )
    }
}
