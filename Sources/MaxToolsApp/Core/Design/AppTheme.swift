import SwiftUI

enum AppTheme {
    static let page = Color(nsColor: .windowBackgroundColor)
    static let panel = Color(nsColor: .controlBackgroundColor).opacity(0.72)
    static let elevated = Color(nsColor: .textBackgroundColor).opacity(0.88)
    static let separator = Color(nsColor: .separatorColor).opacity(0.55)
    static let accent = Color.accentColor
    static let positive = Color.green
    static let warning = Color.orange
}

struct NativePanel<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(16)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(AppTheme.separator, lineWidth: 0.5)
            }
            .shadow(color: .black.opacity(0.08), radius: 12, y: 5)
    }
}

struct ToolHeader: View {
    let eyebrow: String
    let title: String
    let subtitle: String
    let systemImage: String

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.quaternary)
                Image(systemName: systemImage)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(.tint)
            }
            .frame(width: 64, height: 64)

            VStack(alignment: .leading, spacing: 6) {
                Text(eyebrow)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                Text(title)
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                Text(subtitle)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct PrimaryActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.callout.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 14)
            .padding(.vertical, 9)
            .background(AppTheme.accent.opacity(configuration.isPressed ? 0.72 : 1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
}

struct NativeTextEditor: View {
    @Binding var text: String

    var body: some View {
        TextEditor(text: $text)
            .font(.system(.body, design: .monospaced))
            .scrollContentBackground(.hidden)
            .padding(10)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(AppTheme.separator, lineWidth: 0.5)
            }
    }
}

struct StatusPill: View {
    let title: String
    let systemImage: String
    let color: Color

    var body: some View {
        Label(title, systemImage: systemImage)
            .font(.caption.weight(.medium))
            .foregroundStyle(color)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color.opacity(0.12))
            .clipShape(Capsule())
    }
}
