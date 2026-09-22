import SwiftUI

/// Explorer-style ribbon: New, Cut/Copy/Paste, Rename, Delete, Sort, View, Preview.
struct CommandBar: View {
    @ObservedObject var model: FileBrowserModel
    @ObservedObject private var clipboard = ClipboardState.shared

    private var hasSelection: Bool { !model.selection.isEmpty }
    private var single: Bool { model.selection.count == 1 }

    var body: some View {
        HStack(spacing: 2) {
            Menu {
                Button("Folder", systemImage: "folder.badge.plus") { model.newFolder() }
                Button("Text Document", systemImage: "doc.badge.plus") { model.newTextFile() }
            } label: {
                Label("New", systemImage: "plus.circle.fill")
            }
            .menuStyle(.borderlessButton)
            .fixedSize()
            .help("New (⇧⌘N for folder)")

            divider
            tool("scissors", "Cut (⌘X)", enabled: hasSelection) { model.cut() }
            tool("doc.on.doc", "Copy (⌘C)", enabled: hasSelection) { model.copy() }
            tool("doc.on.clipboard", "Paste (⌘V)", enabled: clipboard.canPaste) { model.paste() }
            tool("pencil", "Rename (F2)", enabled: single) { model.beginRename() }
            tool("trash", "Move to Trash (Delete)", enabled: hasSelection) { model.trash() }
            divider

            Menu {
                ForEach(SortField.allCases) { field in
                    Button {
                        model.setSort(field)
                    } label: {
                        if field == model.currentSortField {
                            Label(field.title, systemImage: model.sortAscending ? "chevron.up" : "chevron.down")
                        } else {
                            Text(field.title)
                        }
                    }
                }
                Divider()
                Toggle("Folders on top", isOn: $model.foldersFirst)
            } label: {
                Label("Sort", systemImage: "arrow.up.arrow.down")
            }
            .menuStyle(.borderlessButton)
            .fixedSize()

            Menu {
                Picker("View", selection: $model.viewMode) {
                    ForEach(ViewMode.allCases) { Label($0.title, systemImage: $0.symbol).tag($0) }
                }.pickerStyle(.inline)
                Divider()
                Toggle("Show hidden files", isOn: $model.showHidden)
            } label: {
                Label("View", systemImage: model.viewMode.symbol)
            }
            .menuStyle(.borderlessButton)
            .fixedSize()

            Spacer()

            if model.undoStack.last != nil {
                tool("arrow.uturn.backward", "Undo \(model.undoStack.last?.label ?? "") (⌘Z)", enabled: true) { model.undo() }
            }
            if let busy = model.busyLabel {
                ProgressView().controlSize(.small)
                Text(busy).font(.caption).foregroundStyle(.secondary)
            }
            tool(model.showPreview ? "sidebar.right" : "sidebar.right", "Preview pane (⌥⌘P)", enabled: true, active: model.showPreview) {
                model.showPreview.toggle()
            }
            tool("info.circle", "Properties (⌥Return)", enabled: true) { model.showProperties() }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(.bar)
    }

    private var divider: some View {
        Divider().frame(height: 16).padding(.horizontal, 4)
    }

    private func tool(_ symbol: String, _ help: String, enabled: Bool, active: Bool = false, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: symbol)
                .frame(width: 26, height: 22)
                .background(RoundedRectangle(cornerRadius: 5).fill(active ? Color.accentColor.opacity(0.22) : .clear))
        }
        .buttonStyle(.borderless)
        .disabled(!enabled)
        .help(help)
    }
}

struct StatusBar: View {
    @ObservedObject var model: FileBrowserModel

    var body: some View {
        HStack(spacing: 12) {
            let count = model.displayItems.count
            Text("\(count) item\(count == 1 ? "" : "s")")
            if !model.selection.isEmpty {
                Text("|").foregroundStyle(.tertiary)
                Text("\(model.selection.count) selected" + (model.selectionSize > 0 ? "  \(Fmt.bytes(model.selectionSize))" : ""))
            }
            if model.isLoading { ProgressView().controlSize(.mini) }
            Spacer()
            if model.viewMode != .details {
                Slider(value: $model.iconSize, in: 32...128).frame(width: 110).controlSize(.mini)
            }
            Picker("View", selection: $model.viewMode) {
                ForEach(ViewMode.allCases) { Image(systemName: $0.symbol).tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 100)
            .controlSize(.small)
        }
        .font(.system(size: 11))
        .foregroundStyle(.secondary)
        .padding(.horizontal, 12)
        .padding(.vertical, 4)
        .background(.bar)
    }
}
