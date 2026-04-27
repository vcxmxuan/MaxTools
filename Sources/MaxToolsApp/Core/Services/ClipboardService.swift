import AppKit

protocol ClipboardServicing {
    func readString() -> String
    func writeString(_ value: String)
}

struct ClipboardService: ClipboardServicing {
    func readString() -> String {
        NSPasteboard.general.string(forType: .string) ?? ""
    }

    func writeString(_ value: String) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(value, forType: .string)
    }
}
