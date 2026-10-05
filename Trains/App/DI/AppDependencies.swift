//
//  AppDependencies.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 26.09.2026.
//

import Foundation

enum AppDependencies {
    static let networkClient: any NetworkClientProtocol = NetworkClient()

    static let cityRepository: any CityRepository = RemoteCityRepository(client: networkClient)
    static let tripRepository: any TripRepository = RemoteTripRepository(client: networkClient)
    static let carrierRepository: any CarrierRepository = RemoteCarrierRepository(client: networkClient)
}
