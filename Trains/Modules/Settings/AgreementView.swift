//
//  AgreementView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import SwiftUI

struct AgreementView: View {
    // MARK: - Properties

    @State private var isLoading = true
    @State private var hasFailed = false

    // MARK: - Body

    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appWhite)
            .navigationTitle(Strings.Settings.agreement)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
    }

    // MARK: - Subviews

    @ViewBuilder
    private var content: some View {
        if let url = AppLinks.userAgreement {
            WebView(url: url, isLoading: $isLoading, hasFailed: $hasFailed)
                .opacity(hasFailed ? 0 : 1)
                .overlay {
                    if isLoading {
                        ProgressView()
                            .tint(Color.appBlack)
                    }
                }
                .overlay {
                    if hasFailed {
                        ErrorStateView(error: .noInternet)
                    }
                }
        } else {
            ErrorStateView(error: .server)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        AgreementView()
    }
}
