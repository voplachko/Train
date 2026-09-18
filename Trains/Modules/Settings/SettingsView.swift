//
//  SettingsView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 17.09.2026.
//

import SwiftUI

struct SettingsView: View {
    @Environment(ErrorState.self) private var errorState

    var body: some View {
        VStack(spacing: Dimen.x6) {
            Text("Настройки")
                .font(.bold24)
                .foregroundStyle(Color.appBlack)

            #if DEBUG
            debugErrorControls
            #endif
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appWhite)
    }

    #if DEBUG
    private var debugErrorControls: some View {
        VStack(spacing: Dimen.x3) {
            Button("Показать «Ошибка сервера»") {
                errorState.show(.server)
            }
            Button("Показать «Нет интернета»") {
                errorState.show(.noInternet)
            }
            Button("Убрать ошибку", action: errorState.clear)
        }
        .font(.regular17)
        .tint(Color.appBlue)
    }
    #endif
}

#Preview {
    SettingsView()
        .environment(ErrorState())
}
