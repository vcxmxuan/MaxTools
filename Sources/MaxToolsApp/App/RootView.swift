import SwiftUI

struct RootView: View {
    @State private var selectedToolID: ToolItem.ID? = ToolRegistry.defaultTool.id

    var body: some View {
        NavigationSplitView {
            ZStack {
                Color.black.opacity(0.28)

                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("MAX 工具舱")
                            .font(.system(size: 24, weight: .black, design: .rounded))
                            .foregroundStyle(.white)
                        Text("个人效率控制台")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.58))
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 18)

                    List(ToolRegistry.tools, selection: $selectedToolID) { tool in
                        Label(tool.name, systemImage: tool.systemImage)
                            .font(.callout.weight(.medium))
                            .tag(tool.id)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationSplitViewColumnWidth(min: 220, ideal: 240)
        } detail: {
            if let tool = ToolRegistry.tool(withID: selectedToolID) {
                tool.destination
            } else {
                DashboardView()
            }
        }
        .background(AppTheme.background)
    }
}
