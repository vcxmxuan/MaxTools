import SwiftUI

struct ClipboardToolsView: View {
    private let clipboard: ClipboardServicing = ClipboardService()
    @State private var text = ""

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 18) {
                ToolHeader(
                    eyebrow: "文本入口",
                    title: "剪贴板清理",
                    subtitle: "读取当前剪贴板，去掉首尾空白后重新复制回去。",
                    systemImage: "doc.on.clipboard"
                )

                NeonPanel {
                    HStack {
                        Button {
                            text = clipboard.readString()
                        } label: {
                            Label("读取剪贴板", systemImage: "arrow.down.doc")
                        }
                        .buttonStyle(NeonButtonStyle())

                        Button {
                            text = text.trimmingCharacters(in: .whitespacesAndNewlines)
                            clipboard.writeString(text)
                        } label: {
                            Label("清理并复制", systemImage: "wand.and.stars")
                        }
                        .buttonStyle(NeonButtonStyle())

                        Spacer()

                        Text("\(text.count) 个字符")
                            .font(.callout.monospacedDigit())
                            .foregroundStyle(.white.opacity(0.62))
                    }
                }

                GlassTextEditor(text: $text)
                    .frame(minHeight: 360)
            }
            .padding(24)
        }
    }
}
