//
//  CapturingBodySequence.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 02.10.2026.
//

import Foundation
import OpenAPIRuntime

struct CapturedBody: Sendable {
    let prefix: Data
    let totalBytes: Int

    var isComplete: Bool {
        prefix.count == totalBytes
    }
}

struct CapturingBodySequence: AsyncSequence, Sendable {
    typealias Element = HTTPBody.ByteChunk

    // MARK: - Properties

    let upstream: HTTPBody
    let captureLimit: Int
    let onFinish: @Sendable (CapturedBody) -> Void

    // MARK: - AsyncSequence

    func makeAsyncIterator() -> Iterator {
        Iterator(upstream: upstream.makeAsyncIterator(), captureLimit: captureLimit, onFinish: onFinish)
    }

    // MARK: - Iterator

    struct Iterator: AsyncIteratorProtocol {
        private var upstream: HTTPBody.Iterator
        private let captureLimit: Int
        private let onFinish: @Sendable (CapturedBody) -> Void

        private var captured = Data()
        private var totalBytes = 0
        private var isFinished = false

        init(
            upstream: HTTPBody.Iterator,
            captureLimit: Int,
            onFinish: @escaping @Sendable (CapturedBody) -> Void
        ) {
            self.upstream = upstream
            self.captureLimit = captureLimit
            self.onFinish = onFinish
        }

        mutating func next() async throws -> Element? {
            guard let chunk = try await upstream.next() else {
                finish()
                return nil
            }

            totalBytes += chunk.count

            let remainingCapacity = captureLimit - captured.count
            if remainingCapacity > 0 {
                captured.append(contentsOf: chunk.prefix(remainingCapacity))
            }

            return chunk
        }

        private mutating func finish() {
            guard !isFinished else { return }
            isFinished = true
            onFinish(CapturedBody(prefix: captured, totalBytes: totalBytes))
        }
    }
}
