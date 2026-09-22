import SwiftUI

struct AddressBar: View {
    @ObservedObject var model: FileBrowserModel
    @ObservedObject private var sidebar = SidebarStore.shared

    private var crumbs: [(name: String, url: URL)] {
        var result: [(String, URL)] = []
        var url = model.currentURL
        while true {
            let isRoot = url.path == "/"
            result.append((isRoot ? FileManager.default.displayName(atPath: "/") : url.lastPathComponent, url))
            if isRoot { break }
            url = url.deletingLastPathComponent()
        }
        return result.reversed()
    }

    // Breadcrumbs only — never hosts the editable TextField itself. SwiftUI's onExitCommand and focus
    // tracking don't reliably fire for a TextField placed inside a toolbar item on macOS (confirmed:
    // Escape and click-away silently failed to leave editing), so the actual path editor lives in
    // AddressEditBar, an overlay in the main content area, where those mechanisms are proven to work
    // (same pattern as RenameField). This view just shows breadcrumbs and asks the model to edit.
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: model.isInTrash ? "trash" : "folder")
                .foregroundStyle(.secondary)
            breadcrumbs
                .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                if sidebar.isPinned(model.currentURL) { sidebar.unpin(model.currentURL) } else { sidebar.pin(model.currentURL) }
            } label: {
                Image(systemName: sidebar.isPinned(model.currentURL) ? "star.fill" : "star")
                    .foregroundStyle(sidebar.isPinned(model.currentURL) ? Color.yellow : Color.secondary)
            }
            .buttonStyle(.plain)
            .help(sidebar.isPinned(model.currentURL) ? "Unpin from Quick access" : "Pin to Quick access")
        }
        .padding(.horizontal, 10)
        .frame(height: 26)
        .background(RoundedRectangle(cornerRadius: 7).fill(Color.primary.opacity(0.07)))
    }

    private var breadcrumbs: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 2) {
                ForEach(Array(crumbs.enumerated()), id: \.offset) { index, crumb in
                    if index > 0 {
                        Image(systemName: "chevron.right").font(.system(size: 8, weight: .semibold)).foregroundStyle(.tertiary)
                    }
                    CrumbButton(title: crumb.name, isLast: index == crumbs.count - 1) {
                        model.navigate(to: crumb.url)
                    }
                }
                Color.clear.frame(width: 40, height: 20)
                    .contentShape(Rectangle())
                    .onTapGesture { model.focusAddressBar() }
            }
        }
        .defaultScrollAnchor(.trailing)
        .contentShape(Rectangle())
        .onTapGesture { model.focusAddressBar() }
    }
}

/// The actual editable path field, shown as an overlay pinned to the top of the content area while
/// `model.isEditingPath` is true. Deliberately lives outside the window toolbar — see the note on
/// AddressBar above for why.
struct AddressEditBar: View {
    @ObservedObject var model: FileBrowserModel
    @State private var text = ""
    @FocusState private var focused: Bool

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "folder").foregroundStyle(.secondary)
            TextField("Path", text: $text)
                .textFieldStyle(.plain)
                .font(.system(size: 13))
                .focused($focused)
                .onSubmit {
                    model.isEditingPath = false
                    model.navigate(toPath: text)
                }
                .onExitCommand { model.cancelAddressEdit() }
                .onChange(of: focused) { _, isFocused in if !isFocused { model.cancelAddressEdit() } }
        }
        .padding(.horizontal, 12)
        .frame(height: 30)
        .background(RoundedRectangle(cornerRadius: 8).fill(.regularMaterial))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.accentColor, lineWidth: 1.5))
        .shadow(color: .black.opacity(0.25), radius: 8, y: 2)
        .padding(8)
        .onAppear {
            text = model.currentURL.path
            focused = true
            DispatchQueue.main.async { (NSApp.keyWindow?.firstResponder as? NSTextView)?.selectAll(nil) }
        }
    }
}

private struct CrumbButton: View {
    let title: String
    let isLast: Bool
    let action: () -> Void
    @State private var hovering = false

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 12, weight: isLast ? .semibold : .regular))
                .lineLimit(1)
                .padding(.horizontal, 5)
                .padding(.vertical, 2)
                .background(RoundedRectangle(cornerRadius: 4).fill(hovering ? Color.primary.opacity(0.12) : .clear))
        }
        .buttonStyle(.plain)
        .onHover { hovering = $0 }
    }
}
