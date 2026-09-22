//
//  StoriesTabView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import SwiftUI

struct StoriesTabView: View {
    // MARK: - Properties

    let stories: [Story]

    @Binding var currentIndex: Int
    @Binding var isHolding: Bool

    let onBack: () -> Void
    let onForward: () -> Void

    // MARK: - Body

    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(Array(stories.enumerated()), id: \.element.id) { index, story in
                StoryPageView(story: story)
                    .contentShape(Rectangle())
                    .overlay {
                        StoryTapZones(
                            onBack: onBack,
                            onForward: onForward,
                            isHolding: $isHolding
                        )
                    }
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
    }
}

// MARK: - Preview

#Preview {
    StoriesTabView(
        stories: MockData.stories,
        currentIndex: .constant(0),
        isHolding: .constant(false),
        onBack: {},
        onForward: {}
    )
}
