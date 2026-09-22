import SwiftUI

/// Right-hand details/preview pane (Alt+P in Explorer, ⌥⌘P here).
struct PreviewPane: View {
    @ObservedObject var model: FileBrowserModel

    var body: some View {
        let selected = model.selectedItems
        VStack(spacing: 0) {
            if selected.count == 1, let item = selected.first, model.showPreview {
                QuickLookPreview(url: item.url)
                    .id(item.url)
                    .frame(minHeight: 180, maxHeight: .infinity)
                Divider()
                ScrollView { details(for: item).padding(14) }
                    .frame(maxHeight: 260)
            } else {
                VStack(spacing: 10) {
                    Image(systemName: selected.isEmpty ? "folder" : "square.stack.3d.up")
                        .font(.system(size: 44)).foregroundStyle(.secondary)
                    Text(selected.isEmpty ? model.title : "\(selected.count) items selected").font(.headline)
                    if selected.isEmpty {
                        Text("\(model.displayItems.count) items").foregroundStyle(.secondary)
                        Text("Select a file to preview it.").font(.caption).foregroundStyle(.tertiary)
                    } else {
                        Text(Fmt.bytes(model.selectionSize)).foregroundStyle(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }

    private func details(for item: FileItem) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.name).font(.headline).textSelection(.enabled)
            row("Type", item.kind)
            if !item.isFolder { row("Size", Fmt.exactBytes(item.size)) }
            row("Modified", Fmt.date(item.modified))
            row("Created", Fmt.date(item.created))
            row("Location", item.url.deletingLastPathComponent().path)
            if item.isSymlink { row("Alias", "Yes") }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func row(_ key: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(key).font(.caption).foregroundStyle(.secondary)
            Text(value).font(.callout).textSelection(.enabled)
        }
    }
}
