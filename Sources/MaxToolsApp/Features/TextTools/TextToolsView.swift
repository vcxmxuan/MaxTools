import SwiftUI

struct TextToolsView: View {
    @State private var text = ""

    private var metrics: TextMetrics {
        TextMetrics(text)
    }

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()

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

                NeonPanel {
                    HStack {
                        Button {
                            text = text.uppercased()
                        } label: {
                            Label("转为大写", systemImage: "textformat.abc")
                        }
                        .buttonStyle(NeonButtonStyle())

                        Button {
                            text = text.lowercased()
                        } label: {
                            Label("转为小写", systemImage: "textformat")
                        }
                        .buttonStyle(NeonButtonStyle())
                    }
                }

                GlassTextEditor(text: $text)
                    .frame(minHeight: 320)
            }
            .padding(24)
        }
    }
}

private struct MetricView: View {
    let title: String
    let value: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.58))
            Text(value.formatted())
                .font(.title2.monospacedDigit())
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(AppTheme.panel)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay { RoundedRectangle(cornerRadius: 8).stroke(AppTheme.stroke) }
    }
}
