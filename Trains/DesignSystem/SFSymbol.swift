//
//  SFSymbol.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 19.09.2026.
//

import SwiftUI

enum SFSymbol: String {
    // MARK: - Cases

    case chevronForward = "chevron.forward"
    case checkboxOn = "checkmark.square.fill"
    case checkboxOff = "square"
    case radioOn = "largecircle.fill.circle"
    case radioOff = "circle"

    // MARK: - States

    static func checkbox(isOn: Bool) -> SFSymbol {
        isOn ? .checkboxOn : .checkboxOff
    }

    static func radio(isOn: Bool) -> SFSymbol {
        isOn ? .radioOn : .radioOff
    }
}

// MARK: - Image

extension Image {
    init(symbol: SFSymbol) {
        self.init(systemName: symbol.rawValue)
    }
}
