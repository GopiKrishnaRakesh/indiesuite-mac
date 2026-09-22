import Foundation

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
        let c = child.standardizedFileURL.path
        let p = parent.standardizedFileURL.path
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

    static func compress(_ urls: [URL], in dir: URL) -> OpResult {
        var result = OpResult()
        guard let first = urls.first else { return result }
        let name = urls.count == 1 ? first.lastPathComponent + ".zip" : "Archive.zip"
        let dest = uniqueURL(named: name, in: dir, copy: false)
        let (status, message) = run("/usr/bin/ditto", ["-c", "-k", "--sequesterRsrc", "--keepParent"] + urls.map(\.path) + [dest.path])
        if status == 0 { result.pairs.append(FilePair(from: first, to: dest)) } else { result.errors.append("Compress failed: \(message)") }
        return result
    }

    static func extract(_ archive: URL, in dir: URL) -> OpResult {
        var result = OpResult()
        let stem = archive.deletingPathExtension().lastPathComponent
        let dest = uniqueURL(named: stem, in: dir, copy: false)
        let (status, message) = run("/usr/bin/ditto", ["-x", "-k", archive.path, dest.path])
        if status == 0 { result.pairs.append(FilePair(from: archive, to: dest)) } else { result.errors.append("Extract failed: \(message)") }
        return result
    }

    static func run(_ tool: String, _ args: [String]) -> (Int32, String) {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: tool)
        process.arguments = args
        let pipe = Pipe()
        process.standardError = pipe
        process.standardOutput = FileHandle.nullDevice
        do { try process.run() } catch { return (-1, error.localizedDescription) }
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        process.waitUntilExit()
        return (process.terminationStatus, String(decoding: data, as: UTF8.self).trimmingCharacters(in: .whitespacesAndNewlines))
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
