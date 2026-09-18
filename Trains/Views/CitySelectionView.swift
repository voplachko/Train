//
//  CitySelectionView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct CitySelectionFlow: View {
    let onSelect: (String) -> Void

    var body: some View {
        NavigationStack {
            CitySelectionView(onSelect: onSelect)
        }
    }
}

struct CitySelectionView: View {
    let onSelect: (String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var query = ""

    private let cities = City.mock

    private var filteredCities: [City] {
        guard !query.isEmpty else { return cities }
        return cities.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(filteredCities) { city in
                    NavigationLink(value: city) {
                        SelectionRow(title: city.name)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .overlay {
            if filteredCities.isEmpty {
                NotFoundView(title: "Город не найден")
            }
        }
        .searchable(
            text: $query,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Введите запрос"
        )
        .background(Color.appWhite)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Выбор города")
                    .font(.bold17)
                    .foregroundStyle(Color.appBlack)
            }
            ToolbarItem(placement: .topBarLeading) {
                BackButton { dismiss() }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(for: City.self) { city in
            StationSelectionView(city: city, onSelect: onSelect)
        }
    }
}

#Preview {
    CitySelectionFlow { _ in }
}
