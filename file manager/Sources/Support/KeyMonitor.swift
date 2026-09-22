import AppKit
import SwiftUI

/// Intercepts plain keys (Backspace, Enter, F2, Delete, F5 …) that SwiftUI menu shortcuts can't own
/// without hijacking text fields. Passes everything through while a text field / sheet is active.
@MainActor
final class KeyMonitor {
    static let shared = KeyMonitor()
    private var monitor: Any?

    func install() {
        guard monitor == nil else { return }
        monitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            MainActor.assumeIsolated {
                guard let window = event.window ?? NSApp.keyWindow,
                      let model = ModelRegistry.shared.model(for: window),
                      window.attachedSheet == nil,
                      !(window.firstResponder is NSText) else { return event }
                return model.handleKey(event) ? nil : event
            }
        }
    }
}

/// Menu shortcuts like ⌘C must still copy *text* while a text field is being edited.
@MainActor
enum TextGuard {
    static var isEditingText: Bool { NSApp.keyWindow?.firstResponder is NSText }

    static func perform(_ selector: Selector, otherwise action: () -> Void) {
        if isEditingText { NSApp.sendAction(selector, to: nil, from: nil) } else { action() }
    }
}

struct WindowAccessor: NSViewRepresentable {
    let onWindow: (NSWindow) -> Void

    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async { if let w = view.window { onWindow(w) } }
        return view
    }

    func updateNSView(_ view: NSView, context: Context) {
        DispatchQueue.main.async { if let w = view.window { onWindow(w) } }
    }
}
