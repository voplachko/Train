//
//  RouteSelectorCard.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct RouteSelectorCard: View {
    // MARK: - Properties

    let from: String
    let to: String
    let onSelectFrom: () -> Void
    let onSelectTo: () -> Void
    let onSwap: () -> Void

    @State private var swapRotation: Double = 0

    // MARK: - Body

    var body: some View {
        HStack(spacing: Dimen.x4) {
            fields
            swapButton
        }
        .padding(Dimen.x4)
        .background(
            RoundedRectangle(cornerRadius: Dimen.x5, style: .continuous)
                .fill(Color.appBlue)
        )
    }

    // MARK: - Subviews

    private var fields: some View {
        VStack(spacing: 0) {
            field(
                value: from,
                placeholder: Strings.RouteSearch.fromPlaceholder,
                insertionEdge: .bottom,
                action: onSelectFrom
            )
            field(
                value: to,
                placeholder: Strings.RouteSearch.toPlaceholder,
                insertionEdge: .top,
                action: onSelectTo
            )
        }
        .background(
            RoundedRectangle(cornerRadius: Dimen.x4, style: .continuous)
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
                .lineLimit(AppStyle.singleLine)
                .truncationMode(.tail)
                .frame(maxWidth: .infinity, alignment: .leading)
                .id(value)
                .transition(swapTransition(insertionEdge: insertionEdge))
                .padding(.horizontal, Dimen.x4)
                .frame(height: Dimen.x12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .clipped()
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    private func swapTransition(insertionEdge: Edge) -> AnyTransition {
        .asymmetric(
            insertion: .move(edge: insertionEdge).combined(with: .opacity),
            removal: .move(edge: insertionEdge == .top ? .bottom : .top).combined(with: .opacity)
        )
    }

    private var swapButton: some View {
        Button(action: swap) {
            Image(.icButtonChange)
                .frame(width: Dimen.x9, height: Dimen.x9)
                .background(Circle().fill(Color.appWhiteUniversal))
                .rotationEffect(.degrees(swapRotation))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Strings.RouteSearch.swapAccessibilityLabel)
    }

    // MARK: - Actions

    private func swap() {
        withAnimation(AppAnimation.standard) {
            swapRotation += AppStyle.halfTurn
            onSwap()
        }
    }
}

// MARK: - Previews

#Preview("Пустой") {
    RouteSelectorCard(
        from: "",
        to: "",
        onSelectFrom: {},
        onSelectTo: {},
        onSwap: {}
    )
    .padding(.horizontal, Dimen.x4)
}

#Preview("Заполненный") {
    RouteSelectorCard(
        from: MockData.route.from,
        to: MockData.route.to,
        onSelectFrom: {},
        onSelectTo: {},
        onSwap: {}
    )
    .padding(.horizontal, Dimen.x4)
}
