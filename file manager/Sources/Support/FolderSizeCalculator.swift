import Foundation

/// Fast, asynchronous folder size calculator with in-memory caching and cooperative cancellation.
actor FolderSizeCalculator {
    static let shared = FolderSizeCalculator()

    private var cache: [URL: (size: Int64, modDate: Date)] = [:]

    func size(of folderURL: URL) async -> Int64 {
        let stdURL = folderURL.standardizedFileURL
        let modDate = (try? stdURL.resourceValues(forKeys: [.contentModificationDateKey]))?.contentModificationDate ?? Date()

        if let cached = cache[stdURL], cached.modDate == modDate {
            return cached.size
        }

        let keys: [URLResourceKey] = [.fileSizeKey, .isDirectoryKey, .isPackageKey]
        guard let enumerator = FileManager.default.enumerator(
            at: stdURL,
            includingPropertiesForKeys: keys,
            options: [.skipsPackageDescendants],
            errorHandler: nil
        ) else { return 0 }

        var total: Int64 = 0
        let keySet = Set(keys)

        while let fileURL = enumerator.nextObject() as? URL {
            if Task.isCancelled { return total }
            guard let values = try? fileURL.resourceValues(forKeys: keySet) else { continue }
            // Skip directory entries themselves, count file sizes
            if values.isDirectory != true || values.isPackage == true {
                total += Int64(values.fileSize ?? 0)
            }
        }

        cache[stdURL] = (total, modDate)
        return total
    }

    func clearCache() {
        cache.removeAll()
    }
}
