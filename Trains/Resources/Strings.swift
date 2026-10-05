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
        static let withTransfer = "С пересадкой"
        static let unknownCarrier = "Перевозчик не указан"

        private static let monthsGenitive = [
            "января", "февраля", "марта", "апреля", "мая", "июня",
            "июля", "августа", "сентября", "октября", "ноября", "декабря"
        ]

        static func date(day: Int, month: Int) -> String {
            guard monthsGenitive.indices.contains(month - 1) else { return "\(day)" }
            return "\(day) \(monthsGenitive[month - 1])"
        }

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

    enum CarrierDetails {
        static let title = "Информация о перевозчике"
        static let email = "E-mail"
        static let phone = "Телефон"
        static let logoAccessibilityLabel = "Логотип перевозчика"
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
        static let darkTheme = "Темная тема"
        static let agreement = "Пользовательское соглашение"
        static let apiNotice = "Приложение использует API «Яндекс.Расписания»"

        static func version(_ version: String) -> String {
            "Версия \(version) (beta)"
        }
    }

    enum Stories {
        static let close = "Закрыть"

        static func accessibilityLabel(title: String, isViewed: Bool) -> String {
            isViewed ? "\(title). Просмотрено" : title
        }
    }

    enum Errors {
        static let server = "Ошибка сервера"
        static let noInternet = "Нет интернета"
    }
}
