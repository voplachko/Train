//
//  NotFoundView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct NotFoundView: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.bold24)
            .foregroundStyle(Color.appBlack)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 16)
    }
}

#Preview {
    NotFoundView(title: "Город не найден")
}
