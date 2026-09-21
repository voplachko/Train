//
//  SelectionRow.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct SelectionRow: View {
    // MARK: - Properties

    let title: String

    // MARK: - Body

    var body: some View {
        HStack(spacing: Dimen.x4) {
            Text(title)
                .font(.regular17)
                .foregroundStyle(Color.appBlack)
                .lineLimit(AppStyle.singleLine)

            Spacer(minLength: 0)

            Image(symbol: .chevronForward)
                .font(.system(size: Dimen.x4, weight: .semibold))
                .foregroundStyle(Color.appBlack)
        }
        .padding(.horizontal, Dimen.x4)
        .frame(height: Dimen.x15)
        .contentShape(Rectangle())
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 0) {
        ForEach(MockData.cities.prefix(2)) { city in
            SelectionRow(title: city.name)
        }
    }
}
