import SwiftUI

struct RootView: View {
    @State private var selectedToolID: ToolItem.ID? = ToolRegistry.defaultTool.id

    var body: some View {
        NavigationSplitView {
            ZStack {
                Color(nsColor: .controlBackgroundColor)
                    .opacity(0.72)
                    .backgroundExtensionEffect()
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
            ToolbarSpacer(.flexible)

            ToolbarItem(placement: .principal) {
                Text(ToolRegistry.tool(withID: selectedToolID)?.name ?? "总览")
                    .font(.headline)
            }

            ToolbarSpacer(.fixed)

            ToolbarItem {
                Button {
                    selectedToolID = ToolRegistry.defaultTool.id
                } label: {
                    Label("总览", systemImage: "square.grid.2x2")
                }
                .buttonStyle(.glass)
            }
        }
    }
}
