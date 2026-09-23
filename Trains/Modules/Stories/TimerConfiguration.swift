//
//  TimerConfiguration.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import CoreGraphics
import Foundation

struct TimerConfiguration {
    private enum Default {
        static let storiesCount = 1
        static let secondsPerStory: TimeInterval = 5
        static let timerTickInterval: TimeInterval = 0.05
    }

    // MARK: - Properties

    let storiesCount: Int
    let timerTickInterval: TimeInterval
    let progressPerTick: CGFloat

    // MARK: - Init

    init(
        storiesCount: Int,
        secondsPerStory: TimeInterval = Default.secondsPerStory,
        timerTickInterval: TimeInterval = Default.timerTickInterval
    ) {
        let count = max(storiesCount, Default.storiesCount)
        let duration = secondsPerStory > 0 ? secondsPerStory : Default.secondsPerStory
        let tick = timerTickInterval > 0 ? timerTickInterval : Default.timerTickInterval

        self.storiesCount = count
        self.timerTickInterval = tick
        self.progressPerTick = CGFloat(tick) / (CGFloat(count) * CGFloat(duration))
    }

    // MARK: - Calculations

    func progress(for storyIndex: Int) -> CGFloat {
        min(CGFloat(storyIndex) / CGFloat(storiesCount), 1)
    }

    func index(for progress: CGFloat) -> Int {
        min(Int(progress * CGFloat(storiesCount)), storiesCount - 1)
    }

    func nextProgress(progress: CGFloat) -> CGFloat {
        min(progress + progressPerTick, 1)
    }
}
