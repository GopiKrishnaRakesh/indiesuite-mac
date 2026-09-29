import AppKit
import Foundation

/// Helper for standalone app installation and management.
/// Handles self-moving to /Applications, quarantine clearing, and CLI tool installation.
@MainActor
enum AppInstallHelper {
    static var isRunningFromApplications: Bool {
        let path = Bundle.main.bundleURL.standardizedFileURL.path
        return path.hasPrefix("/Applications/") || path.hasPrefix("/System/Applications/")
    }

    static var isRunningFromDiskImage: Bool {
        let path = Bundle.main.bundleURL.standardizedFileURL.path
        return path.hasPrefix("/Volumes/")
    }

    /// Automatically prompts the user on launch to move the app to /Applications if running from
    /// a temporary folder, Downloads, or a mounted DMG.
    static func checkAndPromptToInstall() {
        guard !isRunningFromApplications else { return }
        // Suppress during unit testing, previewing, or if user explicitly opted out
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil { return }
        if ProcessInfo.processInfo.arguments.contains("-noInstallPrompt") { return }

        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "suppressMoveToApplicationsPrompt") { return }

        promptOrMoveToApplications()
    }

    static func promptOrMoveToApplications() {
        let alert = NSAlert()
        alert.messageText = "Move to Applications folder?"
        if isRunningFromDiskImage {
            alert.informativeText = "Pathway is currently running from a disk image. Moving it to your Applications folder ensures it remains permanently installed, updates easily, and is accessible from Spotlight."
        } else {
            alert.informativeText = "Pathway is currently running outside your Applications folder. Moving it to Applications keeps your Mac organized and ensures Spotlight can index it."
        }
        alert.addButton(withTitle: "Move to Applications Folder")
        alert.addButton(withTitle: "Do Not Move")
        alert.showsSuppressionButton = true
        alert.suppressionButton?.title = "Don't ask again"

        let response = alert.runModal()
        if alert.suppressionButton?.state == .on {
            UserDefaults.standard.set(true, forKey: "suppressMoveToApplicationsPrompt")
        }

        if response == .alertFirstButtonReturn {
            moveToApplications()
        }
    }

    static func moveToApplications() {
        let fm = FileManager.default
        let currentURL = Bundle.main.bundleURL
        let appName = currentURL.lastPathComponent
        let targetURL = URL(fileURLWithPath: "/Applications").appendingPathComponent(appName)

        do {
            if fm.fileExists(atPath: targetURL.path) {
                // If an older or existing copy is in /Applications, safely trash it
                var trashedURL: NSURL?
                try? fm.trashItem(at: targetURL, resultingItemURL: &trashedURL)
                try? fm.removeItem(at: targetURL)
            }

            try fm.copyItem(at: currentURL, to: targetURL)

            // Strip quarantine attribute so Gatekeeper accepts the installed app
            let xattr = Process()
            xattr.executableURL = URL(fileURLWithPath: "/usr/bin/xattr")
            xattr.arguments = ["-dr", "com.apple.quarantine", targetURL.path]
            try? xattr.run()
            xattr.waitUntilExit()

            // Launch the installed copy from /Applications
            NSWorkspace.shared.openApplication(at: targetURL, configuration: NSWorkspace.OpenConfiguration()) { _, error in
                DispatchQueue.main.async {
                    if error == nil {
                        NSApp.terminate(nil)
                    }
                }
            }
        } catch {
            let errAlert = NSAlert()
            errAlert.messageText = "Could not install to Applications"
            errAlert.informativeText = error.localizedDescription
            errAlert.alertStyle = .warning
            errAlert.runModal()
        }
    }

    /// Installs a lightweight CLI command `pathway` into `/usr/local/bin` or `~/.local/bin`
    /// allowing users to type `pathway` or `pathway /some/folder` in Terminal.
    static func installCommandLineTool() {
        let scriptContent = """
        #!/bin/sh
        # Pathway Command Line Launcher
        if [ $# -eq 0 ]; then
            open -a Pathway
        else
            TARGET=$(cd "$1" 2>/dev/null && pwd || echo "$1")
            open -a Pathway --args -startPath "$TARGET"
        fi
        """

        let fm = FileManager.default
        let usrLocalBin = "/usr/local/bin"
        let userLocalBin = (("~/.local/bin" as NSString).expandingTildeInPath)

        var destinationDir = userLocalBin
        if fm.isWritableFile(atPath: usrLocalBin) {
            destinationDir = usrLocalBin
        } else {
            try? fm.createDirectory(atPath: userLocalBin, withIntermediateDirectories: true)
        }

        let scriptPath = (destinationDir as NSString).appendingPathComponent("pathway")

        do {
            try scriptContent.write(toFile: scriptPath, atomically: true, encoding: .utf8)
            let chmod = Process()
            chmod.executableURL = URL(fileURLWithPath: "/bin/chmod")
            chmod.arguments = ["+x", scriptPath]
            try? chmod.run()
            chmod.waitUntilExit()

            let alert = NSAlert()
            alert.messageText = "Command Line Tool Installed!"
            alert.informativeText = "The 'pathway' command has been installed at:\n\(scriptPath)\n\nYou can now open any folder in Pathway from Terminal:\npathway /path/to/folder"
            alert.runModal()
        } catch {
            let errAlert = NSAlert()
            errAlert.messageText = "Failed to Install Command Line Tool"
            errAlert.informativeText = error.localizedDescription
            errAlert.alertStyle = .warning
            errAlert.runModal()
        }
    }
}
