//
//  Named.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 19.09.2026.
//

import Foundation

protocol Named {
    var name: String { get }
}

// MARK: - Conformances

extension City: Named {}
extension Station: Named {}
extension Carrier: Named {}

// MARK: - Search

extension Collection where Element: Named {
    func filtered(byName query: String) -> [Element] {
        let query = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return Array(self) }

        return filter { $0.name.localizedCaseInsensitiveContains(query) }
    }
}
