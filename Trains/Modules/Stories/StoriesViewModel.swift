//
//  StoriesViewModel.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 01.10.2026.
//

import Combine
import Foundation

@MainActor
final class StoriesViewModel: ObservableObject {
    // MARK: - Properties

    let stories: [Story]
    let timerConfiguration: TimerConfiguration

    @Published var currentIndex: Int
    @Published var isHolding = false
    @Published private(set) var restartToken = 0

    // MARK: - Init

    init(stories: [Story], startIndex: Int) {
        self.stories = stories
        self.timerConfiguration = TimerConfiguration(storiesCount: stories.count)
        self.currentIndex = stories.indices.contains(startIndex) ? startIndex : 0
    }

    // MARK: - Intents

    func moveToNextStory() -> Bool {
        guard currentIndex < stories.count - 1 else { return false }

        currentIndex += 1
        return true
    }

    func moveToPreviousStory() {
        guard currentIndex > 0 else {
            restartToken += 1
            return
        }

        currentIndex -= 1
    }
}
