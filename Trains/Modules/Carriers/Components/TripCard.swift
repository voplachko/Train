//
//  TripCard.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 18.09.2026.
//

import SwiftUI

struct TripCard: View {
    let trip: Trip

    var body: some View {
        VStack(alignment: .leading, spacing: Dimen.x5) {
            header
            timeline
        }
        .padding(Dimen.x4)
        .background(
            RoundedRectangle(cornerRadius: Dimen.x6, style: .continuous)
                .fill(Color.appLightGray)
        )
    }

    private var header: some View {
        HStack(alignment: .top, spacing: Dimen.x2) {
            CarrierLogo(carrier: trip.carrier)

            VStack(alignment: .leading, spacing: 0) {
                Text(trip.carrier.name)
                    .font(.regular17)
                    .foregroundStyle(Color.appBlackUniversal)
                    .lineLimit(1)

                if let transferText = trip.transferText {
                    Text(transferText)
                        .font(.regular12)
                        .foregroundStyle(Color.appRed)
                        .lineLimit(1)
                }
            }

            Spacer(minLength: Dimen.x2)

            Text(trip.date)
                .font(.regular12)
                .foregroundStyle(Color.appBlackUniversal)
                .lineLimit(1)
        }
    }

    private var timeline: some View {
        HStack(spacing: Dimen.x1) {
            Text(trip.departure)
                .font(.regular17)
                .foregroundStyle(Color.appBlackUniversal)

            separator

            Text(trip.durationText)
                .font(.regular12)
                .foregroundStyle(Color.appBlackUniversal)
                .lineLimit(1)
                .fixedSize()

            separator

            Text(trip.arrival)
                .font(.regular17)
                .foregroundStyle(Color.appBlackUniversal)
        }
    }

    private var separator: some View {
        Rectangle()
            .fill(Color.appGray)
            .frame(height: Dimen.hairline)
    }
}

private struct CarrierLogo: View {
    let carrier: Carrier

    var body: some View {
        Group {
            if let logoURL = carrier.logoURL {
                AsyncImage(url: logoURL) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    placeholder
                }
            } else {
                placeholder
            }
        }
        .frame(width: Dimen.x9, height: Dimen.x9)
        .background(Color.appWhiteUniversal)
        .clipShape(RoundedRectangle(cornerRadius: Dimen.x3, style: .continuous))
    }

    private var placeholder: some View {
        Text(String(carrier.name.prefix(1)))
            .font(.bold17)
            .foregroundStyle(Color.appGray)
    }
}

#Preview {
    VStack(spacing: Dimen.x2) {
        ForEach(MockTripRepository().trips(for: RouteQuery(from: "Москва", to: "Сочи")).prefix(2)) { trip in
            TripCard(trip: trip)
        }
    }
    .padding(.horizontal, Dimen.x4)
}
