//
//  CloseButton.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import SwiftUI

struct CloseButton: View {
    // MARK: - Properties

    let action: () -> Void

    // MARK: - Body

    var body: some View {
        Button(action: action) {
            Image(.icButtonClose)
                .resizable()
                .scaledToFit()
                .frame(width: Dimen.closeButtonSize, height: Dimen.closeButtonSize)
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Strings.Stories.close)
    }
}

// MARK: - Preview

#Preview {
    Color.appBlue
        .ignoresSafeArea()
        .overlay {
            CloseButton {}
        }
}
