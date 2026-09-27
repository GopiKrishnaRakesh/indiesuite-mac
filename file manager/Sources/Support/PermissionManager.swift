import AppKit
import Foundation
import SwiftUI

/// Manages macOS TCC permissions (Desktop, Documents, Downloads, Removable Volumes)
/// and checks for Full Disk Access (FDA) to ensure a completely smooth onboarding experience.
@MainActor
final class PermissionManager: ObservableObject {
    static let shared = PermissionManager()

    @Published private(set) var hasFullDiskAccess: Bool = false
    @Published private(set) var hasDesktopAccess: Bool = false
    @Published private(set) var hasDocumentsAccess: Bool = false
    @Published private(set) var hasDownloadsAccess: Bool = false
    @Published private(set) var isRequesting: Bool = false

    private var pollTimer: Timer?

    init() {
        checkPermissions()
        startPolling()
    }

    deinit {
        pollTimer?.invalidate()
    }

    func checkPermissions() {
        hasFullDiskAccess = Self.checkFDA()
        hasDesktopAccess = Self.checkFolder("Desktop")
        hasDocumentsAccess = Self.checkFolder("Documents")
        hasDownloadsAccess = Self.checkFolder("Downloads")
    }

    /// Automatically polls while the onboarding or settings sheet is open,
    /// so when a user enables FDA or allows a folder in System Settings,
    /// the UI updates to a green checkmark in real time without restarting.
    func startPolling() {
        guard pollTimer == nil else { return }
        pollTimer = Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.checkPermissions()
            }
        }
    }

    func stopPolling() {
        pollTimer?.invalidate()
        pollTimer = nil
    }

    /// Triggers the native macOS permission prompt for primary user folders in sequence
    func requestAllFolderPermissions() {
        isRequesting = true
        Task.detached(priority: .userInitiated) {
            let home = FileManager.default.homeDirectoryForCurrentUser
            let folders = ["Desktop", "Documents", "Downloads"]
            for folder in folders {
                let url = home.appendingPathComponent(folder)
                _ = try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
            }
            await MainActor.run {
                self.checkPermissions()
                self.isRequesting = false
            }
        }
    }

    /// Directly opens the Privacy & Security -> Full Disk Access pane in macOS System Settings
    func openFullDiskAccessSettings() {
        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles") {
            NSWorkspace.shared.open(url)
        }
    }

    /// Checks if Full Disk Access is active by probing a standard FDA-protected directory
    private static func checkFDA() -> Bool {
        let safariURL = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Library/Safari")
        do {
            _ = try FileManager.default.contentsOfDirectory(at: safariURL, includingPropertiesForKeys: nil)
            return true
        } catch {
            return false
        }
    }

    private static func checkFolder(_ name: String) -> Bool {
        let url = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(name)
        guard FileManager.default.fileExists(atPath: url.path) else { return true }
        do {
            _ = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
            return true
        } catch {
            return false
        }
    }
}
