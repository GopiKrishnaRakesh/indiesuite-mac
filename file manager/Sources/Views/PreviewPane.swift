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

            HStack(spacing: 8) {
                Button {
                    model.open(item)
                } label: {
                    Label("Open", systemImage: "arrow.up.forward.app")
                        .font(.system(size: 11))
                }
                .controlSize(.small)

                Button {
                    model.toggleQuickLook()
                } label: {
                    Label("Quick Look", systemImage: "eye")
                        .font(.system(size: 11))
                }
                .controlSize(.small)

                ShareLink(items: [item.url]) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 11))
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
            }

            Divider()

            row("Type", item.kind)
            if !item.isFolder {
                row("Size", Fmt.exactBytes(item.size))
            } else if let fs = model.folderSizes[item.url.path] ?? item.folderSize {
                row("Size", Fmt.exactBytes(fs))
            }
            row("Modified", Fmt.date(item.modified))
            row("Created", Fmt.date(item.created))
            row("Location", item.url.deletingLastPathComponent().path)
            if item.isSymlink { row("Alias", "Yes") }

            Divider()

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Tags").font(.caption).foregroundStyle(.secondary)
                    Spacer()
                    Menu {
                        ForEach(MacTag.allCases) { tag in
                            Button {
                                model.toggleTag(tag.rawValue, for: [item.url])
                            } label: {
                                Label(tag.rawValue, systemImage: "circle.fill")
                            }
                        }
                        Divider()
                        Button("Clear Tags") { model.clearTags(for: [item.url]) }
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.caption)
                    }
                    .buttonStyle(.plain)
                }

                if item.tags.isEmpty {
                    Text("None").font(.caption).foregroundStyle(.tertiary)
                } else {
                    HStack(spacing: 4) {
                        ForEach(item.tags, id: \.self) { tagName in
                            HStack(spacing: 3) {
                                Circle()
                                    .fill(FileItem.tagColor(for: tagName))
                                    .frame(width: 6, height: 6)
                                Text(tagName)
                                    .font(.system(size: 10))
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Capsule().fill(Color.primary.opacity(0.08)))
                        }
                    }
                }
            }
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
