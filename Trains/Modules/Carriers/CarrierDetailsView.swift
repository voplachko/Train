//
//  CarrierDetailsView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import SwiftUI

struct CarrierDetailsView: View {
    // MARK: - Properties

    let carrier: Carrier

    // MARK: - Body

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: Dimen.x4) {
                CarrierLogo(carrier: carrier, size: .large)

                Text(carrier.name)
                    .font(.bold24)
                    .foregroundStyle(Color.appBlack)
                    .fixedSize(horizontal: false, vertical: true)

                contacts
            }
            .padding(.horizontal, Dimen.x4)
            .padding(.top, Dimen.x4)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appWhite)
        .navigationTitle(Strings.CarrierDetails.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }

    // MARK: - Subviews

    private var contacts: some View {
        VStack(alignment: .leading, spacing: Dimen.x4) {
            if carrier.hasEmail {
                contact(
                    title: Strings.CarrierDetails.email,
                    value: carrier.email,
                    link: AppLinks.mail(carrier.email)
                )
            }

            if carrier.hasPhone {
                contact(
                    title: Strings.CarrierDetails.phone,
                    value: carrier.phone,
                    link: AppLinks.phone(carrier.phone)
                )
            }
        }
        .padding(.top, Dimen.x2)
    }

    private func contact(title: String, value: String, link: URL?) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.regular17)
                .foregroundStyle(Color.appBlack)

            if let link {
                Link(value, destination: link)
                    .font(.regular12)
                    .foregroundStyle(Color.appBlue)
            } else {
                Text(value)
                    .font(.regular12)
                    .foregroundStyle(Color.appBlue)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        if let carrier = MockData.carrier {
            CarrierDetailsView(carrier: carrier)
        }
    }
}
