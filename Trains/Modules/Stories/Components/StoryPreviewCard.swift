//
//  StoryPreviewCard.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import SwiftUI

struct StoryPreviewCard: View {
    // MARK: - Properties

    let story: Story

    private let shape = RoundedRectangle(cornerRadius: Dimen.storyCornerRadius, style: .continuous)

    // MARK: - Body

    var body: some View {
        Image(story.image)
            .resizable()
            .scaledToFill()
            .frame(width: Dimen.storyPreviewWidth, height: Dimen.storyPreviewHeight)
            .clipShape(shape)
            .opacity(story.isViewed ? AppStyle.viewedStoryOpacity : 1)
            .overlay(alignment: .bottomLeading) { title }
            .overlay { border }
            .contentShape(shape)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(
                Strings.Stories.accessibilityLabel(title: story.title, isViewed: story.isViewed)
            )
    }

    // MARK: - Subviews

    private var title: some View {
        Text(story.title)
            .font(.regular12)
            .foregroundStyle(Color.appWhiteUniversal)
            .lineLimit(AppStyle.storyTitleLines)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, Dimen.x3)
            .padding(.bottom, Dimen.x3)
    }

    @ViewBuilder
    private var border: some View {
        if !story.isViewed {
            shape.strokeBorder(Color.appBlue, lineWidth: Dimen.storyBorderWidth)
        }
    }
}

// MARK: - Preview

#Preview {
    HStack(spacing: Dimen.x3) {
        StoryPreviewCard(story: MockData.stories[0])
        StoryPreviewCard(story: MockData.viewedStory)
    }
}
