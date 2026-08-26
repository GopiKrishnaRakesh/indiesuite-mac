import Foundation
import AVFoundation
import AppKit

public class VideoCompressor: ObservableObject {
    public static let shared = VideoCompressor()
    
    @Published public var isExporting = false
    @Published public var exportProgress: Double = 0.0
    
    public init() {}
    
    public func compressVideo(inputURL: URL, outputURL: URL, preset: String = AVAssetExportPresetHighestQuality, completion: @escaping (Result<URL, Error>) -> Void) {
        let asset = AVURLAsset(url: inputURL)
        guard let exportSession = AVAssetExportSession(asset: asset, presetName: preset) else {
            completion(.failure(NSError(domain: "VideoCompressor", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create export session"])))
            return
        }
        
        exportSession.outputURL = outputURL
        exportSession.outputFileType = .mp4
        exportSession.shouldOptimizeForNetworkUse = true
        
        DispatchQueue.main.async {
            self.isExporting = true
            self.exportProgress = 0.0
        }
        
        exportSession.exportAsynchronously {
            DispatchQueue.main.async {
                self.isExporting = false
                if exportSession.status == .completed {
                    self.exportProgress = 1.0
                    completion(.success(outputURL))
                } else if let error = exportSession.error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NSError(domain: "VideoCompressor", code: -2, userInfo: [NSLocalizedDescriptionKey: "Export cancelled or failed"])))
                }
            }
        }
    }
}
