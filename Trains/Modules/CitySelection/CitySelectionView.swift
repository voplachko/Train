//
//  CitySelectionView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct CitySelectionView: View {
    let onSelect: (City) -> Void

    @State private var viewModel = CitySelectionViewModel()

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
                EmptyStateView(title: "Город не найден")
            }
        }
        .searchable(
            text: $viewModel.query,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Введите запрос"
        )
        .background(Color.appWhite)
        .navigationTitle("Выбор города")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    NavigationStack {
        CitySelectionView { _ in }
    }
}
