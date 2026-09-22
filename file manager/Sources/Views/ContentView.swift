import SwiftUI

struct ContentView: View {
    @StateObject private var model = FileBrowserModel(start: ContentView.launchURL)
    @State private var columnVisibility = NavigationSplitViewVisibility.all
    @FocusState private var searchFocused: Bool

    /// `-startPath /some/folder` launch argument (handy for testing and scripting).
    static var launchURL: URL {
        if let path = UserDefaults.standard.string(forKey: "startPath") {
            return URL(fileURLWithPath: (path as NSString).expandingTildeInPath, isDirectory: true)
        }
        return FileManager.default.homeDirectoryForCurrentUser
    }

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            SidebarView(model: model)
                .navigationSplitViewColumnWidth(min: 190, ideal: 230, max: 340)
        } detail: {
            VStack(spacing: 0) {
                CommandBar(model: model)
                Divider()
                FileListArea(model: model)
                Divider()
                StatusBar(model: model)
            }
            .inspector(isPresented: $model.showPreview) {
                PreviewPane(model: model)
                    .inspectorColumnWidth(min: 240, ideal: 300, max: 520)
            }
        }
        .navigationTitle(model.title)
        .toolbar {
            ToolbarItemGroup(placement: .navigation) {
                Button { model.goBack() } label: { Label("Back", systemImage: "chevron.left") }
                    .disabled(!model.canGoBack)
                    .help("Back (Backspace)")
                Button { model.goForward() } label: { Label("Forward", systemImage: "chevron.right") }
                    .disabled(!model.canGoForward)
                    .help("Forward (⌥→)")
                Button { model.goUp() } label: { Label("Up", systemImage: "chevron.up") }
                    .disabled(!model.canGoUp)
                    .help("Up one level (⌘↑)")
            }
            ToolbarItem(placement: .principal) {
                AddressBar(model: model)
                    .frame(minWidth: 320, idealWidth: 560, maxWidth: .infinity)
            }
        }
        .searchable(text: $model.searchText, placement: .toolbar, prompt: "Search \(model.title)")
        .searchFocused($searchFocused)
        .searchScopes($model.searchRecursive) {
            Text("This Folder").tag(false)
            Text("Subfolders").tag(true)
        }
        .onChange(of: model.searchFocusToken) { _, _ in searchFocused = true }
        .focusedSceneObject(model)
        .background(WindowAccessor { model.attach($0) })
        .sheet(item: $model.sheet) { sheet in
            switch sheet {
            case .properties(let urls): PropertiesView(model: model, urls: urls)
            }
        }
        .alert("Pathway", isPresented: Binding(get: { model.errorMessage != nil }, set: { if !$0 { model.errorMessage = nil } })) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(model.errorMessage ?? "")
        }
        .confirmationDialog(
            deleteTitle,
            isPresented: Binding(get: { model.pendingPermanentDelete != nil }, set: { if !$0 { model.pendingPermanentDelete = nil } }),
            titleVisibility: .visible
        ) {
            Button("Delete Permanently", role: .destructive) { model.confirmPermanentDelete() }
            Button("Cancel", role: .cancel) { model.pendingPermanentDelete = nil }
        } message: {
            Text("This can't be undone.")
        }
        .frame(minWidth: 760, minHeight: 440)
        .onAppear { KeyMonitor.shared.install() }
    }

    private var deleteTitle: String {
        let list = model.pendingPermanentDelete ?? []
        return list.count == 1 ? "Permanently delete “\(list[0].lastPathComponent)”?" : "Permanently delete \(list.count) items?"
    }
}

/// Details / Icons / Tiles + drop target for the current folder.
struct FileListArea: View {
    @ObservedObject var model: FileBrowserModel

    var body: some View {
        ZStack {
            switch model.viewMode {
            case .details: DetailsTableView(model: model)
            case .icons, .tiles: IconGridView(model: model)
            }
            if model.displayItems.isEmpty && !model.isLoading {
                emptyState
            }
        }
        .dropDestination(for: URL.self) { urls, _ in
            model.drop(urls, into: model.currentURL)
            return true
        }
    }

    @ViewBuilder private var emptyState: some View {
        if model.isSearching {
            ProgressView("Searching…").padding()
        } else if !model.searchText.isEmpty {
            ContentUnavailableView.search(text: model.searchText)
        } else {
            ContentUnavailableView("This folder is empty", systemImage: "folder", description: Text("Drop files here or press ⇧⌘N to create a folder."))
        }
    }
}
