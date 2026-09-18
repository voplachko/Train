//
//  RouteSelectorCard.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct RouteSelectorCard: View {
    private enum Layout {
        static let cardCornerRadius: CGFloat = 20
        static let cardPadding: CGFloat = 16
        static let fieldsCornerRadius: CGFloat = 20
        static let fieldHeight: CGFloat = 48
        static let fieldHorizontalPadding: CGFloat = 16
        static let swapButtonSize: CGFloat = 36
        static let spacing: CGFloat = 16
    }

    @Binding var from: String
    @Binding var to: String

    let onSelectFrom: () -> Void
    let onSelectTo: () -> Void

    @State private var swapRotation: Double = 0

    var body: some View {
        HStack(spacing: Layout.spacing) {
            fields
            swapButton
        }
        .padding(Layout.cardPadding)
        .background(
            RoundedRectangle(cornerRadius: Layout.cardCornerRadius, style: .continuous)
                .fill(Color.appBlue)
        )
    }

    private var fields: some View {
        VStack(spacing: 0) {
            field(
                value: from,
                placeholder: "Откуда",
                insertionEdge: .bottom,
                action: onSelectFrom
            )
            field(
                value: to,
                placeholder: "Куда",
                insertionEdge: .top,
                action: onSelectTo
            )
        }
        .background(
            RoundedRectangle(cornerRadius: Layout.fieldsCornerRadius, style: .continuous)
                .fill(Color.appWhiteUniversal)
        )
    }

    private func field(
        value: String,
        placeholder: String,
        insertionEdge: Edge,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(value.isEmpty ? placeholder : value)
                .font(.regular17)
                .foregroundStyle(value.isEmpty ? Color.appGray : Color.appBlackUniversal)
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(maxWidth: .infinity, alignment: .leading)
                .id(value)
                .transition(
                    .asymmetric(
                        insertion: .move(edge: insertionEdge).combined(with: .opacity),
                        removal: .move(edge: insertionEdge == .top ? .bottom : .top)
                            .combined(with: .opacity)
                    )
                )
                .padding(.horizontal, Layout.fieldHorizontalPadding)
                .frame(height: Layout.fieldHeight)
                .frame(maxWidth: .infinity, alignment: .leading)
                .clipped()
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    private var swapButton: some View {
        Button(action: swap) {
            Image(.icButtonChange)
                .frame(width: Layout.swapButtonSize, height: Layout.swapButtonSize)
                .rotationEffect(.degrees(swapRotation))
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Поменять местами")
    }

    private func swap() {
        withAnimation(.easeInOut(duration: 0.3)) {
            swapRotation += 180
            let current = from
            from = to
            to = current
        }
    }
}

#Preview("Пустой") {
    RouteSelectorCard(
        from: .constant(""),
        to: .constant(""),
        onSelectFrom: {},
        onSelectTo: {}
    )
    .padding(.horizontal, 16)
}

#Preview("Заполненный") {
    RouteSelectorCard(
        from: .constant("Москва (Курский вокзал)"),
        to: .constant("Санкт Петербург (Балтийский вокзал)"),
        onSelectFrom: {},
        onSelectTo: {}
    )
    .padding(.horizontal, 16)
}
