//
//  TripRepository.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

protocol TripRepository: Sendable {
    func trips(for route: RouteQuery) async throws -> [Trip]
}
