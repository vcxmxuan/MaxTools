import Foundation

struct TextMetrics: Equatable {
    let characters: Int
    let words: Int
    let lines: Int

    init(_ text: String) {
        characters = text.count
        words = text.split { $0.isWhitespace || $0.isNewline }.count
        lines = text.isEmpty ? 0 : text.components(separatedBy: .newlines).count
    }
}
