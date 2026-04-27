import SwiftUI

struct ClipboardToolsView: View {
    private let clipboard: ClipboardServicing = ClipboardService()
    @State private var text = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            ToolHeader(
                eyebrow: "文本入口",
                title: "剪贴板清理",
                subtitle: "读取当前剪贴板，去掉首尾空白后重新复制回去。",
                systemImage: "doc.on.clipboard"
            )

            NativePanel {
                HStack {
                    Button {
                        text = clipboard.readString()
                    } label: {
                        Label("读取剪贴板", systemImage: "arrow.down.doc")
                    }
                    .buttonStyle(.glassProminent)

                    Button {
                        text = text.trimmingCharacters(in: .whitespacesAndNewlines)
                        clipboard.writeString(text)
                    } label: {
                        Label("清理并复制", systemImage: "wand.and.stars")
                    }
                    .buttonStyle(.glass)

                    Spacer()

                    Text("\(text.count) 个字符")
                        .font(.callout.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
            }

            NativeTextEditor(text: $text)
                .frame(minHeight: 360)
        }
        .padding(24)
        .background(LiquidGlassBackground())
    }
}
