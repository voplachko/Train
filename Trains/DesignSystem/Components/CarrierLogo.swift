//
//  CarrierLogo.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import SwiftUI

struct CarrierLogo: View {
    enum Size {
        case small
        case large

        var height: CGFloat {
            switch self {
            case .small: return Dimen.x9
            case .large: return Dimen.x26
            }
        }

        var width: CGFloat? {
            switch self {
            case .small: return Dimen.x9
            case .large: return nil
            }
        }

        var cornerRadius: CGFloat {
            switch self {
            case .small: return Dimen.x3
            case .large: return Dimen.x6
            }
        }

        var font: Font {
            switch self {
            case .small: return .bold17
            case .large: return .bold34
            }
        }

        var padding: CGFloat {
            switch self {
            case .small: return 0
            case .large: return Dimen.x4
            }
        }
    }

    // MARK: - Properties

    let carrier: Carrier
    var size: Size = .small

    // MARK: - Body

    var body: some View {
        logo
            .padding(size.padding)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(width: size.width, height: size.height)
            .background(Color.appWhiteUniversal)
            .clipShape(RoundedRectangle(cornerRadius: size.cornerRadius, style: .continuous))
    }

    // MARK: - Subviews

    @ViewBuilder
    private var logo: some View {
        if let logoURL = carrier.logoURL {
            AsyncImage(url: logoURL) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                placeholder
            }
        } else {
            placeholder
        }
    }

    private var placeholder: some View {
        Text(placeholderTitle)
            .font(size.font)
            .foregroundStyle(placeholderColor)
            .lineLimit(AppStyle.singleLine)
            .minimumScaleFactor(AppStyle.minimumScaleFactor)
            .accessibilityLabel(Strings.CarrierDetails.logoAccessibilityLabel)
    }

    private var placeholderTitle: String {
        switch size {
        case .small: return String(carrier.name.prefix(AppStyle.singleLine))
        case .large: return carrier.name
        }
    }

    private var placeholderColor: Color {
        switch size {
        case .small: return Color.appGray
        case .large: return Color.appBlackUniversal
        }
    }
}

// MARK: - Previews

#Preview("Маленький") {
    CarrierLogo(carrier: MockData.carrier)
}

#Preview("Большой") {
    CarrierLogo(carrier: MockData.carrier, size: .large)
        .padding(.horizontal, Dimen.x4)
}
