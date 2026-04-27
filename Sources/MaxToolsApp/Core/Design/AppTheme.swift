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

struct LiquidGlassBackground: View {
    var body: some View {
        Color(nsColor: .windowBackgroundColor)
            .backgroundExtensionEffect()
            .ignoresSafeArea()
    }
}

struct LiquidGlassPanel<Content: View>: View {
    let content: Content
    @State private var isHovering = false

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        GlassEffectContainer(spacing: 10) {
            content
                .padding(16)
                .glassEffect(.regular.interactive(isHovering), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
            .scaleEffect(isHovering ? 1.006 : 1)
            .animation(.spring(response: 0.28, dampingFraction: 0.82), value: isHovering)
            .onHover { isHovering = $0 }
    }
}

struct NativePanel<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        LiquidGlassPanel {
            content
        }
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
                RoundedRectangle(cornerRadius: 14)
                    .fill(.clear)
                    .glassEffect(.clear.interactive(), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
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
                    .foregroundStyle(.primary)
                Text(subtitle)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct NativeTextEditor: View {
    @Binding var text: String

    var body: some View {
        TextEditor(text: $text)
            .font(.system(.body, design: .monospaced))
            .scrollContentBackground(.hidden)
            .padding(10)
            .glassEffect(.regular.interactive(), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
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
