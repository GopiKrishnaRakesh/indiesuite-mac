import AppKit
import QuickLookUI
import SwiftUI

/// Intercepts plain keys (Backspace, Enter, F2, Delete, F5 …) that SwiftUI menu shortcuts can't own
/// without hijacking text fields. Passes everything through while a text field / sheet is active.
@MainActor
final class KeyMonitor {
    static let shared = KeyMonitor()
    private var monitor: Any?

    func install() {
        guard monitor == nil else { return }
        // AppKit's overlay types this handler as @Sendable, not @MainActor, even though a *local*
        // event monitor always fires synchronously on the main thread. Marking the closure literal
        // itself @MainActor (rather than wrapping the body in MainActor.assumeIsolated) keeps `event`
        // inside a single isolation domain throughout, so it never needs to be Sendable to cross one.
        monitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { @MainActor event in
            guard let window = event.window ?? NSApp.keyWindow,
                  let model = ModelRegistry.shared.model(for: window),
                  window.attachedSheet == nil,
                  !(window.firstResponder is NSText),
                  // Leave every key alone while Quick Look is up — it has its own native Escape/
                  // arrow-key handling, and this monitor was swallowing both before either could
                  // reach it (Escape as "clear selection", arrows as grid navigation).
                  !(QLPreviewPanel.sharedPreviewPanelExists() && QLPreviewPanel.shared().isVisible)
            else { return event }
            return model.handleKey(event) ? nil : event
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
