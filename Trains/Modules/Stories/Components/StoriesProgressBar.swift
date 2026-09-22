//
//  StoriesProgressBar.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import Combine
import SwiftUI

struct StoriesProgressBar: View {
    // MARK: - Properties

    let storiesCount: Int
    let timerConfiguration: TimerConfiguration

    @Binding var currentIndex: Int

    let isPaused: Bool
    let restartToken: Int
    let onFinish: () -> Void

    @State private var progress: CGFloat
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?

    // MARK: - Init

    init(
        storiesCount: Int,
        timerConfiguration: TimerConfiguration,
        currentIndex: Binding<Int>,
        isPaused: Bool,
        restartToken: Int,
        onFinish: @escaping () -> Void
    ) {
        self.storiesCount = storiesCount
        self.timerConfiguration = timerConfiguration
        self._currentIndex = currentIndex
        self.isPaused = isPaused
        self.restartToken = restartToken
        self.onFinish = onFinish
        self.timer = Self.makeTimer(configuration: timerConfiguration)
        self.progress = timerConfiguration.progress(for: currentIndex.wrappedValue)
    }

    // MARK: - Body

    var body: some View {
        ProgressBar(numberOfSections: storiesCount, progress: progress)
            .onAppear {
                timer = Self.makeTimer(configuration: timerConfiguration)
                cancellable = timer.connect()
            }
            .onDisappear {
                cancellable?.cancel()
            }
            .onReceive(timer) { _ in
                timerTick()
            }
            .onChange(of: currentIndex) { _, newValue in
                rewind(to: newValue)
            }
            .onChange(of: restartToken) { _, _ in
                restart()
            }
    }

    // MARK: - Playback

    private func timerTick() {
        guard !isPaused else { return }

        let nextProgress = timerConfiguration.nextProgress(progress: progress)

        guard nextProgress < 1 else {
            progress = 1
            onFinish()
            return
        }

        withAnimation(.linear(duration: timerConfiguration.timerTickInterval)) {
            progress = nextProgress
        }

        let index = timerConfiguration.index(for: nextProgress)
        guard index != currentIndex else { return }
        currentIndex = index
    }

    private func rewind(to index: Int) {
        guard timerConfiguration.index(for: progress) != index else { return }
        progress = timerConfiguration.progress(for: index)
    }

    private func restart() {
        progress = timerConfiguration.progress(for: currentIndex)
    }

    // MARK: - Timer

    private static func makeTimer(configuration: TimerConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInterval, on: .main, in: .common)
    }
}
