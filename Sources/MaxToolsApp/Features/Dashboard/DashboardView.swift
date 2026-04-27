import SwiftUI

struct DashboardView: View {
    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    ToolHeader(
                        eyebrow: "本机专属",
                        title: "个人工具合集",
                        subtitle: "把高频的小动作收进一个干净、快速、只为你服务的 macOS 工具舱。",
                        systemImage: "sparkles"
                    )

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 230), spacing: 14)], spacing: 14) {
                        ForEach(ToolRegistry.tools.filter { $0.name != "总览" }) { tool in
                            NeonPanel {
                                VStack(alignment: .leading, spacing: 12) {
                                    ZStack {
                                        Circle()
                                            .fill(AppTheme.accent)
                                        Image(systemName: tool.systemImage)
                                            .font(.title2.weight(.semibold))
                                            .foregroundStyle(.white)
                                    }
                                    .frame(width: 46, height: 46)

                                    Text(tool.name)
                                        .font(.headline)
                                        .foregroundStyle(.white)

                                    Text(tool.summary)
                                        .font(.subheadline)
                                        .foregroundStyle(.white.opacity(0.66))
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                .frame(maxWidth: .infinity, minHeight: 142, alignment: .topLeading)
                            }
                        }
                    }

                    NeonPanel {
                        HStack(spacing: 16) {
                            Image(systemName: "bolt.horizontal.circle.fill")
                                .font(.system(size: 34))
                                .foregroundStyle(.cyan)
                            VStack(alignment: .leading, spacing: 6) {
                                Text("下一步可以继续扩展")
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text("新增工具时，只要添加一个 Feature 页面，并在工具注册表里加入入口。")
                                    .font(.subheadline)
                                    .foregroundStyle(.white.opacity(0.64))
                            }
                        }
                    }
                }
                .padding(24)
            }
        }
    }
}
