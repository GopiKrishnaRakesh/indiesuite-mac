import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

struct RegexMatch: Identifiable {
    let id = UUID()
    let fullMatch: String
    let groups: [String]
    let range: NSRange
}

class RegexForgeState: ObservableObject {
    @Published var pattern: String = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}"
    @Published var testInput: String = "Contact team at support@indiesuite.app or founder@macsuite.io"
    @Published var caseInsensitive: Bool = false
    @Published var multiline: Bool = false

    @Published var matches: [RegexMatch] = []
    @Published var errorMessage: String? = nil

    let presets: [(String, String)] = [
        ("Email", "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}"),
        ("URL", "https?://[\\w.-]+(?:/[\\w./?%&=-]*)?"),
        ("IPv4 Address", "\\b(?:\\d{1,3}\\.){3}\\d{1,3}\\b"),
        ("Hex Color", "#(?:[0-9a-fA-F]{3}){1,2}\\b"),
        ("Phone (US)", "\\(?\\d{3}\\)?[-.\\s]?\\d{3}[-.\\s]?\\d{4}"),
        ("Digits Only", "\\d+")
    ]

    init() {
        evaluate()
    }

    func evaluate() {
        guard !pattern.isEmpty else {
            matches = []
            errorMessage = nil
            return
        }

        var options: NSRegularExpression.Options = []
        if caseInsensitive { options.insert(.caseInsensitive) }
        if multiline { options.insert(.anchorsMatchLines) }

        do {
            let regex = try NSRegularExpression(pattern: pattern, options: options)
            let nsString = testInput as NSString
            let results = regex.matches(in: testInput, options: [], range: NSRange(location: 0, length: nsString.length))

            matches = results.map { result in
                var groups: [String] = []
                if result.numberOfRanges > 1 {
                    for i in 1..<result.numberOfRanges {
                        let r = result.range(at: i)
                        groups.append(r.location != NSNotFound ? nsString.substring(with: r) : "")
                    }
                }
                return RegexMatch(fullMatch: nsString.substring(with: result.range), groups: groups, range: result.range)
            }
            errorMessage = nil
        } catch {
            matches = []
            errorMessage = error.localizedDescription
        }
    }

    func copyMatches() {
        let text = matches.map { $0.fullMatch }.joined(separator: "\n")
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
    }
}

struct RegexForgeView: View {
    @StateObject private var state = RegexForgeState()
    @StateObject private var license = LicenseManager.shared

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "character.cursor.ibeam")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("RegexForge")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                if let err = state.errorMessage {
                    Text("Invalid")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.red)
                        .help(err)
                } else {
                    Text("\(state.matches.count) Match\(state.matches.count == 1 ? "" : "es")")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.green)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Pattern").font(.system(size: 10, weight: .bold)).foregroundColor(.secondary)
                    Spacer()
                    Menu("Presets") {
                        ForEach(state.presets, id: \.0) { preset in
                            Button(preset.0) {
                                state.pattern = preset.1
                                state.evaluate()
                            }
                        }
                    }
                    .font(.system(size: 10))
                    .frame(width: 90)
                }
                TextField("Regex pattern", text: $state.pattern)
                    .textFieldStyle(.plain)
                    .font(.system(size: 11, design: .monospaced))
                    .padding(6)
                    .glassCard(cornerRadius: 6)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(state.errorMessage != nil ? Color.red.opacity(0.6) : Color.clear, lineWidth: 1.5))
                    .onChange(of: state.pattern) { _ in state.evaluate() }

                HStack(spacing: 14) {
                    Toggle("Case Insensitive", isOn: $state.caseInsensitive)
                        .font(.system(size: 10))
                        .onChange(of: state.caseInsensitive) { _ in state.evaluate() }
                    Toggle("Multiline (^$)", isOn: $state.multiline)
                        .font(.system(size: 10))
                        .onChange(of: state.multiline) { _ in state.evaluate() }
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Test String").font(.system(size: 10, weight: .bold)).foregroundColor(.secondary)
                TextEditor(text: $state.testInput)
                    .font(.system(size: 10, design: .monospaced))
                    .frame(height: 70)
                    .padding(4)
                    .glassCard(cornerRadius: 6)
                    .onChange(of: state.testInput) { _ in state.evaluate() }
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Matches").font(.system(size: 10, weight: .bold)).foregroundColor(.secondary)
                    Spacer()
                    Button("Copy All") { state.copyMatches() }
                        .buttonStyle(.plain)
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.accentColor)
                        .disabled(state.matches.isEmpty)
                }
                ScrollView {
                    VStack(alignment: .leading, spacing: 4) {
                        if state.matches.isEmpty {
                            Text(state.errorMessage ?? "No matches yet")
                                .font(.system(size: 10))
                                .foregroundColor(.secondary)
                                .padding(6)
                        }
                        ForEach(state.matches) { m in
                            HStack {
                                Text(m.fullMatch)
                                    .font(.system(size: 10, design: .monospaced))
                                    .lineLimit(1)
                                if !m.groups.isEmpty {
                                    Text("(\(m.groups.joined(separator: ", ")))")
                                        .font(.system(size: 9, design: .monospaced))
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding(5)
                            .background(Color.primary.opacity(0.03))
                            .cornerRadius(5)
                        }
                    }
                }
                .frame(maxHeight: 90)
            }

            HStack {
                Text("NSRegularExpression • Live evaluation")
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
                Spacer()
                Button("Quit") { NSApp.terminate(nil) }
                    .buttonStyle(.plain)
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
        }
        .padding(14)
        .frame(width: 360, height: 470)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<RegexForgeView>?

    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = RegexForgeView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "character.cursor.ibeam",
            titleText: "RegexForge",
            contentWidth: 360,
            contentHeight: 470
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
