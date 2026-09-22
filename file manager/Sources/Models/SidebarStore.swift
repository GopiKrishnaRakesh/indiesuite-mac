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
    /// Every mounted volume, including ones the user has hidden (`hiddenVolumePaths`) — the sidebar
    /// filters those out itself via `visibleVolumes`, but keeping the full list lets "un-hide" work
    /// without a re-scan.
    @Published private(set) var volumes: [VolumeInfo] = []
    /// Volumes removed from the sidebar via "Remove from Sidebar". Not persisted across launches or
    /// across an eject/remount cycle — matches Finder, where hiding a disk is a per-session thing, not
    /// a standing setting that could strand a drive invisibly forever.
    @Published private(set) var hiddenVolumePaths: Set<String> = []

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
            center.addObserver(forName: name, object: nil, queue: .main) { [weak self] note in
                Task { @MainActor in
                    // Forget any hide on the volume that just went away, so replugging (or a rename,
                    // which unmounts and remounts under the new name) shows it again.
                    if name == NSWorkspace.didUnmountNotification,
                       let path = (note.userInfo?[NSWorkspace.volumeURLUserInfoKey] as? URL)?.path {
                        self?.hiddenVolumePaths.remove(path)
                    }
                    self?.refreshVolumes()
                }
            }
        }
    }

    func refreshVolumes() {
        let keys: [URLResourceKey] = [.volumeNameKey, .volumeTotalCapacityKey, .volumeAvailableCapacityForImportantUsageKey]
        let urls = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: keys, options: [.skipHiddenVolumes]) ?? []
        volumes = urls.map { url in
            let v = try? url.resourceValues(forKeys: Set(keys))
            // Two different resource keys (.volumeIsRootFileSystemKey, then .volumeIsInternalKey)
            // both turned out to misreport for real hardware — confirmed against a real external
            // drive, twice. Neither is used anymore. macOS's own mount-point convention is more
            // reliable than anything a driver reports: every genuinely separate, user-facing volume
            // (external drives, disk images, extra partitions) mounts under /Volumes/; the boot
            // volume itself and its hidden internal role volumes (Data, Preboot, Recovery, VM, …)
            // never do — they live at "/" or under /System/Volumes/ instead.
            return VolumeInfo(
                url: url,
                name: v?.volumeName ?? url.lastPathComponent,
                total: Int64(v?.volumeTotalCapacity ?? 0),
                available: v?.volumeAvailableCapacityForImportantUsage ?? 0,
                isEjectable: url.path.hasPrefix("/Volumes/")
            )
        }
        .sorted { ($0.url.path == "/" ? 0 : 1, $0.name) < ($1.url.path == "/" ? 0 : 1, $1.name) }
    }

    var visibleVolumes: [VolumeInfo] { volumes.filter { !hiddenVolumePaths.contains($0.url.path) } }

    func hideVolume(_ url: URL) { hiddenVolumePaths.insert(url.path) }
    func unhideVolume(_ url: URL) { hiddenVolumePaths.remove(url.path) }

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
