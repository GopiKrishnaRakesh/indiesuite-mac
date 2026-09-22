import AppKit
import QuickLookThumbnailing
import UniformTypeIdentifiers

/// Real content thumbnails (actual photo/PDF-page previews) for Icon/Tile view, as opposed to
/// IconCache's generic file-type glyph. Generation runs off the main thread via QLThumbnailGenerator
/// and results are cached by URL + size bucket so re-layout and scrolling don't regenerate them.
enum ThumbnailLoader {
    private static let cache = NSCache<NSString, NSImage>()

    /// Only file types that actually have visual content are worth the cost of generating a thumbnail.
    static func isPreviewable(_ url: URL) -> Bool {
        guard let type = UTType(filenameExtension: url.pathExtension) else { return false }
        return type.conforms(to: .image) || type.conforms(to: .pdf) || type.conforms(to: .movie)
    }

    /// Buckets size to the nearest 16pt so dragging the icon-size slider doesn't regenerate on
    /// every frame.
    static func bucket(_ size: Double) -> Int { max(32, Int((size / 16).rounded()) * 16) }

    static func cached(for url: URL, size: Double) -> NSImage? {
        cache.object(forKey: key(url, size))
    }

    private static func key(_ url: URL, _ size: Double) -> NSString {
        "\(url.path)#\(bucket(size))" as NSString
    }

    static func load(for url: URL, size: Double) async -> NSImage? {
        let k = key(url, size)
        if let hit = cache.object(forKey: k) { return hit }
        let pixels = CGFloat(bucket(size))
        let scale = await MainActor.run { NSScreen.main?.backingScaleFactor ?? 2 }
        let request = QLThumbnailGenerator.Request(
            fileAt: url, size: CGSize(width: pixels, height: pixels), scale: scale, representationTypes: .thumbnail
        )
        let image = await withCheckedContinuation { (continuation: CheckedContinuation<NSImage?, Never>) in
            QLThumbnailGenerator.shared.generateBestRepresentation(for: request) { representation, _ in
                continuation.resume(returning: representation?.nsImage)
            }
        }
        if let image { cache.setObject(image, forKey: k) }
        return image
    }
}
