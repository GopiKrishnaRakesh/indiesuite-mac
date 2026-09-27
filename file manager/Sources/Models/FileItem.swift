import AppKit
import SwiftUI
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
    var folderSize: Int64? = nil
    let modified: Date?
    let created: Date?
    let kind: String
    let tags: [String]

    var id: URL { url }
    /// A real folder the user can navigate into (packages such as .app open like files).
    var isFolder: Bool { isDirectory && !isPackage }

    // Non-optional sort keys for Table's KeyPathComparator.
    var modifiedSort: Date { modified ?? .distantPast }
    var createdSort: Date { created ?? .distantPast }
    var sizeSort: Int64 { isFolder ? (folderSize ?? -1) : size }
    var tagsSort: String { tags.first ?? "" }
    var displaySize: String {
        if isFolder {
            if let fs = folderSize {
                return fs == 0 ? "Zero bytes" : Fmt.bytes(fs)
            }
            return "—"
        }
        return Fmt.bytes(size)
    }
    var isZip: Bool { url.pathExtension.lowercased() == "zip" }
    static let archiveExtensions: Set<String> = ["zip", "tar", "gz", "tgz", "bz2", "tbz", "tbz2", "xz", "txz"]
    var isArchive: Bool { !isFolder && Self.archiveExtensions.contains(url.pathExtension.lowercased()) }

    static let imageExtensions: Set<String> = ["jpg", "jpeg", "png", "heic", "heif", "tiff", "tif", "webp", "gif", "bmp", "ico", "icns", "avif"]
    var isImage: Bool { !isFolder && Self.imageExtensions.contains(url.pathExtension.lowercased()) }

    static let documentExtensions: Set<String> = ["docx", "doc", "rtf", "rtfd", "html", "htm", "txt", "text", "odt", "md", "markdown", "webarchive"]
    var isConvertibleDocument: Bool { !isFolder && Self.documentExtensions.contains(url.pathExtension.lowercased()) }

    var isPdf: Bool { !isFolder && url.pathExtension.lowercased() == "pdf" }

    static let resourceKeys: [URLResourceKey] = [
        .nameKey, .isDirectoryKey, .isPackageKey, .isHiddenKey, .isSymbolicLinkKey,
        .fileSizeKey, .contentModificationDateKey, .creationDateKey, .localizedTypeDescriptionKey,
        .tagNamesKey,
    ]

    init(url: URL) {
        self.init(url: url, folderSize: nil)
    }

    init(url: URL, folderSize: Int64?) {
        let stdURL = url.standardizedFileURL
        let values = try? stdURL.resourceValues(forKeys: Set(Self.resourceKeys))
        let symlink = values?.isSymbolicLink ?? false
        var directory = values?.isDirectory ?? false
        if symlink {
            var isDir: ObjCBool = false
            directory = FileManager.default.fileExists(atPath: stdURL.path, isDirectory: &isDir) && isDir.boolValue
        }
        self.url = stdURL
        self.name = values?.name ?? url.lastPathComponent
        self.isDirectory = directory
        self.isPackage = values?.isPackage ?? false
        self.isHidden = values?.isHidden ?? url.lastPathComponent.hasPrefix(".")
        self.isSymlink = symlink
        self.size = Int64(values?.fileSize ?? 0)
        self.folderSize = folderSize
        self.modified = values?.contentModificationDate
        self.created = values?.creationDate
        let described = values?.localizedTypeDescription
        self.kind = directory && !(values?.isPackage ?? false) ? "File folder" : (described ?? "Document")
        self.tags = values?.tagNames ?? []
    }

    static func tagColor(for name: String) -> SwiftUI.Color {
        switch name.lowercased() {
        case "red": return .red
        case "orange": return .orange
        case "yellow": return .yellow
        case "green": return .green
        case "blue": return .blue
        case "purple": return .purple
        case "gray", "grey": return .gray
        default: return .accentColor
        }
    }
}

enum MacTag: String, CaseIterable, Identifiable {
    case red = "Red"
    case orange = "Orange"
    case yellow = "Yellow"
    case green = "Green"
    case blue = "Blue"
    case purple = "Purple"
    case gray = "Gray"

    var id: String { rawValue }
    var color: SwiftUI.Color {
        FileItem.tagColor(for: rawValue)
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
