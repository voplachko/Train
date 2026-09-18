//
//  StationSelectionView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct StationSelectionView: View {
    let onSelect: (Station) -> Void

    @State private var viewModel: StationSelectionViewModel

    init(city: City, onSelect: @escaping (Station) -> Void) {
        self.onSelect = onSelect
        _viewModel = State(initialValue: StationSelectionViewModel(city: city))
    }

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
                EmptyStateView(title: "Станция не найдена")
            }
        }
        .searchable(
            text: $viewModel.query,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Введите запрос"
        )
        .background(Color.appWhite)
        .navigationTitle("Выбор станции")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    NavigationStack {
        StationSelectionView(city: MockCityRepository().cities()[0]) { _ in }
    }
}
