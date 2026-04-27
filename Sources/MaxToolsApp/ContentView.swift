import AppKit
import SwiftUI

struct ContentView: View {
    @State private var selection: ToolSection? = .overview
    @State private var searchText = ""
    @State private var workingText = ""
    @State private var fileName = ""
    @State private var rawURL = ""

    private var selectedSection: ToolSection {
        selection ?? .overview
    }

    private var metrics: TextMetrics {
        TextMetrics(workingText)
    }

    private var slug: String {
        fileName
            .lowercased()
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .filter { !$0.isEmpty }
            .joined(separator: "-")
    }

    private var parsedURL: URL? {
        URL(string: rawURL)
    }

    var body: some View {
        NavigationSplitView {
            List(ToolSection.allCases, selection: $selection) { section in
                Label(section.rawValue, systemImage: section.symbol)
                    .tag(section)
            }
            .navigationTitle("MaxTools")
            .searchable(text: $searchText, prompt: "搜索工具")
        } detail: {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    header

                    switch selectedSection {
                    case .overview:
                        overview
                    case .skills:
                        skills
                    case .clipboard:
                        clipboard
                    case .text:
                        textTools
                    case .files:
                        fileTools
                    case .server:
                        server
                    case .url:
                        urlTools
                    }
                }
                .padding(28)
            }
            .scrollEdgeEffectStyle(.soft, for: .vertical)
            .background(Color(nsColor: .windowBackgroundColor).backgroundExtensionEffect())
        }
        .toolbar {
            ToolbarSpacer(.flexible)

            ToolbarItem(placement: .principal) {
                Text(selectedSection.rawValue)
                    .font(.headline)
            }

            ToolbarSpacer(.fixed)

            ToolbarItem {
                Button {
                    selection = .overview
                } label: {
                    Label("总览", systemImage: ToolSection.overview.symbol)
                }
                .buttonStyle(.glass)
            }
        }
    }

    private var header: some View {
        HStack(spacing: 14) {
            Image(systemName: selectedSection.symbol)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(.tint)
                .frame(width: 56, height: 56)
                .glassEffect(.clear.interactive(), in: RoundedRectangle(cornerRadius: 16, style: .continuous))

            VStack(alignment: .leading, spacing: 4) {
                Text(selectedSection.rawValue)
                    .font(.system(size: 30, weight: .semibold, design: .rounded))
                Text(selectedSection.summary)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
    }

    private var overview: some View {
        GlassEffectContainer(spacing: 14) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 220), spacing: 14)], spacing: 14) {
                ForEach(ToolSection.allCases.filter { $0 != .overview }) { section in
                    Button {
                        selection = section
                    } label: {
                        VStack(alignment: .leading, spacing: 10) {
                            Image(systemName: section.symbol)
                                .font(.title2)
                                .foregroundStyle(.tint)
                            Text(section.rawValue)
                                .font(.headline)
                            Text(section.summary)
                                .font(.callout)
                                .foregroundStyle(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .frame(maxWidth: .infinity, minHeight: 120, alignment: .topLeading)
                        .padding(16)
                    }
                    .buttonStyle(.plain)
                    .glassEffect(.regular.interactive(), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                }
            }
        }
    }

    private var skills: some View {
        VStack(alignment: .leading, spacing: 12) {
            infoRow("apple-ui", "macOS 26、SwiftUI、真实 Liquid Glass、无渐变、单色 SF Symbols。", "macwindow")
            infoRow("my-servers", "服务器工作默认只读检查，生产变更前确认，不保存敏感凭据。", "server.rack")
            infoRow("openai-docs", "需要 OpenAI 官方文档时优先查官方资料。", "doc.text.magnifyingglass")
        }
    }

    private var clipboard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Button {
                    workingText = NSPasteboard.general.string(forType: .string) ?? ""
                } label: {
                    Label("读取剪贴板", systemImage: "arrow.down.doc")
                }
                .buttonStyle(.glassProminent)

                Button {
                    workingText = workingText.trimmingCharacters(in: .whitespacesAndNewlines)
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(workingText, forType: .string)
                } label: {
                    Label("清理并复制", systemImage: "wand.and.stars")
                }
                .buttonStyle(.glass)

                Spacer()

                Text("\(workingText.count) 个字符")
                    .font(.callout.monospacedDigit())
                    .foregroundStyle(.secondary)
            }

            textEditor
        }
    }

    private var textTools: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 12) {
                metric("字符", metrics.characters)
                metric("词语", metrics.words)
                metric("行数", metrics.lines)
            }

            HStack {
                Button {
                    workingText = workingText.uppercased()
                } label: {
                    Label("转为大写", systemImage: "textformat.abc")
                }
                .buttonStyle(.glassProminent)

                Button {
                    workingText = workingText.lowercased()
                } label: {
                    Label("转为小写", systemImage: "textformat")
                }
                .buttonStyle(.glass)
            }

            textEditor
        }
    }

    private var fileTools: some View {
        VStack(alignment: .leading, spacing: 14) {
            TextField("输入文件名或标题", text: $fileName)
                .textFieldStyle(.roundedBorder)

            resultPanel("整理结果", slug.isEmpty ? "-" : slug, "text.badge.checkmark")
        }
    }

    private var server: some View {
        VStack(alignment: .leading, spacing: 12) {
            infoRow("只读优先", "先看状态、日志、磁盘、CPU、内存和证书。", "eye")
            infoRow("宝塔优先", "优先使用宝塔面板和控制台，不默认 SSH。", "rectangle.and.hand.point.up.left")
            infoRow("变更确认", "重启、部署、数据库、防火墙、DNS 修改前必须确认。", "lock.shield")
        }
    }

    private var urlTools: some View {
        VStack(alignment: .leading, spacing: 14) {
            TextField("https://example.com/path", text: $rawURL)
                .textFieldStyle(.roundedBorder)

            resultPanel("协议", parsedURL?.scheme ?? "-", "network")
            resultPanel("主机", parsedURL?.host() ?? "-", "server.rack")
            resultPanel("路径", parsedURL?.path(percentEncoded: false).isEmpty == false ? parsedURL?.path(percentEncoded: false) ?? "-" : "-", "point.topleft.down.curvedto.point.bottomright.up")
        }
    }

    private var textEditor: some View {
        TextEditor(text: $workingText)
            .font(.system(.body, design: .monospaced))
            .scrollContentBackground(.hidden)
            .padding(12)
            .frame(minHeight: 320)
            .glassEffect(.regular.interactive(), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    private func metric(_ title: String, _ value: Int) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value.formatted())
                .font(.title2.monospacedDigit().weight(.semibold))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .glassEffect(.regular.interactive(), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    private func infoRow(_ title: String, _ detail: String, _ symbol: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: symbol)
                .font(.title3)
                .foregroundStyle(.tint)
                .frame(width: 28)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(detail)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(16)
        .glassEffect(.regular.interactive(), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    private func resultPanel(_ title: String, _ value: String, _ symbol: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: symbol)
                .foregroundStyle(.tint)
                .frame(width: 24)
            Text(title)
                .font(.headline)
                .frame(width: 82, alignment: .leading)
            Text(value)
                .font(.body.monospaced())
                .textSelection(.enabled)
            Spacer()
        }
        .padding(16)
        .glassEffect(.regular.interactive(), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}
