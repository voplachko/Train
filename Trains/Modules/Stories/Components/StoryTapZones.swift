//
//  StoryTapZones.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import SwiftUI

struct StoryTapZones: View {
    // MARK: - Properties

    let onBack: () -> Void
    let onForward: () -> Void

    @Binding var isHolding: Bool

    // MARK: - Body

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                zone(action: onBack)
                    .frame(width: geometry.size.width * AppStyle.storyBackZoneRatio)

                zone(action: onForward)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    // MARK: - Subviews

    private func zone(action: @escaping () -> Void) -> some View {
        Color.clear
            .contentShape(Rectangle())
            .onTapGesture {
                guard !isHolding else { return }
                action()
            }
            .onLongPressGesture(minimumDuration: AppStyle.storyHoldDuration) {
                isHolding = true
            } onPressingChanged: { isPressing in
                guard !isPressing else { return }
                isHolding = false
            }
    }
}
