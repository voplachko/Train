//
//  RootTabView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 07.09.2026.
//

import SwiftUI

struct RootTabView: View {
    enum Tab {
        case schedule
        case settings
    }

    @Environment(ErrorState.self) private var errorState

    @State private var selectedTab: Tab = .schedule

    var body: some View {
        TabView(selection: $selectedTab) {
            ScheduleFlowView()
                .errorOverlay(errorState.current, onTap: clearErrorInDebug)
                .tag(Tab.schedule)
                .tabItem {
                    Image(selectedTab == .schedule ? .icTabMainActive : .icTabMainInactive)
                }

            SettingsView()
                .errorOverlay(errorState.current, onTap: clearErrorInDebug)
                .tag(Tab.settings)
                .tabItem {
                    Image(selectedTab == .settings ? .icTabSettingsActive : .icTabSettingsInactive)
                }
        }
        .tint(Color.appBlack)
    }

    private func clearErrorInDebug() {
        #if DEBUG
        errorState.clear()
        #endif
    }
}

#Preview {
    RootTabView()
        .environment(ErrorState())
}
