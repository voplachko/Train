//
//  AllStationsService.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 08.09.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias AllStations = Components.Schemas.AllStationsResponse

protocol AllStationsServiceProtocol {
    func getAllStations() async throws -> AllStations
}

final class AllStationsService: BaseAPIService, AllStationsServiceProtocol {
    /// Ответ /stations_list/ приходит с Content-Type: text/html,
    /// поэтому тело собирается вручную и декодируется как JSON.
    private static let responseSizeLimit = 50 * 1024 * 1024 // 50 MB

    func getAllStations() async throws -> AllStations {
        let response = try await client.getAllStations(query: .init())
        let responseBody = try response.ok.body.html

        let fullData = try await Data(
            collecting: responseBody,
            upTo: Self.responseSizeLimit
        )

        return try JSONDecoder().decode(AllStations.self, from: fullData)
    }
}
