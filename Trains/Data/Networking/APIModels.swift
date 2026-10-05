//
//  APIModels.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import Foundation

// MARK: - Generated models

typealias NearestStations = Components.Schemas.Stations
typealias NearestCity = Components.Schemas.NearestCityResponse
typealias ScheduleBetweenStations = Components.Schemas.Segments
typealias StationSchedule = Components.Schemas.ScheduleResponse
typealias RouteStations = Components.Schemas.ThreadStationsResponse
typealias CarrierInfo = Components.Schemas.CarrierResponse
typealias CopyrightInfo = Components.Schemas.CopyrightResponse

// MARK: - Stations directory

struct StationsDirectory: Decodable, Sendable {
    struct Country: Decodable, Sendable {
        let title: String?
        let regions: [Region]?
    }

    struct Region: Decodable, Sendable {
        let title: String?
        let settlements: [Settlement]?
    }

    struct Settlement: Decodable, Sendable {
        let title: String?
        let codes: Codes?
        let stations: [Station]?
    }

    struct Station: Decodable, Sendable {
        let title: String?
        let codes: Codes?
        let transportType: String?

        private enum CodingKeys: String, CodingKey {
            case title
            case codes
            case transportType = "transport_type"
        }
    }

    struct Codes: Decodable, Sendable {
        let yandexCode: String?

        private enum CodingKeys: String, CodingKey {
            case yandexCode = "yandex_code"
        }
    }

    let countries: [Country]?
}
