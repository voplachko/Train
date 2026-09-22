//
//  Story.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import SwiftUI

struct Story: Identifiable {
    // MARK: - Properties

    let id: Int
    let image: ImageResource
    let title: String
    let description: String
    var isViewed: Bool

    // MARK: - Init

    init(
        id: Int,
        image: ImageResource,
        title: String,
        description: String,
        isViewed: Bool = false
    ) {
        self.id = id
        self.image = image
        self.title = title
        self.description = description
        self.isViewed = isViewed
    }
}
