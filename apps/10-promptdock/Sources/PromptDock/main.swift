import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class PromptDockState: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var selectedCategory: String = "All"
    
    @Published var prompts: [SavedPrompt] = [
        SavedPrompt(title: "Code Review & Refactor", template: "Review the following code for performance, security vulnerabilities, and clean code principles:\n\n```\n{{clipboard}}\n```", category: "Dev", uses: 84),
        SavedPrompt(title: "Explain Like I'm 5", template: "Explain the concept of '{{topic}}' in simple terms with everyday analogies.", category: "Learning", uses: 42),
        SavedPrompt(title: "Polite Email Rewriter", template: "Rewrite the following message to sound professional, courteous, yet concise:\n\n{{clipboard}}", category: "Writing", uses: 67),
        SavedPrompt(title: "Generate TypeScript Types", template: "Convert the following JSON payload into strict TypeScript interfaces with comments:\n\n{{clipboard}}", category: "Dev", uses: 128)
    ]
    
    struct SavedPrompt: Identifiable {
        let id = UUID()
        let title: String
        let template: String
        let category: String
        let uses: Int
    }
    
    func copyPrompt(_ prompt: SavedPrompt) {
        let text = prompt.template.replacingOccurrences(of: "{{clipboard}}", with: NSPasteboard.general.string(forType: .string) ?? "...")
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
    }
}

struct PromptDockView: View {
    @StateObject private var state = PromptDockState()
    @StateObject private var license = LicenseManager.shared
    
    let categories = ["All", "Dev", "Writing", "Learning"]
    
    var filteredPrompts: [PromptDockState.SavedPrompt] {
        state.prompts.filter {
            (state.selectedCategory == "All" || $0.category == state.selectedCategory) &&
            (state.searchQuery.isEmpty || $0.title.localizedCaseInsensitiveContains(state.searchQuery))
        }
    }
    
    var body: some View {
        VStack(spacing: 12) {
            // Header
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "sparkles.rectangle.stack.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("PromptDock")
                        .font(.system(size: 15, weight: .bold))
                }
                
                Spacer()
                
                HotkeyPill(keyCombination: "⌥ P")
            }
            
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .font(.system(size: 11))
                TextField("Search prompts or press 1-4...", text: $state.searchQuery)
                    .textFieldStyle(.plain)
                    .font(.system(size: 11))
            }
            .padding(6)
            .glassCard(cornerRadius: 6)
            
            // Category Filter Pills
            HStack(spacing: 6) {
                ForEach(categories, id: \.self) { cat in
                    Button(action: {
                        state.selectedCategory = cat
                    }) {
                        Text(cat)
                            .font(.system(size: 10, weight: state.selectedCategory == cat ? .bold : .medium))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(state.selectedCategory == cat ? Color.accentColor : Color.primary.opacity(0.06))
                            .foregroundColor(state.selectedCategory == cat ? .white : .primary)
                            .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                }
                Spacer()
            }
            
            // Prompts List
            ScrollView {
                VStack(spacing: 6) {
                    ForEach(Array(filteredPrompts.enumerated()), id: \.element.id) { index, item in
                        HStack {
                            Text("\(index + 1)")
                                .font(.system(size: 10, weight: .bold, design: .monospaced))
                                .foregroundColor(.secondary)
                                .frame(width: 14)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(item.title)
                                    .font(.system(size: 11, weight: .semibold))
                                Text(item.template)
                                    .font(.system(size: 9))
                                    .lineLimit(1)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                state.copyPrompt(item)
                            }) {
                                HStack(spacing: 2) {
                                    Image(systemName: "arrow.right.circle.fill")
                                    Text("Inject")
                                }
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(DSTheme.primaryGradient)
                                .cornerRadius(4)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(6)
                        .background(Color.primary.opacity(0.03))
                        .cornerRadius(6)
                    }
                }
            }
            .frame(maxHeight: 250)
            
            // Footer
            HStack {
                Button("+ New Template") {}
                    .buttonStyle(.plain)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.accentColor)
                
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
        .frame(width: 350, height: 420)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<PromptDockView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = PromptDockView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "sparkles.rectangle.stack",
            titleText: "PromptDock",
            contentWidth: 350,
            contentHeight: 420
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
