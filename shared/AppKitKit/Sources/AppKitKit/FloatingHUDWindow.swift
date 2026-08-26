import AppKit
import SwiftUI
import DesignSystem

public class FloatingHUDWindow<Content: View>: NSPanel {
    public init(contentView: Content, size: CGSize = CGSize(width: 480, height: 320)) {
        super.init(
            contentRect: NSRect(origin: .zero, size: size),
            styleMask: [.nonactivatingPanel, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        
        self.isFloatingPanel = true
        self.level = .floating
        self.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        self.titleVisibility = .hidden
        self.titlebarAppearsTransparent = true
        self.isMovableByWindowBackground = true
        self.backgroundColor = .clear
        self.hasShadow = true
        
        self.contentViewController = NSHostingController(rootView: contentView)
        self.center()
    }
    
    public func showHUD() {
        self.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    public func hideHUD() {
        self.orderOut(nil)
    }
    
    public func toggleHUD() {
        if self.isVisible {
            hideHUD()
        } else {
            showHUD()
        }
    }
}
