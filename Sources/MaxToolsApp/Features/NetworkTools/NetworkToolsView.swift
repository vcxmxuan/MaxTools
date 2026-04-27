import SwiftUI

struct NetworkToolsView: View {
    @State private var rawURL = ""

    private var parsedURL: URL? {
        URL(string: rawURL)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            ToolHeader(
                eyebrow: "接口辅助",
                title: "URL 解析",
                subtitle: "输入一个 URL，立即拆解协议、主机和路径。",
                systemImage: "link"
            )

            NativePanel {
                VStack(alignment: .leading, spacing: 12) {
                    Text("URL")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                    TextField("https://example.com/path", text: $rawURL)
                        .textFieldStyle(.roundedBorder)
                        .font(.title3)
                }
            }

            VStack(spacing: 12) {
                URLPartRow(title: "协议", value: parsedURL?.scheme ?? "-")
                URLPartRow(title: "主机", value: parsedURL?.host() ?? "-")
                URLPartRow(
                    title: "路径",
                    value: parsedURL?.path(percentEncoded: false).isEmpty == false ? parsedURL?.path(percentEncoded: false) ?? "-" : "-"
                )
            }

            Spacer()
        }
        .padding(24)
        .background(AppTheme.page)
    }
}

private struct URLPartRow: View {
    let title: String
    let value: String

    var body: some View {
        NativePanel {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .frame(width: 72, alignment: .leading)
                Text(value)
                    .font(.body.monospaced())
                    .textSelection(.enabled)
                Spacer()
            }
        }
    }
}
