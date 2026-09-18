//
//  BackButton.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct BackButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(Color.appBlack)
        }
        .accessibilityLabel("Назад")
    }
}
