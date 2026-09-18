//
//  StationSelectionView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct StationSelectionView: View {
    let city: City
    let onSelect: (String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var query = ""

    private var filteredStations: [Station] {
        guard !query.isEmpty else { return city.stations }
        return city.stations.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(filteredStations) { station in
                    Button {
                        onSelect("\(city.name) (\(station.name))")
                    } label: {
                        SelectionRow(title: station.name)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .overlay {
            if filteredStations.isEmpty {
                NotFoundView(title: "Станция не найдена")
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
                Text("Выбор станции")
                    .font(.bold17)
                    .foregroundStyle(Color.appBlack)
            }
            ToolbarItem(placement: .topBarLeading) {
                BackButton { dismiss() }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        StationSelectionView(city: City.mock[0]) { _ in }
    }
}
