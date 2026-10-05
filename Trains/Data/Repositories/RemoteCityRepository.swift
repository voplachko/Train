//
//  RemoteCityRepository.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 24.09.2026.
//

import Foundation

actor RemoteCityRepository: CityRepository {
    private enum Constants {
        static let trainTransportType = "train"
    }

    // MARK: - Properties

    private let client: any NetworkClientProtocol

    private var cachedCities: [City]?
    private var loadingTask: Task<[City], any Error>?

    // MARK: - Init

    init(client: any NetworkClientProtocol) {
        self.client = client
    }

    // MARK: - CityRepository

    func cities() async throws -> [City] {
        if let cachedCities {
            return cachedCities
        }

        if let loadingTask {
            return try await loadingTask.value
        }

        let task = Task { try await loadCities() }
        loadingTask = task

        do {
            let cities = try await task.value
            cachedCities = cities
            loadingTask = nil
            return cities
        } catch {
            loadingTask = nil
            throw error
        }
    }

    // MARK: - Loading

    private func loadCities() async throws -> [City] {
        let directory = try await client.allStations()
        let countries = directory.countries ?? []

        let cities = await withTaskGroup(of: [City].self) { group in
            for country in countries {
                group.addTask { Self.makeCities(from: country) }
            }

            var result: [City] = []
            for await countryCities in group {
                result.append(contentsOf: countryCities)
            }
            return result
        }

        var seenIDs = Set<String>()
        return cities
            .filter { seenIDs.insert($0.id).inserted }
            .sorted(by: Self.isOrderedBefore)
    }

    // MARK: - Mapping

    private static func makeCities(from country: StationsDirectory.Country) -> [City] {
        (country.regions ?? [])
            .flatMap { $0.settlements ?? [] }
            .compactMap(makeCity(from:))
    }

    private static func makeCity(from settlement: StationsDirectory.Settlement) -> City? {
        guard
            let name = normalized(settlement.title),
            let code = normalized(settlement.codes?.yandexCode)
        else {
            return nil
        }

        let stations = (settlement.stations ?? [])
            .compactMap(makeStation(from:))
            .sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }

        guard !stations.isEmpty else { return nil }
        return City(id: code, name: name, stations: stations)
    }

    private static func makeStation(from station: StationsDirectory.Station) -> Station? {
        guard
            station.transportType == Constants.trainTransportType,
            let name = normalized(station.title),
            let code = normalized(station.codes?.yandexCode)
        else {
            return nil
        }

        return Station(id: code, name: name)
    }

    private static func isOrderedBefore(_ lhs: City, _ rhs: City) -> Bool {
        if lhs.stations.count != rhs.stations.count {
            return lhs.stations.count > rhs.stations.count
        }

        return lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
    }

    private static func normalized(_ value: String?) -> String? {
        guard let value = value?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty else {
            return nil
        }
        return value
    }
}
