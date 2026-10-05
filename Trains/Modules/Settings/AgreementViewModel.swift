//
//  AgreementViewModel.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 30.09.2026.
//

import Combine
import Foundation

@MainActor
final class AgreementViewModel: ObservableObject {
    // MARK: - Properties

    let url: URL?

    @Published var isLoading = true
    @Published var hasFailed = false

    // MARK: - Init

    init(url: URL? = AppLinks.userAgreement) {
        self.url = url
    }
}
