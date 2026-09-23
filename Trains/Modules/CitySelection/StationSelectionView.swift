//
//  StationSelectionView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct StationSelectionView: View {
    // MARK: - Properties

    let onSelect: (Station) -> Void

    @State private var viewModel: StationSelectionViewModel

    // MARK: - Init

    init(city: City, onSelect: @escaping (Station) -> Void) {
        self.onSelect = onSelect
        _viewModel = State(initialValue: StationSelectionViewModel(city: city))
    }

    // MARK: - Body

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.stations) { station in
                    Button {
                        onSelect(station)
                    } label: {
                        SelectionRow(title: station.name)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .overlay {
            if viewModel.isEmpty {
                EmptyStateView(title: Strings.StationSelection.notFound)
            }
        }
        .searchable(
            text: $viewModel.query,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: Strings.Search.prompt
        )
        .background(Color.appWhite)
        .navigationTitle(Strings.StationSelection.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        if let city = MockData.city {
            StationSelectionView(city: city) { _ in }
        }
    }
}
