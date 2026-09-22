import SwiftUI

@main
struct PathwayApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .defaultSize(width: 1180, height: 720)
        .windowToolbarStyle(.unified)
        .commands { PathwayCommands() }

        Window("Keyboard Shortcuts", id: "shortcuts") {
            ShortcutsView()
        }
        .windowResizability(.contentSize)
    }
}

struct PathwayCommands: Commands {
    @FocusedObject private var model: FileBrowserModel?
    @Environment(\.openWindow) private var openWindow

    var body: some Commands {
        // File
        CommandGroup(after: .newItem) {
            Button("New Folder") { model?.newFolder() }.keyboardShortcut("n", modifiers: [.command, .shift])
            Button("New Text Document") { model?.newTextFile() }.keyboardShortcut("n", modifiers: [.command, .option])
            Divider()
            Button("Open") { model?.openSelection() }.keyboardShortcut(.downArrow, modifiers: .command)
            Button("Rename") { model?.beginRename() }
            Button("Duplicate") { model?.duplicate() }.keyboardShortcut("d")
            Button("Compress") { model?.compress() }
            Button("Quick Look") { model?.toggleQuickLook() }
            Button("Properties") { model?.showProperties() }.keyboardShortcut("i")
            Divider()
            Button("Move to Trash") {
                TextGuard.perform(#selector(NSResponder.deleteToBeginningOfLine(_:))) { model?.trash() }
            }.keyboardShortcut(.delete, modifiers: .command)
            Button("Delete Permanently…") { model?.requestPermanentDelete() }
            Divider()
            Button("Reveal in Finder") { model?.reveal() }.keyboardShortcut("r", modifiers: [.command, .shift])
            Button("Open in Terminal") { model?.openInTerminal() }.keyboardShortcut("t", modifiers: [.command, .option])
        }

        // Edit
        CommandGroup(replacing: .undoRedo) {
            Button("Undo") { TextGuard.perform(Selector(("undo:"))) { model?.undo() } }
                .keyboardShortcut("z")
        }
        CommandGroup(replacing: .pasteboard) {
            Button("Cut") { TextGuard.perform(#selector(NSText.cut(_:))) { model?.cut() } }.keyboardShortcut("x")
            Button("Copy") { TextGuard.perform(#selector(NSText.copy(_:))) { model?.copy() } }.keyboardShortcut("c")
            Button("Paste") { TextGuard.perform(#selector(NSText.paste(_:))) { model?.paste() } }.keyboardShortcut("v")
            Button("Copy Path") { model?.copyPath() }.keyboardShortcut("c", modifiers: [.command, .option])
            Divider()
            Button("Select All") { TextGuard.perform(#selector(NSText.selectAll(_:))) { model?.selectAll() } }.keyboardShortcut("a")
            Button("Invert Selection") { model?.invertSelection() }.keyboardShortcut("a", modifiers: [.command, .option])
            Button("Select None") { model?.selectNone() }
        }

        // View
        CommandGroup(before: .toolbar) {
            Button("Details") { model?.viewMode = .details }.keyboardShortcut("1")
            Button("Icons") { model?.viewMode = .icons }.keyboardShortcut("2")
            Button("Tiles") { model?.viewMode = .tiles }.keyboardShortcut("3")
            Divider()
            Menu("Sort By") {
                ForEach(SortField.allCases) { field in
                    Button(field.title + (model?.currentSortField == field ? (model?.sortAscending == true ? "  ▲" : "  ▼") : "")) {
                        model?.setSort(field)
                    }
                }
                Divider()
                Button("Ascending") { model?.setSortDirection(ascending: true) }
                Button("Descending") { model?.setSortDirection(ascending: false) }
            }
            Toggle("Show Hidden Files", isOn: Binding(get: { model?.showHidden ?? false }, set: { model?.showHidden = $0 }))
                .keyboardShortcut(".", modifiers: [.command, .shift])
            Toggle("Folders on Top", isOn: Binding(get: { model?.foldersFirst ?? true }, set: { model?.foldersFirst = $0 }))
            Toggle("Preview Pane", isOn: Binding(get: { model?.showPreview ?? false }, set: { model?.showPreview = $0 }))
                .keyboardShortcut("p", modifiers: [.command, .option])
            Button("Bigger Icons") { model?.iconSize = min((model?.iconSize ?? 64) + 16, 128) }.keyboardShortcut("+")
            Button("Smaller Icons") { model?.iconSize = max((model?.iconSize ?? 64) - 16, 32) }.keyboardShortcut("-")
            Button("Refresh") { model?.refresh() }.keyboardShortcut("r")
            Divider()
        }

        // Go
        CommandMenu("Go") {
            Button("Back") { model?.goBack() }.keyboardShortcut("[").disabled(model?.canGoBack != true)
            Button("Forward") { model?.goForward() }.keyboardShortcut("]").disabled(model?.canGoForward != true)
            Button("Enclosing Folder") { model?.goUp() }.keyboardShortcut(.upArrow, modifiers: .command).disabled(model?.canGoUp != true)
            Divider()
            Button("Home") { model?.goHome() }.keyboardShortcut("h", modifiers: [.command, .shift])
            Button("Desktop") { model?.navigate(to: SidebarStore.home.appendingPathComponent("Desktop")) }.keyboardShortcut("d", modifiers: [.command, .shift])
            Button("Documents") { model?.navigate(to: SidebarStore.home.appendingPathComponent("Documents")) }.keyboardShortcut("o", modifiers: [.command, .shift])
            Button("Downloads") { model?.navigate(to: SidebarStore.home.appendingPathComponent("Downloads")) }.keyboardShortcut("l", modifiers: [.command, .option])
            Button("Applications") { model?.goTo("/Applications") }.keyboardShortcut("a", modifiers: [.command, .shift])
            Button("This Mac") { model?.goTo("/") }.keyboardShortcut("c", modifiers: [.command, .shift])
            Divider()
            Button("Go to Folder…") { model?.focusAddressBar() }.keyboardShortcut("g", modifiers: [.command, .shift])
            Button("Address Bar") { model?.focusAddressBar() }.keyboardShortcut("l")
            Button("Search") { model?.focusSearch() }.keyboardShortcut("f")
            Divider()
            ForEach(SidebarStore.shared.recents.prefix(8), id: \.self) { url in
                Button(url.lastPathComponent.isEmpty ? url.path : url.lastPathComponent) { model?.navigate(to: url) }
            }
        }

        // Help
        CommandGroup(replacing: .help) {
            Button("Keyboard Shortcuts") { openWindow(id: "shortcuts") }.keyboardShortcut("/")
        }
    }
}
