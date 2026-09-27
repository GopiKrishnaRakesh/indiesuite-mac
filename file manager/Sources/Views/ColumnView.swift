import AppKit
import QuickLookUI
import SwiftUI

/// macOS Finder signature Miller Columns View (Column View).
/// Displays hierarchical cascading directory columns with a rich preview card for the selected file.
struct ColumnBrowserView: View {
    @ObservedObject var model: FileBrowserModel

    // State for the expanded column hierarchy: chain of folders currently navigated
    @State private var columnPath: [URL] = []
    @State private var selectedInColumn: [Int: URL] = [:]
    @State private var columnItems: [Int: [FileItem]] = [:]

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(alignment: .top, spacing: 0) {
                    // Column 0: Root (model.currentURL)
                    directoryColumn(index: 0, url: model.currentURL)
                        .id("col-0")

                    // Subsequent columns for selected subfolders
                    ForEach(Array(columnPath.enumerated()), id: \.offset) { index, folderURL in
                        Rectangle().fill(Color.primary.opacity(0.1)).frame(width: 1)
                        directoryColumn(index: index + 1, url: folderURL)
                            .id("col-\(index + 1)")
                    }

                    // Leaf preview column if a non-folder file is selected
                    if let leafItem = activeLeafFile {
                        Rectangle().fill(Color.primary.opacity(0.1)).frame(width: 1)
                        ColumnPreviewPane(item: leafItem, model: model)
                            .id("col-preview")
                    }
                }
            }
            .onChange(of: columnPath.count) { _, newCount in
                withAnimation(.easeOut(duration: 0.15)) {
                    if activeLeafFile != nil {
                        proxy.scrollTo("col-preview", anchor: .trailing)
                    } else if newCount > 0 {
                        proxy.scrollTo("col-\(newCount)", anchor: .trailing)
                    }
                }
            }
            .onChange(of: model.currentURL) { _, newURL in
                resetToRoot(newURL)
            }
            .onAppear {
                resetToRoot(model.currentURL)
            }
        }
    }

    private var activeLeafFile: FileItem? {
        let activeCol = columnPath.count
        guard let selectedURL = selectedInColumn[activeCol],
              let items = columnItems[activeCol],
              let item = items.first(where: { $0.url == selectedURL }),
              !item.isFolder else {
            return nil
        }
        return item
    }

    private func resetToRoot(_ rootURL: URL) {
        columnPath = []
        selectedInColumn = [:]
        columnItems = [:]
        loadColumn(index: 0, url: rootURL)
    }

    private func directoryColumn(index: Int, url: URL) -> some View {
        let items = (index == 0 && model.selectedTagFilter == nil && model.searchText.isEmpty) ? model.displayItems : (columnItems[index] ?? [])
        return VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 1) {
                    ForEach(items) { item in
                        columnRow(item: item, columnIndex: index)
                    }
                }
                .padding(4)
            }
            .frame(width: 230)
            .background(Color.clear)
            .dropDestination(for: URL.self) { droppedURLs, _ in
                model.drop(droppedURLs, into: url)
                return true
            }
        }
        .task(id: url) {
            if index > 0 || columnItems[0] == nil {
                loadColumn(index: index, url: url)
            }
        }
    }

    private func columnRow(item: FileItem, columnIndex: Int) -> some View {
        let isSelected = selectedInColumn[columnIndex] == item.url || (columnIndex == columnPath.count && model.selection.contains(item.url))
        return HStack(spacing: 6) {
            Image(nsImage: IconCache.icon(for: item.url))
                .resizable()
                .frame(width: 16, height: 16)

            Text(item.name)
                .font(.system(size: 12))
                .lineLimit(1)
                .truncationMode(.middle)
                .foregroundStyle(isSelected ? Color.white : Color.primary)

            Spacer(minLength: 2)

            // Tag dots
            if !item.tags.isEmpty {
                HStack(spacing: 2) {
                    ForEach(item.tags.prefix(2), id: \.self) { tagName in
                        Circle()
                            .fill(FileItem.tagColor(for: tagName))
                            .frame(width: 6, height: 6)
                    }
                }
            }

            if item.isFolder {
                Image(systemName: "chevron.right")
                    .font(.system(size: 9, weight: .semibold))
                    .foregroundStyle(isSelected ? Color.white.opacity(0.8) : Color.secondary.opacity(0.6))
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(isSelected ? Color.accentColor : Color.clear)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            selectItem(item, inColumn: columnIndex)
        }
        .onTapGesture(count: 2) {
            if item.isFolder {
                model.navigate(to: item.url)
            } else {
                model.open(item)
            }
        }
        .draggable(item.url)
        .contextMenu {
            ItemContextMenu(model: model, ids: model.selection.contains(item.id) ? model.selection : [item.id])
        }
    }

    private func selectItem(_ item: FileItem, inColumn columnIndex: Int) {
        selectedInColumn[columnIndex] = item.url
        // Prune deeper columns
        columnPath = Array(columnPath.prefix(columnIndex))
        selectedInColumn = selectedInColumn.filter { $0.key <= columnIndex }
        columnItems = columnItems.filter { $0.key <= columnIndex }

        if item.isFolder {
            columnPath.append(item.url)
            loadColumn(index: columnIndex + 1, url: item.url)
        }

        // Keep model selection in sync so CommandBar and Menus know what's selected
        model.selection = [item.id]
    }

    private func loadColumn(index: Int, url: URL) {
        Task {
            let loaded = (try? await Task.detached {
                try FileBrowserModel.readDirectory(url)
            }.value) ?? []

            var list = loaded
            if !model.showHidden { list = list.filter { !$0.isHidden } }
            list.sort(using: model.sortOrder)
            if model.foldersFirst {
                list = list.filter(\.isFolder) + list.filter { !$0.isFolder }
            }
            columnItems[index] = list
        }
    }
}

/// macOS Finder Column View Inspector Preview Card
struct ColumnPreviewPane: View {
    let item: FileItem
    @ObservedObject var model: FileBrowserModel

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 14) {
                    // Preview Icon or QuickLook View
                    QuickLookPreview(url: item.url)
                        .frame(height: 170)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(color: .black.opacity(0.12), radius: 4, y: 2)

                    VStack(spacing: 4) {
                        Text(item.name)
                            .font(.system(size: 13, weight: .semibold))
                            .multilineTextAlignment(.center)
                            .textSelection(.enabled)
                        Text(item.kind)
                            .font(.system(size: 11))
                            .foregroundStyle(.secondary)
                    }

                    Divider()

                    // Metadata details
                    VStack(alignment: .leading, spacing: 6) {
                        metaRow("Size", Fmt.exactBytes(item.size))
                        metaRow("Modified", Fmt.date(item.modified))
                        metaRow("Created", Fmt.date(item.created))
                        metaRow("Location", item.url.deletingLastPathComponent().path)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Divider()

                    // Tags
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("Tags").font(.caption.weight(.medium)).foregroundStyle(.secondary)
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
                                    HStack(spacing: 4) {
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
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Divider()

                    // Quick Actions
                    HStack(spacing: 8) {
                        Button {
                            model.open(item)
                        } label: {
                            Label("Open", systemImage: "arrow.up.forward.app")
                                .font(.system(size: 11))
                                .frame(maxWidth: .infinity)
                        }
                        .controlSize(.small)

                        Button {
                            model.toggleQuickLook()
                        } label: {
                            Label("Quick Look", systemImage: "eye")
                                .font(.system(size: 11))
                                .frame(maxWidth: .infinity)
                        }
                        .controlSize(.small)

                        ShareLink(items: [item.url]) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 11))
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.small)
                    }
                }
                .padding(14)
            }
        }
        .frame(width: 260)
        .background(Color.primary.opacity(0.02))
    }

    private func metaRow(_ title: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(title).font(.caption).foregroundStyle(.secondary)
            Text(value).font(.system(size: 11)).textSelection(.enabled)
        }
    }
}
