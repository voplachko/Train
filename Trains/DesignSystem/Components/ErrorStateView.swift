//
//  ErrorStateView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct ErrorStateView: View {
    // MARK: - Properties

    let error: AppError

    // MARK: - Body

    var body: some View {
        VStack(spacing: Dimen.x4) {
            Image(error.image)
                .resizable()
                .scaledToFit()
                .frame(width: Dimen.x56, height: Dimen.x56)

            Text(error.title)
                .font(.bold24)
                .foregroundStyle(Color.appBlack)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, Dimen.x4)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appWhite)
    }
}

// MARK: - Modifier

extension View {
    func errorOverlay(_ error: AppError?, onTap: (() -> Void)? = nil) -> some View {
        overlay {
            if let error {
                ErrorStateView(error: error)
                    .contentShape(Rectangle())
                    .onTapGesture { onTap?() }
                    .transition(.opacity)
            }
        }
        .animation(AppAnimation.quick, value: error)
    }
}

// MARK: - Previews

#Preview("Ошибка сервера") {
    ErrorStateView(error: .server)
}

#Preview("Нет интернета") {
    ErrorStateView(error: .noInternet)
}
