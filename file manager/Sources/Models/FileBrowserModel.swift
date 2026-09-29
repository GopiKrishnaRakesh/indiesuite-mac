import AppKit
import SwiftUI
import UniformTypeIdentifiers

enum ViewMode: String, CaseIterable, Identifiable {
    case details, icons, tiles, columns
    var id: String { rawValue }
    var title: String {
        switch self {
        case .details: "Details"
        case .icons: "Icons"
        case .tiles: "Tiles"
        case .columns: "Columns"
        }
    }
    var symbol: String {
        switch self {
        case .details: "list.bullet"
        case .icons: "square.grid.2x2"
        case .tiles: "rectangle.grid.1x2"
        case .columns: "rectangle.split.3x1"
        }
    }
}

enum SortField: String, CaseIterable, Identifiable {
    case name, kind, modified, created, size, tags
    var id: String { rawValue }
    var title: String {
        switch self {
        case .name: "Name"
        case .kind: "Type"
        case .modified: "Date modified"
        case .created: "Date created"
        case .size: "Size"
        case .tags: "Tags"
        }
    }
    func comparator(_ order: SortOrder) -> KeyPathComparator<FileItem> {
        switch self {
        case .name: KeyPathComparator(\FileItem.name, comparator: .localizedStandard, order: order)
        case .kind: KeyPathComparator(\FileItem.kind, comparator: .localizedStandard, order: order)
        case .modified: KeyPathComparator(\FileItem.modifiedSort, order: order)
        case .created: KeyPathComparator(\FileItem.createdSort, order: order)
        case .size: KeyPathComparator(\FileItem.sizeSort, order: order)
        case .tags: KeyPathComparator(\FileItem.tagsSort, comparator: .localizedStandard, order: order)
        }
    }
}

enum GroupByField: String, CaseIterable, Identifiable {
    case none = "none"
    case kind = "kind"
    case dateModified = "dateModified"
    case size = "size"
    case tags = "tags"

    var id: String { rawValue }

    var title: String {
        switch self {
        case .none: "None"
        case .kind: "Type"
        case .dateModified: "Date modified"
        case .size: "Size"
        case .tags: "Tags"
        }
    }
}

struct FileGroup: Identifiable {
    let id: String
    let title: String
    let items: [FileItem]
}

enum NavMode { case push, back, forward }

enum Sheet: Identifiable {
    case properties([URL])
    var id: String {
        switch self {
        case .properties(let urls): "properties-" + urls.map(\.path).joined(separator: "|")
        }
    }
}

struct UndoEntry {
    let label: String
    let run: @Sendable () throws -> Void
}

@MainActor
final class FileBrowserModel: ObservableObject {
    // MARK: Location + contents
    @Published private(set) var currentURL: URL
    @Published private(set) var backStack: [URL] = []
    @Published private(set) var forwardStack: [URL] = []
    @Published private(set) var items: [FileItem] = []
    @Published private(set) var displayItems: [FileItem] = []
    @Published private(set) var isLoading = false
    @Published private(set) var busyLabel: String?

    // MARK: Selection
    @Published var selection: Set<URL> = [] {
        didSet { if selection != oldValue { QuickLookController.shared.refresh(selected: selectedURLs) } }
    }
    @Published var scrollTarget: URL?
    var gridColumns = 1
    private var anchor: URL?
    private var cursor: URL?

    // MARK: Presentation (persisted)
    private let defaults = UserDefaults.standard
    @Published var viewMode: ViewMode {
        didSet { defaults.set(viewMode.rawValue, forKey: "viewMode") }
    }
    @Published var showHidden: Bool {
        didSet { defaults.set(showHidden, forKey: "showHidden"); rebuild(); restartSearchIfNeeded() }
    }
    @Published var showPreview: Bool {
        didSet { defaults.set(showPreview, forKey: "showPreview") }
    }
    @Published var showPathBar: Bool {
        didSet { defaults.set(showPathBar, forKey: "showPathBar") }
    }
    @Published var selectedTagFilter: String? {
        didSet { rebuild() }
    }
    @Published var foldersFirst: Bool {
        didSet { defaults.set(foldersFirst, forKey: "foldersFirst"); rebuild() }
    }
    @Published var iconSize: Double {
        didSet { defaults.set(iconSize, forKey: "iconSize") }
    }
    @Published var sortOrder: [KeyPathComparator<FileItem>] = [SortField.name.comparator(.forward)] {
        didSet { rebuild() }
    }
    @Published var groupBy: GroupByField {
        didSet { defaults.set(groupBy.rawValue, forKey: "groupBy"); rebuild() }
    }
    @Published var folderSizes: [String: Int64] = [:]
    @Published var calculateFolderSizes: Bool {
        didSet {
            defaults.set(calculateFolderSizes, forKey: "calculateFolderSizes")
            if calculateFolderSizes {
                triggerFolderSizeCalculations(for: items.filter(\.isFolder))
            } else {
                folderSizeTask?.cancel()
                folderSizes.removeAll()
                rebuild()
            }
        }
    }
    private var folderSizeTask: Task<Void, Never>?

    // MARK: Search
    @Published var searchText = "" {
        didSet { if searchText != oldValue { searchChanged() } }
    }
    @Published var searchRecursive = false {
        didSet { if searchRecursive != oldValue { searchChanged() } }
    }
    @Published private(set) var searchResults: [FileItem]?
    @Published private(set) var isSearching = false
    var isRecursiveSearchActive: Bool { searchRecursive && !searchText.isEmpty }

    // MARK: UI state
    @Published var isEditingPath = false
    @Published var searchFocusToken = 0
    @Published var renamingURL: URL?
    @Published var renameText = ""
    @Published var sheet: Sheet?
    @Published var showOnboarding: Bool = false
    @Published var showFeatureStore: Bool = false
    @Published var errorMessage: String?
    @Published var pendingPermanentDelete: [URL]?
    @Published private(set) var undoStack: [UndoEntry] = []

    // MARK: Drag Selection Marquee
    @Published var dragMarqueeRect: CGRect?
    @Published var itemFrames: [URL: CGRect] = [:]

    weak var window: NSWindow?
    private var loadGeneration = 0
    private var searchGeneration = 0
    private var watcher: DispatchSourceFileSystemObject?
    private var reloadTask: Task<Void, Never>?
    private var pendingSelection: URL?
    private var typeBuffer = ""
    private var typeBufferTime = Date.distantPast

    // MARK: Init
    init(start: URL = FileManager.default.homeDirectoryForCurrentUser) {
        let d = UserDefaults.standard
        currentURL = start.standardizedFileURL
        viewMode = ViewMode(rawValue: d.string(forKey: "viewMode") ?? "") ?? .details
        showHidden = d.bool(forKey: "showHidden")
        showPreview = d.bool(forKey: "showPreview")
        showPathBar = d.object(forKey: "showPathBar") as? Bool ?? true
        foldersFirst = d.object(forKey: "foldersFirst") as? Bool ?? true
        iconSize = d.object(forKey: "iconSize") as? Double ?? 64
        showOnboarding = !d.bool(forKey: "hasCompletedSetup")
        groupBy = GroupByField(rawValue: d.string(forKey: "groupBy") ?? "") ?? .none
        calculateFolderSizes = d.object(forKey: "calculateFolderSizes") as? Bool ?? true
        navigate(to: start, mode: .push, force: true)
    }

    deinit {
        watcher?.cancel()
        folderSizeTask?.cancel()
    }

    // MARK: Derived
    var canGoBack: Bool { !backStack.isEmpty }
    var canGoForward: Bool { !forwardStack.isEmpty }
    var canGoUp: Bool { currentURL.path != "/" }
    var selectionURLs: [URL] { displayItems.filter { selection.contains($0.id) }.map(\.url) }
    var selectedURLs: [URL] { selectionURLs }
    var selectedItems: [FileItem] { displayItems.filter { selection.contains($0.id) } }
    var isInTrash: Bool { FileOps.isInside(currentURL, of: SidebarStore.trash) }
    var title: String { currentURL.path == "/" ? FileManager.default.displayName(atPath: "/") : currentURL.lastPathComponent }
    var canUndo: Bool { !undoStack.isEmpty }
    var selectionSize: Int64 {
        selectedItems.reduce(0) { total, item in
            total + (item.isFolder ? (folderSizes[item.url.path] ?? item.folderSize ?? 0) : item.size)
        }
    }

    // MARK: - Navigation
    func navigate(to target: URL, mode: NavMode = .push, select: URL? = nil, force: Bool = false) {
        let dest = target.standardizedFileURL
        if mode == .push && dest == currentURL && !force { return }
        let snapshot = (currentURL, backStack, forwardStack)
        switch mode {
        case .push:
            if !force { backStack.append(currentURL); forwardStack.removeAll() }
        case .back:
            guard !backStack.isEmpty else { return }
            forwardStack.append(currentURL); backStack.removeLast()
        case .forward:
            guard !forwardStack.isEmpty else { return }
            backStack.append(currentURL); forwardStack.removeLast()
        }
        currentURL = dest
        cancelRename()
        resetSearch()
        selection = []
        anchor = nil; cursor = nil
        pendingSelection = select
        isLoading = true
        folderSizeTask?.cancel()
        loadGeneration += 1
        let generation = loadGeneration
        Task {
            do {
                let loaded = try await Task.detached { try Self.readDirectory(dest) }.value
                guard generation == loadGeneration else { return }
                items = loaded
                isLoading = false
                rebuild()
                if let pick = pendingSelection, displayItems.contains(where: { $0.id == pick }) {
                    selection = [pick]; anchor = pick; cursor = pick; scrollTarget = pick
                }
                pendingSelection = nil
                startWatching()
                SidebarStore.shared.noteVisit(dest)
                focusFileList()
                triggerFolderSizeCalculations(for: loaded.filter(\.isFolder))
            } catch {
                guard generation == loadGeneration else { return }
                if force {
                    items = []; rebuild(); isLoading = false
                } else {
                    (currentURL, backStack, forwardStack) = snapshot
                    isLoading = false
                }
                errorMessage = Self.friendly(error, at: dest)
            }
        }
    }

    func goBack() { if let dest = backStack.last { navigate(to: dest, mode: .back, select: currentURL) } }
    func goForward() { if let dest = forwardStack.last { navigate(to: dest, mode: .forward, select: currentURL) } }
    func goUp() { if canGoUp { navigate(to: currentURL.deletingLastPathComponent(), select: currentURL) } }
    func goHome() { navigate(to: SidebarStore.home) }
    func goTo(_ path: String) { navigate(to: URL(fileURLWithPath: path, isDirectory: true)) }

    func navigate(toPath text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let expanded = (trimmed as NSString).expandingTildeInPath
        var isDir: ObjCBool = false
        guard FileManager.default.fileExists(atPath: expanded, isDirectory: &isDir) else {
            errorMessage = "Can't find “\(trimmed)”. Check the spelling and try again."
            return
        }
        let url = URL(fileURLWithPath: expanded)
        if isDir.boolValue { navigate(to: url) } else { navigate(to: url.deletingLastPathComponent(), select: url) }
    }

    func focusAddressBar() { isEditingPath = true }
    func focusSearch() { searchFocusToken += 1 }

    /// Leaves address-bar editing without navigating. The address bar's TextField sits inside a
    /// toolbar item, where SwiftUI's onExitCommand/focus tracking doesn't reliably fire on macOS, so
    /// Escape and clicking elsewhere are routed here explicitly instead (see KeyMonitor and clickSelect).
    func cancelAddressEdit() {
        guard isEditingPath else { return }
        isEditingPath = false
        focusFileList()
    }

    func refresh() { Task { await reload() } }

    nonisolated static func readDirectory(_ url: URL) throws -> [FileItem] {
        let urls = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: FileItem.resourceKeys, options: [])
        return urls.map(FileItem.init)
    }

    func reload() async {
        let url = currentURL
        guard let loaded = try? await Task.detached(operation: { try Self.readDirectory(url) }).value, url == currentURL else { return }
        items = loaded
        IconCache.invalidate()
        rebuild()
        let existing = Set(displayItems.map(\.id))
        let kept = selection.intersection(existing)
        if kept != selection { selection = kept }
        if let renaming = renamingURL, !existing.contains(renaming) { cancelRename() }
        triggerFolderSizeCalculations(for: loaded.filter(\.isFolder))
    }

    private func startWatching() {
        watcher?.cancel()
        watcher = nil
        let fd = Darwin.open(currentURL.path, O_EVTONLY)
        guard fd >= 0 else { return }
        let source = DispatchSource.makeFileSystemObjectSource(fileDescriptor: fd, eventMask: [.write, .delete, .rename, .extend], queue: .main)
        source.setEventHandler { [weak self] in self?.scheduleReload() }
        source.setCancelHandler { close(fd) }
        source.resume()
        watcher = source
    }

    private func scheduleReload() {
        reloadTask?.cancel()
        reloadTask = Task {
            try? await Task.sleep(for: .milliseconds(250))
            guard !Task.isCancelled else { return }
            await reload()
        }
    }

    static func friendly(_ error: Error, at url: URL) -> String {
        let ns = error as NSError
        if ns.domain == NSCocoaErrorDomain, ns.code == NSFileReadNoPermissionError || ns.code == 257 {
            return "Pathway doesn't have permission to open “\(url.lastPathComponent)”.\n\nAllow access in System Settings › Privacy & Security › Files & Folders (or Full Disk Access), then try again."
        }
        return "Can't open “\(url.lastPathComponent)”: \(error.localizedDescription)"
    }

    // MARK: - Display list
    private func rebuild() {
        var list = searchResults ?? items
        if !showHidden { list = list.filter { !$0.isHidden } }
        if let tagFilter = selectedTagFilter {
            list = list.filter { $0.tags.contains { $0.localizedCaseInsensitiveCompare(tagFilter) == .orderedSame } }
        }
        if !searchText.isEmpty && !searchRecursive {
            list = list.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        list = list.map { item in
            if item.isFolder, let fs = folderSizes[item.url.path] {
                var updated = item
                updated.folderSize = fs
                return updated
            }
            return item
        }
        list.sort(using: sortOrder)
        if foldersFirst {
            list = list.filter(\.isFolder) + list.filter { !$0.isFolder }
        }
        displayItems = list
    }

    func displaySize(for item: FileItem) -> String {
        if item.isFolder {
            if let size = folderSizes[item.url.path] ?? item.folderSize {
                return size == 0 ? "Zero bytes" : Fmt.bytes(size)
            }
            return "—"
        }
        return Fmt.bytes(item.size)
    }

    private func triggerFolderSizeCalculations(for folders: [FileItem]) {
        guard calculateFolderSizes, !folders.isEmpty else { return }
        folderSizeTask?.cancel()
        folderSizeTask = Task { [weak self] in
            await withTaskGroup(of: (String, Int64)?.self) { group in
                var iterator = folders.makeIterator()
                let maxConcurrent = 4
                var running = 0

                while running < maxConcurrent, let nextFolder = iterator.next() {
                    let folderURL = nextFolder.url
                    group.addTask {
                        if Task.isCancelled { return nil }
                        let size = await FolderSizeCalculator.shared.size(of: folderURL)
                        return (folderURL.path, size)
                    }
                    running += 1
                }

                for await result in group {
                    if Task.isCancelled { break }
                    if let (path, size) = result {
                        await MainActor.run {
                            guard let self else { return }
                            self.folderSizes[path] = size
                            if let idx = self.items.firstIndex(where: { $0.url.path == path }) {
                                var updated = self.items[idx]
                                updated.folderSize = size
                                self.items[idx] = updated
                            }
                            if let idx = self.displayItems.firstIndex(where: { $0.url.path == path }) {
                                var updated = self.displayItems[idx]
                                updated.folderSize = size
                                self.displayItems[idx] = updated
                            }
                        }
                    }

                    if let nextFolder = iterator.next() {
                        let folderURL = nextFolder.url
                        group.addTask {
                            if Task.isCancelled { return nil }
                            let size = await FolderSizeCalculator.shared.size(of: folderURL)
                            return (folderURL.path, size)
                        }
                    }
                }
            }

            await MainActor.run {
                guard let self else { return }
                if self.currentSortField == .size {
                    self.rebuild()
                }
            }
        }
    }

    var currentSortField: SortField {
        guard let first = sortOrder.first else { return .name }
        if first.keyPath == \FileItem.kind { return .kind }
        if first.keyPath == \FileItem.modifiedSort { return .modified }
        if first.keyPath == \FileItem.createdSort { return .created }
        if first.keyPath == \FileItem.sizeSort { return .size }
        if first.keyPath == \FileItem.tagsSort { return .tags }
        return .name
    }

    var sortAscending: Bool { sortOrder.first?.order != .reverse }

    func setSort(_ field: SortField) {
        let order: SortOrder = (field == currentSortField && sortAscending) ? .reverse : .forward
        sortOrder = [field.comparator(order)]
    }

    func setSortDirection(ascending: Bool) {
        sortOrder = [currentSortField.comparator(ascending ? .forward : .reverse)]
    }

    var groupedItems: [FileGroup] {
        guard groupBy != .none else {
            return [FileGroup(id: "all", title: "", items: displayItems)]
        }

        switch groupBy {
        case .none:
            return [FileGroup(id: "all", title: "", items: displayItems)]

        case .kind:
            var folders: [FileItem] = []
            var images: [FileItem] = []
            var documents: [FileItem] = []
            var archives: [FileItem] = []
            var apps: [FileItem] = []
            var others: [FileItem] = []

            for item in displayItems {
                if item.isFolder {
                    folders.append(item)
                } else if item.isImage {
                    images.append(item)
                } else if item.isConvertibleDocument || item.isPdf {
                    documents.append(item)
                } else if item.isArchive {
                    archives.append(item)
                } else if item.isPackage || item.url.pathExtension.lowercased() == "app" {
                    apps.append(item)
                } else {
                    others.append(item)
                }
            }

            var groups: [FileGroup] = []
            if !folders.isEmpty { groups.append(FileGroup(id: "folders", title: "Folders", items: folders)) }
            if !images.isEmpty { groups.append(FileGroup(id: "images", title: "Images", items: images)) }
            if !documents.isEmpty { groups.append(FileGroup(id: "documents", title: "Documents", items: documents)) }
            if !archives.isEmpty { groups.append(FileGroup(id: "archives", title: "Archives", items: archives)) }
            if !apps.isEmpty { groups.append(FileGroup(id: "apps", title: "Applications", items: apps)) }
            if !others.isEmpty { groups.append(FileGroup(id: "others", title: "Other Files", items: others)) }
            return groups

        case .dateModified:
            let calendar = Calendar.current
            let now = Date()
            let startOfToday = calendar.startOfDay(for: now)
            let yesterday = calendar.date(byAdding: .day, value: -1, to: startOfToday) ?? startOfToday
            let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: startOfToday) ?? startOfToday
            let thirtyDaysAgo = calendar.date(byAdding: .day, value: -30, to: startOfToday) ?? startOfToday
            let startOfYear = calendar.date(from: calendar.dateComponents([.year], from: now)) ?? startOfToday

            var today: [FileItem] = []
            var yest: [FileItem] = []
            var pastWeek: [FileItem] = []
            var pastMonth: [FileItem] = []
            var thisYear: [FileItem] = []
            var older: [FileItem] = []

            for item in displayItems {
                guard let date = item.modified else {
                    older.append(item)
                    continue
                }
                if date >= startOfToday {
                    today.append(item)
                } else if date >= yesterday {
                    yest.append(item)
                } else if date >= sevenDaysAgo {
                    pastWeek.append(item)
                } else if date >= thirtyDaysAgo {
                    pastMonth.append(item)
                } else if date >= startOfYear {
                    thisYear.append(item)
                } else {
                    older.append(item)
                }
            }

            var groups: [FileGroup] = []
            if !today.isEmpty { groups.append(FileGroup(id: "today", title: "Today", items: today)) }
            if !yest.isEmpty { groups.append(FileGroup(id: "yesterday", title: "Yesterday", items: yest)) }
            if !pastWeek.isEmpty { groups.append(FileGroup(id: "pastWeek", title: "Previous 7 Days", items: pastWeek)) }
            if !pastMonth.isEmpty { groups.append(FileGroup(id: "pastMonth", title: "Previous 30 Days", items: pastMonth)) }
            if !thisYear.isEmpty { groups.append(FileGroup(id: "thisYear", title: "Earlier this Year", items: thisYear)) }
            if !older.isEmpty { groups.append(FileGroup(id: "older", title: "Older", items: older)) }
            return groups

        case .size:
            var huge: [FileItem] = []
            var large: [FileItem] = []
            var medium: [FileItem] = []
            var small: [FileItem] = []
            var tiny: [FileItem] = []
            var zero: [FileItem] = []

            for item in displayItems {
                let s = item.isFolder ? (folderSizes[item.url.path] ?? item.folderSize ?? 0) : item.size
                if s > 500 * 1024 * 1024 {
                    huge.append(item)
                } else if s > 100 * 1024 * 1024 {
                    large.append(item)
                } else if s > 1 * 1024 * 1024 {
                    medium.append(item)
                } else if s > 16 * 1024 {
                    small.append(item)
                } else if s > 0 {
                    tiny.append(item)
                } else {
                    zero.append(item)
                }
            }

            var groups: [FileGroup] = []
            if !huge.isEmpty { groups.append(FileGroup(id: "huge", title: "Huge (> 500 MB)", items: huge)) }
            if !large.isEmpty { groups.append(FileGroup(id: "large", title: "Large (100 MB – 500 MB)", items: large)) }
            if !medium.isEmpty { groups.append(FileGroup(id: "medium", title: "Medium (1 MB – 100 MB)", items: medium)) }
            if !small.isEmpty { groups.append(FileGroup(id: "small", title: "Small (16 KB – 1 MB)", items: small)) }
            if !tiny.isEmpty { groups.append(FileGroup(id: "tiny", title: "Tiny (< 16 KB)", items: tiny)) }
            if !zero.isEmpty { groups.append(FileGroup(id: "zero", title: "Zero bytes", items: zero)) }
            return groups

        case .tags:
            var tagDict: [String: [FileItem]] = [:]
            var untagged: [FileItem] = []

            for item in displayItems {
                if item.tags.isEmpty {
                    untagged.append(item)
                } else {
                    for t in item.tags {
                        tagDict[t, default: []].append(item)
                    }
                }
            }

            var groups: [FileGroup] = []
            for (tagName, groupItems) in tagDict.sorted(by: { $0.key < $1.key }) {
                groups.append(FileGroup(id: "tag-\(tagName)", title: tagName, items: groupItems))
            }
            if !untagged.isEmpty {
                groups.append(FileGroup(id: "untagged", title: "No Tags", items: untagged))
            }
            return groups
        }
    }

    // MARK: - Search
    private func resetSearch() {
        searchGeneration += 1
        if !searchText.isEmpty { searchText = "" }
        searchResults = nil
        isSearching = false
    }

    private func searchChanged() {
        searchGeneration += 1
        searchResults = nil
        isSearching = false
        rebuild()
        restartSearchIfNeeded()
    }

    private func restartSearchIfNeeded() {
        guard isRecursiveSearchActive else { return }
        let generation = searchGeneration
        let root = currentURL, query = searchText, hidden = showHidden
        isSearching = true
        searchResults = []
        Task {
            try? await Task.sleep(for: .milliseconds(300))
            guard generation == searchGeneration else { return }
            let found = await Task.detached(priority: .userInitiated) { Self.recursiveSearch(root: root, query: query, showHidden: hidden) }.value
            guard generation == searchGeneration else { return }
            searchResults = found
            isSearching = false
            rebuild()
            triggerFolderSizeCalculations(for: found.filter(\.isFolder))
        }
    }

    nonisolated static func recursiveSearch(root: URL, query: String, showHidden: Bool) -> [FileItem] {
        var options: FileManager.DirectoryEnumerationOptions = [.skipsPackageDescendants]
        if !showHidden { options.insert(.skipsHiddenFiles) }
        guard let enumerator = FileManager.default.enumerator(at: root, includingPropertiesForKeys: FileItem.resourceKeys, options: options) else { return [] }
        var results: [FileItem] = []
        var scanned = 0
        for case let url as URL in enumerator {
            scanned += 1
            if scanned > 200_000 || results.count >= 3000 { break }
            if url.lastPathComponent.localizedCaseInsensitiveContains(query) { results.append(FileItem(url: url)) }
        }
        return results
    }

    // MARK: - Selection
    func selectAll() { selection = Set(displayItems.map(\.id)) }
    func selectNone() { cancelAddressEdit(); selection = [] }
    func invertSelection() { selection = Set(displayItems.map(\.id)).subtracting(selection) }

    func clickSelect(_ item: FileItem, modifiers: NSEvent.ModifierFlags) {
        cancelAddressEdit()
        if modifiers.contains(.shift), let a = anchor, let ai = displayItems.firstIndex(where: { $0.id == a }),
           let bi = displayItems.firstIndex(where: { $0.id == item.id }) {
            let range = min(ai, bi)...max(ai, bi)
            selection = Set(displayItems[range].map(\.id))
        } else if modifiers.contains(.command) {
            if selection.contains(item.id) { selection.remove(item.id) } else { selection.insert(item.id) }
            anchor = item.id
        } else {
            selection = [item.id]
            anchor = item.id
        }
        cursor = item.id
    }

    func moveCursor(by delta: Int, extend: Bool) {
        let list = displayItems
        guard !list.isEmpty else { return }
        let current = cursor.flatMap { c in list.firstIndex { $0.id == c } } ?? selection.first.flatMap { s in list.firstIndex { $0.id == s } }
        let start = current ?? (delta > 0 ? -1 : list.count)
        let target = min(max(start + delta, 0), list.count - 1)
        let id = list[target].id
        if extend, let a = anchor, let ai = list.firstIndex(where: { $0.id == a }) {
            selection = Set(list[min(ai, target)...max(ai, target)].map(\.id))
        } else {
            selection = [id]
            anchor = id
        }
        cursor = id
        scrollTarget = id
    }

    private func typeToSelect(_ characters: String) {
        if Date().timeIntervalSince(typeBufferTime) > 1 { typeBuffer = "" }
        typeBuffer += characters
        typeBufferTime = Date()
        if let match = displayItems.first(where: { $0.name.lowercased().hasPrefix(typeBuffer.lowercased()) }) {
            selection = [match.id]; anchor = match.id; cursor = match.id; scrollTarget = match.id
        }
    }

    // MARK: - Opening
    func open(_ item: FileItem) {
        if item.isFolder {
            navigate(to: item.url)
        } else {
            NSWorkspace.shared.open(item.url)
        }
    }

    func open(_ ids: Set<URL>) {
        let picked = displayItems.filter { ids.contains($0.id) }
        if picked.count == 1, let one = picked.first { open(one); return }
        for item in picked where !item.isFolder { NSWorkspace.shared.open(item.url) }
    }

    func openSelection() { open(selection) }

    func reveal(_ urls: [URL]? = nil) {
        let list = urls ?? (selectionURLs.isEmpty ? [currentURL] : selectionURLs)
        NSWorkspace.shared.activateFileViewerSelecting(list)
    }

    func openContainingFolder(_ url: URL) { navigate(to: url.deletingLastPathComponent(), select: url) }

    func openInTerminal(_ url: URL? = nil) {
        var target = url ?? currentURL
        if let selected = selectedItems.first, url == nil, selected.isFolder, selection.count == 1 { target = selected.url }
        let isDirectory = (try? target.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) ?? false
        if isDirectory != true { target = target.deletingLastPathComponent() }
        guard let terminal = NSWorkspace.shared.urlForApplication(withBundleIdentifier: "com.apple.Terminal") else { return }
        NSWorkspace.shared.open([target], withApplicationAt: terminal, configuration: NSWorkspace.OpenConfiguration())
    }

    func open(_ urls: [URL], with app: URL) {
        NSWorkspace.shared.open(urls, withApplicationAt: app, configuration: NSWorkspace.OpenConfiguration())
    }

    func showProperties(_ urls: [URL]? = nil) {
        let list = urls ?? (selectionURLs.isEmpty ? [currentURL] : selectionURLs)
        sheet = .properties(list)
    }

    func toggleQuickLook() {
        QuickLookController.shared.toggle(folderItems: displayItems.map(\.url), selected: selectedURLs, model: self)
    }

    /// Keeps the file list's selection in step as the user arrows through the Quick Look panel.
    func syncSelectionFromQuickLook(_ url: URL) {
        guard displayItems.contains(where: { $0.id == url }), selection != [url] else { return }
        selection = [url]
        scrollTarget = url
    }

    // MARK: - Clipboard
    func copy(_ urls: [URL]? = nil) {
        let list = urls ?? selectionURLs
        guard !list.isEmpty else { return }
        ClipboardState.shared.copy(list)
    }

    func cut(_ urls: [URL]? = nil) {
        let list = urls ?? selectionURLs
        guard !list.isEmpty else { return }
        ClipboardState.shared.cut(list)
    }

    func copyPath(_ urls: [URL]? = nil) {
        let list = urls ?? (selectionURLs.isEmpty ? [currentURL] : selectionURLs)
        let pb = NSPasteboard.general
        pb.clearContents()
        pb.setString(list.map(\.path).joined(separator: "\n"), forType: .string)
    }

    func paste(into folder: URL? = nil) {
        let clip = ClipboardState.shared
        let urls = clip.pasteURLs
        guard !urls.isEmpty else { return }
        let dest = folder ?? currentURL
        let isCut = clip.isCutActive
        Task {
            let result = await runOp(isCut ? "Moving…" : "Copying…") { isCut ? FileOps.move(urls, to: dest) : FileOps.copy(urls, to: dest) }
            if isCut { clip.clearCut() }
            record(result, label: isCut ? "Move" : "Copy", inverse: isCut ? .moveBack : .trashCreated)
            await finish(result, selecting: result.pairs.map(\.to))
        }
    }

    func duplicate(_ urls: [URL]? = nil) {
        let list = urls ?? selectionURLs
        guard !list.isEmpty else { return }
        let dest = currentURL
        Task {
            let result = await runOp("Duplicating…") { FileOps.copy(list, to: dest) }
            record(result, label: "Duplicate", inverse: .trashCreated)
            await finish(result, selecting: result.pairs.map(\.to))
        }
    }

    /// Drag & drop / sidebar drop. Moves on the same volume, copies across volumes or when Option is held.
    func drop(_ urls: [URL], into folder: URL) {
        let movable = urls.filter { $0.deletingLastPathComponent().standardizedFileURL != folder.standardizedFileURL || NSEvent.modifierFlags.contains(.option) }
        guard !movable.isEmpty else { return }
        let copy = NSEvent.modifierFlags.contains(.option) || movable.contains { FileOps.volumeID(of: $0) != FileOps.volumeID(of: folder) }
        Task {
            let result = await runOp(copy ? "Copying…" : "Moving…") { copy ? FileOps.copy(movable, to: folder) : FileOps.move(movable, to: folder) }
            record(result, label: copy ? "Copy" : "Move", inverse: copy ? .trashCreated : .moveBack)
            await finish(result, selecting: folder == currentURL ? result.pairs.map(\.to) : [])
        }
    }

    // MARK: - Create / rename / delete
    func newFolder() { create(named: "New folder", folder: true) }
    func newTextFile() { create(named: "New Text Document.txt", folder: false) }

    /// macOS Finder: New Folder with Selection (⌃⌘N)
    func newFolderWithSelection() {
        let targets = selectionURLs
        guard !targets.isEmpty else { return }
        let dir = currentURL
        let folderURL = FileOps.uniqueURL(named: "New Folder with Items", in: dir, copy: false)
        do {
            try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: false)
        } catch {
            errorMessage = "Couldn't create folder: \(error.localizedDescription)"
            return
        }
        Task {
            let result = await runOp("Moving into new folder…") { FileOps.move(targets, to: folderURL) }
            record(result, label: "New Folder with Selection", inverse: .moveBack)
            await reload()
            selection = [folderURL]
            anchor = folderURL
            cursor = folderURL
            scrollTarget = folderURL
            beginRename(folderURL)
        }
    }

    /// macOS Finder: Make Alias (⌃⌘A)
    func makeAlias(_ urls: [URL]? = nil) {
        let targets = urls ?? (selectionURLs.isEmpty ? [currentURL] : selectionURLs)
        guard !targets.isEmpty else { return }
        let dir = currentURL
        var createdURLs: [URL] = []
        for src in targets {
            let base = src.deletingPathExtension().lastPathComponent
            let ext = src.pathExtension
            let aliasName = ext.isEmpty ? "\(base) alias" : "\(base) alias.\(ext)"
            let dest = FileOps.uniqueURL(named: aliasName, in: dir, copy: false)
            do {
                try FileManager.default.createSymbolicLink(at: dest, withDestinationURL: src)
                createdURLs.append(dest)
            } catch {
                errorMessage = "Couldn't create alias for “\(src.lastPathComponent)”: \(error.localizedDescription)"
            }
        }
        if !createdURLs.isEmpty {
            let pairs = createdURLs.map { FilePair(from: $0, to: $0) }
            record(OpResult(pairs: pairs), label: "Make Alias", inverse: .trashCreated)
            Task {
                await reload()
                selection = Set(createdURLs)
                if let first = createdURLs.first { scrollTarget = first }
            }
        }
    }

    // MARK: - macOS Finder Tags
    func toggleTag(_ tag: String, for urls: [URL]? = nil) {
        let targets = urls ?? (selectionURLs.isEmpty ? [currentURL] : selectionURLs)
        guard !targets.isEmpty else { return }
        for url in targets {
            let existing = (try? url.resourceValues(forKeys: [.tagNamesKey]))?.tagNames ?? []
            var updated = existing
            if let idx = updated.firstIndex(where: { $0.localizedCaseInsensitiveCompare(tag) == .orderedSame }) {
                updated.remove(at: idx)
            } else {
                updated.append(tag)
            }
            do {
                try (url as NSURL).setResourceValue(updated as NSArray, forKey: .tagNamesKey)
            } catch {
                errorMessage = "Couldn't update tags on “\(url.lastPathComponent)”: \(error.localizedDescription)"
            }
        }
        refresh()
    }

    func clearTags(for urls: [URL]? = nil) {
        let targets = urls ?? (selectionURLs.isEmpty ? [currentURL] : selectionURLs)
        guard !targets.isEmpty else { return }
        for url in targets {
            try? (url as NSURL).setResourceValue([] as NSArray, forKey: .tagNamesKey)
        }
        refresh()
    }

    private func create(named name: String, folder: Bool) {
        let dir = currentURL
        let dest = FileOps.uniqueURL(named: name, in: dir, copy: false)
        do {
            if folder { try FileManager.default.createDirectory(at: dest, withIntermediateDirectories: false) }
            else if !FileManager.default.createFile(atPath: dest.path, contents: nil) { throw CocoaError(.fileWriteUnknown) }
        } catch {
            errorMessage = "Couldn't create “\(dest.lastPathComponent)”: \(error.localizedDescription)"
            return
        }
        let result = OpResult(pairs: [FilePair(from: dest, to: dest)], errors: [])
        record(result, label: folder ? "New Folder" : "New File", inverse: .trashCreated)
        Task {
            await reload()
            selection = [dest]; anchor = dest; cursor = dest; scrollTarget = dest
            beginRename(dest)
        }
    }

    func beginRename(_ url: URL? = nil) {
        guard let target = url ?? (selection.count == 1 ? selection.first : nil) else { return }
        renameText = target.lastPathComponent
        renamingURL = target
    }

    func cancelRename() {
        renamingURL = nil
        renameText = ""
        focusFileList()
    }

    func commitRename() {
        guard let source = renamingURL else { return }
        let newName = renameText.trimmingCharacters(in: .whitespacesAndNewlines)
        renamingURL = nil
        defer { focusFileList() }
        guard !newName.isEmpty, newName != source.lastPathComponent else { return }
        guard !newName.contains("/"), !newName.contains(":") else {
            errorMessage = "A name can't contain “/” or “:”."
            return
        }
        let dest = source.deletingLastPathComponent().appendingPathComponent(newName)
        if FileOps.exists(dest) && dest.path.lowercased() != source.path.lowercased() {
            errorMessage = "A file named “\(newName)” already exists in this folder."
            return
        }
        do {
            try FileManager.default.moveItem(at: source, to: dest)
        } catch {
            errorMessage = "Couldn't rename: \(error.localizedDescription)"
            return
        }
        record(OpResult(pairs: [FilePair(from: source, to: dest)]), label: "Rename", inverse: .moveBack)
        Task {
            await reload()
            selection = [dest]; anchor = dest; cursor = dest; scrollTarget = dest
        }
    }

    func trash(_ urls: [URL]? = nil) {
        let list = urls ?? selectionURLs
        guard !list.isEmpty else { return }
        if isInTrash { requestPermanentDelete(list); return }
        Task {
            let result = await runOp("Moving to Trash…") { FileOps.trash(list) }
            // Pairs are (original, trashed); undo moves trashed → original.
            record(result, label: "Delete", inverse: .restoreFromTrash)
            await finish(result, selecting: [])
        }
    }

    func requestPermanentDelete(_ urls: [URL]? = nil) {
        let list = urls ?? selectionURLs
        guard !list.isEmpty else { return }
        pendingPermanentDelete = list
    }

    func confirmPermanentDelete() {
        guard let list = pendingPermanentDelete else { return }
        pendingPermanentDelete = nil
        Task {
            let result = await runOp("Deleting…") { FileOps.deletePermanently(list) }
            await finish(result, selecting: [])
        }
    }

    func compress(_ urls: [URL]? = nil, format: ArchiveFormat = .zip) {
        let list = urls ?? selectionURLs
        guard !list.isEmpty else { return }
        let dir = currentURL
        Task {
            let result = await runOp("Compressing…") { FileOps.compress(list, in: dir, format: format) }
            record(result, label: "Compress", inverse: .trashCreated, using: result.pairs.map { FilePair(from: $0.to, to: $0.to) })
            await finish(result, selecting: result.pairs.map(\.to))
        }
    }

    func extract(_ urls: [URL]? = nil, toSubfolder: Bool = false) {
        let list = urls ?? selectionURLs
        guard !list.isEmpty else { return }
        let dir = currentURL
        Task {
            let result = await runOp("Extracting…") { FileOps.extract(list, in: dir, toSubfolder: toSubfolder) }
            record(result, label: "Extract", inverse: .trashCreated, using: result.pairs.map { FilePair(from: $0.to, to: $0.to) })
            await finish(result, selecting: result.pairs.map(\.to))
        }
    }

    func extract(_ url: URL) {
        extract([url], toSubfolder: true)
    }

    func convertImages(_ urls: [URL]? = nil, to format: ImageFormat) {
        let list = urls ?? selectionURLs
        guard !list.isEmpty else { return }
        let dir = currentURL
        Task {
            let result = await runOp("Converting \(list.count) image\(list.count == 1 ? "" : "s")…") {
                FileOps.convertImages(list, to: format, in: dir)
            }
            record(result, label: "Convert to \(format.title)", inverse: .trashCreated, using: result.pairs.map { FilePair(from: $0.to, to: $0.to) })
            await finish(result, selecting: result.pairs.map(\.to))
        }
    }

    func combineImagesToPDF(_ urls: [URL]? = nil) {
        let list = urls ?? selectionURLs
        guard !list.isEmpty else { return }
        let dir = currentURL
        Task {
            let result = await runOp("Combining images into PDF…") {
                FileOps.combineImagesToPDF(list, in: dir)
            }
            record(result, label: "Combine Images to PDF", inverse: .trashCreated, using: result.pairs.map { FilePair(from: $0.to, to: $0.to) })
            await finish(result, selecting: result.pairs.map(\.to))
        }
    }

    func convertDocuments(_ urls: [URL]? = nil, to format: DocumentFormat) {
        let list = urls ?? selectionURLs
        guard !list.isEmpty else { return }
        let dir = currentURL
        Task {
            let result = await runOp("Converting \(list.count) document\(list.count == 1 ? "" : "s")…") {
                FileOps.convertDocuments(list, to: format, in: dir)
            }
            record(result, label: "Convert to \(format.title)", inverse: .trashCreated, using: result.pairs.map { FilePair(from: $0.to, to: $0.to) })
            await finish(result, selecting: result.pairs.map(\.to))
        }
    }

    // MARK: - Undo
    enum Inverse { case moveBack, trashCreated, restoreFromTrash }

    private func record(_ result: OpResult, label: String, inverse: Inverse, using override: [FilePair]? = nil) {
        let pairs = override ?? result.pairs
        guard !pairs.isEmpty else { return }
        let entry: UndoEntry
        switch inverse {
        case .moveBack:
            entry = UndoEntry(label: label) {
                for p in pairs.reversed() { try FileManager.default.moveItem(at: p.to, to: p.from) }
            }
        case .restoreFromTrash:
            entry = UndoEntry(label: label) {
                for p in pairs.reversed() { try FileManager.default.moveItem(at: p.to, to: p.from) }
            }
        case .trashCreated:
            entry = UndoEntry(label: label) {
                for p in pairs.reversed() { try FileManager.default.trashItem(at: p.to, resultingItemURL: nil) }
            }
        }
        undoStack.append(entry)
        if undoStack.count > 50 { undoStack.removeFirst() }
    }

    func undo() {
        guard let entry = undoStack.popLast() else { return }
        Task {
            do {
                try await Task.detached { try entry.run() }.value
            } catch {
                errorMessage = "Couldn't undo \(entry.label.lowercased()): \(error.localizedDescription)"
            }
            await reload()
        }
    }

    // MARK: - Operation plumbing
    private func runOp(_ label: String, _ work: @escaping @Sendable () -> OpResult) async -> OpResult {
        busyLabel = label
        let result = await Task.detached(priority: .userInitiated, operation: work).value
        busyLabel = nil
        return result
    }

    private func finish(_ result: OpResult, selecting: [URL]) async {
        await reload()
        let existing = Set(displayItems.map(\.id))
        let picks = Set(selecting).intersection(existing)
        if !picks.isEmpty { selection = picks; scrollTarget = picks.first }
        if !result.errors.isEmpty { errorMessage = result.errors.joined(separator: "\n") }
    }

    // MARK: - Keyboard (Windows-style plain keys, handled by KeyMonitor)
    func handleKey(_ event: NSEvent) -> Bool {
        let flags = event.modifierFlags.intersection([.command, .option, .shift, .control])
        let gridMode = viewMode != .details
        switch event.keyCode {
        case 51: // Backspace
            if flags.isEmpty { goBack(); return true }
            if flags == .shift { requestPermanentDelete(); return true }
            return false
        case 117: // Forward delete
            if flags.isEmpty { trash(); return true }
            if flags == .shift { requestPermanentDelete(); return true }
            if flags == .command { trash(); return true }
            return false
        case 36, 76: // Return / Enter
            if flags.isEmpty { openSelection(); return true }
            if flags == .option { showProperties(); return true }
            return false
        case 120 where flags.isEmpty: beginRename(); return true // F2
        case 96 where flags.isEmpty: refresh(); return true // F5
        case 99 where flags.isEmpty: focusSearch(); return true // F3
        case 118 where flags.isEmpty: focusAddressBar(); return true // F4
        case 53 where flags.isEmpty: // Escape
            MarqueeMonitor.shared.cancelDrag(for: self)
            if !searchText.isEmpty { searchText = "" } else { selection = [] }
            return true
        case 123 where flags == .option: goBack(); return true
        case 124 where flags == .option: goForward(); return true
        case 126 where flags == .option: goUp(); return true
        case 115 where flags == .option: goHome(); return true
        case 123, 124, 125, 126:
            guard gridMode, flags.isEmpty || flags == .shift else { return false }
            let cols = max(gridColumns, 1)
            let delta: Int
            switch event.keyCode {
            case 123: delta = -1
            case 124: delta = 1
            case 125: delta = viewMode == .tiles ? cols : cols
            default: delta = -cols
            }
            moveCursor(by: delta, extend: flags == .shift)
            return true
        case 115 where flags.isEmpty && gridMode: moveCursor(by: -displayItems.count, extend: false); return true
        case 119 where flags.isEmpty && gridMode: moveCursor(by: displayItems.count, extend: false); return true
        case 49 where flags.isEmpty && Date().timeIntervalSince(typeBufferTime) > 1: // Space → Quick Look
            toggleQuickLook()
            return true
        default:
            guard flags.isEmpty || flags == .shift,
                  let chars = event.characters, chars.count == 1,
                  let scalar = chars.unicodeScalars.first,
                  CharacterSet.alphanumerics.union(.punctuationCharacters).union(.symbols).union(.whitespaces).contains(scalar) else { return false }
            typeToSelect(chars)
            return true
        }
    }

    // MARK: - Window integration
    func attach(_ window: NSWindow) {
        self.window = window
        ModelRegistry.shared.register(self, for: window)
    }

    /// Puts keyboard focus back on the file list so arrows / type-to-select keep working.
    func focusFileList() {
        guard let window else { return }
        DispatchQueue.main.async {
            guard window.attachedSheet == nil, !(window.firstResponder is NSText) else { return }
            if let table = Self.findFileTable(in: window.contentView) { window.makeFirstResponder(table) }
        }
    }

    static func findFileTable(in view: NSView?) -> NSTableView? {
        guard let view else { return nil }
        if let table = view as? NSTableView, !(table is NSOutlineView), table.tableColumns.count > 1 { return table }
        for sub in view.subviews { if let found = findFileTable(in: sub) { return found } }
        return nil
    }
}

@MainActor
final class ModelRegistry {
    static let shared = ModelRegistry()
    private let map = NSMapTable<NSWindow, FileBrowserModel>(keyOptions: .weakMemory, valueOptions: .weakMemory)
    func register(_ model: FileBrowserModel, for window: NSWindow) { map.setObject(model, forKey: window) }
    func model(for window: NSWindow) -> FileBrowserModel? { map.object(forKey: window) }
}
