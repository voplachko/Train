//
//  StoriesView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import SwiftUI

struct StoriesView: View {
    private enum Layout {
        static let dismissDistance: CGFloat = 120
        static let dismissTolerance: CGFloat = 60
        static let dismissScaleDistance: CGFloat = 600
        static let maxScaleReduction: CGFloat = 0.2
    }

    // MARK: - Properties

    let stories: [Story]
    let onStoryShown: (Int) -> Void

    @Environment(\.dismiss) private var dismiss

    @State private var currentIndex: Int
    @State private var isHolding = false
    @State private var dragOffset: CGFloat = 0
    @State private var restartToken = 0

    private let timerConfiguration: TimerConfiguration

    // MARK: - Init

    init(stories: [Story], startIndex: Int, onStoryShown: @escaping (Int) -> Void) {
        let safeIndex = stories.indices.contains(startIndex) ? startIndex : 0

        self.stories = stories
        self.onStoryShown = onStoryShown
        self.timerConfiguration = TimerConfiguration(storiesCount: stories.count)
        _currentIndex = State(initialValue: safeIndex)
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            Color.appBlackUniversal
                .ignoresSafeArea()

            content
                .scaleEffect(dismissScale)
                .offset(y: dragOffset)
        }
        .statusBarHidden()
        .onAppear {
            onStoryShown(currentIndex)
        }
        .simultaneousGesture(dismissGesture)
    }

    // MARK: - Subviews

    private var content: some View {
        ZStack(alignment: .top) {
            StoriesTabView(
                stories: stories,
                currentIndex: $currentIndex,
                isHolding: $isHolding,
                onBack: showPreviousStory,
                onForward: showNextStory
            )
            .onChange(of: currentIndex) { _, newValue in
                onStoryShown(newValue)
            }

            controls
        }
    }

    private var controls: some View {
        VStack(spacing: Dimen.x6) {
            StoriesProgressBar(
                storiesCount: stories.count,
                timerConfiguration: timerConfiguration,
                currentIndex: $currentIndex,
                isPaused: isPaused,
                restartToken: restartToken,
                onFinish: close
            )

            CloseButton(action: close)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal, Dimen.x3)
        .padding(.top, Dimen.x7)
        .opacity(isHolding ? 0 : 1)
        .animation(AppAnimation.quick, value: isHolding)
    }

    // MARK: - Output

    private var isPaused: Bool {
        isHolding || dragOffset > 0
    }

    private var dismissScale: CGFloat {
        1 - min(dragOffset / Layout.dismissScaleDistance, Layout.maxScaleReduction)
    }

    // MARK: - Gestures

    private var dismissGesture: some Gesture {
        DragGesture(minimumDistance: Dimen.x5)
            .onChanged { value in
                guard isVerticalDrag(value.translation) else { return }
                dragOffset = max(value.translation.height, 0)
            }
            .onEnded { value in
                guard isVerticalDrag(value.translation),
                      value.translation.height > Layout.dismissDistance else {
                    withAnimation(AppAnimation.quick) {
                        dragOffset = 0
                    }
                    return
                }

                close()
            }
    }

    private func isVerticalDrag(_ translation: CGSize) -> Bool {
        translation.height > 0 && abs(translation.width) < Layout.dismissTolerance
    }

    // MARK: - Actions

    private func close() {
        Haptics.impact(.rigid)
        dismiss()
    }

    private func showNextStory() {
        guard currentIndex < stories.count - 1 else {
            close()
            return
        }

        Haptics.impact(.soft)
        currentIndex += 1
    }

    private func showPreviousStory() {
        Haptics.impact(.soft)

        guard currentIndex > 0 else {
            restartToken += 1
            return
        }

        currentIndex -= 1
    }
}

// MARK: - Preview

#Preview {
    StoriesView(stories: MockData.stories, startIndex: 2) { _ in }
}
