import SwiftUI

/// Icon + name, or an inline rename field (F2).
struct NameCell: View {
    let item: FileItem
    @ObservedObject var model: FileBrowserModel
    @ObservedObject private var clipboard = ClipboardState.shared

    var body: some View {
        HStack(spacing: 7) {
            Image(nsImage: IconCache.icon(for: item.url))
                .resizable()
                .frame(width: 18, height: 18)
            if model.renamingURL == item.url {
                RenameField(model: model, item: item)
            } else {
                VStack(alignment: .leading, spacing: 0) {
                    Text(item.name).lineLimit(1)
                    if model.searchResults != nil, model.isRecursiveSearchActive {
                        Text(item.url.deletingLastPathComponent().path.replacingOccurrences(of: SidebarStore.home.path, with: "~"))
                            .font(.system(size: 10)).foregroundStyle(.secondary).lineLimit(1)
                    }
                }
            }
        }
        .opacity(clipboard.isCut(item.url) || item.isHidden ? 0.5 : 1)
    }
}

struct RenameField: View {
    @ObservedObject var model: FileBrowserModel
    let item: FileItem
    @FocusState private var focused: Bool

    var body: some View {
        TextField("Name", text: $model.renameText)
            .textFieldStyle(.roundedBorder)
            .focused($focused)
            .onSubmit { model.commitRename() }
            .onExitCommand { model.cancelRename() }
            .onChange(of: focused) { _, isFocused in
                if !isFocused && model.renamingURL == item.url { model.commitRename() }
            }
            .onAppear {
                focused = true
                // Select the base name only, like Explorer does.
                DispatchQueue.main.async {
                    guard let editor = NSApp.keyWindow?.firstResponder as? NSTextView else { return }
                    let ext = (item.name as NSString).pathExtension
                    let length = item.isFolder || ext.isEmpty ? (item.name as NSString).length : (item.name as NSString).deletingPathExtension.count
                    editor.setSelectedRange(NSRange(location: 0, length: length))
                }
            }
    }
}

struct DetailsTableView: View {
    @ObservedObject var model: FileBrowserModel

    var body: some View {
        Table(of: FileItem.self, selection: $model.selection, sortOrder: $model.sortOrder) {
            TableColumn("Name", sortUsing: KeyPathComparator(\FileItem.name, comparator: .localizedStandard)) { item in
                NameCell(item: item, model: model)
            }
            .width(min: 160, ideal: 320)
            TableColumn("Date modified", sortUsing: KeyPathComparator(\FileItem.modifiedSort)) { item in
                Text(Fmt.date(item.modified)).foregroundStyle(.secondary).lineLimit(1)
            }
            .width(min: 110, ideal: 150)
            TableColumn("Type", sortUsing: KeyPathComparator(\FileItem.kind, comparator: .localizedStandard)) { item in
                Text(item.kind).foregroundStyle(.secondary).lineLimit(1)
            }
            .width(min: 80, ideal: 140)
            TableColumn("Size", sortUsing: KeyPathComparator(\FileItem.sizeSort)) { item in
                Text(item.displaySize)
                    .monospacedDigit()
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .width(min: 60, ideal: 90)
        } rows: {
            ForEach(model.displayItems) { item in
                TableRow(item)
                    .draggable(item.url)
            }
        }
        .contextMenu(forSelectionType: URL.self) { ids in
            ItemContextMenu(model: model, ids: ids)
        } primaryAction: { ids in
            model.open(ids)
        }
    }
}

struct IconGridView: View {
    @ObservedObject var model: FileBrowserModel

    private var cellWidth: CGFloat { model.viewMode == .tiles ? 250 : max(model.iconSize + 36, 84) }

    var body: some View {
        GeometryReader { proxy in
            ScrollViewReader { reader in
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: cellWidth), spacing: 6, alignment: .top)], spacing: 6) {
                        ForEach(model.displayItems) { item in
                            GridCell(item: item, model: model)
                                .id(item.id)
                                .draggable(item.url)
                                .contextMenu { ItemContextMenu(model: model, ids: model.selection.contains(item.id) ? model.selection : [item.id]) }
                        }
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, minHeight: proxy.size.height - 24, alignment: .top)
                    .background(
                        Color.clear.contentShape(Rectangle())
                            .onTapGesture { model.selectNone() }
                            .contextMenu { ItemContextMenu(model: model, ids: []) }
                    )
                }
                .onChange(of: model.scrollTarget) { _, target in
                    if let target { withAnimation(.easeOut(duration: 0.12)) { reader.scrollTo(target) } }
                }
            }
            .onChange(of: proxy.size.width, initial: true) { _, width in
                model.gridColumns = max(1, Int((width - 24 + 6) / (cellWidth + 6)))
            }
            .onChange(of: model.viewMode) { _, _ in
                model.gridColumns = max(1, Int((proxy.size.width - 24 + 6) / (cellWidth + 6)))
            }
            .onChange(of: model.iconSize) { _, _ in
                model.gridColumns = max(1, Int((proxy.size.width - 24 + 6) / (cellWidth + 6)))
            }
        }
    }
}

private struct GridCell: View {
    let item: FileItem
    @ObservedObject var model: FileBrowserModel
    @ObservedObject private var clipboard = ClipboardState.shared
    @State private var thumbnail: NSImage?

    private var selected: Bool { model.selection.contains(item.id) }

    var body: some View {
        Group {
            if model.viewMode == .tiles {
                HStack(spacing: 8) {
                    icon(size: 44)
                    VStack(alignment: .leading, spacing: 1) {
                        label.font(.system(size: 12, weight: .medium))
                        Text(item.kind).font(.system(size: 10)).foregroundStyle(.secondary).lineLimit(1)
                        if !item.isFolder { Text(item.displaySize).font(.system(size: 10)).foregroundStyle(.secondary) }
                    }
                    Spacer(minLength: 0)
                }
            } else {
                VStack(spacing: 4) {
                    icon(size: model.iconSize)
                    label.font(.system(size: 12)).multilineTextAlignment(.center)
                }
            }
        }
        .padding(6)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 8).fill(selected ? Color.accentColor.opacity(0.28) : .clear))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(selected ? Color.accentColor.opacity(0.7) : .clear, lineWidth: 1))
        .contentShape(RoundedRectangle(cornerRadius: 8))
        .opacity(clipboard.isCut(item.url) || item.isHidden ? 0.5 : 1)
        .onTapGesture(count: 2) { model.open(item) }
        .onTapGesture { model.clickSelect(item, modifiers: NSEvent.modifierFlags) }
        .task(id: "\(item.url.path)#\(ThumbnailLoader.bucket(model.iconSize))") { await loadThumbnail() }
    }

    private func icon(size: CGFloat) -> some View {
        Image(nsImage: thumbnail ?? IconCache.icon(for: item.url))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
    }

    private func loadThumbnail() async {
        guard !item.isFolder, ThumbnailLoader.isPreviewable(item.url) else { thumbnail = nil; return }
        if let cached = ThumbnailLoader.cached(for: item.url, size: model.iconSize) {
            thumbnail = cached
            return
        }
        thumbnail = nil
        let image = await ThumbnailLoader.load(for: item.url, size: model.iconSize)
        if !Task.isCancelled { thumbnail = image }
    }

    @ViewBuilder private var label: some View {
        if model.renamingURL == item.url {
            RenameField(model: model, item: item)
        } else {
            Text(item.name).lineLimit(model.viewMode == .tiles ? 1 : 2).truncationMode(.middle)
        }
    }
}

struct ItemContextMenu: View {
    @ObservedObject var model: FileBrowserModel
    let ids: Set<URL>

    private var urls: [URL] { model.displayItems.filter { ids.contains($0.id) }.map(\.url) }
    private var items: [FileItem] { model.displayItems.filter { ids.contains($0.id) } }

    var body: some View {
        if ids.isEmpty { backgroundMenu } else { itemMenu }
    }

    @ViewBuilder private var backgroundMenu: some View {
        Menu("New") {
            Button("Folder", systemImage: "folder.badge.plus") { model.newFolder() }
            Button("Text Document", systemImage: "doc.badge.plus") { model.newTextFile() }
        }
        Button("Paste") { model.paste() }.disabled(!ClipboardState.shared.canPaste)
        Divider()
        Menu("Sort by") {
            ForEach(SortField.allCases) { field in Button(field.title) { model.setSort(field) } }
        }
        Menu("View") {
            ForEach(ViewMode.allCases) { mode in Button(mode.title, systemImage: mode.symbol) { model.viewMode = mode } }
        }
        Button("Refresh") { model.refresh() }
        Divider()
        Button("Select All") { model.selectAll() }
        Button("Open in Terminal") { model.openInTerminal(model.currentURL) }
        Button("Properties") { model.showProperties([model.currentURL]) }
    }

    @ViewBuilder private var itemMenu: some View {
        let single = items.count == 1 ? items.first : nil
        Button("Open") { model.open(ids) }
        if let single, !single.isFolder {
            Menu("Open With") {
                ForEach(openWithApps(for: single.url), id: \.self) { app in
                    Button(FileManager.default.displayName(atPath: app.path).replacingOccurrences(of: ".app", with: "")) {
                        model.open(urls, with: app)
                    }
                }
            }
        }
        if model.isRecursiveSearchActive, let single {
            Button("Open Containing Folder") { model.openContainingFolder(single.url) }
        }
        Button("Reveal in Finder") { model.reveal(urls) }
        Divider()
        Button("Cut") { model.cut(urls) }
        Button("Copy") { model.copy(urls) }
        if let single, single.isFolder {
            Button("Paste into Folder") { model.paste(into: single.url) }.disabled(!ClipboardState.shared.canPaste)
        }
        Button("Copy Path") { model.copyPath(urls) }
        Divider()
        Button("Duplicate") { model.duplicate(urls) }
        Button("Compress") { model.compress(urls) }
        if let single, single.isZip { Button("Extract Here") { model.extract(single.url) } }
        if let single {
            Button("Rename") { model.beginRename(single.url) }
            if single.isFolder {
                Button(SidebarStore.shared.isPinned(single.url) ? "Unpin from Quick access" : "Pin to Quick access") {
                    if SidebarStore.shared.isPinned(single.url) { SidebarStore.shared.unpin(single.url) } else { SidebarStore.shared.pin(single.url) }
                }
                Button("Open in Terminal") { model.openInTerminal(single.url) }
            }
        }
        Divider()
        Button("Move to Trash", systemImage: "trash") { model.trash(urls) }
        Button("Delete Permanently…") { model.requestPermanentDelete(urls) }
        Divider()
        Button("Properties") { model.showProperties(urls) }
    }

    private func openWithApps(for url: URL) -> [URL] {
        Array(NSWorkspace.shared.urlsForApplications(toOpen: url).prefix(12))
    }
}
