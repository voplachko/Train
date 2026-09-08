//
//  NetworkServicesTestRunner.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 08.09.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

private enum TestInput {
    static let lat = 59.864177
    static let lng = 30.319163
    static let distance = 50

    static let fromCode = "c213"
    static let toCode = "c2"

    static let stationCode = "s9600721"
}

func testAllServices() {
    Task {
        do {
            let client = try APIConfiguration.makeClient()
            let apikey = APIConfiguration.apiKey

            let nearestStationsService = NearestStationsService(client: client, apikey: apikey)
            let nearestStations = try await nearestStationsService.getNearestStations(
                lat: TestInput.lat,
                lng: TestInput.lng,
                distance: TestInput.distance
            )
            print("✅ nearest_stations: найдено \(nearestStations.stations?.count ?? 0) станций")

            let nearestCityService = NearestCityService(client: client, apikey: apikey)
            let nearestCity = try await nearestCityService.getNearestCity(
                lat: TestInput.lat,
                lng: TestInput.lng,
                distance: TestInput.distance
            )
            print("✅ nearest_settlement: \(nearestCity.title ?? "—")")

            let scheduleBetweenService = ScheduleBetweenStationsService(client: client, apikey: apikey)
            let segments = try await scheduleBetweenService.getScheduleBetweenStations(
                from: TestInput.fromCode,
                to: TestInput.toCode,
                date: todayString()
            )
            print("✅ search: найдено \(segments.segments?.count ?? 0) рейсов")

            let stationScheduleService = StationScheduleService(client: client, apikey: apikey)
            let stationSchedule = try await stationScheduleService.getStationSchedule(
                station: TestInput.stationCode,
                date: todayString()
            )
            print("✅ schedule: станция \(stationSchedule.station?.title ?? "—"), рейсов \(stationSchedule.schedule?.count ?? 0)")

            if let threadUID = segments.segments?.first?.thread?.uid {
                let routeStationsService = RouteStationsService(client: client, apikey: apikey)
                let route = try await routeStationsService.getRouteStations(uid: threadUID)
                print("✅ thread: \(route.title ?? "—"), остановок \(route.stops?.count ?? 0)")
            } else {
                print("⚠️ thread: не удалось получить uid нитки из результатов /search/")
            }

            if let carrierCode = segments.segments?.first?.thread?.carrier?.code {
                let carrierService = CarrierService(client: client, apikey: apikey)
                let carrier = try await carrierService.getCarrierInfo(code: String(carrierCode))
                let carrierTitle = carrier.carrier?.title ?? carrier.carriers?.first?.title
                print("✅ carrier: \(carrierTitle ?? "—")")
            } else {
                print("⚠️ carrier: не удалось получить код перевозчика из результатов /search/")
            }

            let copyrightService = CopyrightService(client: client, apikey: apikey)
            let copyright = try await copyrightService.getCopyright()
            print("✅ copyright: \(copyright.copyright?.text ?? "—")")

            let allStationsService = AllStationsService(client: client, apikey: apikey)
            let allStations = try await allStationsService.getAllStations()
            print("✅ stations_list: стран \(allStations.countries?.count ?? 0)")

            print("🎉 Все сервисы отработали")
        } catch {
            print("❌ Ошибка при вызове сервиса: \(error)")
        }
    }
}

private func todayString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: Date())
}
