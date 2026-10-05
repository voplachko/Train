//
//  CarrierRepository.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 23.09.2026.
//

import Foundation

protocol CarrierRepository: Sendable {
    func carrier(code: Int) async throws -> Carrier?
}
