import SwiftUI

struct ToolItem: Identifiable, Hashable {
    let id: String
    let name: String
    let summary: String
    let systemImage: String
    let destination: AnyView

    init(name: String, summary: String, systemImage: String, destination: AnyView) {
        self.id = name
        self.name = name
        self.summary = summary
        self.systemImage = systemImage
        self.destination = destination
    }

    static func == (lhs: ToolItem, rhs: ToolItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
