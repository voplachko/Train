//
//  SettingsView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 17.09.2026.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Properties

    @Environment(ThemeStore.self) private var themeStore

    // MARK: - Body

    var body: some View {
        @Bindable var themeStore = themeStore

        NavigationStack {
            VStack(spacing: 0) {
                themeRow(isDarkTheme: $themeStore.isDarkTheme)

                NavigationLink(value: SettingsRoute.agreement) {
                    SelectionRow(title: Strings.Settings.agreement)
                }
                .buttonStyle(.plain)

                Spacer(minLength: 0)

                footer
            }
            .padding(.top, Dimen.x6)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.appWhite)
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: SettingsRoute.self) { route in
                destination(for: route)
            }
        }
    }

    // MARK: - Destinations

    @ViewBuilder
    private func destination(for route: SettingsRoute) -> some View {
        switch route {
        case .agreement:
            AgreementView()
        }
    }

    // MARK: - Subviews

    private func themeRow(isDarkTheme: Binding<Bool>) -> some View {
        HStack(spacing: Dimen.x4) {
            Text(Strings.Settings.darkTheme)
                .font(.regular17)
                .foregroundStyle(Color.appBlack)

            Spacer(minLength: 0)

            Toggle(Strings.Settings.darkTheme, isOn: isDarkTheme)
                .labelsHidden()
                .tint(Color.appBlue)
        }
        .padding(.horizontal, Dimen.x4)
        .frame(height: Dimen.x15)
    }

    private var footer: some View {
        VStack(spacing: Dimen.x4) {
            Text(Strings.Settings.apiNotice)
            Text(Strings.Settings.version)
        }
        .font(.regular12)
        .foregroundStyle(Color.appBlack)
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, Dimen.x4)
        .padding(.bottom, Dimen.x6)
    }
}

// MARK: - Preview

#Preview {
    SettingsView()
        .environment(ThemeStore())
}
