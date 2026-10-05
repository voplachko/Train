//
//  CarrierDetailsViewModel.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 29.09.2026.
//

import Combine
import Foundation

@MainActor
final class CarrierDetailsViewModel: ObservableObject {
    // MARK: - Properties

    @Published private(set) var carrier: Carrier

    private let repository: any CarrierRepository
    private var hasRefreshed = false

    // MARK: - Init

    init(carrier: Carrier, repository: any CarrierRepository = AppDependencies.carrierRepository) {
        self.carrier = carrier
        self.repository = repository
    }

    // MARK: - Output

    var emailLink: URL? {
        AppLinks.mail(carrier.email)
    }

    var phoneLink: URL? {
        AppLinks.phone(carrier.phone)
    }

    // MARK: - Intents

    func refresh() async {
        guard !hasRefreshed, let code = carrier.code else { return }
        hasRefreshed = true

        do {
            guard let fresh = try await repository.carrier(code: code) else { return }
            carrier = carrier.updated(with: fresh)
        } catch {
            if AppErrorMapper.isCancellation(error) {
                hasRefreshed = false
            }
        }
    }
}
