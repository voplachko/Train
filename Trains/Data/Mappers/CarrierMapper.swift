//
//  CarrierMapper.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 25.09.2026.
//

import Foundation

enum CarrierMapper {
    static func carrier(from dto: Components.Schemas.Carrier) -> Carrier? {
        guard let name = dto.title?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty else {
            return nil
        }

        return Carrier(
            id: dto.code.map { String($0) } ?? name,
            code: dto.code,
            name: name,
            logoURL: logoURL(from: dto.logo),
            email: dto.email?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
            phone: dto.phone?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        )
    }

    static func unknownCarrier(id: String) -> Carrier {
        Carrier(id: id, name: Strings.Carriers.unknownCarrier)
    }

    // MARK: - Private

    private static func logoURL(from string: String?) -> URL? {
        guard let string, !string.isEmpty else { return nil }

        let normalized = string.hasPrefix("//") ? "https:" + string : string
        return URL(string: normalized)
    }
}
