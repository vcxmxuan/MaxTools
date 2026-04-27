import SwiftUI

struct ServerOpsView: View {
    private let checks = [
        ServerCheck(title: "站点可达性", detail: "检查主域名、HTTPS 状态和响应时间。", systemImage: "globe"),
        ServerCheck(title: "宝塔面板", detail: "优先通过面板查看网站、证书、数据库、计划任务和日志。", systemImage: "rectangle.and.text.magnifyingglass"),
        ServerCheck(title: "资源状态", detail: "先看 CPU、内存、磁盘、进程和网络，再判断是否需要变更。", systemImage: "gauge.with.dots.needle.67percent"),
        ServerCheck(title: "日志排查", detail: "读取 nginx、应用和数据库日志，先定位原因，再考虑操作。", systemImage: "doc.text.magnifyingglass"),
        ServerCheck(title: "生产变更", detail: "重启服务、修改防火墙、部署代码、改数据库前必须确认。", systemImage: "lock.shield")
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                ToolHeader(
                    eyebrow: "生产安全",
                    title: "服务器运维",
                    subtitle: "根据 my-servers skill 生成：默认只读检查，涉及生产变更时先确认。",
                    systemImage: "server.rack"
                )

                NativePanel {
                    HStack(spacing: 12) {
                        StatusPill(title: "JD Cloud", systemImage: "cloud", color: .accentColor)
                        StatusPill(title: "宝塔优先", systemImage: "rectangle.and.hand.point.up.left", color: .green)
                        StatusPill(title: "生产环境", systemImage: "exclamationmark.triangle", color: .orange)
                        Spacer()
                    }
                }

                VStack(spacing: 10) {
                    ForEach(checks) { check in
                        NativePanel {
                            HStack(alignment: .top, spacing: 14) {
                                Image(systemName: check.systemImage)
                                    .font(.title3)
                                    .foregroundStyle(.tint)
                                    .frame(width: 28)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(check.title)
                                        .font(.headline)
                                    Text(check.detail)
                                        .font(.callout)
                                        .foregroundStyle(.secondary)
                                }

                                Spacer()
                            }
                        }
                    }
                }

                NativePanel {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("安全边界")
                            .font(.headline)
                        Text("项目只记录流程和规则，不写入服务器密码、数据库密码、面板密钥或私钥。任何生产变更都应先确认目标、备份和回滚方式。")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(24)
        }
        .background(LiquidGlassBackground())
    }
}

private struct ServerCheck: Identifiable {
    let id = UUID()
    let title: String
    let detail: String
    let systemImage: String
}
