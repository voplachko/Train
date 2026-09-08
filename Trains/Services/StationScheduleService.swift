//
//  StationScheduleService.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 08.09.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias StationSchedule = Components.Schemas.ScheduleResponse

protocol StationScheduleServiceProtocol {
    func getStationSchedule(station: String, date: String?) async throws -> StationSchedule
}

final class StationScheduleService: BaseAPIService, StationScheduleServiceProtocol {
    func getStationSchedule(station: String, date: String? = nil) async throws -> StationSchedule {
        let response = try await client.getStationSchedule(query: .init(
            station: station,
            date: date
        ))
        return try response.ok.body.json
    }
}
