import SwiftUI

/// Windows Explorer → Pathway keyboard cheat sheet.
struct ShortcutsView: View {
    private struct Entry: Identifiable { let id = UUID(); let keys: String; let windows: String; let action: String }
    private struct Group: Identifiable { let id = UUID(); let title: String; let entries: [Entry] }

    private let groups: [Group] = [
        Group(title: "Navigate", entries: [
            Entry(keys: "⌫  or  ⌥←", windows: "Backspace / Alt+←", action: "Back to the previous folder"),
            Entry(keys: "⌥→  or  ⌘]", windows: "Alt+→", action: "Forward"),
            Entry(keys: "⌥↑  or  ⌘↑", windows: "Alt+↑", action: "Up one level"),
            Entry(keys: "↩  or  ⌘↓", windows: "Enter", action: "Open selected file or folder"),
            Entry(keys: "⌘L  or  F4", windows: "Ctrl+L / F4", action: "Edit the address bar"),
            Entry(keys: "⇧⌘H  or  ⌥Home", windows: "Alt+Home", action: "Go to Home folder"),
            Entry(keys: "F5  or  ⌘R", windows: "F5", action: "Refresh"),
        ]),
        Group(title: "Files", entries: [
            Entry(keys: "F2", windows: "F2", action: "Rename (inline)"),
            Entry(keys: "Delete  or  ⌘⌫", windows: "Delete", action: "Move to Trash"),
            Entry(keys: "⇧Delete", windows: "Shift+Delete", action: "Delete permanently (asks first)"),
            Entry(keys: "⌘X / ⌘C / ⌘V", windows: "Ctrl+X / C / V", action: "Cut, copy, paste (cut moves the files)"),
            Entry(keys: "⌘Z", windows: "Ctrl+Z", action: "Undo the last file operation"),
            Entry(keys: "⇧⌘N", windows: "Ctrl+Shift+N", action: "New folder"),
            Entry(keys: "⌘D", windows: "—", action: "Duplicate"),
            Entry(keys: "⌥↩  or  ⌘I", windows: "Alt+Enter", action: "Properties"),
            Entry(keys: "Space", windows: "—", action: "Quick Look preview"),
            Entry(keys: "⌥⌘C", windows: "Ctrl+Shift+C", action: "Copy path"),
        ]),
        Group(title: "Select", entries: [
            Entry(keys: "⌘A", windows: "Ctrl+A", action: "Select all"),
            Entry(keys: "⌥⌘A", windows: "—", action: "Invert selection"),
            Entry(keys: "⇧ + ↑ ↓", windows: "Shift+↑↓", action: "Extend selection"),
            Entry(keys: "⌘ + click", windows: "Ctrl+click", action: "Toggle one item"),
            Entry(keys: "Type letters", windows: "Type to jump", action: "Jump to the item starting with those letters"),
            Entry(keys: "Esc", windows: "Esc", action: "Clear selection or search"),
        ]),
        Group(title: "View & search", entries: [
            Entry(keys: "⌘F  or  F3", windows: "Ctrl+F / F3", action: "Search (this folder or subfolders)"),
            Entry(keys: "⌘1 / ⌘2 / ⌘3", windows: "Ctrl+Shift+1…", action: "Details / Icons / Tiles"),
            Entry(keys: "⌥⌘P", windows: "Alt+P", action: "Toggle preview pane"),
            Entry(keys: "⇧⌘.", windows: "—", action: "Show hidden files"),
            Entry(keys: "⌘+  /  ⌘−", windows: "Ctrl+scroll", action: "Bigger / smaller icons"),
        ]),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Keyboard Shortcuts").font(.largeTitle.weight(.bold))
                ForEach(groups) { group in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(group.title).font(.headline)
                        ForEach(group.entries) { e in
                            HStack(alignment: .firstTextBaseline) {
                                Text(e.keys).font(.system(.body, design: .monospaced)).frame(width: 170, alignment: .leading)
                                Text(e.action)
                                Spacer()
                                Text(e.windows).font(.caption).foregroundStyle(.secondary)
                            }
                            Divider()
                        }
                    }
                }
            }
            .padding(24)
        }
        .frame(width: 640, height: 640)
    }
}
