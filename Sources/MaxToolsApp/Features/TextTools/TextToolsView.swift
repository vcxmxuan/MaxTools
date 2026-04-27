import SwiftUI

struct TextToolsView: View {
    @State private var text = ""

    private var metrics: TextMetrics {
        TextMetrics(text)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            ToolHeader(
                eyebrow: "内容加工",
                title: "文本处理",
                subtitle: "统计字符、词语和行数，并快速做大小写转换。",
                systemImage: "textformat"
            )

            HStack(spacing: 12) {
                MetricView(title: "字符", value: metrics.characters)
                MetricView(title: "词语", value: metrics.words)
                MetricView(title: "行数", value: metrics.lines)
            }

            NativePanel {
                HStack {
                    Button {
                        text = text.uppercased()
                    } label: {
                        Label("转为大写", systemImage: "textformat.abc")
                    }
                    .buttonStyle(.glassProminent)

                    Button {
                        text = text.lowercased()
                    } label: {
                        Label("转为小写", systemImage: "textformat")
                    }
                    .buttonStyle(.glass)
                }
            }

            NativeTextEditor(text: $text)
                .frame(minHeight: 320)
        }
        .padding(24)
        .background(LiquidGlassBackground())
    }
}

private struct MetricView: View {
    let title: String
    let value: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value.formatted())
                .font(.title2.monospacedDigit())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay { RoundedRectangle(cornerRadius: 12).stroke(.white.opacity(0.22), lineWidth: 0.7) }
    }
}
