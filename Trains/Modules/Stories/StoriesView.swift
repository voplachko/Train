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

    let onStoryShown: (Int) -> Void

    @Environment(\.dismiss) private var dismiss

    @StateObject private var viewModel: StoriesViewModel
    @State private var dragOffset: CGFloat = 0

    // MARK: - Init

    init(stories: [Story], startIndex: Int, onStoryShown: @escaping (Int) -> Void) {
        self.onStoryShown = onStoryShown
        _viewModel = StateObject(
            wrappedValue: StoriesViewModel(stories: stories, startIndex: startIndex)
        )
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
            onStoryShown(viewModel.currentIndex)
        }
        .simultaneousGesture(dismissGesture)
    }

    // MARK: - Subviews

    private var content: some View {
        ZStack(alignment: .top) {
            StoriesTabView(
                stories: viewModel.stories,
                currentIndex: $viewModel.currentIndex,
                isHolding: $viewModel.isHolding,
                onBack: showPreviousStory,
                onForward: showNextStory
            )
            .onChange(of: viewModel.currentIndex) { _, newValue in
                onStoryShown(newValue)
            }

            controls
        }
    }

    private var controls: some View {
        VStack(spacing: Dimen.x6) {
            StoriesProgressBar(
                storiesCount: viewModel.stories.count,
                timerConfiguration: viewModel.timerConfiguration,
                currentIndex: $viewModel.currentIndex,
                isPaused: isPaused,
                restartToken: viewModel.restartToken,
                onFinish: close
            )

            CloseButton(action: close)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal, Dimen.x3)
        .padding(.top, Dimen.x7)
        .opacity(viewModel.isHolding ? 0 : 1)
        .animation(AppAnimation.quick, value: viewModel.isHolding)
    }

    // MARK: - Output

    private var isPaused: Bool {
        viewModel.isHolding || dragOffset > 0
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
        guard viewModel.moveToNextStory() else {
            close()
            return
        }

        Haptics.impact(.soft)
    }

    private func showPreviousStory() {
        Haptics.impact(.soft)
        viewModel.moveToPreviousStory()
    }
}

// MARK: - Preview

#Preview {
    StoriesView(stories: MockData.stories, startIndex: 2) { _ in }
}
