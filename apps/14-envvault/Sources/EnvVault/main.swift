import SwiftUI
import AppKit
import Security
import DesignSystem
import AppKitKit
import Licensing

/// Thin wrapper around the macOS Keychain (Security framework).
/// Only the secret's key NAME is kept in UserDefaults (non-sensitive index);
/// the actual VALUE is only ever stored in / read from the Keychain.
enum SecretsVault {
    static let service = "com.indiesuite.envvault"
    static let indexKey = "EnvVaultKeyIndex"

    static func listKeys() -> [String] {
        UserDefaults.standard.stringArray(forKey: indexKey) ?? []
    }

    private static func saveIndex(_ keys: [String]) {
        UserDefaults.standard.set(keys, forKey: indexKey)
    }

    static func read(_ key: String) -> String? {
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        query.removeValue(forKey: kSecReturnData as String)
        guard status == errSecSuccess, let data = item as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }

    @discardableResult
    static func write(key: String, value: String) -> Bool {
        let data = value.data(using: .utf8) ?? Data()
        let baseQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key
        ]

        // Try update first, add if it doesn't exist yet.
        let updateStatus = SecItemUpdate(baseQuery as CFDictionary, [kSecValueData as String: data] as CFDictionary)
        if updateStatus == errSecItemNotFound {
            var addQuery = baseQuery
            addQuery[kSecValueData as String] = data
            addQuery[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlock
            let addStatus = SecItemAdd(addQuery as CFDictionary, nil)
            guard addStatus == errSecSuccess else { return false }
        } else if updateStatus != errSecSuccess {
            return false
        }

        var keys = listKeys()
        if !keys.contains(key) {
            keys.append(key)
            saveIndex(keys)
        }
        return true
    }

    static func delete(_ key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
        saveIndex(listKeys().filter { $0 != key })
    }
}

struct EnvEntry: Identifiable {
    let id = UUID()
    let key: String
    var value: String
}

class EnvVaultState: ObservableObject {
    @Published var isMasked: Bool = true
    @Published var entries: [EnvEntry] = []
    @Published var newKey: String = ""
    @Published var newValue: String = ""
    @Published var statusMessage: String = ""

    init() {
        reload()
    }

    func reload() {
        entries = SecretsVault.listKeys().sorted().map { key in
            EnvEntry(key: key, value: SecretsVault.read(key) ?? "")
        }
    }

    func addEntry() {
        let key = newKey.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !key.isEmpty, !newValue.isEmpty else { return }
        if SecretsVault.write(key: key, value: newValue) {
            statusMessage = "Saved \(key) to Keychain"
            newKey = ""
            newValue = ""
            reload()
        } else {
            statusMessage = "Failed to write to Keychain"
        }
    }

    func deleteEntry(_ entry: EnvEntry) {
        SecretsVault.delete(entry.key)
        reload()
    }

    func copyValue(_ entry: EnvEntry) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(entry.value, forType: .string)
        statusMessage = "Copied \(entry.key)"
    }

    func copyAllAsEnv() {
        let formatted = entries.map { "\($0.key)=\($0.value)" }.joined(separator: "\n")
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(formatted, forType: .string)
        statusMessage = "Copied .env (\(entries.count) vars)"
    }
}

struct EnvVaultView: View {
    @StateObject private var state = EnvVaultState()
    @StateObject private var license = LicenseManager.shared

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("EnvVault")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Button(action: { state.isMasked.toggle() }) {
                    Image(systemName: state.isMasked ? "eye.slash.fill" : "eye.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.plain)
                .help("Toggle Mask Secrets")
            }

            // Add new secret
            VStack(spacing: 6) {
                HStack(spacing: 6) {
                    TextField("KEY_NAME", text: $state.newKey)
                        .textFieldStyle(.plain)
                        .font(.system(size: 10, design: .monospaced))
                        .padding(6)
                        .background(Color.primary.opacity(0.04))
                        .cornerRadius(5)
                    SecureField("value", text: $state.newValue)
                        .textFieldStyle(.plain)
                        .font(.system(size: 10, design: .monospaced))
                        .padding(6)
                        .background(Color.primary.opacity(0.04))
                        .cornerRadius(5)
                    Button(action: { state.addEntry() }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.accentColor)
                    }
                    .buttonStyle(.plain)
                    .disabled(state.newKey.isEmpty || state.newValue.isEmpty)
                }
            }
            .padding(8)
            .glassCard(cornerRadius: 8)

            HStack {
                Text("\(state.entries.count) secrets in macOS Keychain")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.secondary)
                Spacer()
                Button("Copy .env") { state.copyAllAsEnv() }
                    .buttonStyle(.plain)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(DSTheme.amberGradient)
                    .cornerRadius(4)
                    .disabled(state.entries.isEmpty)
            }

            ScrollView {
                VStack(spacing: 6) {
                    if state.entries.isEmpty {
                        Text("No secrets yet — add one above.")
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                            .padding(10)
                    }
                    ForEach(state.entries) { entry in
                        HStack {
                            Text(entry.key)
                                .font(.system(size: 10, weight: .bold, design: .monospaced))
                                .foregroundColor(.accentColor)
                                .frame(width: 120, alignment: .leading)
                                .lineLimit(1)

                            Text(state.isMasked ? String(repeating: "•", count: min(entry.value.count, 20)) : entry.value)
                                .font(.system(size: 10, design: .monospaced))
                                .lineLimit(1)
                                .foregroundColor(.secondary)

                            Spacer()

                            Button(action: { state.copyValue(entry) }) {
                                Image(systemName: "doc.on.doc")
                                    .font(.system(size: 10))
                                    .foregroundColor(.secondary)
                            }
                            .buttonStyle(.plain)

                            Button(action: { state.deleteEntry(entry) }) {
                                Image(systemName: "trash")
                                    .font(.system(size: 10))
                                    .foregroundColor(.red.opacity(0.75))
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(6)
                        .background(Color.primary.opacity(0.03))
                        .cornerRadius(6)
                    }
                }
            }
            .frame(maxHeight: 190)

            HStack {
                Text(state.statusMessage.isEmpty ? "Stored in the macOS Keychain, not on disk" : state.statusMessage)
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                Spacer()
                Button("Quit") { NSApp.terminate(nil) }
                    .buttonStyle(.plain)
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
        }
        .padding(14)
        .frame(width: 360, height: 440)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<EnvVaultView>?

    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = EnvVaultView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "lock.shield",
            titleText: "EnvVault",
            contentWidth: 360,
            contentHeight: 440
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
