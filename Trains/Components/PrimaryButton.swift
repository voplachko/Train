//
//  PrimaryButton.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 17.09.2026.
//

import SwiftUI

struct PrimaryButton: View {
    private enum Layout {
        static let height: CGFloat = 60
        static let shortWidth: CGFloat = 150
        static let cornerRadius: CGFloat = 16
        static let horizontalInset: CGFloat = 16
        static let titleVerticalPadding: CGFloat = 20
        static let indicatorSize: CGFloat = 8
        static let indicatorSpacing: CGFloat = 4
    }

    private enum Kind {
        case short
        case long(showsIndicator: Bool)
    }

    private let title: String
    private let kind: Kind
    private let action: () -> Void

    private init(title: String, kind: Kind, action: @escaping () -> Void) {
        self.title = title
        self.kind = kind
        self.action = action
    }

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

    var body: some View {
        switch kind {
        case .short:
            button(showsIndicator: false)
                .frame(width: Layout.shortWidth)
        case .long(let showsIndicator):
            button(showsIndicator: showsIndicator)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, Layout.horizontalInset)
        }
    }

    private func button(showsIndicator: Bool) -> some View {
        Button(action: action) {
            HStack(spacing: Layout.indicatorSpacing) {
                Text(title)
                    .font(.bold17)
                    .lineLimit(1)

                if showsIndicator {
                    Circle()
                        .fill(Color.appRed)
                        .frame(width: Layout.indicatorSize, height: Layout.indicatorSize)
                }
            }
            .padding(.vertical, Layout.titleVerticalPadding)
            .frame(maxWidth: .infinity)
            .frame(height: Layout.height)
        }
        .buttonStyle(PrimaryButtonStyle(cornerRadius: Layout.cornerRadius))
    }
}

private struct PrimaryButtonStyle: ButtonStyle {
    let cornerRadius: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.appWhiteUniversal)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(Color.appBlue)
            )
            .contentShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}

#Preview {
    VStack(spacing: 24) {
        PrimaryButton.short("Найти") {}
        PrimaryButton.long("Применить") {}
        PrimaryButton.long("Применить", showsIndicator: true) {}
    }
}
