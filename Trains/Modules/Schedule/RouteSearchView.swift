//
//  RouteSearchView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 17.09.2026.
//

import SwiftUI

struct RouteSearchView: View {
    let viewModel: ScheduleFlowViewModel

    var body: some View {
        VStack(spacing: Dimen.x4) {
            // TODO: stories collection goes here in the next sprint.

            RouteSelectorCard(
                from: viewModel.from,
                to: viewModel.to,
                onSelectFrom: { viewModel.selectPoint(for: .from) },
                onSelectTo: { viewModel.selectPoint(for: .to) },
                onSwap: viewModel.swapRoute
            )

            if viewModel.isRouteFilled {
                PrimaryButton.short("Найти", action: viewModel.search)
                    .transition(.opacity.combined(with: .scale(scale: 0.9)))
            }

            Spacer(minLength: 0)
        }
        .padding(.top, Dimen.x5)
        .padding(.horizontal, Dimen.x4)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.appWhite)
        .animation(.easeInOut(duration: 0.3), value: viewModel.isRouteFilled)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview("Пустой") {
    NavigationStack {
        RouteSearchView(viewModel: ScheduleFlowViewModel())
    }
}

#Preview("Заполненный") {
    NavigationStack {
        RouteSearchView(
            viewModel: ScheduleFlowViewModel(
                from: "Москва (Курский вокзал)",
                to: "Санкт Петербург (Балтийский вокзал)"
            )
        )
    }
}
