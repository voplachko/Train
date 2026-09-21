//
//  Strings.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 19.09.2026.
//

import Foundation

/// TODO: move to a String Catalog once the app is localized.
enum Strings {
    enum RouteSearch {
        static let fromPlaceholder = "Откуда"
        static let toPlaceholder = "Куда"
        static let swapAccessibilityLabel = "Поменять местами"
        static let search = "Найти"

        static func point(city: String, station: String) -> String {
            "\(city) (\(station))"
        }
    }

    enum CitySelection {
        static let title = "Выбор города"
        static let notFound = "Город не найден"
    }

    enum StationSelection {
        static let title = "Выбор станции"
        static let notFound = "Станция не найдена"
    }

    enum Search {
        static let prompt = "Введите запрос"
    }

    enum Carriers {
        static let empty = "Вариантов нет"
        static let refineTime = "Уточнить время"

        static func route(from: String, to: String) -> String {
            "\(from) → \(to)"
        }

        static func transfer(city: String) -> String {
            "С пересадкой в \(city)"
        }

        static func duration(hours: Int) -> String {
            "\(hours) \(hoursWord(for: hours))"
        }

        private static func hoursWord(for value: Int) -> String {
            if (11...14).contains(value % 100) { return "часов" }

            switch value % 10 {
            case 1: return "час"
            case 2, 3, 4: return "часа"
            default: return "часов"
            }
        }
    }

    enum Filters {
        static let departureTime = "Время отправления"
        static let transfers = "Показывать варианты с пересадками"
        static let yes = "Да"
        static let no = "Нет"
        static let apply = "Применить"

        static let morning = "Утро 06:00 - 12:00"
        static let day = "День 12:00 - 18:00"
        static let evening = "Вечер 18:00 - 00:00"
        static let night = "Ночь 00:00 - 06:00"
    }

    enum Settings {
        static let title = "Настройки"
    }

    enum Errors {
        static let server = "Ошибка сервера"
        static let noInternet = "Нет интернета"
    }

    #if DEBUG
    enum Debug {
        static let showServerError = "Показать «Ошибка сервера»"
        static let showNoInternet = "Показать «Нет интернета»"
        static let clearError = "Убрать ошибку"
    }
    #endif
}
