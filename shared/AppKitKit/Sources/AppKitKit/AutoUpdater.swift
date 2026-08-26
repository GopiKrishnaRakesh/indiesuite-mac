import Foundation
import AppKit

public struct AppReleaseInfo: Codable {
    public let version: String
    public let buildNumber: Int
    public let downloadURL: URL
    public let releaseNotes: String
    public let pubDate: Date?
}

public class AutoUpdater: ObservableObject {
    public static let shared = AutoUpdater()
    
    @Published public var isChecking = false
    @Published public var updateAvailable: AppReleaseInfo?
    @Published public var latestVersion: String = ""
    
    private let appcastEndpoint = "https://indiesuite.app/api/appcast"
    
    public func checkForUpdates(appName: String, currentVersion: String) {
        guard let url = URL(string: "\(appcastEndpoint)/\(appName).json") else { return }
        
        isChecking = true
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                self?.isChecking = false
                guard let data = data, error == nil,
                      let release = try? JSONDecoder().decode(AppReleaseInfo.self, from: data) else {
                    return
                }
                
                self?.latestVersion = release.version
                if release.version.compare(currentVersion, options: .numeric) == .orderedDescending {
                    self?.updateAvailable = release
                }
            }
        }.resume()
    }
}
