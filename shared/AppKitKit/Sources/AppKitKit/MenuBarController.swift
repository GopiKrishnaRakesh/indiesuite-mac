import AppKit
import SwiftUI
import DesignSystem

public class MenuBarController<Content: View>: NSObject {
    private var statusItem: NSStatusItem?
    private var popover = NSPopover()
    private let rootView: Content
    private let systemIconName: String
    private let titleText: String?
    
    public init(rootView: Content, systemIconName: String, titleText: String? = nil, contentWidth: CGFloat = 340, contentHeight: CGFloat = 460) {
        self.rootView = rootView
        self.systemIconName = systemIconName
        self.titleText = titleText
        super.init()
        
        setupStatusItem()
        setupPopover(width: contentWidth, height: contentHeight)
    }
    
    private func setupStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        guard let button = statusItem?.button else { return }
        
        if let image = NSImage(systemSymbolName: systemIconName, accessibilityDescription: titleText ?? "Utility") {
            image.isTemplate = true
            button.image = image
        }
        
        if let titleText = titleText {
            button.title = " \(titleText)"
        }
        
        button.target = self
        button.action = #selector(togglePopover(_:))
    }
    
    private func setupPopover(width: CGFloat, height: CGFloat) {
        popover.contentSize = NSSize(width: width, height: height)
        popover.behavior = .transient
        popover.animates = true
        
        let hostingController = NSHostingController(rootView: rootView)
        popover.contentViewController = hostingController
    }
    
    @objc public func togglePopover(_ sender: AnyObject?) {
        guard let button = statusItem?.button else { return }
        if popover.isShown {
            popover.performClose(sender)
        } else {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            popover.contentViewController?.view.window?.makeKey()
        }
    }
    
    public func updateTitle(_ newTitle: String) {
        DispatchQueue.main.async {
            self.statusItem?.button?.title = " \(newTitle)"
        }
    }
    
    public func updateIcon(_ iconName: String) {
        DispatchQueue.main.async {
            if let image = NSImage(systemSymbolName: iconName, accessibilityDescription: nil) {
                image.isTemplate = true
                self.statusItem?.button?.image = image
            }
        }
    }
}
