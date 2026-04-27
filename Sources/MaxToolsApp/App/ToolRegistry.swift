import SwiftUI

enum ToolRegistry {
    static let tools: [ToolItem] = [
        ToolItem(
            name: "总览",
            summary: "查看所有个人工具和当前工作入口。",
            systemImage: "square.grid.2x2",
            destination: AnyView(DashboardView())
        ),
        ToolItem(
            name: "剪贴板",
            summary: "读取、清理并回写剪贴板文本。",
            systemImage: "doc.on.clipboard",
            destination: AnyView(ClipboardToolsView())
        ),
        ToolItem(
            name: "文本处理",
            summary: "统计文本，并快速转换大小写。",
            systemImage: "textformat",
            destination: AnyView(TextToolsView())
        ),
        ToolItem(
            name: "文件命名",
            summary: "把文件名整理成适合脚本和网址的格式。",
            systemImage: "folder",
            destination: AnyView(FileToolsView())
        ),
        ToolItem(
            name: "网络解析",
            summary: "快速拆解 URL 的协议、主机和路径。",
            systemImage: "network",
            destination: AnyView(NetworkToolsView())
        )
    ]

    static var defaultTool: ToolItem {
        tools[0]
    }

    static func tool(withID id: ToolItem.ID?) -> ToolItem? {
        tools.first { $0.id == id }
    }
}
