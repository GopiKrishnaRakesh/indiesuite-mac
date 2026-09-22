import AppKit
import SwiftUI

struct SidebarView: View {
    @ObservedObject var model: FileBrowserModel
    @ObservedObject private var store = SidebarStore.shared

    private var selection: Binding<URL?> {
        Binding(
            get: {
                let c = model.currentURL
                let known = store.pinned.contains(c) || store.volumes.contains { $0.url == c } || c == SidebarStore.trash
                return known ? c : nil
            },
            set: { if let url = $0 { model.navigate(to: url) } }
        )
    }

    var body: some View {
        List(selection: selection) {
            Section("Quick access") {
                ForEach(store.pinned, id: \.self) { url in
                    Label(name(for: url), systemImage: symbol(for: url))
                        .tag(url)
                        .dropDestination(for: URL.self) { urls, _ in model.drop(urls, into: url); return true }
                        .contextMenu {
                            Button("Open") { model.navigate(to: url) }
                            Button("Reveal in Finder") { model.reveal([url]) }
                            Divider()
                            Button("Unpin from Quick access") { store.unpin(url) }
                        }
                }
                .onMove { store.movePinned(from: $0, to: $1) }
            }
            .dropDestination(for: URL.self) { urls, _ in
                for url in urls where (try? url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) == true { store.pin(url) }
                return true
            }

            Section("This Mac") {
                ForEach(store.visibleVolumes) { volume in
                    VolumeRow(volume: volume)
                        .tag(volume.url)
                        .contextMenu {
                            Button("Open") { model.navigate(to: volume.url) }
                            Button("Reveal in Finder") { model.reveal([volume.url]) }
                            Divider()
                            Button("Rename…") { promptRenameVolume(volume) }
                            if volume.isEjectable {
                                Button("Eject “\(volume.name)”") { ejectVolume(volume) }
                            }
                            Divider()
                            Button("Copy Path") { model.copyPath([volume.url]) }
                            Button("Get Info") { model.showProperties([volume.url]) }
                            // Never offered for the boot/internal drive — reformatting the wrong disk
                            // here would be catastrophic and there's no undo.
                            if volume.isEjectable {
                                Divider()
                                Button("Format…", role: .destructive) { promptFormatVolume(volume) }
                            }
                            Divider()
                            Button("Remove from Sidebar") { store.hideVolume(volume.url) }
                        }
                }
                Label("Trash", systemImage: "trash")
                    .tag(SidebarStore.trash)
                    .contextMenu {
                        Button("Open") { model.navigate(to: SidebarStore.trash) }
                        Button("Reveal in Finder") { model.reveal([SidebarStore.trash]) }
                    }
            }

            if !recents.isEmpty {
                Section("Recent") {
                    ForEach(recents, id: \.self) { url in
                        Label(name(for: url), systemImage: "clock")
                            .contentShape(Rectangle())
                            .onTapGesture { model.navigate(to: url) }
                            .contextMenu {
                                Button("Open") { model.navigate(to: url) }
                                Button("Reveal in Finder") { model.reveal([url]) }
                                Divider()
                                Button(store.isPinned(url) ? "Unpin from Quick access" : "Pin to Quick access") {
                                    if store.isPinned(url) { store.unpin(url) } else { store.pin(url) }
                                }
                            }
                    }
                }
            }

            Section("Folders") {
                FolderTreeNode(url: SidebarStore.home, title: NSUserName(), model: model, startExpanded: true)
            }
        }
        .listStyle(.sidebar)
    }

    private var recents: [URL] {
        store.recents.filter { !store.pinned.contains($0) && $0 != model.currentURL }.prefix(6).map { $0 }
    }

    private func name(for url: URL) -> String {
        url == SidebarStore.home ? "Home" : url.lastPathComponent
    }

    private func ejectVolume(_ volume: VolumeInfo) {
        do {
            try NSWorkspace.shared.unmountAndEjectDevice(at: volume.url)
            if FileOps.isInside(model.currentURL, of: volume.url) { model.goHome() }
        } catch {
            model.errorMessage = "Couldn't eject “\(volume.name)”: \(error.localizedDescription)"
        }
    }

    private func promptRenameVolume(_ volume: VolumeInfo) {
        let alert = NSAlert()
        alert.messageText = "Rename “\(volume.name)”"
        alert.informativeText = "Enter a new name for this volume."
        alert.addButton(withTitle: "Rename")
        alert.addButton(withTitle: "Cancel")
        let field = NSTextField(frame: NSRect(x: 0, y: 0, width: 240, height: 24))
        field.stringValue = volume.name
        alert.accessoryView = field
        alert.window.initialFirstResponder = field
        guard alert.runModal() == .alertFirstButtonReturn else { return }
        let newName = field.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !newName.isEmpty, newName != volume.name else { return }
        let wasCurrent = FileOps.isInside(model.currentURL, of: volume.url)
        let volumeURL = volume.url
        Task {
            // The mount point itself is derived from the volume's name, so renaming it via diskutil
            // unmounts and remounts under /Volumes/<newName> — there's no way to rename in place.
            let error = await Task.detached { FileOps.renameVolume(volumeURL, to: newName) }.value
            if let error {
                model.errorMessage = "Couldn't rename “\(volume.name)”: \(error)"
                return
            }
            store.refreshVolumes()
            if wasCurrent {
                model.navigate(to: URL(fileURLWithPath: "/Volumes/\(newName)", isDirectory: true), force: true)
            }
        }
    }

    /// Erases and reformats a volume. Deliberately two separate alerts, not one: a plain warning first
    /// (nothing to misclick past in a hurry), then the actual name/format choice — matching how
    /// destructive an irreversible whole-drive erase is, versus the app's other one-step confirmations.
    private func promptFormatVolume(_ volume: VolumeInfo) {
        let warning = NSAlert()
        warning.alertStyle = .critical
        warning.messageText = "Erase “\(volume.name)”?"
        warning.informativeText = "This permanently deletes everything on this drive. This can't be undone."
        warning.addButton(withTitle: "Continue")
        warning.addButton(withTitle: "Cancel")
        guard warning.runModal() == .alertFirstButtonReturn else { return }

        let formats: [(label: String, diskutilName: String)] = [
            ("APFS", "APFS"),
            ("Mac OS Extended (Journaled)", "JHFS+"),
            ("ExFAT (Windows/Mac)", "ExFAT"),
            ("MS-DOS FAT32 (Windows/Mac)", "MS-DOS"),
        ]
        let alert = NSAlert()
        alert.messageText = "Format “\(volume.name)”"
        alert.informativeText = "Choose a name and format for the erased volume."
        alert.addButton(withTitle: "Erase")
        alert.addButton(withTitle: "Cancel")

        let nameField = NSTextField(frame: NSRect(x: 0, y: 32, width: 260, height: 24))
        nameField.stringValue = volume.name
        let formatPopup = NSPopUpButton(frame: NSRect(x: 0, y: 0, width: 260, height: 24))
        formatPopup.addItems(withTitles: formats.map(\.label))
        let container = NSView(frame: NSRect(x: 0, y: 0, width: 260, height: 60))
        container.addSubview(nameField)
        container.addSubview(formatPopup)
        alert.accessoryView = container
        alert.window.initialFirstResponder = nameField

        guard alert.runModal() == .alertFirstButtonReturn else { return }
        let newName = nameField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !newName.isEmpty else { return }
        let format = formats[formatPopup.indexOfSelectedItem].diskutilName
        let wasCurrent = FileOps.isInside(model.currentURL, of: volume.url)
        let volumeURL = volume.url
        if wasCurrent { model.goHome() }
        Task {
            let error = await Task.detached { FileOps.eraseVolume(volumeURL, format: format, name: newName) }.value
            if let error {
                model.errorMessage = "Couldn't erase “\(volume.name)”: \(error)"
            }
            store.refreshVolumes()
        }
    }

    private func symbol(for url: URL) -> String {
        switch url.path {
        case SidebarStore.home.path: return "house"
        case SidebarStore.home.appendingPathComponent("Desktop").path: return "menubar.dock.rectangle"
        case SidebarStore.home.appendingPathComponent("Documents").path: return "doc.text"
        case SidebarStore.home.appendingPathComponent("Downloads").path: return "arrow.down.circle"
        case SidebarStore.home.appendingPathComponent("Pictures").path: return "photo"
        case SidebarStore.home.appendingPathComponent("Music").path: return "music.note"
        case SidebarStore.home.appendingPathComponent("Movies").path: return "film"
        case "/Applications": return "square.grid.2x2"
        default: return "folder"
        }
    }
}

private struct VolumeRow: View {
    let volume: VolumeInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Label(volume.name, systemImage: volume.isEjectable ? "externaldrive" : "internaldrive")
            if volume.total > 0 {
                // Not part of the hit-test area on its own (an NSProgressIndicator can eat clicks),
                // which is why right-click silently did nothing when it landed on the bar or the
                // free-space text below it — .contentShape below forces the whole row, gaps included,
                // to answer right-clicks as one unit instead.
                ProgressView(value: volume.usedFraction)
                    .progressViewStyle(.linear)
                    .tint(volume.usedFraction > 0.9 ? .red : .accentColor)
                    .controlSize(.mini)
                    .allowsHitTesting(false)
                Text("\(Fmt.bytes(volume.available)) free of \(Fmt.bytes(volume.total))")
                    .font(.system(size: 10))
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 2)
        .contentShape(Rectangle())
    }
}

/// Lazily-loaded folder tree (the Windows "navigation pane").
struct FolderTreeNode: View {
    let url: URL
    var title: String?
    @ObservedObject var model: FileBrowserModel
    var startExpanded = false
    @State private var expanded = false
    @State private var children: [URL]?

    var body: some View {
        DisclosureGroup(isExpanded: $expanded) {
            if let children {
                ForEach(children, id: \.self) { child in
                    FolderTreeNode(url: child, model: model)
                }
            }
        } label: {
            Label(title ?? url.lastPathComponent, systemImage: url == SidebarStore.home ? "house.fill" : "folder")
                .fontWeight(model.currentURL == url ? .semibold : .regular)
                .contentShape(Rectangle())
                .onTapGesture { model.navigate(to: url) }
                .dropDestination(for: URL.self) { urls, _ in model.drop(urls, into: url); return true }
                .contextMenu {
                    Button("Open") { model.navigate(to: url) }
                    Button("Reveal in Finder") { model.reveal([url]) }
                    Divider()
                    Button(SidebarStore.shared.isPinned(url) ? "Unpin from Quick access" : "Pin to Quick access") {
                        if SidebarStore.shared.isPinned(url) { SidebarStore.shared.unpin(url) } else { SidebarStore.shared.pin(url) }
                    }
                    Button("Open in Terminal") { model.openInTerminal(url) }
                    Divider()
                    Button("Copy Path") { model.copyPath([url]) }
                    Button("Properties") { model.showProperties([url]) }
                }
        }
        .onChange(of: expanded) { _, isOpen in if isOpen { loadChildren() } }
        .onAppear { if startExpanded && !expanded { expanded = true } }
    }

    private func loadChildren() {
        guard children == nil else { return }
        let parent = url
        Task {
            let found = await Task.detached { () -> [URL] in
                let urls = (try? FileManager.default.contentsOfDirectory(
                    at: parent,
                    includingPropertiesForKeys: [.isDirectoryKey, .isPackageKey],
                    options: [.skipsHiddenFiles]
                )) ?? []
                return urls.filter {
                    let v = try? $0.resourceValues(forKeys: [.isDirectoryKey, .isPackageKey])
                    return (v?.isDirectory ?? false) && !(v?.isPackage ?? false)
                }
                .sorted { $0.lastPathComponent.localizedStandardCompare($1.lastPathComponent) == .orderedAscending }
            }.value
            children = found
        }
    }
}
