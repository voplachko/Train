//
//  Haptics.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import UIKit

enum Haptics {
    static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        Task { @MainActor in
            UIImpactFeedbackGenerator(style: style).impactOccurred()
        }
    }
}
