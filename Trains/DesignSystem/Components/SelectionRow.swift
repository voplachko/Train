//
//  SelectionRow.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct SelectionRow: View {
    let title: String

    var body: some View {
        HStack(spacing: Dimen.x4) {
            Text(title)
                .font(.regular17)
                .foregroundStyle(Color.appBlack)
                .lineLimit(1)

            Spacer(minLength: 0)

            Image(systemName: "chevron.forward")
                .font(.system(size: Dimen.x4, weight: .semibold))
                .foregroundStyle(Color.appBlack)
        }
        .padding(.horizontal, Dimen.x4)
        .frame(height: Dimen.x15)
        .contentShape(Rectangle())
    }
}

#Preview {
    VStack(spacing: 0) {
        SelectionRow(title: "Москва")
        SelectionRow(title: "Санкт Петербург")
    }
}
