import SwiftUI

enum AppTheme {
    static let background = LinearGradient(
        colors: [
            Color(red: 0.03, green: 0.04, blue: 0.08),
            Color(red: 0.07, green: 0.08, blue: 0.14),
            Color(red: 0.02, green: 0.08, blue: 0.11)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let panel = LinearGradient(
        colors: [
            Color.white.opacity(0.14),
            Color.white.opacity(0.06)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let accent = LinearGradient(
        colors: [
            Color(red: 0.24, green: 0.95, blue: 0.84),
            Color(red: 0.54, green: 0.45, blue: 1.0),
            Color(red: 1.0, green: 0.34, blue: 0.68)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let stroke = LinearGradient(
        colors: [
            Color.white.opacity(0.34),
            Color.white.opacity(0.07)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

struct NeonPanel<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(16)
            .background(AppTheme.panel)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(AppTheme.stroke, lineWidth: 1)
            }
            .shadow(color: Color(red: 0.24, green: 0.95, blue: 0.84).opacity(0.12), radius: 18, y: 10)
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
                    .fill(AppTheme.accent)
                Image(systemName: systemImage)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .frame(width: 64, height: 64)

            VStack(alignment: .leading, spacing: 6) {
                Text(eyebrow)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.cyan)
                Text(title)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                Text(subtitle)
                    .font(.callout)
                    .foregroundStyle(.white.opacity(0.68))
            }
        }
    }
}

struct NeonButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.callout.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 14)
            .padding(.vertical, 9)
            .background(AppTheme.accent.opacity(configuration.isPressed ? 0.72 : 1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(color: .cyan.opacity(configuration.isPressed ? 0.08 : 0.22), radius: 10, y: 6)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
}

struct GlassTextEditor: View {
    @Binding var text: String

    var body: some View {
        TextEditor(text: $text)
            .font(.system(.body, design: .monospaced))
            .foregroundStyle(.white)
            .scrollContentBackground(.hidden)
            .padding(10)
            .background(Color.black.opacity(0.22))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white.opacity(0.14))
            }
    }
}
