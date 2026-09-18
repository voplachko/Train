//
//  MockCityRepository.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

struct MockCityRepository: CityRepository {
    func cities() -> [City] {
        [
            City(name: "Москва", stations: [
                Station(name: "Киевский вокзал"),
                Station(name: "Курский вокзал"),
                Station(name: "Ярославский вокзал"),
                Station(name: "Белорусский вокзал"),
                Station(name: "Савёловский вокзал"),
                Station(name: "Ленинградский вокзал")
            ]),
            City(name: "Санкт Петербург", stations: [
                Station(name: "Балтийский вокзал"),
                Station(name: "Московский вокзал"),
                Station(name: "Ладожский вокзал"),
                Station(name: "Финляндский вокзал")
            ]),
            City(name: "Сочи", stations: [
                Station(name: "Вокзал Сочи"),
                Station(name: "Вокзал Адлер")
            ]),
            City(name: "Горный воздух", stations: [
                Station(name: "Вокзал Горный воздух")
            ]),
            City(name: "Краснодар", stations: [
                Station(name: "Вокзал Краснодар 1"),
                Station(name: "Вокзал Краснодар 2")
            ]),
            City(name: "Казань", stations: [
                Station(name: "Вокзал Казань 1"),
                Station(name: "Вокзал Восстание Пассажирская")
            ]),
            City(name: "Омск", stations: [
                Station(name: "Вокзал Омск")
            ])
        ]
    }
}
