//
//  StoriesStore.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import SwiftUI

@Observable
final class StoriesStore {
    // MARK: - Properties

    private(set) var stories: [Story]

    // MARK: - Init

    init(repository: StoryRepository = MockStoryRepository()) {
        self.stories = repository.stories()
    }

    // MARK: - Intents

    func markViewed(at index: Int) {
        guard stories.indices.contains(index), !stories[index].isViewed else { return }
        stories[index].isViewed = true
    }
}
