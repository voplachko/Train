//
//  ProgressBar.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import SwiftUI

struct ProgressBar: View {
    // MARK: - Properties

    let numberOfSections: Int
    let progress: CGFloat

    // MARK: - Body

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                track(width: geometry.size.width, color: Color.appWhiteUniversal)
                track(
                    width: min(progress * geometry.size.width, geometry.size.width),
                    color: Color.appBlue
                )
            }
            .mask {
                MaskView(numberOfSections: numberOfSections)
            }
        }
        .frame(height: Dimen.progressBarHeight)
    }

    // MARK: - Subviews

    private func track(width: CGFloat, color: Color) -> some View {
        RoundedRectangle(cornerRadius: Dimen.progressBarHeight, style: .continuous)
            .fill(color)
            .frame(width: width, height: Dimen.progressBarHeight)
    }
}

// MARK: - Mask

private struct MaskView: View {
    let numberOfSections: Int

    var body: some View {
        HStack(spacing: Dimen.x2) {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                RoundedRectangle(cornerRadius: Dimen.progressBarHeight, style: .continuous)
                    .frame(height: Dimen.progressBarHeight)
                    .foregroundStyle(Color.appWhiteUniversal)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    Color.appBlackUniversal
        .ignoresSafeArea()
        .overlay {
            ProgressBar(numberOfSections: 5, progress: 0.5)
                .padding(.horizontal, Dimen.x3)
        }
}
