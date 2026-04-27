import SwiftUI

struct RootView: View {
    @State private var selectedToolID: ToolItem.ID? = ToolRegistry.defaultTool.id
    @State private var searchText = ""

    private var selectedTool: ToolItem {
        ToolRegistry.tool(withID: selectedToolID) ?? ToolRegistry.defaultTool
    }

    private var visibleTools: [ToolItem] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return ToolRegistry.tools
        }

        return ToolRegistry.tools.filter {
            $0.name.localizedStandardContains(searchText) ||
            $0.summary.localizedStandardContains(searchText)
        }
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            LiquidGlassBackground()

            WorkspaceBackdrop(selectedTool: selectedTool)

            selectedTool.destination
                .padding(.leading, 252)
                .padding(.top, 18)
                .transition(.opacity.combined(with: .scale(scale: 0.994)))
                .animation(.smooth(duration: 0.22), value: selectedToolID)

            FloatingSidebar(
                selectedToolID: $selectedToolID,
                tools: visibleTools
            )
            .padding(.leading, 22)
            .padding(.top, 24)
            .padding(.bottom, 24)

            FloatingSearchField(text: $searchText)
                .frame(width: 260)
                .padding(.top, 22)
                .padding(.trailing, 28)
                .frame(maxWidth: .infinity, alignment: .topTrailing)
        }
        .toolbar {
            ToolbarSpacer(.flexible)

            ToolbarItem(placement: .principal) {
                Text(selectedTool.name)
                    .font(.headline)
            }

            ToolbarSpacer(.fixed)

            ToolbarItem {
                Button {
                    selectedToolID = ToolRegistry.defaultTool.id
                } label: {
                    Label("回到总览", systemImage: "square.grid.2x2")
                }
                .buttonStyle(.glass)
            }
        }
    }
}

private struct FloatingSidebar: View {
    @Binding var selectedToolID: ToolItem.ID?
    let tools: [ToolItem]

    var body: some View {
        GlassEffectContainer(spacing: 12) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 10) {
                    Image(systemName: "command")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.tint)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("MaxTools")
                            .font(.headline)
                        Text("个人工具舱")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()
                }
                .padding(.bottom, 8)

                ForEach(tools) { tool in
                    SidebarToolButton(
                        tool: tool,
                        isSelected: selectedToolID == tool.id
                    ) {
                        selectedToolID = tool.id
                    }
                }

                Spacer(minLength: 18)

                StatusPill(title: "macOS 26", systemImage: "sparkles", color: .accentColor)
            }
            .padding(14)
            .frame(width: 208)
            .glassEffect(.regular.interactive(), in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        }
    }
}

private struct SidebarToolButton: View {
    let tool: ToolItem
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(systemName: tool.systemImage)
                    .font(.system(size: 15, weight: .medium))
                    .frame(width: 22)

                Text(tool.name)
                    .font(.callout.weight(isSelected ? .semibold : .regular))

                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .contentShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(.plain)
        .foregroundStyle(isSelected ? .primary : .secondary)
        .background {
            if isSelected {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.accentColor.opacity(0.14))
            }
        }
    }
}

private struct FloatingSearchField: View {
    @Binding var text: String

    var body: some View {
        GlassEffectContainer(spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                TextField("搜索工具", text: $text)
                    .textFieldStyle(.plain)

                if !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 9)
            .glassEffect(.regular.interactive(), in: Capsule())
        }
    }
}

private struct WorkspaceBackdrop: View {
    let selectedTool: ToolItem

    var body: some View {
        VStack(alignment: .trailing, spacing: 14) {
            HStack(spacing: 14) {
                ForEach(ToolRegistry.tools.filter { $0.name != "总览" }.prefix(3)) { tool in
                    BackdropTile(tool: tool, isSelected: selectedTool.id == tool.id)
                }
            }

            HStack(spacing: 14) {
                ForEach(ToolRegistry.tools.filter { $0.name != "总览" }.dropFirst(3)) { tool in
                    BackdropTile(tool: tool, isSelected: selectedTool.id == tool.id)
                }
            }

            Spacer()
        }
        .padding(.top, 112)
        .padding(.trailing, 34)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .opacity(0.46)
        .allowsHitTesting(false)
    }
}

private struct BackdropTile: View {
    let tool: ToolItem
    let isSelected: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: tool.systemImage)
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(.tint)

            Text(tool.name)
                .font(.headline)

            Text(tool.summary)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(2)
        }
        .frame(width: 178, height: 118, alignment: .topLeading)
        .padding(14)
        .background(Color(nsColor: .controlBackgroundColor).opacity(isSelected ? 0.72 : 0.46))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}
