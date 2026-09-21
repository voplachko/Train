//
//  FiltersView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct FiltersView: View {
    // MARK: - Properties

    @Binding var applied: TripFilters

    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: FiltersViewModel

    // MARK: - Init

    init(applied: Binding<TripFilters>) {
        _applied = applied
        _viewModel = State(initialValue: FiltersViewModel(filters: applied.wrappedValue))
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            sectionTitle(Strings.Filters.departureTime)

            ForEach(DepartureInterval.allCases) { interval in
                row(
                    title: interval.title,
                    symbol: .checkbox(isOn: viewModel.isSelected(interval))
                ) {
                    viewModel.toggle(interval)
                }
            }

            sectionTitle(Strings.Filters.transfers)

            row(
                title: Strings.Filters.yes,
                symbol: .radio(isOn: viewModel.isTransfersSelected(true))
            ) {
                viewModel.selectTransfers(true)
            }

            row(
                title: Strings.Filters.no,
                symbol: .radio(isOn: viewModel.isTransfersSelected(false))
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
                PrimaryButton.long(Strings.Filters.apply, action: apply)
                    .padding(.bottom, Dimen.x6)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
        .animation(AppAnimation.quick, value: viewModel.isApplyVisible)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }

    // MARK: - Actions

    private func apply() {
        applied = viewModel.draft
        dismiss()
    }

    // MARK: - Subviews

    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.bold24)
            .foregroundStyle(Color.appBlack)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, Dimen.x4)
            .padding(.vertical, Dimen.x4)
    }

    private func row(title: String, symbol: SFSymbol, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: Dimen.x4) {
                Text(title)
                    .font(.regular17)
                    .foregroundStyle(Color.appBlack)

                Spacer(minLength: 0)

                Image(symbol: symbol)
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

// MARK: - Previews

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
