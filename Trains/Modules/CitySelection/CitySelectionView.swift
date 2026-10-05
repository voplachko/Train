//
//  CitySelectionView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct CitySelectionView: View {
    // MARK: - Properties

    let onSelect: (City) -> Void

    @StateObject private var viewModel: CitySelectionViewModel

    // MARK: - Init

    init(
        repository: any CityRepository = AppDependencies.cityRepository,
        onSelect: @escaping (City) -> Void
    ) {
        self.onSelect = onSelect
        _viewModel = StateObject(wrappedValue: CitySelectionViewModel(repository: repository))
    }

    // MARK: - Body

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.cities) { city in
                    Button {
                        onSelect(city)
                    } label: {
                        SelectionRow(title: city.name)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .overlay {
            if viewModel.state.isLoading {
                ProgressView()
                    .tint(Color.appBlack)
            } else if viewModel.isEmpty {
                EmptyStateView(title: Strings.CitySelection.notFound)
            }
        }
        .errorOverlay(viewModel.state.error, onTap: viewModel.retry)
        .searchable(
            text: $viewModel.query,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: Strings.Search.prompt
        )
        .background(Color.appWhite)
        .navigationTitle(Strings.CitySelection.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .task(id: viewModel.reloadToken) {
            await viewModel.loadCities()
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        CitySelectionView(repository: MockCityRepository()) { _ in }
    }
}
