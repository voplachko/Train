//
//  NetworkReachability.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 27.09.2026.
//

import Foundation
import Network

enum NetworkReachability {
    private static let queue = DispatchQueue(label: "com.voplachko.Trains.reachability")

    static func isConnected() async -> Bool {
        await withCheckedContinuation { continuation in
            let monitor = NWPathMonitor()

            monitor.pathUpdateHandler = { path in
                monitor.pathUpdateHandler = nil
                monitor.cancel()
                continuation.resume(returning: path.status == .satisfied)
            }

            monitor.start(queue: queue)
        }
    }
}
