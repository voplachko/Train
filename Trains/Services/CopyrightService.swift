//
//  CopyrightService.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 08.09.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias CopyrightInfo = Components.Schemas.CopyrightResponse

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> CopyrightInfo
}

final class CopyrightService: BaseAPIService, CopyrightServiceProtocol {
    func getCopyright() async throws -> CopyrightInfo {
        let response = try await client.getCopyright(query: .init())
        return try response.ok.body.json
    }
}
