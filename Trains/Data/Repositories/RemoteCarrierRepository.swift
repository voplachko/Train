//
//  RemoteCarrierRepository.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 26.09.2026.
//

import Foundation

struct RemoteCarrierRepository: CarrierRepository {
    // MARK: - Properties

    private let client: any NetworkClientProtocol

    // MARK: - Init

    init(client: any NetworkClientProtocol) {
        self.client = client
    }

    // MARK: - CarrierRepository

    func carrier(code: Int) async throws -> Carrier? {
        let response = try await client.carrierInfo(code: String(code), system: nil)
        let dto = response.carrier ?? response.carriers?.first
        return dto.flatMap(CarrierMapper.carrier(from:))
    }
}
