import AppKit
import QuickLookUI
import SwiftUI

/// Monitors mouse dragging in the file list area to provide fluid, reliable
/// click-and-drag rubber-band (marquee) multi-selection across all view modes
/// (Details, Icons, and Tiles).
@MainActor
final class MarqueeMonitor {
    static let shared = MarqueeMonitor()
    private var monitor: Any?
    private let trackingViews = NSMapTable<NSWindow, FileListTrackingView>(keyOptions: .weakMemory, valueOptions: .weakMemory)

    struct DragSession {
        let startWindowPoint: NSPoint
        let startLocalPoint: CGPoint
        let preDragSelection: Set<URL>
        var isMarqueeActive: Bool
    }

    private var currentSession: DragSession?

    func register(trackingView: FileListTrackingView, model: FileBrowserModel, window: NSWindow) {
        trackingViews.setObject(trackingView, forKey: window)
    }

    func install() {
        guard monitor == nil else { return }
        monitor = NSEvent.addLocalMonitorForEvents(matching: [.leftMouseDown, .leftMouseDragged, .leftMouseUp]) { [weak self] event in
            guard let self else { return event }
            return self.handle(event: event)
        }
    }

    func cancelDrag(for model: FileBrowserModel) {
        if currentSession?.isMarqueeActive == true {
            model.dragMarqueeRect = nil
        }
        currentSession = nil
    }

    private func handle(event: NSEvent) -> NSEvent? {
        guard let window = event.window ?? NSApp.keyWindow,
              let model = ModelRegistry.shared.model(for: window),
              window.attachedSheet == nil,
              !(window.firstResponder is NSText),
              !(QLPreviewPanel.sharedPreviewPanelExists() && QLPreviewPanel.shared().isVisible),
              let trackingView = trackingViews.object(forKey: window)
        else {
            currentSession = nil
            return event
        }

        switch event.type {
        case .leftMouseDown:
            return handleMouseDown(event: event, window: window, model: model, trackingView: trackingView)
        case .leftMouseDragged:
            return handleMouseDragged(event: event, window: window, model: model, trackingView: trackingView)
        case .leftMouseUp:
            return handleMouseUp(event: event, model: model)
        default:
            return event
        }
    }

    private func handleMouseDown(event: NSEvent, window: NSWindow, model: FileBrowserModel, trackingView: FileListTrackingView) -> NSEvent? {
        let pointInWindow = event.locationInWindow
        let localPoint = trackingView.convert(pointInWindow, from: nil)

        // Must be inside the file list area bounds
        guard trackingView.bounds.contains(localPoint) else {
            currentSession = nil
            return event
        }

        // Double-click or multi-click opens files; don't start marquee
        if event.clickCount > 1 {
            currentSession = nil
            return event
        }

        // If clicking on an ALREADY SELECTED item, allow standard drag-and-drop
        if isClickingOnSelectedTarget(at: pointInWindow, localPoint: localPoint, in: window, model: model) {
            currentSession = nil
            return event
        }

        let flags = event.modifierFlags
        let preSelection: Set<URL> = (flags.contains(.command) || flags.contains(.shift)) ? model.selection : []

        currentSession = DragSession(
            startWindowPoint: pointInWindow,
            startLocalPoint: localPoint,
            preDragSelection: preSelection,
            isMarqueeActive: false
        )

        return event
    }

    private func isClickingOnSelectedTarget(at pointInWindow: NSPoint, localPoint: CGPoint, in window: NSWindow, model: FileBrowserModel) -> Bool {
        guard !model.selection.isEmpty else { return false }

        if model.viewMode == .details {
            if let table = FileBrowserModel.findFileTable(in: window.contentView) {
                let tablePoint = table.convert(pointInWindow, from: nil)
                let row = table.row(at: tablePoint)
                if row >= 0 && row < model.displayItems.count {
                    let clickedItem = model.displayItems[row]
                    return model.selection.contains(clickedItem.id)
                }
            }
        }

        for id in model.selection {
            if let frame = model.itemFrames[id], frame.contains(localPoint) {
                return true
            }
        }

        return false
    }

    private func handleMouseDragged(event: NSEvent, window: NSWindow, model: FileBrowserModel, trackingView: FileListTrackingView) -> NSEvent? {
        guard var session = currentSession else { return event }

        let pointInWindow = event.locationInWindow
        let localPoint = trackingView.convert(pointInWindow, from: nil)

        let dx = pointInWindow.x - session.startWindowPoint.x
        let dy = pointInWindow.y - session.startWindowPoint.y
        let distance = hypot(dx, dy)

        if !session.isMarqueeActive {
            guard distance >= 4 else { return event }
            session.isMarqueeActive = true
        }

        let minX = min(session.startLocalPoint.x, localPoint.x)
        let minY = min(session.startLocalPoint.y, localPoint.y)
        let width = max(abs(localPoint.x - session.startLocalPoint.x), 1)
        let height = max(abs(localPoint.y - session.startLocalPoint.y), 1)
        let marqueeLocalRect = CGRect(x: minX, y: minY, width: width, height: height)

        model.dragMarqueeRect = marqueeLocalRect

        var hits: Set<URL> = []

        if model.viewMode == .details {
            if let table = FileBrowserModel.findFileTable(in: window.contentView) {
                let minWinX = min(session.startWindowPoint.x, pointInWindow.x)
                let minWinY = min(session.startWindowPoint.y, pointInWindow.y)
                let winW = max(abs(pointInWindow.x - session.startWindowPoint.x), 1)
                let winH = max(abs(pointInWindow.y - session.startWindowPoint.y), 1)
                let marqueeWinRect = NSRect(x: minWinX, y: minWinY, width: winW, height: winH)

                let tableRect = table.convert(marqueeWinRect, from: nil)
                let rowRange = table.rows(in: tableRect)
                if rowRange.location != NSNotFound && rowRange.length > 0 && rowRange.location < model.displayItems.count {
                    let end = min(rowRange.location + rowRange.length, model.displayItems.count)
                    for r in rowRange.location ..< end {
                        hits.insert(model.displayItems[r].id)
                    }
                }
            }
            // Also include any items matching via reported frames
            for (id, frame) in model.itemFrames {
                if marqueeLocalRect.minY <= frame.maxY && marqueeLocalRect.maxY >= frame.minY {
                    hits.insert(id)
                }
            }
        } else {
            // Icons & Tiles view
            for (id, frame) in model.itemFrames {
                if marqueeLocalRect.intersects(frame) {
                    hits.insert(id)
                }
            }
        }

        let flags = event.modifierFlags
        if flags.contains(.command) || flags.contains(.shift) {
            model.selection = session.preDragSelection.union(hits)
        } else {
            model.selection = hits
        }

        currentSession = session
        trackingView.autoscroll(with: event)
        return nil
    }

    private func handleMouseUp(event: NSEvent, model: FileBrowserModel) -> NSEvent? {
        guard let session = currentSession else { return event }
        currentSession = nil

        if session.isMarqueeActive {
            model.dragMarqueeRect = nil
            return nil
        } else {
            return event
        }
    }
}

/// NSViewRepresentable that attaches to FileListArea to track geometry and deliver
/// local coordinate conversions for marquee selection.
struct FileListAreaAccessor: NSViewRepresentable {
    let model: FileBrowserModel

    func makeNSView(context: Context) -> FileListTrackingView {
        let view = FileListTrackingView()
        view.model = model
        return view
    }

    func updateNSView(_ view: FileListTrackingView, context: Context) {
        view.model = model
        if let window = view.window {
            MarqueeMonitor.shared.register(trackingView: view, model: model, window: window)
        }
    }
}

/// Transparent NSView host with flipped coordinate space matching SwiftUI.
final class FileListTrackingView: NSView {
    weak var model: FileBrowserModel?
    override var isFlipped: Bool { true }

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        if let window, let model {
            MarqueeMonitor.shared.register(trackingView: self, model: model, window: window)
        }
    }
}
