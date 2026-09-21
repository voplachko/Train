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

    @State private var viewModel = CitySelectionViewModel()

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
            if viewModel.isEmpty {
                EmptyStateView(title: Strings.CitySelection.notFound)
            }
        }
        .searchable(
            text: $viewModel.query,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: Strings.Search.prompt
        )
        .background(Color.appWhite)
        .navigationTitle(Strings.CitySelection.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        CitySelectionView { _ in }
    }
}
