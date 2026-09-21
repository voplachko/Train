//
//  ScheduleBetweenStationsService.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 08.09.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleBetweenStations = Components.Schemas.Segments

protocol ScheduleBetweenStationsServiceProtocol {
    func getScheduleBetweenStations(from: String, to: String, date: String?) async throws -> ScheduleBetweenStations
}

final class ScheduleBetweenStationsService: BaseAPIService, ScheduleBetweenStationsServiceProtocol {
    func getScheduleBetweenStations(
        from: String,
        to: String,
        date: String? = nil
    ) async throws -> ScheduleBetweenStations {
        let response = try await client.getSchedualBetweenStations(query: .init(
            from: from,
            to: to,
            date: date
        ))
        return try response.ok.body.json
    }
}
