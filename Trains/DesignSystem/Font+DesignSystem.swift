//
//  Font+DesignSystem.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 17.09.2026.
//

import SwiftUI

extension Font {
    // MARK: - Regular

    static let regular12 = Font.system(size: 12, weight: .regular)
    static let regular17 = Font.system(size: 17, weight: .regular)
    static let regular20 = Font.system(size: 20, weight: .regular)

    // MARK: - Bold

    static let bold17 = Font.system(size: 17, weight: .bold)
    static let bold24 = Font.system(size: 24, weight: .bold)
    static let bold34 = Font.system(size: 34, weight: .bold)
}

// MARK: - Preview

#Preview {
    VStack(alignment: .leading, spacing: Dimen.x4) {
        Text("Regular/12").font(.regular12)
        Text("Regular/17").font(.regular17)
        Text("Regular/20").font(.regular20)
        Text("Bold/17").font(.bold17)
        Text("Bold/24").font(.bold24)
        Text("Bold/34").font(.bold34)
    }
    .foregroundStyle(Color.appBlack)
}
