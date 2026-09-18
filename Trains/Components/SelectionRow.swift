//
//  SelectionRow.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct SelectionRow: View {
    private enum Layout {
        static let height: CGFloat = 60
        static let horizontalPadding: CGFloat = 16
    }

    let title: String

    var body: some View {
        HStack(spacing: Layout.horizontalPadding) {
            Text(title)
                .font(.regular17)
                .foregroundStyle(Color.appBlack)
                .lineLimit(1)

            Spacer(minLength: 0)

            Image(systemName: "chevron.forward")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(Color.appBlack)
        }
        .padding(.horizontal, Layout.horizontalPadding)
        .frame(height: Layout.height)
        .contentShape(Rectangle())
    }
}

#Preview {
    VStack(spacing: 0) {
        SelectionRow(title: "Москва")
        SelectionRow(title: "Санкт Петербург")
    }
}
