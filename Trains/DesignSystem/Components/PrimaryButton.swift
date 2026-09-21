//
//  PrimaryButton.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 17.09.2026.
//

import SwiftUI

struct PrimaryButton: View {
    private enum Kind {
        case short
        case long(showsIndicator: Bool)
    }

    // MARK: - Properties

    private let title: String
    private let kind: Kind
    private let action: () -> Void

    // MARK: - Init

    private init(title: String, kind: Kind, action: @escaping () -> Void) {
        self.title = title
        self.kind = kind
        self.action = action
    }

    // MARK: - Factory

    static func short(_ title: String, action: @escaping () -> Void) -> PrimaryButton {
        PrimaryButton(title: title, kind: .short, action: action)
    }

    static func long(
        _ title: String,
        showsIndicator: Bool = false,
        action: @escaping () -> Void
    ) -> PrimaryButton {
        PrimaryButton(title: title, kind: .long(showsIndicator: showsIndicator), action: action)
    }

    // MARK: - Body

    var body: some View {
        switch kind {
        case .short:
            button(showsIndicator: false)
                .frame(width: Dimen.shortButtonWidth)

        case .long(let showsIndicator):
            button(showsIndicator: showsIndicator)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, Dimen.x4)
        }
    }

    // MARK: - Subviews

    private func button(showsIndicator: Bool) -> some View {
        Button(action: action) {
            HStack(spacing: Dimen.x1) {
                Text(title)
                    .font(.bold17)
                    .lineLimit(AppStyle.singleLine)

                if showsIndicator {
                    Circle()
                        .fill(Color.appRed)
                        .frame(width: Dimen.x2, height: Dimen.x2)
                }
            }
            .padding(.vertical, Dimen.x5)
            .frame(maxWidth: .infinity)
            .frame(height: Dimen.x15)
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}

// MARK: - Style

private struct PrimaryButtonStyle: ButtonStyle {
    private let shape = RoundedRectangle(cornerRadius: Dimen.x4, style: .continuous)

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.appWhiteUniversal)
            .background(shape.fill(Color.appBlue))
            .contentShape(shape)
            .opacity(configuration.isPressed ? AppStyle.pressedOpacity : 1)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: Dimen.x6) {
        PrimaryButton.short(Strings.RouteSearch.search) {}
        PrimaryButton.long(Strings.Filters.apply) {}
        PrimaryButton.long(Strings.Carriers.refineTime, showsIndicator: true) {}
    }
}
