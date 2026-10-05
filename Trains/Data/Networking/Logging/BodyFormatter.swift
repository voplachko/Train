//
//  BodyFormatter.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 04.10.2026.
//

import Foundation

enum BodyFormatter {
    struct Output {
        let lines: [String]
        let isTruncated: Bool
    }

    private enum Constants {
        static let indent = "  "
        static let maxLineLength = 300
        static let ellipsis = "…"
    }

    // MARK: - Formatting

    static func format(_ data: Data, maxLines: Int) -> Output {
        let text = String(decoding: data, as: UTF8.self)
        let output = looksLikeJSON(text)
            ? formatJSON(text, maxLines: maxLines)
            : formatPlainText(text, maxLines: maxLines)

        return Output(lines: output.lines.map(limitLength), isTruncated: output.isTruncated)
    }

    // MARK: - JSON

    private static func looksLikeJSON(_ text: String) -> Bool {
        guard let first = text.first(where: { !$0.isWhitespace }) else { return false }
        return first == "{" || first == "["
    }

    private static func formatJSON(_ text: String, maxLines: Int) -> Output {
        var lines: [String] = []
        var line = ""
        var depth = 0

        var isInsideString = false
        var isEscaped = false
        var needsLineBreak = false
        var lastWasOpening = false

        func breakLine() {
            lines.append(line)
            line = String(repeating: Constants.indent, count: depth)
        }

        for character in text {
            if lines.count >= maxLines {
                return Output(lines: lines, isTruncated: true)
            }

            if isInsideString {
                line.append(character)
                if isEscaped {
                    isEscaped = false
                } else if character == "\\" {
                    isEscaped = true
                } else if character == "\"" {
                    isInsideString = false
                }
                continue
            }

            if character.isWhitespace {
                continue
            }

            switch character {
            case "}", "]":
                depth = max(depth - 1, 0)
                if !lastWasOpening {
                    breakLine()
                }
                needsLineBreak = false
                line.append(character)
                lastWasOpening = false

            default:
                if needsLineBreak {
                    breakLine()
                    needsLineBreak = false
                }

                switch character {
                case "{", "[":
                    line.append(character)
                    depth += 1
                    needsLineBreak = true
                    lastWasOpening = true
                    continue
                case ",":
                    line.append(character)
                    needsLineBreak = true
                case ":":
                    line.append(": ")
                case "\"":
                    line.append(character)
                    isInsideString = true
                default:
                    line.append(character)
                }
                lastWasOpening = false
            }
        }

        if !line.trimmingCharacters(in: .whitespaces).isEmpty {
            lines.append(line)
        }
        return Output(lines: lines, isTruncated: false)
    }

    // MARK: - Plain text

    private static func formatPlainText(_ text: String, maxLines: Int) -> Output {
        let allLines = text.split(separator: "\n", omittingEmptySubsequences: false)
        return Output(
            lines: allLines.prefix(maxLines).map { String($0) },
            isTruncated: allLines.count > maxLines
        )
    }

    // MARK: - Helpers

    private static func limitLength(_ line: String) -> String {
        guard line.count > Constants.maxLineLength else { return line }
        return String(line.prefix(Constants.maxLineLength)) + Constants.ellipsis
    }
}
