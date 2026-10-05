//
//  NetworkClient.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

// MARK: - Protocol

protocol NetworkClientProtocol: Sendable {
    func nearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
    func nearestCity(lat: Double, lng: Double, distance: Int) async throws -> NearestCity
    func scheduleBetweenStations(
        from: String,
        to: String,
        date: String?,
        transfers: Bool
    ) async throws -> ScheduleBetweenStations
    func stationSchedule(station: String, date: String?) async throws -> StationSchedule
    func routeStations(uid: String) async throws -> RouteStations
    func carrierInfo(code: String, system: String?) async throws -> CarrierInfo
    func copyright() async throws -> CopyrightInfo
    func allStations() async throws -> StationsDirectory
}

// MARK: - Client

actor NetworkClient: NetworkClientProtocol {
    private enum Constants {
        static let allStationsSizeLimit = 50 * 1024 * 1024
    }

    // MARK: - Properties

    private var client: Client?

    // MARK: - Services

    func nearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let response = try await apiClient().getNearestStations(query: .init(
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }

    func nearestCity(lat: Double, lng: Double, distance: Int) async throws -> NearestCity {
        let response = try await apiClient().getNearestCity(query: .init(
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }

    func scheduleBetweenStations(
        from: String,
        to: String,
        date: String?,
        transfers: Bool
    ) async throws -> ScheduleBetweenStations {
        let response = try await apiClient().getSchedualBetweenStations(query: .init(
            from: from,
            to: to,
            date: date,
            transfers: transfers
        ))
        return try response.ok.body.json
    }

    func stationSchedule(station: String, date: String?) async throws -> StationSchedule {
        let response = try await apiClient().getStationSchedule(query: .init(
            station: station,
            date: date
        ))
        return try response.ok.body.json
    }

    func routeStations(uid: String) async throws -> RouteStations {
        let response = try await apiClient().getRouteStations(query: .init(uid: uid))
        return try response.ok.body.json
    }

    func carrierInfo(code: String, system: String?) async throws -> CarrierInfo {
        let response = try await apiClient().getCarrierInfo(query: .init(
            code: code,
            system: system
        ))
        return try response.ok.body.json
    }

    func copyright() async throws -> CopyrightInfo {
        let response = try await apiClient().getCopyright(query: .init())
        return try response.ok.body.json
    }

    func allStations() async throws -> StationsDirectory {
        let response = try await apiClient().getAllStations(query: .init())
        let body = try response.ok.body.html
        let data = try await Data(collecting: body, upTo: Constants.allStationsSizeLimit)

        try Task.checkCancellation()
        return try JSONDecoder().decode(StationsDirectory.self, from: data)
    }

    // MARK: - Private

    private func apiClient() throws -> Client {
        if let client {
            return client
        }

        let newClient = try APIConfiguration.makeClient()
        client = newClient
        return newClient
    }
}
