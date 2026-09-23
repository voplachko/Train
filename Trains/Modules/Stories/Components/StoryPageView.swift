//
//  StoryPageView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import SwiftUI

struct StoryPageView: View {
    private enum Layout {
        static let titleLines = 2
        static let descriptionLines = 3
    }

    // MARK: - Properties

    let story: Story

    // MARK: - Body

    var body: some View {
        Color.appBlackUniversal
            .overlay {
                Image(story.image)
                    .resizable()
                    .scaledToFill()
            }
            .overlay(alignment: .bottomLeading) {
                caption
            }
            .clipShape(RoundedRectangle(cornerRadius: Dimen.storyPageCornerRadius, style: .continuous))
    }

    // MARK: - Subviews

    private var caption: some View {
        VStack(alignment: .leading, spacing: Dimen.x4) {
            Text(story.title)
                .font(.bold34)
                .lineLimit(Layout.titleLines)

            Text(story.description)
                .font(.regular20)
                .lineLimit(Layout.descriptionLines)
        }
        .foregroundStyle(Color.appWhiteUniversal)
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Dimen.x4)
        .padding(.bottom, Dimen.x10)
    }
}

// MARK: - Preview

#Preview {
    if let story = MockData.story {
        StoryPageView(story: story)
            .ignoresSafeArea()
    }
}
