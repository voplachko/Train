//
//  EmptyStateView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct EmptyStateView: View {
    // MARK: - Properties

    let title: String

    // MARK: - Body

    var body: some View {
        Text(title)
            .font(.bold24)
            .foregroundStyle(Color.appBlack)
            .multilineTextAlignment(.center)
            .padding(.horizontal, Dimen.x4)
            .frame(maxWidth: .infinity)
    }
}

// MARK: - Preview

#Preview {
    EmptyStateView(title: Strings.Carriers.empty)
}
