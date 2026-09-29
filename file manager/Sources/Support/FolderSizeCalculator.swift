import Foundation

/// Fast, asynchronous folder size calculator with in-memory caching and cooperative cancellation.
actor FolderSizeCalculator {
    static let shared = FolderSizeCalculator()

    private var cache: [String: (size: Int64, modDate: Date?)] = [:]

    func cachedSize(for path: String, modDate: Date?) -> Int64? {
        if let cached = cache[path], cached.modDate == modDate {
            return cached.size
        }
        return nil
    }

    func store(size: Int64, modDate: Date?, for path: String) {
        cache[path] = (size, modDate)
    }

    func clearCache() {
        cache.removeAll()
    }

    func remove(path: String) {
        cache.removeValue(forKey: path)
    }

    nonisolated func size(of folderURL: URL) async -> Int64 {
        let path = folderURL.path
        let resolvedURL = folderURL.resolvingSymlinksInPath()
        let modDate = (try? resolvedURL.resourceValues(forKeys: [.contentModificationDateKey]))?.contentModificationDate

        if let cached = await cachedSize(for: path, modDate: modDate) {
            return cached
        }

        let keys: [URLResourceKey] = [.fileSizeKey, .totalFileSizeKey, .isDirectoryKey]
        guard let enumerator = FileManager.default.enumerator(
            at: resolvedURL,
            includingPropertiesForKeys: keys,
            options: [],
            errorHandler: { _, _ in true }
        ) else { return 0 }

        var total: Int64 = 0
        let keySet = Set(keys)
        var count = 0

        while let fileURL = enumerator.nextObject() as? URL {
            if Task.isCancelled { return total }
            count += 1
            if count % 200 == 0 {
                await Task.yield()
                if Task.isCancelled { return total }
            }
            guard let values = try? fileURL.resourceValues(forKeys: keySet) else { continue }
            if values.isDirectory != true {
                total += Int64(values.fileSize ?? values.totalFileSize ?? 0)
            }
        }

        await store(size: total, modDate: modDate, for: path)
        return total
    }
}
