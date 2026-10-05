//
//  RootTabView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 07.09.2026.
//

import SwiftUI

struct RootTabView: View {
    private enum Tab {
        case schedule
        case settings
    }

    // MARK: - Properties

    @State private var selectedTab: Tab = .schedule

    // MARK: - Body

    var body: some View {
        TabView(selection: $selectedTab) {
            ScheduleFlowView()
                .tag(Tab.schedule)
                .tabItem {
                    Image(selectedTab == .schedule ? .icTabMainActive : .icTabMainInactive)
                }

            SettingsView()
                .tag(Tab.settings)
                .tabItem {
                    Image(selectedTab == .settings ? .icTabSettingsActive : .icTabSettingsInactive)
                }
        }
        .tint(Color.appBlack)
    }
}

// MARK: - Preview

#Preview {
    RootTabView()
        .environment(ThemeStore())
        .environment(StoriesStore())
}
