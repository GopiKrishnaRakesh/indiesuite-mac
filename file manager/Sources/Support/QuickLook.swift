import AppKit
import QuickLookUI
import SwiftUI

/// Spacebar Quick Look panel (same panel Finder uses). The data source is the *whole current
/// folder*, not just the selection, so the panel's native Left/Right-arrow cycling works exactly
/// like Finder's — with only the selected item(s) in the data source there's nothing to cycle to.
@MainActor
final class QuickLookController: NSObject, QLPreviewPanelDataSource, QLPreviewPanelDelegate {
    static let shared = QuickLookController()
    private var urls: [URL] = []
    private weak var model: FileBrowserModel?
    private var indexObservation: NSKeyValueObservation?

    func toggle(folderItems: [URL], selected: [URL], model: FileBrowserModel) {
        guard let panel = QLPreviewPanel.shared() else { return }
        if panel.isVisible {
            panel.orderOut(nil)
            return
        }
        guard !selected.isEmpty else { return }
        self.model = model
        urls = folderItems.isEmpty ? selected : folderItems
        panel.dataSource = self
        panel.delegate = self
        panel.reloadData()
        if let start = selected.first, let index = urls.firstIndex(of: start) {
            panel.currentPreviewItemIndex = index
        }
        observeIndex(panel)
        panel.makeKeyAndOrderFront(nil)
    }

    /// Keeps an open panel in sync when the file list's own selection changes from elsewhere
    /// (e.g. arrow keys while the file list itself has focus).
    func refresh(selected: [URL]) {
        guard let panel = QLPreviewPanel.sharedPreviewPanelExists() ? QLPreviewPanel.shared() : nil, panel.isVisible,
              let first = selected.first, let index = urls.firstIndex(of: first),
              panel.currentPreviewItemIndex != index else { return }
        panel.currentPreviewItemIndex = index
    }

    /// Mirrors the panel's own item back into the file list's selection as the user arrows through
    /// Quick Look, Finder-style.
    private func observeIndex(_ panel: QLPreviewPanel) {
        indexObservation = panel.observe(\.currentPreviewItemIndex) { [weak self] panel, _ in
            guard let self, urls.indices.contains(panel.currentPreviewItemIndex) else { return }
            let url = urls[panel.currentPreviewItemIndex]
            Task { @MainActor in self.model?.syncSelectionFromQuickLook(url) }
        }
    }

    nonisolated func numberOfPreviewItems(in panel: QLPreviewPanel!) -> Int {
        MainActor.assumeIsolated { urls.count }
    }

    nonisolated func previewPanel(_ panel: QLPreviewPanel!, previewItemAt index: Int) -> (any QLPreviewItem)! {
        MainActor.assumeIsolated { urls.indices.contains(index) ? urls[index] as NSURL : nil }
    }
}

/// Inline preview used by the preview pane.
struct QuickLookPreview: NSViewRepresentable {
    let url: URL

    func makeNSView(context: Context) -> QLPreviewView {
        let view = QLPreviewView(frame: .zero, style: .normal)!
        view.previewItem = url as NSURL
        return view
    }

    func updateNSView(_ view: QLPreviewView, context: Context) {
        if (view.previewItem as? NSURL) as URL? != url { view.previewItem = url as NSURL }
    }
}
