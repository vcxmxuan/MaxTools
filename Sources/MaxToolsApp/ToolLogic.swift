import Foundation

public struct TextMetrics: Equatable {
    public let characters: Int
    public let words: Int
    public let lines: Int

    public init(_ text: String) {
        characters = text.count
        words = text.split { $0.isWhitespace || $0.isNewline }.count
        lines = text.isEmpty ? 0 : text.components(separatedBy: .newlines).count
    }
}

enum ToolSection: String, CaseIterable, Identifiable {
    case overview = "总览"
    case skills = "技能"
    case clipboard = "剪贴板"
    case text = "文本"
    case files = "文件"
    case server = "服务器"
    case url = "URL"

    var id: String { rawValue }

    var symbol: String {
        switch self {
        case .overview: "square.grid.2x2"
        case .skills: "sparkles.rectangle.stack"
        case .clipboard: "doc.on.clipboard"
        case .text: "textformat"
        case .files: "folder"
        case .server: "server.rack"
        case .url: "link"
        }
    }

    var summary: String {
        switch self {
        case .overview: "个人工具入口和当前状态。"
        case .skills: "本机 Codex skills 规则摘要。"
        case .clipboard: "读取、清理和写回剪贴板文本。"
        case .text: "统计字符、词语和行数。"
        case .files: "整理文件名和短横线命名。"
        case .server: "服务器只读检查和生产安全边界。"
        case .url: "拆解 URL 的协议、主机和路径。"
        }
    }
}
