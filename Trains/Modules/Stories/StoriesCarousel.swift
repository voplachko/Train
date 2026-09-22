//
//  StoriesCarousel.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import SwiftUI

struct StoriesCarousel: View {
    // MARK: - Properties

    let stories: [Story]
    let namespace: Namespace.ID

    let activeStoryID: Int?

    let onSelect: (Story) -> Void

    // MARK: - Body

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Dimen.x3) {
                    ForEach(stories) { story in
                        card(for: story)
                    }
                }
                .padding(.horizontal, Dimen.x4)
            }
            .onChange(of: activeStoryID) { _, newValue in
                guard let newValue else { return }
                proxy.scrollTo(newValue, anchor: .center)
            }
        }
        .frame(height: Dimen.storyPreviewHeight)
    }

    // MARK: - Subviews

    private func card(for story: Story) -> some View {
        Button {
            onSelect(story)
        } label: {
            StoryPreviewCard(story: story)
        }
        .buttonStyle(.plain)
        .matchedTransitionSource(id: story.id, in: namespace)
        .id(story.id)
    }
}

// MARK: - Preview

#Preview {
    @Previewable @Namespace var namespace

    StoriesCarousel(stories: MockData.stories, namespace: namespace, activeStoryID: nil) { _ in }
}
