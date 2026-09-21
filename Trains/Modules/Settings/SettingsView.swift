//
//  SettingsView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 17.09.2026.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Properties

    @Environment(ErrorState.self) private var errorState

    // MARK: - Body

    var body: some View {
        VStack(spacing: Dimen.x6) {
            Text(Strings.Settings.title)
                .font(.bold24)
                .foregroundStyle(Color.appBlack)

            #if DEBUG
            debugErrorControls
            #endif
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appWhite)
    }

    // MARK: - Debug

    #if DEBUG
    private var debugErrorControls: some View {
        VStack(spacing: Dimen.x3) {
            Button(Strings.Debug.showServerError) {
                errorState.show(.server)
            }
            Button(Strings.Debug.showNoInternet) {
                errorState.show(.noInternet)
            }
            Button(Strings.Debug.clearError, action: errorState.clear)
        }
        .font(.regular17)
        .tint(Color.appBlue)
    }
    #endif
}

// MARK: - Preview

#Preview {
    SettingsView()
        .environment(ErrorState())
}
