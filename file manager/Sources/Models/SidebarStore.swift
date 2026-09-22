import AppKit

struct VolumeInfo: Identifiable, Hashable {
    let url: URL
    let name: String
    let total: Int64
    let available: Int64
    let isEjectable: Bool
    var id: URL { url }
    var usedFraction: Double { total > 0 ? Double(total - available) / Double(total) : 0 }
}

/// Shared across windows: pinned folders ("Quick access"), recent folders, mounted volumes.
@MainActor
final class SidebarStore: ObservableObject {
    static let shared = SidebarStore()
    static let home = FileManager.default.homeDirectoryForCurrentUser.standardizedFileURL
    static let trash = home.appendingPathComponent(".Trash")

    @Published private(set) var pinned: [URL] = []
    @Published private(set) var recents: [URL] = []
    @Published private(set) var volumes: [VolumeInfo] = []

    private let defaultsKey = "pinnedFolders"

    private init() {
        if let paths = UserDefaults.standard.stringArray(forKey: defaultsKey) {
            pinned = paths.map { URL(fileURLWithPath: $0, isDirectory: true) }
        } else {
            let names = ["Desktop", "Documents", "Downloads", "Pictures", "Music", "Movies"]
            pinned = [Self.home] + names.map { Self.home.appendingPathComponent($0, isDirectory: true) }
                + [URL(fileURLWithPath: "/Applications", isDirectory: true)]
            pinned = pinned.filter { FileManager.default.fileExists(atPath: $0.path) }
        }
        refreshVolumes()
        let center = NSWorkspace.shared.notificationCenter
        for name in [NSWorkspace.didMountNotification, NSWorkspace.didUnmountNotification] {
            center.addObserver(forName: name, object: nil, queue: .main) { [weak self] _ in
                Task { @MainActor in self?.refreshVolumes() }
            }
        }
    }

    func refreshVolumes() {
        let keys: [URLResourceKey] = [.volumeNameKey, .volumeTotalCapacityKey, .volumeAvailableCapacityForImportantUsageKey, .volumeIsInternalKey, .volumeIsRootFileSystemKey]
        let urls = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: keys, options: [.skipHiddenVolumes]) ?? []
        volumes = urls.map { url in
            let v = try? url.resourceValues(forKeys: Set(keys))
            let isRoot = v?.volumeIsRootFileSystem ?? false
            return VolumeInfo(
                url: url,
                name: v?.volumeName ?? url.lastPathComponent,
                total: Int64(v?.volumeTotalCapacity ?? 0),
                available: v?.volumeAvailableCapacityForImportantUsage ?? 0,
                isEjectable: !isRoot && !(v?.volumeIsInternal ?? true)
            )
        }
        .sorted { ($0.url.path == "/" ? 0 : 1, $0.name) < ($1.url.path == "/" ? 0 : 1, $1.name) }
    }

    func isPinned(_ url: URL) -> Bool { pinned.contains(url.standardizedFileURL) }

    func pin(_ url: URL) {
        let u = url.standardizedFileURL
        guard !pinned.contains(u) else { return }
        pinned.append(u)
        persist()
    }

    func unpin(_ url: URL) {
        pinned.removeAll { $0 == url.standardizedFileURL }
        persist()
    }

    func movePinned(from: IndexSet, to: Int) {
        pinned.move(fromOffsets: from, toOffset: to)
        persist()
    }

    func noteVisit(_ url: URL) {
        let u = url.standardizedFileURL
        recents.removeAll { $0 == u }
        recents.insert(u, at: 0)
        if recents.count > 8 { recents.removeLast(recents.count - 8) }
    }

    private func persist() {
        UserDefaults.standard.set(pinned.map(\.path), forKey: defaultsKey)
    }
}

/// Clipboard shared by every window. Mirrors file URLs onto the system pasteboard so Finder interoperates.
@MainActor
final class ClipboardState: ObservableObject {
    static let shared = ClipboardState()
    @Published private(set) var cutURLs: Set<URL> = []
    private var cutChangeCount = -1

    var isCutActive: Bool { !cutURLs.isEmpty && NSPasteboard.general.changeCount == cutChangeCount }
    func isCut(_ url: URL) -> Bool { isCutActive && cutURLs.contains(url) }

    var pasteURLs: [URL] {
        (NSPasteboard.general.readObjects(forClasses: [NSURL.self], options: [.urlReadingFileURLsOnly: true]) as? [URL]) ?? []
    }

    var canPaste: Bool {
        NSPasteboard.general.canReadObject(forClasses: [NSURL.self], options: [.urlReadingFileURLsOnly: true])
    }

    func copy(_ urls: [URL]) {
        write(urls)
        cutURLs = []
    }

    func cut(_ urls: [URL]) {
        write(urls)
        cutURLs = Set(urls)
        cutChangeCount = NSPasteboard.general.changeCount
    }

    func clearCut() { cutURLs = [] }

    private func write(_ urls: [URL]) {
        let pb = NSPasteboard.general
        pb.clearContents()
        pb.writeObjects(urls.map { $0 as NSURL })
    }
}
