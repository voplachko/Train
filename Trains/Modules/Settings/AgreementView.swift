//
//  AgreementView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import SwiftUI

struct AgreementView: View {
    // MARK: - Properties

    @StateObject private var viewModel = AgreementViewModel()

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
        if let url = viewModel.url {
            WebView(url: url, isLoading: $viewModel.isLoading, hasFailed: $viewModel.hasFailed)
                .opacity(viewModel.hasFailed ? 0 : 1)
                .overlay {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(Color.appBlack)
                    }
                }
                .overlay {
                    if viewModel.hasFailed {
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
