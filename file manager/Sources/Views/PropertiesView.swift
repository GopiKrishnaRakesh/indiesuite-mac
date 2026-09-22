import SwiftUI

/// Explorer-style Properties dialog: general info, folder size, attributes, permissions.
struct PropertiesView: View {
    @ObservedObject var model: FileBrowserModel
    let urls: [URL]
    @Environment(\.dismiss) private var dismiss

    @State private var logicalSize: Int64 = 0
    @State private var onDisk: Int64 = 0
    @State private var fileCount = 0
    @State private var folderCount = 0
    @State private var calculating = true
    @State private var mode = 0
    @State private var owner = ""
    @State private var group = ""
    @State private var accessed: Date?
    @State private var hidden = false
    @State private var sizeTask: Task<Void, Never>?
    @State private var volumeFormat: String?

    private var single: URL? { urls.count == 1 ? urls.first : nil }
    private var item: FileItem? { single.map(FileItem.init) }
    /// A mounted volume's root (an external drive, "Macintosh HD", …) rather than an ordinary folder —
    /// its "size" is capacity/free-space math already sitting in SidebarStore, not a full recursive
    /// scan, which would otherwise walk the entire drive just to open this dialog. Matched against
    /// SidebarStore.volumes (not re-derived from a fresh single-key resourceValues fetch, which
    /// doesn't reliably populate .volumeIsRootFileSystemKey on its own) since that list's own batched
    /// fetch is already proven to work.
    private var matchedVolume: VolumeInfo? {
        guard let single else { return nil }
        return SidebarStore.shared.volumes.first { $0.url.path == single.path }
    }
    private var isVolumeRoot: Bool { matchedVolume != nil }

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    general
                    if single != nil && !isVolumeRoot { attributes; permissions }
                }
                .padding(18)
            }
            Divider()
            HStack {
                Button("Reveal in Finder") { model.reveal(urls) }
                Button("Copy Path") { model.copyPath(urls) }
                Spacer()
                Button("Close") { dismiss() }.keyboardShortcut(.defaultAction)
            }
            .padding(12)
        }
        .frame(width: 440, height: 560)
        .task { load() }
        .onDisappear { sizeTask?.cancel() }
    }

    // MARK: Sections
    private var header: some View {
        HStack(spacing: 14) {
            if let single {
                Image(nsImage: IconCache.icon(for: single)).resizable().frame(width: 56, height: 56)
                VStack(alignment: .leading, spacing: 2) {
                    Text(item?.name ?? "").font(.title3.weight(.semibold)).textSelection(.enabled).lineLimit(2)
                    Text(isVolumeRoot ? "Volume" : (item?.kind ?? "")).foregroundStyle(.secondary)
                }
            } else {
                Image(systemName: "square.stack.3d.up").font(.system(size: 40)).frame(width: 56, height: 56)
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(urls.count) items").font(.title3.weight(.semibold))
                    Text("Multiple selection").foregroundStyle(.secondary)
                }
            }
            Spacer()
        }
        .padding(18)
    }

    private var general: some View {
        section("General") {
            if isVolumeRoot {
                row("Capacity", Fmt.bytes(logicalSize))
                row("Available", Fmt.bytes(onDisk))
                row("Used", Fmt.bytes(logicalSize - onDisk))
                if let volumeFormat { row("Format", volumeFormat) }
            } else {
                if let single {
                    row("Location", single.deletingLastPathComponent().path)
                    if let target = try? FileManager.default.destinationOfSymbolicLink(atPath: single.path) { row("Alias to", target) }
                }
                row("Size", calculating ? "Calculating…" : Fmt.exactBytes(logicalSize))
                row("Size on disk", calculating ? "Calculating…" : Fmt.bytes(onDisk))
                if folderCount > 0 || fileCount > 0 || urls.count > 1 || (item?.isFolder ?? false) {
                    row("Contains", "\(fileCount.formatted()) files, \(folderCount.formatted()) folders")
                }
                if let item {
                    row("Created", Fmt.date(item.created))
                    row("Modified", Fmt.date(item.modified))
                    row("Accessed", Fmt.date(accessed))
                }
            }
        }
    }

    private var attributes: some View {
        section("Attributes") {
            Toggle("Hidden", isOn: Binding(get: { hidden }, set: { setHidden($0) }))
            if !owner.isEmpty { row("Owner", "\(owner) (group: \(group))") }
        }
    }

    private var permissions: some View {
        section("Permissions") {
            Grid(alignment: .leading, horizontalSpacing: 18, verticalSpacing: 6) {
                GridRow {
                    Text("")
                    Text("Read").font(.caption).foregroundStyle(.secondary)
                    Text("Write").font(.caption).foregroundStyle(.secondary)
                    Text("Execute").font(.caption).foregroundStyle(.secondary)
                }
                permissionRow("Owner", shift: 6)
                permissionRow("Group", shift: 3)
                permissionRow("Everyone", shift: 0)
            }
            Text("Mode: " + String(mode, radix: 8)).font(.caption).foregroundStyle(.secondary).monospaced()
        }
    }

    private func permissionRow(_ title: String, shift: Int) -> some View {
        GridRow {
            Text(title)
            ForEach([4, 2, 1], id: \.self) { bit in
                Toggle("", isOn: Binding(
                    get: { (mode >> shift) & bit != 0 },
                    set: { on in setMode(on ? mode | (bit << shift) : mode & ~(bit << shift)) }
                ))
                .labelsHidden()
            }
        }
    }

    private func section(_ title: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(.headline)
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func row(_ key: String, _ value: String) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text(key).foregroundStyle(.secondary).frame(width: 90, alignment: .leading)
            Text(value).textSelection(.enabled)
            Spacer(minLength: 0)
        }
    }

    // MARK: Data
    private func load() {
        if let volume = matchedVolume {
            logicalSize = volume.total
            onDisk = volume.available
            volumeFormat = try? single?.resourceValues(forKeys: [.volumeLocalizedFormatDescriptionKey]).volumeLocalizedFormatDescription
            calculating = false
            return
        }
        if let single {
            let attrs = try? FileManager.default.attributesOfItem(atPath: single.path)
            mode = (attrs?[.posixPermissions] as? Int) ?? 0
            owner = (attrs?[.ownerAccountName] as? String) ?? ""
            group = (attrs?[.groupOwnerAccountName] as? String) ?? ""
            let values = try? single.resourceValues(forKeys: [.contentAccessDateKey, .isHiddenKey])
            accessed = values?.contentAccessDate
            hidden = values?.isHidden ?? false
        }
        let targets = urls
        sizeTask = Task {
            let totals = await Task.detached { Self.measure(targets) }.value
            guard !Task.isCancelled else { return }
            (logicalSize, onDisk, fileCount, folderCount) = totals
            calculating = false
        }
    }

    nonisolated static func measure(_ urls: [URL]) -> (Int64, Int64, Int, Int) {
        var logical: Int64 = 0, disk: Int64 = 0, files = 0, folders = 0
        let fm = FileManager.default
        let keys: [URLResourceKey] = [.isDirectoryKey, .fileSizeKey, .totalFileAllocatedSizeKey]
        for url in urls {
            let v = try? url.resourceValues(forKeys: Set(keys))
            if v?.isDirectory == true {
                if let e = fm.enumerator(at: url, includingPropertiesForKeys: keys, options: []) {
                    for case let child as URL in e {
                        if Task.isCancelled { return (logical, disk, files, folders) }
                        let cv = try? child.resourceValues(forKeys: Set(keys))
                        if cv?.isDirectory == true { folders += 1 } else {
                            files += 1
                            logical += Int64(cv?.fileSize ?? 0)
                            disk += Int64(cv?.totalFileAllocatedSize ?? 0)
                        }
                    }
                }
            } else {
                files += 1
                logical += Int64(v?.fileSize ?? 0)
                disk += Int64(v?.totalFileAllocatedSize ?? 0)
            }
        }
        return (logical, disk, files, folders)
    }

    private func setMode(_ newMode: Int) {
        guard let single else { return }
        do {
            try FileManager.default.setAttributes([.posixPermissions: newMode], ofItemAtPath: single.path)
            mode = newMode
        } catch {
            model.errorMessage = "Couldn't change permissions: \(error.localizedDescription)"
        }
    }

    private func setHidden(_ value: Bool) {
        guard var url = single else { return }
        var values = URLResourceValues()
        values.isHidden = value
        do {
            try url.setResourceValues(values)
            hidden = value
            model.refresh()
        } catch {
            model.errorMessage = "Couldn't change the hidden attribute: \(error.localizedDescription)"
        }
    }
}
