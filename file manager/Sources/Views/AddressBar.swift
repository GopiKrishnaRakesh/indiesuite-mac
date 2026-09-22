import SwiftUI

struct AddressBar: View {
    @ObservedObject var model: FileBrowserModel
    @ObservedObject private var sidebar = SidebarStore.shared
    @State private var text = ""
    @FocusState private var focused: Bool

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

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: model.isInTrash ? "trash" : "folder")
                .foregroundStyle(.secondary)
            ZStack(alignment: .leading) {
                if model.isEditingPath {
                    TextField("Path", text: $text)
                        .textFieldStyle(.plain)
                        .focused($focused)
                        .onSubmit {
                            model.isEditingPath = false
                            model.navigate(toPath: text)
                        }
                        .onExitCommand {
                            model.isEditingPath = false
                            model.focusFileList()
                        }
                        .onAppear {
                            text = model.currentURL.path
                            focused = true
                            DispatchQueue.main.async { (NSApp.keyWindow?.firstResponder as? NSTextView)?.selectAll(nil) }
                        }
                        .onChange(of: focused) { _, isFocused in if !isFocused { model.isEditingPath = false } }
                } else {
                    breadcrumbs
                }
            }
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
        .overlay(RoundedRectangle(cornerRadius: 7).stroke(model.isEditingPath ? Color.accentColor : .clear, lineWidth: 1.5))
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
