import AppKit
import SwiftUI

/// macOS Finder signature Path Bar (Path Breadcrumb).
/// Sits along the bottom, displaying hierarchical path components with native icons,
/// drag & drop destination for moving files, and quick actions.
struct PathBar: View {
    @ObservedObject var model: FileBrowserModel

    private var crumbs: [(name: String, url: URL, icon: String)] {
        var result: [(String, URL, String)] = []
        var url = model.currentURL
        while true {
            let isRoot = url.path == "/"
            let name = isRoot ? FileManager.default.displayName(atPath: "/") : url.lastPathComponent
            let icon = iconName(for: url)
            result.append((name, url, icon))
            if isRoot { break }
            url = url.deletingLastPathComponent()
        }
        return result.reversed()
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 4) {
                ForEach(Array(crumbs.enumerated()), id: \.offset) { index, crumb in
                    if index > 0 {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 8, weight: .bold))
                            .foregroundStyle(.tertiary)
                    }

                    CrumbSegment(crumb: crumb, isLast: index == crumbs.count - 1, model: model)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 3)
        }
        .frame(height: 24)
        .background(Color.primary.opacity(0.04))
        .overlay(alignment: .top) {
            Divider()
        }
    }

    private func iconName(for url: URL) -> String {
        if url.path == "/" { return "internaldrive" }
        if url.path.hasPrefix("/Volumes/") { return "externaldrive" }
        if url == SidebarStore.home { return "house.fill" }
        if url.path == SidebarStore.home.appendingPathComponent("Desktop").path { return "menubar.dock.rectangle" }
        if url.path == SidebarStore.home.appendingPathComponent("Documents").path { return "doc.text" }
        if url.path == SidebarStore.home.appendingPathComponent("Downloads").path { return "arrow.down.circle" }
        if url.path == SidebarStore.home.appendingPathComponent("Pictures").path { return "photo" }
        return "folder.fill"
    }
}

private struct CrumbSegment: View {
    let crumb: (name: String, url: URL, icon: String)
    let isLast: Bool
    @ObservedObject var model: FileBrowserModel
    @State private var isHovering = false

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: crumb.icon)
                .font(.system(size: 10))
                .foregroundStyle(isLast ? Color.accentColor : Color.secondary)

            Text(crumb.name)
                .font(.system(size: 11, weight: isLast ? .semibold : .regular))
                .foregroundStyle(isLast ? Color.primary : Color.secondary)
                .lineLimit(1)
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 2)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(isHovering ? Color.primary.opacity(0.08) : Color.clear)
        )
        .contentShape(Rectangle())
        .onHover { isHovering = $0 }
        .onTapGesture {
            model.navigate(to: crumb.url)
        }
        .dropDestination(for: URL.self) { urls, _ in
            model.drop(urls, into: crumb.url)
            return true
        }
        .contextMenu {
            Button("Open “\(crumb.name)”") {
                model.navigate(to: crumb.url)
            }
            Button("Reveal in Finder") {
                model.reveal([crumb.url])
            }
            Button("Open in Terminal") {
                model.openInTerminal(crumb.url)
            }
            Divider()
            Button("Copy Path") {
                model.copyPath([crumb.url])
            }
        }
    }
}
