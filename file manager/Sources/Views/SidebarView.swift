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
                ForEach(store.volumes) { volume in
                    VolumeRow(volume: volume)
                        .tag(volume.url)
                        .contextMenu {
                            Button("Open") { model.navigate(to: volume.url) }
                            if volume.isEjectable {
                                Button("Eject") { try? NSWorkspace.shared.unmountAndEjectDevice(at: volume.url) }
                            }
                        }
                }
                Label("Trash", systemImage: "trash")
                    .tag(SidebarStore.trash)
            }

            if !recents.isEmpty {
                Section("Recent") {
                    ForEach(recents, id: \.self) { url in
                        Label(name(for: url), systemImage: "clock")
                            .contentShape(Rectangle())
                            .onTapGesture { model.navigate(to: url) }
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
                ProgressView(value: volume.usedFraction)
                    .progressViewStyle(.linear)
                    .tint(volume.usedFraction > 0.9 ? .red : .accentColor)
                    .controlSize(.mini)
                Text("\(Fmt.bytes(volume.available)) free of \(Fmt.bytes(volume.total))")
                    .font(.system(size: 10))
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 2)
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
