import SwiftUI

struct RootView: View {
    @State private var selectedToolID: ToolItem.ID? = ToolRegistry.defaultTool.id

    var body: some View {
        NavigationSplitView {
            ZStack {
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.06),
                        Color.cyan.opacity(0.05),
                        Color.black.opacity(0.08)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                List(ToolRegistry.tools, selection: $selectedToolID) { tool in
                    Label(tool.name, systemImage: tool.systemImage)
                        .tag(tool.id)
                        .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
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
