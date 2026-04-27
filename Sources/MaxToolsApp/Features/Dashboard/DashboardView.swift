import SwiftUI

struct DashboardView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                ToolHeader(
                    eyebrow: "本机专属",
                    title: "个人工具合集",
                    subtitle: "根据你的 Codex skills 重新生成：Apple 原生界面优先，服务器操作默认安全只读。",
                    systemImage: "square.grid.2x2"
                )

                HStack(spacing: 12) {
                    StatusCard(title: "自定义技能", value: "2", symbol: "person.crop.square.stack")
                    StatusCard(title: "工具入口", value: "\(ToolRegistry.tools.count - 1)", symbol: "hammer")
                    StatusCard(title: "安全策略", value: "只读优先", symbol: "lock.shield")
                }

                NativePanel {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("工具目录")
                                .font(.headline)
                            Spacer()
                            StatusPill(title: "液态玻璃", systemImage: "sparkles", color: .accentColor)
                        }

                        ForEach(ToolRegistry.tools.filter { $0.name != "总览" }) { tool in
                            HStack(spacing: 12) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.thinMaterial)
                                    Image(systemName: tool.systemImage)
                                        .foregroundStyle(.tint)
                                }
                                .frame(width: 34, height: 34)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(tool.name)
                                        .font(.callout.weight(.medium))
                                    Text(tool.summary)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                            }
                            .padding(.vertical, 6)

                            if tool.id != ToolRegistry.tools.last?.id {
                                Divider()
                            }
                        }
                    }
                }

                NativePanel {
                    HStack(spacing: 12) {
                        Image(systemName: "wand.and.stars")
                            .font(.title2)
                            .foregroundStyle(.tint)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("重新生成依据")
                                .font(.headline)
                            Text("已读取 apple-ui 和 my-servers：界面转向 Apple 原生工具风，服务器模块只记录规则，不保存敏感凭据。")
                                .font(.callout)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                }
            }
            .padding(24)
        }
        .scrollEdgeEffectStyle(.soft, for: .vertical)
    }
}

private struct StatusCard: View {
    let title: String
    let value: String
    let symbol: String

    var body: some View {
        NativePanel {
            VStack(alignment: .leading, spacing: 8) {
                Image(systemName: symbol)
                    .font(.title3)
                    .foregroundStyle(.tint)
                Text(value)
                    .font(.title2.weight(.semibold))
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
