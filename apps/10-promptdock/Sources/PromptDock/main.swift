import SwiftUI
import AppKit
import Carbon
import DesignSystem
import AppKitKit
import Licensing

struct SavedPrompt: Identifiable, Codable {
    var id = UUID()
    var title: String
    var template: String
    var category: String
    var uses: Int = 0
}

enum PromptStore {
    static let defaultsKey = "PromptDockSavedPrompts"

    static func load() -> [SavedPrompt] {
        if let data = UserDefaults.standard.data(forKey: defaultsKey),
           let decoded = try? JSONDecoder().decode([SavedPrompt].self, from: data) {
            return decoded
        }
        return [
            SavedPrompt(title: "Code Review & Refactor", template: "Review the following code for performance, security vulnerabilities, and clean code principles:\n\n```\n{{clipboard}}\n```", category: "Dev"),
            SavedPrompt(title: "Explain Like I'm 5", template: "Explain the concept of '{{clipboard}}' in simple terms with everyday analogies.", category: "Learning"),
            SavedPrompt(title: "Polite Email Rewriter", template: "Rewrite the following message to sound professional, courteous, yet concise:\n\n{{clipboard}}", category: "Writing"),
            SavedPrompt(title: "Generate TypeScript Types", template: "Convert the following JSON payload into strict TypeScript interfaces with comments:\n\n{{clipboard}}", category: "Dev")
        ]
    }

    static func save(_ prompts: [SavedPrompt]) {
        if let data = try? JSONEncoder().encode(prompts) {
            UserDefaults.standard.set(data, forKey: defaultsKey)
        }
    }
}

/// Simulates ⌘V into the frontmost app — requires Accessibility trust, same as any
/// paste-injection utility (Alfred, Raycast, TextExpander all need this).
enum KeystrokeInjector {
    static func pasteIntoFrontmostApp() {
        guard let source = CGEventSource(stateID: .hidSystemState) else { return }
        let vKeyCode: CGKeyCode = 9 // 'v'
        let keyDown = CGEvent(keyboardEventSource: source, virtualKey: vKeyCode, keyDown: true)
        keyDown?.flags = .maskCommand
        let keyUp = CGEvent(keyboardEventSource: source, virtualKey: vKeyCode, keyDown: false)
        keyUp?.flags = .maskCommand
        keyDown?.post(tap: .cghidEventTap)
        keyUp?.post(tap: .cghidEventTap)
    }
}

class PromptDockState: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var selectedCategory: String = "All"
    @Published var prompts: [SavedPrompt] = PromptStore.load()
    @Published var newTitle: String = ""
    @Published var newTemplate: String = ""
    @Published var isAdding: Bool = false
    @Published var statusMessage: String = ""

    var categories: [String] {
        ["All"] + Array(Set(prompts.map(\.category))).sorted()
    }

    func filteredPrompts() -> [SavedPrompt] {
        prompts.filter {
            (selectedCategory == "All" || $0.category == selectedCategory) &&
            (searchQuery.isEmpty || $0.title.localizedCaseInsensitiveContains(searchQuery))
        }
    }

    /// Real: fills {{clipboard}} with the ACTUAL current pasteboard content,
    /// copies the result, then simulates paste into whatever app is frontmost.
    func inject(_ prompt: SavedPrompt) {
        let clip = NSPasteboard.general.string(forType: .string) ?? ""
        let text = prompt.template.replacingOccurrences(of: "{{clipboard}}", with: clip)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)

        if let idx = prompts.firstIndex(where: { $0.id == prompt.id }) {
            prompts[idx].uses += 1
            PromptStore.save(prompts)
        }

        if WindowTilerPermission.isTrusted(prompt: false) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                KeystrokeInjector.pasteIntoFrontmostApp()
            }
            statusMessage = "Injected \"\(prompt.title)\""
        } else {
            statusMessage = "Copied \"\(prompt.title)\" — grant Accessibility to auto-paste"
        }
    }

    func addPrompt() {
        let title = newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !title.isEmpty, !newTemplate.isEmpty else { return }
        prompts.append(SavedPrompt(title: title, template: newTemplate, category: "Custom"))
        PromptStore.save(prompts)
        newTitle = ""
        newTemplate = ""
        isAdding = false
    }

    func deletePrompt(_ prompt: SavedPrompt) {
        prompts.removeAll { $0.id == prompt.id }
        PromptStore.save(prompts)
    }
}

enum WindowTilerPermission {
    static func isTrusted(prompt: Bool) -> Bool {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: prompt]
        return AXIsProcessTrustedWithOptions(options)
    }
}

struct PromptDockView: View {
    @ObservedObject var state: PromptDockState
    @StateObject private var license = LicenseManager.shared

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "sparkles.rectangle.stack.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("PromptDock").font(.system(size: 15, weight: .bold))
                }
                Spacer()
                HotkeyPill(keyCombination: "⌥ P")
            }

            HStack {
                Image(systemName: "magnifyingglass").foregroundColor(.secondary).font(.system(size: 11))
                TextField("Search prompts...", text: $state.searchQuery)
                    .textFieldStyle(.plain)
                    .font(.system(size: 11))
            }
            .padding(6)
            .glassCard(cornerRadius: 6)

            HStack(spacing: 6) {
                ForEach(state.categories, id: \.self) { cat in
                    Button(action: { state.selectedCategory = cat }) {
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

            ScrollView {
                VStack(spacing: 6) {
                    ForEach(Array(state.filteredPrompts().enumerated()), id: \.element.id) { index, item in
                        HStack {
                            Text("\(index + 1)")
                                .font(.system(size: 10, weight: .bold, design: .monospaced))
                                .foregroundColor(.secondary)
                                .frame(width: 14)

                            VStack(alignment: .leading, spacing: 2) {
                                Text(item.title).font(.system(size: 11, weight: .semibold))
                                Text(item.template).font(.system(size: 9)).lineLimit(1).foregroundColor(.secondary)
                            }

                            Spacer()

                            Text("\(item.uses)×").font(.system(size: 9)).foregroundColor(.secondary)

                            Button(action: { state.inject(item) }) {
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

                            Button(action: { state.deletePrompt(item) }) {
                                Image(systemName: "trash").font(.system(size: 9)).foregroundColor(.red.opacity(0.7))
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(6)
                        .background(Color.primary.opacity(0.03))
                        .cornerRadius(6)
                    }
                }
            }
            .frame(maxHeight: 220)

            if state.isAdding {
                VStack(spacing: 6) {
                    TextField("Title", text: $state.newTitle)
                        .textFieldStyle(.plain).font(.system(size: 11)).padding(6)
                        .background(Color.primary.opacity(0.04)).cornerRadius(5)
                    TextField("Template (use {{clipboard}})", text: $state.newTemplate)
                        .textFieldStyle(.plain).font(.system(size: 10, design: .monospaced)).padding(6)
                        .background(Color.primary.opacity(0.04)).cornerRadius(5)
                    HStack {
                        Button("Cancel") { state.isAdding = false }.buttonStyle(.plain).font(.system(size: 10))
                        Spacer()
                        Button("Save") { state.addPrompt() }
                            .buttonStyle(.plain).font(.system(size: 10, weight: .bold)).foregroundColor(.accentColor)
                    }
                }
                .padding(8)
                .glassCard(cornerRadius: 8)
            }

            HStack {
                Button(state.isAdding ? "" : "+ New Template") { state.isAdding = true }
                    .buttonStyle(.plain)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.accentColor)
                Spacer()
                Text(state.statusMessage).font(.system(size: 9)).foregroundColor(.secondary).lineLimit(1)
                Button("Quit") { NSApp.terminate(nil) }
                    .buttonStyle(.plain)
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
        }
        .padding(14)
        .frame(width: 380, height: 460)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<PromptDockView>?
    let state = PromptDockState()

    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = PromptDockView(state: state)
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "sparkles.rectangle.stack",
            titleText: nil,
            contentWidth: 380,
            contentHeight: 460
        )

        _ = GlobalHotkeyManager.shared.registerHotkey(keyCode: UInt32(kVK_ANSI_P), modifiers: UInt32(optionKey)) { [weak self] in
            self?.menuBarController?.togglePopover(nil)
        }
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
