import SwiftUI

struct RootView: View {
    @State private var selectedToolID: ToolItem.ID? = ToolRegistry.defaultTool.id

    var body: some View {
        NavigationSplitView {
            List(ToolRegistry.tools, selection: $selectedToolID) { tool in
                Label(tool.name, systemImage: tool.systemImage)
                    .tag(tool.id)
            }
            .navigationTitle("MaxTools")
            .navigationSplitViewColumnWidth(min: 220, ideal: 240)
        } detail: {
            if let tool = ToolRegistry.tool(withID: selectedToolID) {
                tool.destination
            } else {
                DashboardView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(ToolRegistry.tool(withID: selectedToolID)?.name ?? "总览")
                    .font(.headline)
            }
        }
    }
}
