//
//  LogBlock.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 04.10.2026.
//

import Foundation

struct LogBlock {
    private enum Border {
        static let width = 80
        static let top = "┌" + line
        static let divider = "├" + line
        static let bottom = "└" + line
        static let gutter = "│ "

        private static var line: String {
            String(repeating: "─", count: width)
        }
    }

    // MARK: - Properties

    let title: String
    private(set) var sections: [[String]] = []

    // MARK: - Init

    init(title: String) {
        self.title = title
    }

    // MARK: - Building

    mutating func addSection(_ lines: [String]) {
        guard !lines.isEmpty else { return }
        sections.append(lines)
    }

    // MARK: - Rendering

    func rendered() -> String {
        var lines = [Border.top, Border.gutter + title]

        for section in sections {
            lines.append(Border.divider)
            lines.append(contentsOf: section.map { Border.gutter + $0 })
        }

        lines.append(Border.bottom)
        return lines.joined(separator: "\n")
    }
}
