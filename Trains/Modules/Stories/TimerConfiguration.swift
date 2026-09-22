//
//  TimerConfiguration.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import CoreGraphics
import Foundation

struct TimerConfiguration {
    // MARK: - Properties

    let storiesCount: Int
    let timerTickInterval: TimeInterval
    let progressPerTick: CGFloat

    // MARK: - Init

    init(
        storiesCount: Int,
        secondsPerStory: TimeInterval = 5,
        timerTickInterval: TimeInterval = 0.05
    ) {
        self.storiesCount = storiesCount
        self.timerTickInterval = timerTickInterval
        self.progressPerTick = 1.0 / CGFloat(max(storiesCount, 1)) / secondsPerStory * timerTickInterval
    }

    // MARK: - Calculations

    func progress(for storyIndex: Int) -> CGFloat {
        min(CGFloat(storyIndex) / CGFloat(max(storiesCount, 1)), 1)
    }

    func index(for progress: CGFloat) -> Int {
        min(Int(progress * CGFloat(storiesCount)), max(storiesCount - 1, 0))
    }

    func nextProgress(progress: CGFloat) -> CGFloat {
        min(progress + progressPerTick, 1)
    }
}
