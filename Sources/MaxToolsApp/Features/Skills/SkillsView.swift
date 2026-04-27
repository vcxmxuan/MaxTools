import SwiftUI

struct SkillsView: View {
    private let skills = [
        SkillSummary(
            name: "apple-ui",
            role: "Apple 原生界面设计",
            summary: "用于 SwiftUI、AppKit、macOS 工具、现代玻璃质感界面和避免模板化界面。",
            systemImage: "macwindow",
            status: "已读取"
        ),
        SkillSummary(
            name: "my-servers",
            role: "个人服务器运维规则",
            summary: "用于 JD Cloud、宝塔面板、vcxmx.icu、部署、日志、监控和生产安全流程。",
            systemImage: "server.rack",
            status: "敏感信息不入库"
        ),
        SkillSummary(
            name: "imagegen",
            role: "位图视觉生成",
            summary: "用于生成照片、插画、纹理、精灵图、透明背景素材和视觉变体。",
            systemImage: "photo.on.rectangle.angled",
            status: "系统技能"
        ),
        SkillSummary(
            name: "openai-docs",
            role: "OpenAI 官方文档",
            summary: "用于查询 OpenAI API、模型、升级和提示词迁移的最新官方信息。",
            systemImage: "doc.text.magnifyingglass",
            status: "系统技能"
        ),
        SkillSummary(
            name: "skill-creator / installer",
            role: "技能创建与安装",
            summary: "用于创建、维护、安装 Codex skills，让工作流继续沉淀成本机能力。",
            systemImage: "wrench.and.screwdriver",
            status: "系统技能"
        )
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                ToolHeader(
                    eyebrow: "本机能力",
                    title: "技能总览",
                    subtitle: "根据当前 Codex skills 重新生成的能力目录，界面和工具优先服务这些真实工作流。",
                    systemImage: "sparkles.rectangle.stack"
                )

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 280), spacing: 12)], spacing: 12) {
                    ForEach(skills) { skill in
                        NativePanel {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Image(systemName: skill.systemImage)
                                        .font(.title2)
                                        .foregroundStyle(.tint)
                                    Spacer()
                                    StatusPill(title: skill.status, systemImage: "checkmark.circle", color: .green)
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(skill.name)
                                        .font(.headline)
                                    Text(skill.role)
                                        .font(.subheadline.weight(.medium))
                                        .foregroundStyle(.secondary)
                                }

                                Text(skill.summary)
                                    .font(.callout)
                                    .foregroundStyle(.secondary)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .frame(maxWidth: .infinity, minHeight: 170, alignment: .topLeading)
                        }
                    }
                }
            }
            .padding(24)
        }
        .background(AppTheme.page)
    }
}

private struct SkillSummary: Identifiable {
    let id = UUID()
    let name: String
    let role: String
    let summary: String
    let systemImage: String
    let status: String
}
