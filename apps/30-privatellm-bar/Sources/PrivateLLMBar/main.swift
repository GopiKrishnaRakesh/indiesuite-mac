import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class PrivateLLMBarState: ObservableObject {

    @Published var selectedModel: String = "Llama-3.2-3B-Instruct (MLX 4-bit)"
    @Published var promptInput: String = "Summarize this log file:"
    @Published var responseOutput: String = "Offline Apple Silicon MLX inference ready. 100% private, 0 cloud dependency."

}

struct PrivateLLMBarView: View {
    @StateObject private var state = PrivateLLMBarState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "brain.head.profile")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("PrivateLLM Bar")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("100% Offline")
                    .font(.system(size: 9, weight: .bold))
                    .padding(3)
                    .background(Color.purple.opacity(0.15))
                    .foregroundColor(.purple)
                    .cornerRadius(3)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Prompt")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.secondary)
                TextField("Prompt", text: $state.promptInput)
                    .textFieldStyle(.plain)
                    .font(.system(size: 11))
                    .padding(6)
                    .glassCard(cornerRadius: 6)
            }
            
            Text(state.responseOutput)
                .font(.system(size: 10, design: .rounded))
                .foregroundColor(.secondary)
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .glassCard(cornerRadius: 8)

            
            HStack {
                Text("Indie Suite Pro Ready")
                    .font(.system(size: 9))
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
        .frame(width: 340, height: 360)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<PrivateLLMBarView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = PrivateLLMBarView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "brain.head.profile",
            titleText: "LocalAI",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
