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
                    HStack(spacing: 4) {
                        Text(item.name).lineLimit(1)
                        if !item.tags.isEmpty {
                            HStack(spacing: 2) {
                                ForEach(item.tags.prefix(3), id: \.self) { tagName in
                                    Circle()
                                        .fill(FileItem.tagColor(for: tagName))
                                        .frame(width: 7, height: 7)
                                }
                            }
                        }
                    }
                    if model.searchResults != nil, model.isRecursiveSearchActive {
                        Text(item.url.deletingLastPathComponent().path.replacingOccurrences(of: SidebarStore.home.path, with: "~"))
                            .font(.system(size: 10)).foregroundStyle(.secondary).lineLimit(1)
                    }
                }
            }
        }
        .background(
            GeometryReader { geo in
                Color.clear.preference(
                    key: GridCellFrameKey.self,
                    value: [item.id: geo.frame(in: .named("fileListAreaSpace"))]
                )
            }
        )
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

struct SizeCell: View {
    let item: FileItem
    @ObservedObject var model: FileBrowserModel

    var body: some View {
        Text(model.displaySize(for: item))
            .monospacedDigit()
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .trailing)
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
                SizeCell(item: item, model: model)
            }
            .width(min: 60, ideal: 90)
        } rows: {
            if model.groupBy == .none {
                ForEach(model.displayItems) { item in
                    TableRow(item)
                        .draggable(item.url)
                }
            } else {
                ForEach(model.groupedItems) { group in
                    Section {
                        ForEach(group.items) { item in
                            TableRow(item)
                                .draggable(item.url)
                        }
                    } header: {
                        Text("\(group.title) (\(group.items.count))")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .contextMenu(forSelectionType: URL.self) { ids in
            ItemContextMenu(model: model, ids: ids)
        } primaryAction: { ids in
            model.open(ids)
        }
    }
}

struct GridCellFrameKey: PreferenceKey {
    static var defaultValue: [URL: CGRect] = [:]
    static func reduce(value: inout [URL: CGRect], nextValue: () -> [URL: CGRect]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

struct IconGridView: View {
    @ObservedObject var model: FileBrowserModel

    private var cellWidth: CGFloat { model.viewMode == .tiles ? 250 : max(model.iconSize + 36, 84) }

    var body: some View {
        GeometryReader { proxy in
            ScrollViewReader { reader in
                ScrollView {
                    grid(minHeight: proxy.size.height - 24)
                }
                .onChange(of: model.scrollTarget) { _, target in
                    if let target { withAnimation(.easeOut(duration: 0.12)) { reader.scrollTo(target) } }
                }
            }
            .onChange(of: proxy.size.width, initial: true) { _, width in updateColumns(width: width) }
            .onChange(of: model.viewMode) { _, _ in updateColumns(width: proxy.size.width) }
            .onChange(of: model.iconSize) { _, _ in updateColumns(width: proxy.size.width) }
        }
    }

    private func updateColumns(width: CGFloat) {
        model.gridColumns = max(1, Int((width - 24 + 6) / (cellWidth + 6)))
    }

    private func grid(minHeight: CGFloat) -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: cellWidth), spacing: 6, alignment: .top)], spacing: 6) {
            if model.groupBy == .none {
                ForEach(model.displayItems) { item in
                    gridCell(for: item)
                }
            } else {
                ForEach(model.groupedItems) { group in
                    Section {
                        ForEach(group.items) { item in
                            gridCell(for: item)
                        }
                    } header: {
                        HStack(spacing: 6) {
                            Text(group.title)
                                .font(.system(size: 13, weight: .bold))
                                .foregroundStyle(.primary)
                            Text("(\(group.items.count))")
                                .font(.system(size: 11))
                                .foregroundStyle(.secondary)
                            Spacer()
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 4)
                    }
                }
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, minHeight: minHeight, alignment: .top)
        .background(backgroundTapArea)
    }

    private func gridCell(for item: FileItem) -> some View {
        let isSelected = model.selection.contains(item.id)
        let ids: Set<URL> = isSelected ? model.selection : [item.id]
        let cell = GridCell(item: item, model: model)
            .id(item.id)
            .background(
                GeometryReader { geo in
                    Color.clear.preference(
                        key: GridCellFrameKey.self,
                        value: [item.id: geo.frame(in: .named("fileListAreaSpace"))]
                    )
                }
            )
            .contextMenu {
                ItemContextMenu(model: model, ids: ids)
            }

        return Group {
            if isSelected {
                cell.draggable(item.url)
            } else {
                cell
            }
        }
    }

    private var backgroundTapArea: some View {
        Color.clear.contentShape(Rectangle())
            .onTapGesture {
                model.selectNone()
            }
            .contextMenu {
                ItemContextMenu(model: model, ids: model.selection)
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
                        Text(model.displaySize(for: item)).font(.system(size: 10)).foregroundStyle(.secondary)
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
            VStack(spacing: 2) {
                Text(item.name).lineLimit(model.viewMode == .tiles ? 1 : 2).truncationMode(.middle)
                if !item.tags.isEmpty {
                    HStack(spacing: 2) {
                        ForEach(item.tags.prefix(3), id: \.self) { tagName in
                            Circle()
                                .fill(FileItem.tagColor(for: tagName))
                                .frame(width: 6, height: 6)
                        }
                    }
                }
            }
        }
    }
}

struct ItemContextMenu: View {
    @ObservedObject var model: FileBrowserModel
    let ids: Set<URL>

    private var effectiveIDs: Set<URL> {
        if !ids.isEmpty { return ids }
        return model.selection
    }

    private var urls: [URL] { model.displayItems.filter { effectiveIDs.contains($0.id) }.map(\.url) }
    private var items: [FileItem] { model.displayItems.filter { effectiveIDs.contains($0.id) } }

    var body: some View {
        if effectiveIDs.isEmpty {
            backgroundMenu
        } else {
            itemMenu
        }
    }

    @ViewBuilder private var backgroundMenu: some View {
        Menu("New") {
            Button("Folder", systemImage: "folder.badge.plus") { model.newFolder() }
            Button("Text Document", systemImage: "doc.badge.plus") { model.newTextFile() }
        }
        Button("Paste") { model.paste() }.disabled(!ClipboardState.shared.canPaste)
        Divider()
        Menu("Sort by") {
            ForEach(SortField.allCases) { field in
                Button {
                    model.setSort(field)
                } label: {
                    if field == model.currentSortField {
                        Label(field.title, systemImage: model.sortAscending ? "arrow.up" : "arrow.down")
                    } else {
                        Text(field.title)
                    }
                }
            }
            Divider()
            Button {
                model.setSortDirection(ascending: true)
            } label: {
                if model.sortAscending {
                    Label("Ascending", systemImage: "checkmark")
                } else {
                    Text("Ascending")
                }
            }
            Button {
                model.setSortDirection(ascending: false)
            } label: {
                if !model.sortAscending {
                    Label("Descending", systemImage: "checkmark")
                } else {
                    Text("Descending")
                }
            }
        }
        Menu("Group by") {
            ForEach(GroupByField.allCases) { field in
                Button {
                    model.groupBy = field
                } label: {
                    if field == model.groupBy {
                        Label(field.title, systemImage: "checkmark")
                    } else {
                        Text(field.title)
                    }
                }
            }
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
        let count = items.count
        let archives = items.filter(\.isArchive)
        let images = items.filter(\.isImage)
        let docs = items.filter(\.isConvertibleDocument)

        if count > 1 {
            Text("\(count) items selected")
                .font(.caption)
                .foregroundStyle(.secondary)
            Divider()
        }

        Button(count > 1 ? "Open \(count) Items" : "Open") {
            model.open(effectiveIDs)
        }
        Button(count > 1 ? "Quick Look (\(count) Items)" : "Quick Look") {
            model.toggleQuickLook()
        }
        ShareLink(items: urls) {
            Label(count > 1 ? "Share \(count) Items…" : "Share…", systemImage: "square.and.arrow.up")
        }

        // Unzip / Extract Actions
        if !archives.isEmpty {
            Divider()
            if archives.count == 1 {
                let arch = archives[0]
                Button("Extract Here", systemImage: "arrow.up.bin") {
                    model.extract([arch.url], toSubfolder: false)
                }
                Button("Extract to “\(arch.url.deletingPathExtension().lastPathComponent)”", systemImage: "folder.badge.plus") {
                    model.extract([arch.url], toSubfolder: true)
                }
            } else {
                Menu("Extract (\(archives.count) Archives)", systemImage: "arrow.up.bin") {
                    Button("Extract All Here") {
                        model.extract(archives.map(\.url), toSubfolder: false)
                    }
                    Button("Extract Each to Subfolder") {
                        model.extract(archives.map(\.url), toSubfolder: true)
                    }
                }
            }
        }

        // Convert Image Actions
        if !images.isEmpty {
            Divider()
            Menu(images.count > 1 ? "Convert \(images.count) Images" : "Convert Image", systemImage: "photo.on.rectangle") {
                Button("Convert to JPEG (.jpg)") { model.convertImages(images.map(\.url), to: .jpeg) }
                Button("Convert to PNG (.png)") { model.convertImages(images.map(\.url), to: .png) }
                Button("Convert to HEIC (.heic)") { model.convertImages(images.map(\.url), to: .heic) }
                Button("Convert to TIFF (.tiff)") { model.convertImages(images.map(\.url), to: .tiff) }
                Button("Convert to GIF (.gif)") { model.convertImages(images.map(\.url), to: .gif) }
                Button("Convert to BMP (.bmp)") { model.convertImages(images.map(\.url), to: .bmp) }
                Divider()
                Button(images.count > 1 ? "Convert Each to PDF (.pdf)" : "Convert to PDF (.pdf)") {
                    model.convertImages(images.map(\.url), to: .pdf)
                }
                if images.count > 1 {
                    Button("Combine into Single PDF…", systemImage: "doc.on.doc") {
                        model.combineImagesToPDF(images.map(\.url))
                    }
                }
            }
        }

        // Convert Document Actions
        if !docs.isEmpty {
            Divider()
            Menu(docs.count > 1 ? "Convert \(docs.count) Documents" : "Convert Document", systemImage: "doc.text") {
                Button("Convert to PDF (.pdf)") { model.convertDocuments(docs.map(\.url), to: .pdf) }
                Divider()
                Button("Convert to Word (.docx)") { model.convertDocuments(docs.map(\.url), to: .docx) }
                Button("Convert to Rich Text (.rtf)") { model.convertDocuments(docs.map(\.url), to: .rtf) }
                Button("Convert to Plain Text (.txt)") { model.convertDocuments(docs.map(\.url), to: .txt) }
                Button("Convert to HTML (.html)") { model.convertDocuments(docs.map(\.url), to: .html) }
                Button("Convert to OpenDocument (.odt)") { model.convertDocuments(docs.map(\.url), to: .odt) }
            }
        }

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
        Menu(count > 1 ? "Tags (\(count) Items)" : "Tags") {
            ForEach(MacTag.allCases) { tag in
                Button {
                    model.toggleTag(tag.rawValue, for: urls)
                } label: {
                    Label(tag.rawValue, systemImage: "circle.fill")
                }
            }
            Divider()
            Button("Clear Tags") { model.clearTags(for: urls) }
        }
        Divider()
        Button("New Folder with Selection (\(count) Item\(count == 1 ? "" : "s"))") {
            model.newFolderWithSelection()
        }
        Button(count > 1 ? "Make Aliases (\(count) Items)" : "Make Alias") {
            model.makeAlias(urls)
        }
        Divider()
        Button(count > 1 ? "Cut (\(count) Items)" : "Cut") { model.cut(urls) }
        Button(count > 1 ? "Copy (\(count) Items)" : "Copy") { model.copy(urls) }
        if let single, single.isFolder {
            Button("Paste into Folder") { model.paste(into: single.url) }.disabled(!ClipboardState.shared.canPaste)
        }
        Button(count > 1 ? "Copy \(count) Paths" : "Copy Path") { model.copyPath(urls) }
        Divider()
        Button(count > 1 ? "Duplicate (\(count) Items)" : "Duplicate") { model.duplicate(urls) }
        Menu(count > 1 ? "Compress (\(count) Items)" : "Compress", systemImage: "doc.zipper") {
            Button("ZIP Archive (.zip)") { model.compress(urls, format: .zip) }
            Button("TAR Archive (.tar.gz)") { model.compress(urls, format: .tarGz) }
        }
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
        Button(count > 1 ? "Move \(count) Items to Trash" : "Move to Trash", systemImage: "trash") { model.trash(urls) }
        Button(count > 1 ? "Delete \(count) Items Permanently…" : "Delete Permanently…") { model.requestPermanentDelete(urls) }
        Divider()
        Button(count > 1 ? "Properties (\(count) Items)" : "Properties") { model.showProperties(urls) }

        if count > 1 {
            Divider()
            Button("Deselect All") { model.selectNone() }
        }
    }

    private func openWithApps(for url: URL) -> [URL] {
        Array(NSWorkspace.shared.urlsForApplications(toOpen: url).prefix(12))
    }
}
