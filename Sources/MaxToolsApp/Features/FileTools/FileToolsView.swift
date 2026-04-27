import SwiftUI

struct FileToolsView: View {
    @State private var fileName = ""

    private var slug: String {
        fileName
            .lowercased()
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .filter { !$0.isEmpty }
            .joined(separator: "-")
    }

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 18) {
                ToolHeader(
                    eyebrow: "文件整理",
                    title: "文件命名",
                    subtitle: "把随手写的标题整理成稳定、适合脚本处理的短横线命名。",
                    systemImage: "folder"
                )

                NeonPanel {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("原始文件名")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.white.opacity(0.62))
                        TextField("输入文件名或标题", text: $fileName)
                            .textFieldStyle(.plain)
                            .font(.title3)
                            .foregroundStyle(.white)
                            .padding(12)
                            .background(Color.black.opacity(0.22))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }

                NeonPanel {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("整理结果")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.cyan)
                        Text(slug.isEmpty ? "-" : slug)
                            .font(.title3.monospaced())
                            .foregroundStyle(.white)
                            .textSelection(.enabled)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                Spacer()
            }
            .padding(24)
        }
    }
}
