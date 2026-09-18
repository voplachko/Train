//
//  EmptyStateView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct EmptyStateView: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.bold24)
            .foregroundStyle(Color.appBlack)
            .multilineTextAlignment(.center)
            .padding(.horizontal, Dimen.x4)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    EmptyStateView(title: "Вариантов нет")
}
