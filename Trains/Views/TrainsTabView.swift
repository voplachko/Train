//
//  TrainsTabView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 07.09.2026.
//

import SwiftUI

enum Tab {
    case main
    case settings
}

struct TrainsTabView: View {
    @State private var selectedTab: Tab = .main
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MainView()
                .tag(Tab.main)
                .tabItem {
                    Image(selectedTab == .main ? .icTabMainActive : .icTabMainInactive)
                }
            
            SettingsView()
                .tag(Tab.settings)
                .tabItem {
                    Image(selectedTab == .settings ? .icTabSettingsActive : .icTabSettingsInactive)
                }
        }
        
    }
}

#Preview {
    TrainsTabView()
}
