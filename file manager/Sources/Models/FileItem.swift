import AppKit
import UniformTypeIdentifiers

/// One row in the file list. Immutable snapshot of a file-system entry.
struct FileItem: Identifiable, Hashable, Sendable {
    let url: URL
    let name: String
    let isDirectory: Bool
    let isPackage: Bool
    let isHidden: Bool
    let isSymlink: Bool
    let size: Int64
    let modified: Date?
    let created: Date?
    let kind: String

    var id: URL { url }
    /// A real folder the user can navigate into (packages such as .app open like files).
    var isFolder: Bool { isDirectory && !isPackage }

    // Non-optional sort keys for Table's KeyPathComparator.
    var modifiedSort: Date { modified ?? .distantPast }
    var sizeSort: Int64 { isFolder ? -1 : size }
    var displaySize: String { isFolder ? "" : Fmt.bytes(size) }
    var isZip: Bool { url.pathExtension.lowercased() == "zip" }

    static let resourceKeys: [URLResourceKey] = [
        .nameKey, .isDirectoryKey, .isPackageKey, .isHiddenKey, .isSymbolicLinkKey,
        .fileSizeKey, .contentModificationDateKey, .creationDateKey, .localizedTypeDescriptionKey,
    ]

    init(url: URL) {
        let values = try? url.resourceValues(forKeys: Set(Self.resourceKeys))
        let symlink = values?.isSymbolicLink ?? false
        var directory = values?.isDirectory ?? false
        if symlink {
            var isDir: ObjCBool = false
            directory = FileManager.default.fileExists(atPath: url.path, isDirectory: &isDir) && isDir.boolValue
        }
        self.url = url
        self.name = values?.name ?? url.lastPathComponent
        self.isDirectory = directory
        self.isPackage = values?.isPackage ?? false
        self.isHidden = values?.isHidden ?? url.lastPathComponent.hasPrefix(".")
        self.isSymlink = symlink
        self.size = Int64(values?.fileSize ?? 0)
        self.modified = values?.contentModificationDate
        self.created = values?.creationDate
        let described = values?.localizedTypeDescription
        self.kind = directory && !(values?.isPackage ?? false) ? "File folder" : (described ?? "Document")
    }
}

enum Fmt {
    static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .short
        return f
    }()

    static func date(_ d: Date?) -> String { d.map { dateFormatter.string(from: $0) } ?? "—" }
    static func bytes(_ b: Int64) -> String { ByteCountFormatter.string(fromByteCount: b, countStyle: .file) }
    static func exactBytes(_ b: Int64) -> String {
        "\(bytes(b)) (\(b.formatted(.number)) bytes)"
    }
}

/// Small cache so scrolling long folders doesn't re-ask LaunchServices for every icon.
@MainActor
enum IconCache {
    private static let cache: NSCache<NSString, NSImage> = {
        let c = NSCache<NSString, NSImage>()
        c.countLimit = 3000
        return c
    }()

    static func icon(for url: URL) -> NSImage {
        let key = url.path as NSString
        if let hit = cache.object(forKey: key) { return hit }
        let image = NSWorkspace.shared.icon(forFile: url.path)
        cache.setObject(image, forKey: key)
        return image
    }

    static func invalidate() { cache.removeAllObjects() }
}
