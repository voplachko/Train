//
//  TrainsApp.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 07.09.2026.
//

import SwiftUI

@main
struct TrainsApp: App {
    @State private var errorState = ErrorState()
    @State private var themeStore = ThemeStore()
    @State private var storiesStore = StoriesStore()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environment(errorState)
                .environment(themeStore)
                .environment(storiesStore)
                .preferredColorScheme(themeStore.colorScheme)
        }
    }
}
