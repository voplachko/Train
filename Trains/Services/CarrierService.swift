//
//  CarrierService.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 08.09.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias CarrierInfo = Components.Schemas.CarrierResponse

protocol CarrierServiceProtocol {
    func getCarrierInfo(code: String, system: String?) async throws -> CarrierInfo
}

final class CarrierService: BaseAPIService, CarrierServiceProtocol {
    func getCarrierInfo(code: String, system: String? = nil) async throws -> CarrierInfo {
        let response = try await client.getCarrierInfo(query: .init(
            code: code,
            system: system
        ))
        return try response.ok.body.json
    }
}
