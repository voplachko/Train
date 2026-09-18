//
//  FiltersView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct FiltersView: View {
    @Binding var applied: TripFilters

    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: FiltersViewModel

    init(applied: Binding<TripFilters>) {
        _applied = applied
        _viewModel = State(initialValue: FiltersViewModel(filters: applied.wrappedValue))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            sectionTitle("Время отправления")

            ForEach(DepartureInterval.allCases) { interval in
                row(
                    title: interval.title,
                    iconName: viewModel.isSelected(interval) ? "checkmark.square.fill" : "square"
                ) {
                    viewModel.toggle(interval)
                }
            }

            sectionTitle("Показывать варианты с пересадками")

            row(
                title: "Да",
                iconName: viewModel.isTransfersSelected(true) ? "largecircle.fill.circle" : "circle"
            ) {
                viewModel.selectTransfers(true)
            }

            row(
                title: "Нет",
                iconName: viewModel.isTransfersSelected(false) ? "largecircle.fill.circle" : "circle"
            ) {
                viewModel.selectTransfers(false)
            }

            Spacer(minLength: 0)
        }
        .padding(.top, Dimen.x4)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.appWhite)
        .overlay(alignment: .bottom) {
            if viewModel.isApplyVisible {
                PrimaryButton.long("Применить", action: apply)
                    .padding(.bottom, Dimen.x6)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: viewModel.isApplyVisible)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }

    private func apply() {
        applied = viewModel.draft
        dismiss()
    }

    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.bold24)
            .foregroundStyle(Color.appBlack)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, Dimen.x4)
            .padding(.vertical, Dimen.x4)
    }

    private func row(title: String, iconName: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: Dimen.x4) {
                Text(title)
                    .font(.regular17)
                    .foregroundStyle(Color.appBlack)

                Spacer(minLength: 0)

                Image(systemName: iconName)
                    .font(.system(size: Dimen.x6))
                    .foregroundStyle(Color.appBlack)
            }
            .padding(.horizontal, Dimen.x4)
            .frame(height: Dimen.x15)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview("Пустой") {
    NavigationStack {
        FiltersView(applied: .constant(TripFilters()))
    }
}

#Preview("Выбрано") {
    NavigationStack {
        FiltersView(
            applied: .constant(TripFilters(intervals: [.morning, .night], allowsTransfers: false))
        )
    }
}
