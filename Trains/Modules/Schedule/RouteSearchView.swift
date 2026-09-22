//
//  RouteSearchView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 17.09.2026.
//

import SwiftUI

struct RouteSearchView: View {
    // MARK: - Properties

    let viewModel: ScheduleFlowViewModel

    @Environment(StoriesStore.self) private var storiesStore

    @Namespace private var storiesNamespace

    @State private var storiesPresentation: StoriesPresentation?
    @State private var activeStoryID: Int?

    // MARK: - Body

    var body: some View {
        VStack(spacing: Dimen.x5) {
            StoriesCarousel(
                stories: storiesStore.stories,
                namespace: storiesNamespace,
                activeStoryID: activeStoryID,
                onSelect: showStories(from:)
            )

            searchCard

            Spacer(minLength: 0)
        }
        .padding(.top, Dimen.x6)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.appWhite)
        .animation(AppAnimation.standard, value: viewModel.isRouteFilled)
        .toolbar(.hidden, for: .navigationBar)
        .fullScreenCover(item: $storiesPresentation) { presentation in
            StoriesView(
                stories: storiesStore.stories,
                startIndex: presentation.startIndex,
                onStoryShown: handleStoryShown(at:)
            )
            .navigationTransition(
                .zoom(sourceID: activeStoryID ?? presentation.storyID, in: storiesNamespace)
            )
        }
    }

    // MARK: - Subviews

    private var searchCard: some View {
        VStack(spacing: Dimen.x4) {
            RouteSelectorCard(
                from: viewModel.from,
                to: viewModel.to,
                onSelectFrom: { viewModel.selectPoint(for: .from) },
                onSelectTo: { viewModel.selectPoint(for: .to) },
                onSwap: viewModel.swapRoute
            )

            if viewModel.isRouteFilled {
                PrimaryButton.short(Strings.RouteSearch.search, action: viewModel.search)
                    .transition(.opacity.combined(with: .scale(scale: AppStyle.appearScale)))
            }
        }
        .padding(.horizontal, Dimen.x4)
    }

    // MARK: - Actions

    private func showStories(from story: Story) {
        guard let index = storiesStore.stories.firstIndex(where: { $0.id == story.id }) else {
            return
        }

        activeStoryID = story.id
        storiesPresentation = StoriesPresentation(startIndex: index, storyID: story.id)
    }

    private func handleStoryShown(at index: Int) {
        storiesStore.markViewed(at: index)

        guard storiesStore.stories.indices.contains(index) else { return }
        activeStoryID = storiesStore.stories[index].id
    }
}

// MARK: - Previews

#Preview("Пустой") {
    NavigationStack {
        RouteSearchView(viewModel: ScheduleFlowViewModel())
    }
    .environment(StoriesStore())
}

#Preview("Заполненный") {
    NavigationStack {
        RouteSearchView(
            viewModel: ScheduleFlowViewModel(from: MockData.route.from, to: MockData.route.to)
        )
    }
    .environment(StoriesStore())
}
