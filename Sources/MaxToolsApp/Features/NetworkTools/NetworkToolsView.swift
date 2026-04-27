import SwiftUI

struct NetworkToolsView: View {
    @State private var rawURL = ""

    private var parsedURL: URL? {
        URL(string: rawURL)
    }

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 18) {
                ToolHeader(
                    eyebrow: "接口辅助",
                    title: "网络解析",
                    subtitle: "输入一个 URL，立即拆解协议、主机和路径。",
                    systemImage: "network"
                )

                NeonPanel {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("URL")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.white.opacity(0.62))
                        TextField("https://example.com/path", text: $rawURL)
                            .textFieldStyle(.plain)
                            .font(.title3)
                            .foregroundStyle(.white)
                            .padding(12)
                            .background(Color.black.opacity(0.22))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
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
        }
    }
}

private struct URLPartRow: View {
    let title: String
    let value: String

    var body: some View {
        NeonPanel {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.7))
                    .frame(width: 72, alignment: .leading)
                Text(value)
                    .font(.body.monospaced())
                    .foregroundStyle(.white)
                    .textSelection(.enabled)
                Spacer()
            }
        }
    }
}
