//
//  MainView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 17.09.2026.
//

import SwiftUI

struct MainView: View {
    private enum RouteField: Identifiable {
        case from
        case to

        var id: Self { self }
    }

    @State private var from: String
    @State private var to: String
    @State private var editedField: RouteField?

    init(from: String = "", to: String = "") {
        _from = State(initialValue: from)
        _to = State(initialValue: to)
    }

    private var isRouteFilled: Bool {
        !from.isEmpty && !to.isEmpty
    }

    var body: some View {
        VStack(spacing: 16) {
            // TODO: stories collection goes here in the next sprint.

            RouteSelectorCard(
                from: $from,
                to: $to,
                onSelectFrom: { editedField = .from },
                onSelectTo: { editedField = .to }
            )

            if isRouteFilled {
                PrimaryButton.short("Найти") {
                    // TODO: open the carriers list screen.
                }
                .transition(.opacity.combined(with: .scale(scale: 0.9)))
            }

            Spacer(minLength: 0)
        }
        .padding(.top, 20)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.appWhite)
        .animation(.easeInOut(duration: 0.3), value: isRouteFilled)
        .fullScreenCover(item: $editedField) { field in
            CitySelectionFlow { value in
                switch field {
                case .from:
                    from = value
                case .to:
                    to = value
                }
                editedField = nil
            }
        }
    }
}

#Preview("Пустой") {
    MainView()
}

#Preview("Заполненный") {
    MainView(from: "Москва (Курский вокзал)", to: "Санкт Петербург (Балтийский вокзал)")
}
