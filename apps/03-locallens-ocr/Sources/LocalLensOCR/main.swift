import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing
import AudioVideoCore

class LocalLensState: ObservableObject {
    @Published var autoCopy: Bool = true
    @Published var removeLineBreaks: Bool = true
    @Published var codeMode: Bool = true
    @Published var detectedLanguage: String = "Swift / TypeScript"
    @Published var lastExtractedText: String = """
    struct UserProfile: Codable {
        let id: UUID
        let username: String
        let email: String
        let isPro: Bool
    }
    """
    
    @Published var history: [OCRHistoryItem] = [
        OCRHistoryItem(content: "SELECT id, name, created_at FROM users WHERE status = 'active' ORDER BY created_at DESC LIMIT 50;", type: "SQL Query"),
        OCRHistoryItem(content: "https://github.com/apple/swift-evolution/blob/main/proposals/0380-if-switch-expressions.md", type: "URL")
    ]
    
    struct OCRHistoryItem: Identifiable {
        let id = UUID()
        let content: String
        let type: String
    }
    
    func captureScreenArea() {
        // Trigger interactive screencapture or test OCR
        lastExtractedText = """
        func fetchUserData(userId: String) async throws -> UserProfile {
            let url = APIEndpoints.user(id: userId)
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(UserProfile.self, from: data)
        }
        """
        
        if autoCopy {
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(lastExtractedText, forType: .string)
        }
    }
}

struct LocalLensView: View {
    @StateObject private var state = LocalLensState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 14) {
            // Header
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "viewfinder.circle.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("LocalLens OCR")
                        .font(.system(size: 15, weight: .bold))
                }
                
                Spacer()
                
                HotkeyPill(keyCombination: "⌘ ⇧ 2")
            }
            
            // Capture Action Card
            VStack(spacing: 10) {
                Button(action: {
                    state.captureScreenArea()
                }) {
                    HStack {
                        Image(systemName: "crop")
                            .font(.system(size: 14, weight: .bold))
                        Text("Capture & Extract Screen Area")
                            .font(.system(size: 13, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(DSTheme.cyanGradient)
                    .cornerRadius(8)
                }
                .buttonStyle(.plain)
                
                HStack {
                    Toggle("Auto-copy to clipboard", isOn: $state.autoCopy)
                        .font(.system(size: 11))
                    Spacer()
                    Toggle("Format code syntax", isOn: $state.codeMode)
                        .font(.system(size: 11))
                }
            }
            .padding(10)
            .glassCard(cornerRadius: 10)
            
            // Extracted Result View
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("Extracted Content")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.secondary)
                    
                    Text(state.detectedLanguage)
                        .font(.system(size: 9, weight: .semibold))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.cyan.opacity(0.15))
                        .foregroundColor(.cyan)
                        .cornerRadius(4)
                    
                    Spacer()
                    
                    Button(action: {
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(state.lastExtractedText, forType: .string)
                    }) {
                        Label("Copy", systemImage: "doc.on.doc")
                            .font(.system(size: 10))
                    }
                    .buttonStyle(.plain)
                }
                
                Text(state.lastExtractedText)
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .background(Color.primary.opacity(0.04))
                    .cornerRadius(8)
            }
            
            // History
            VStack(alignment: .leading, spacing: 6) {
                Text("Extraction History")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.secondary)
                
                VStack(spacing: 4) {
                    ForEach(state.history) { item in
                        HStack {
                            Text(item.type)
                                .font(.system(size: 9, weight: .bold))
                                .padding(.horizontal, 4)
                                .padding(.vertical, 1)
                                .background(Color.primary.opacity(0.08))
                                .cornerRadius(3)
                            
                            Text(item.content)
                                .font(.system(size: 10, design: .monospaced))
                                .lineLimit(1)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                        }
                        .padding(4)
                    }
                }
                .glassCard(cornerRadius: 8)
            }
            
            // Footer
            HStack {
                Text("Vision Neural Engine Ready")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Button("Quit") {
                    NSApp.terminate(nil)
                }
                .buttonStyle(.plain)
                .font(.system(size: 10))
                .foregroundColor(.secondary)
            }
        }
        .padding(14)
        .frame(width: 350, height: 460)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<LocalLensView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = LocalLensView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "viewfinder.circle",
            titleText: "LocalLens",
            contentWidth: 350,
            contentHeight: 460
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
