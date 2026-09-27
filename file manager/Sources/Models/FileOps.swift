import Foundation
import AppKit
import PDFKit

enum ArchiveFormat: String, CaseIterable, Identifiable, Sendable {
    case zip = "zip"
    case tarGz = "tar.gz"

    var id: String { rawValue }

    var title: String {
        switch self {
        case .zip: return "ZIP Archive (.zip)"
        case .tarGz: return "TAR Gzip (.tar.gz)"
        }
    }

    var fileExtension: String { rawValue }
}

enum ImageFormat: String, CaseIterable, Identifiable, Sendable {
    case jpeg = "jpeg"
    case png = "png"
    case heic = "heic"
    case tiff = "tiff"
    case pdf = "pdf"
    case gif = "gif"
    case bmp = "bmp"

    var id: String { rawValue }

    var title: String {
        switch self {
        case .jpeg: return "JPEG (.jpg)"
        case .png: return "PNG (.png)"
        case .heic: return "HEIC (.heic)"
        case .tiff: return "TIFF (.tiff)"
        case .pdf: return "PDF (.pdf)"
        case .gif: return "GIF (.gif)"
        case .bmp: return "BMP (.bmp)"
        }
    }

    var fileExtension: String {
        switch self {
        case .jpeg: return "jpg"
        default: return rawValue
        }
    }

    var sipsFormatName: String {
        switch self {
        case .jpeg: return "jpeg"
        case .png: return "png"
        case .heic: return "heic"
        case .tiff: return "tiff"
        case .pdf: return "pdf"
        case .gif: return "gif"
        case .bmp: return "bmp"
        }
    }
}

enum DocumentFormat: String, CaseIterable, Identifiable, Sendable {
    case pdf = "pdf"
    case docx = "docx"
    case rtf = "rtf"
    case txt = "txt"
    case html = "html"
    case odt = "odt"

    var id: String { rawValue }

    var title: String {
        switch self {
        case .pdf: return "PDF (.pdf)"
        case .docx: return "Word Document (.docx)"
        case .rtf: return "Rich Text (.rtf)"
        case .txt: return "Plain Text (.txt)"
        case .html: return "HTML Document (.html)"
        case .odt: return "OpenDocument (.odt)"
        }
    }

    var fileExtension: String { rawValue }

    var textutilFormat: String {
        switch self {
        case .docx: return "docx"
        case .rtf: return "rtf"
        case .txt: return "txt"
        case .html: return "html"
        case .odt: return "odt"
        case .pdf: return "pdf"
        }
    }
}

struct FilePair: Sendable {
    let from: URL
    let to: URL
}

struct OpResult: Sendable {
    var pairs: [FilePair] = []
    var errors: [String] = []
}

/// Blocking file-system operations. Always call from a background task.
enum FileOps {
    static func exists(_ url: URL) -> Bool {
        let fm = FileManager.default
        return fm.fileExists(atPath: url.path) || (try? fm.destinationOfSymbolicLink(atPath: url.path)) != nil
    }

    /// Windows-style conflict naming: "name - Copy", "name - Copy (2)" for copies; "name (2)" for moves.
    static func uniqueURL(named name: String, in dir: URL, copy: Bool) -> URL {
        let first = dir.appendingPathComponent(name)
        if !exists(first) { return first }
        let ns = name as NSString
        let ext = ns.pathExtension
        let stem = ns.deletingPathExtension
        var n = 1
        while true {
            let label: String
            if copy { label = n == 1 ? " - Copy" : " - Copy (\(n))" } else { label = " (\(n + 1))" }
            let candidate = dir.appendingPathComponent(ext.isEmpty ? stem + label : stem + label + "." + ext)
            if !exists(candidate) { return candidate }
            n += 1
        }
    }

    static func isInside(_ child: URL, of parent: URL) -> Bool {
        let c = child.resolvingSymlinksInPath().standardizedFileURL.path
        let p = parent.resolvingSymlinksInPath().standardizedFileURL.path
        return c == p || c.hasPrefix(p.hasSuffix("/") ? p : p + "/")
    }

    static func copy(_ urls: [URL], to dir: URL) -> OpResult {
        var result = OpResult()
        for src in urls {
            if isInside(dir, of: src) {
                result.errors.append("Can't copy “\(src.lastPathComponent)” into itself.")
                continue
            }
            let dest = uniqueURL(named: src.lastPathComponent, in: dir, copy: true)
            do {
                try FileManager.default.copyItem(at: src, to: dest)
                result.pairs.append(FilePair(from: src, to: dest))
            } catch {
                result.errors.append("“\(src.lastPathComponent)”: \(error.localizedDescription)")
            }
        }
        return result
    }

    static func move(_ urls: [URL], to dir: URL) -> OpResult {
        var result = OpResult()
        for src in urls {
            if src.deletingLastPathComponent().standardizedFileURL == dir.standardizedFileURL { continue }
            if isInside(dir, of: src) {
                result.errors.append("Can't move “\(src.lastPathComponent)” into itself.")
                continue
            }
            let dest = uniqueURL(named: src.lastPathComponent, in: dir, copy: false)
            do {
                try FileManager.default.moveItem(at: src, to: dest)
                result.pairs.append(FilePair(from: src, to: dest))
            } catch {
                result.errors.append("“\(src.lastPathComponent)”: \(error.localizedDescription)")
            }
        }
        return result
    }

    /// Pairs are (original location, location inside the Trash).
    static func trash(_ urls: [URL]) -> OpResult {
        var result = OpResult()
        for url in urls {
            do {
                var out: NSURL?
                try FileManager.default.trashItem(at: url, resultingItemURL: &out)
                result.pairs.append(FilePair(from: url, to: (out as URL?) ?? url))
            } catch {
                result.errors.append("“\(url.lastPathComponent)”: \(error.localizedDescription)")
            }
        }
        return result
    }

    static func deletePermanently(_ urls: [URL]) -> OpResult {
        var result = OpResult()
        for url in urls {
            do {
                try FileManager.default.removeItem(at: url)
                result.pairs.append(FilePair(from: url, to: url))
            } catch {
                result.errors.append("“\(url.lastPathComponent)”: \(error.localizedDescription)")
            }
        }
        return result
    }

    static func compress(_ urls: [URL], in dir: URL, format: ArchiveFormat = .zip) -> OpResult {
        var result = OpResult()
        guard let first = urls.first else { return result }

        switch format {
        case .zip:
            let name = urls.count == 1 ? first.lastPathComponent + ".zip" : "Archive.zip"
            let dest = uniqueURL(named: name, in: dir, copy: false)
            let (status, message): (Int32, String)
            if urls.count == 1 {
                (status, message) = run("/usr/bin/ditto", ["-c", "-k", "--sequesterRsrc", "--keepParent", first.path, dest.path])
            } else {
                let names = urls.map { $0.lastPathComponent }
                (status, message) = run("/usr/bin/zip", ["-q", "-r", dest.path] + names, currentDirectoryURL: dir)
            }
            if status == 0 {
                result.pairs.append(FilePair(from: first, to: dest))
            } else {
                result.errors.append("Compress to ZIP failed: \(message)")
            }

        case .tarGz:
            let stem = urls.count == 1 ? first.deletingPathExtension().lastPathComponent : "Archive"
            let name = "\(stem).tar.gz"
            let dest = uniqueURL(named: name, in: dir, copy: false)
            let names = urls.map { $0.lastPathComponent }
            let (status, message) = run("/usr/bin/tar", ["-czf", dest.path] + names, currentDirectoryURL: dir)
            if status == 0 {
                result.pairs.append(FilePair(from: first, to: dest))
            } else {
                result.errors.append("Compress to TAR failed: \(message)")
            }
        }
        return result
    }

    static func extract(_ urls: [URL], in dir: URL, toSubfolder: Bool = false) -> OpResult {
        var result = OpResult()
        for archive in urls {
            let lowerName = archive.lastPathComponent.lowercased()
            var stem = archive.deletingPathExtension().lastPathComponent
            if lowerName.hasSuffix(".tar.gz") || lowerName.hasSuffix(".tar.bz2") || lowerName.hasSuffix(".tar.xz") {
                stem = (archive.deletingPathExtension().deletingPathExtension().lastPathComponent)
            }

            let destFolder: URL
            if toSubfolder {
                destFolder = uniqueURL(named: stem, in: dir, copy: false)
                try? FileManager.default.createDirectory(at: destFolder, withIntermediateDirectories: true)
            } else {
                destFolder = dir
            }

            let ext = archive.pathExtension.lowercased()
            let (status, message): (Int32, String)
            if ext == "zip" {
                (status, message) = run("/usr/bin/ditto", ["-x", "-k", archive.path, destFolder.path])
            } else {
                (status, message) = run("/usr/bin/tar", ["-xf", archive.path, "-C", destFolder.path])
            }

            if status == 0 {
                result.pairs.append(FilePair(from: archive, to: destFolder))
            } else {
                result.errors.append("Extract failed for “\(archive.lastPathComponent)”: \(message)")
            }
        }
        return result
    }

    static func extract(_ archive: URL, in dir: URL) -> OpResult {
        extract([archive], in: dir, toSubfolder: true)
    }

    static func convertImages(_ urls: [URL], to format: ImageFormat, in dir: URL) -> OpResult {
        var result = OpResult()
        for source in urls {
            let stem = source.deletingPathExtension().lastPathComponent
            let targetName = "\(stem).\(format.fileExtension)"
            let dest = uniqueURL(named: targetName, in: dir, copy: false)

            if format == .pdf {
                if let img = NSImage(contentsOf: source), let page = PDFPage(image: img) {
                    let doc = PDFDocument()
                    doc.insert(page, at: 0)
                    if doc.write(to: dest) {
                        result.pairs.append(FilePair(from: source, to: dest))
                    } else {
                        result.errors.append("Failed to write PDF for “\(source.lastPathComponent)”")
                    }
                } else {
                    let (status, message) = run("/usr/bin/sips", ["-s", "format", "pdf", source.path, "--out", dest.path])
                    if status == 0 {
                        result.pairs.append(FilePair(from: source, to: dest))
                    } else {
                        result.errors.append("Convert failed for “\(source.lastPathComponent)”: \(message)")
                    }
                }
            } else {
                let (status, message) = run("/usr/bin/sips", ["-s", "format", format.sipsFormatName, source.path, "--out", dest.path])
                if status == 0 {
                    result.pairs.append(FilePair(from: source, to: dest))
                } else {
                    result.errors.append("Convert failed for “\(source.lastPathComponent)”: \(message)")
                }
            }
        }
        return result
    }

    static func combineImagesToPDF(_ urls: [URL], in dir: URL) -> OpResult {
        var result = OpResult()
        guard !urls.isEmpty else { return result }
        let dest = uniqueURL(named: "Combined Images.pdf", in: dir, copy: false)
        let doc = PDFDocument()
        for url in urls {
            if let img = NSImage(contentsOf: url), let page = PDFPage(image: img) {
                doc.insert(page, at: doc.pageCount)
            }
        }
        if doc.pageCount > 0 && doc.write(to: dest) {
            result.pairs.append(FilePair(from: urls[0], to: dest))
        } else {
            result.errors.append("Failed to create combined PDF from selected images.")
        }
        return result
    }

    static func convertDocuments(_ urls: [URL], to format: DocumentFormat, in dir: URL) -> OpResult {
        var result = OpResult()
        for source in urls {
            let stem = source.deletingPathExtension().lastPathComponent
            let targetName = "\(stem).\(format.fileExtension)"
            let dest = uniqueURL(named: targetName, in: dir, copy: false)

            if format == .pdf {
                do {
                    let attr: NSAttributedString
                    let ext = source.pathExtension.lowercased()
                    let richDocExts: Set<String> = ["rtf", "rtfd", "html", "htm", "doc", "docx", "odt", "webarchive"]
                    if !richDocExts.contains(ext) {
                        let text: String
                        if let s = try? String(contentsOf: source, encoding: .utf8) {
                            text = s
                        } else if let s = try? String(contentsOf: source, encoding: .isoLatin1) {
                            text = s
                        } else {
                            let data = try Data(contentsOf: source)
                            text = String(decoding: data, as: UTF8.self)
                        }
                        attr = NSAttributedString(string: text, attributes: [
                            .font: NSFont.monospacedSystemFont(ofSize: 11, weight: .regular)
                        ])
                    } else {
                        attr = try NSAttributedString(url: source, options: [:], documentAttributes: nil)
                    }

                    let textStorage = NSTextStorage(attributedString: attr)
                    let layoutManager = NSLayoutManager()
                    let textContainer = NSTextContainer(size: NSSize(width: 500, height: CGFloat.greatestFiniteMagnitude))
                    layoutManager.addTextContainer(textContainer)
                    textStorage.addLayoutManager(layoutManager)
                    let textView = NSTextView(frame: NSRect(x: 0, y: 0, width: 500, height: 100), textContainer: textContainer)
                    textView.sizeToFit()
                    let bounds = NSRect(x: 0, y: 0, width: 612, height: max(792, textView.frame.height + 72))
                    let containerView = NSView(frame: bounds)
                    textView.frame.origin = CGPoint(x: 56, y: 36)
                    containerView.addSubview(textView)
                    let pdfData = containerView.dataWithPDF(inside: bounds)
                    try pdfData.write(to: dest)
                    result.pairs.append(FilePair(from: source, to: dest))
                } catch {
                    result.errors.append("Convert to PDF failed for “\(source.lastPathComponent)”: \(error.localizedDescription)")
                }
            } else {
                let ext = source.pathExtension.lowercased()
                let richDocExts: Set<String> = ["rtf", "rtfd", "html", "htm", "doc", "docx", "odt", "webarchive"]
                let args: [String]
                if !richDocExts.contains(ext) {
                    args = ["-format", "txt", "-convert", format.textutilFormat, source.path, "-output", dest.path]
                } else {
                    args = ["-convert", format.textutilFormat, source.path, "-output", dest.path]
                }
                let (status, message) = run("/usr/bin/textutil", args)
                if status == 0 {
                    result.pairs.append(FilePair(from: source, to: dest))
                } else {
                    result.errors.append("Convert failed for “\(source.lastPathComponent)”: \(message)")
                }
            }
        }
        return result
    }

    static func run(_ tool: String, _ args: [String], currentDirectoryURL: URL? = nil) -> (Int32, String) {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: tool)
        process.arguments = args
        if let currentDirectoryURL {
            process.currentDirectoryURL = currentDirectoryURL
        }
        let errPipe = Pipe()
        let outPipe = Pipe()
        process.standardError = errPipe
        process.standardOutput = outPipe
        do { try process.run() } catch { return (-1, error.localizedDescription) }
        let errData = errPipe.fileHandleForReading.readDataToEndOfFile()
        let outData = outPipe.fileHandleForReading.readDataToEndOfFile()
        process.waitUntilExit()
        let errString = String(decoding: errData, as: UTF8.self).trimmingCharacters(in: .whitespacesAndNewlines)
        let outString = String(decoding: outData, as: UTF8.self).trimmingCharacters(in: .whitespacesAndNewlines)
        let message = !errString.isEmpty ? errString : outString
        return (process.terminationStatus, message)
    }

    static func volumeID(of url: URL) -> String? {
        (try? url.resourceValues(forKeys: [.volumeIdentifierKey]))?.volumeIdentifier.map { "\($0)" }
    }

    /// Renames a mounted volume (e.g. an external drive), not a file — there's no Foundation API for
    /// this, so it shells out to `diskutil`, which accepts a mount point in place of a disk identifier.
    /// Returns an error message on failure, nil on success.
    static func renameVolume(_ url: URL, to newName: String) -> String? {
        let (status, message) = run("/usr/sbin/diskutil", ["rename", url.path, newName])
        guard status == 0 else { return message.isEmpty ? "diskutil rename failed (status \(status))" : message }
        return nil
    }

    /// Erases and reformats a single volume/partition in place (`eraseVolume`, not the much more
    /// destructive `eraseDisk`, which would take every other partition on the same physical disk with
    /// it). Irreversible — callers must confirm with the user before calling this. Returns an error
    /// message on failure, nil on success.
    static func eraseVolume(_ url: URL, format: String, name: String) -> String? {
        let (status, message) = run("/usr/sbin/diskutil", ["eraseVolume", format, name, url.path])
        guard status == 0 else { return message.isEmpty ? "diskutil eraseVolume failed (status \(status))" : message }
        return nil
    }
}
