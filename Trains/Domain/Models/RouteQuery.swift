//
//  RouteQuery.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import Foundation

struct RouteQuery: Hashable {
    let from: String
    let to: String

    var title: String {
        "\(from) → \(to)"
    }
}
