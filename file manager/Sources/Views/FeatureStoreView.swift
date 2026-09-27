import SwiftUI

struct FeatureItem: Identifiable {
    let id = UUID()
    let title: String
    let badge: String
    let category: FeatureCategory
    let icon: String
    let iconColor: Color
    let summary: String
    let detail: String
    let actionTitle: String
    let action: (FileBrowserModel) -> Void
}

enum FeatureCategory: String, CaseIterable, Identifiable {
    case all = "All"
    case macos = "macOS Power"
    case windows = "Windows Explorer"
    case productivity = "Productivity"

    var id: String { rawValue }
}

/// The Pathway Feature Store: an interactive, curated showcase of the app's hybrid macOS & Windows capabilities.
struct FeatureStoreView: View {
    @ObservedObject var model: FileBrowserModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedCategory: FeatureCategory = .all
    @State private var searchFilter: String = ""

    private var features: [FeatureItem] {
        [
            FeatureItem(
                title: "Miller Columns View",
                badge: "NEW • ⌘4",
                category: .macos,
                icon: "rectangle.split.3x1",
                iconColor: .blue,
                summary: "Cascading hierarchical directory columns with real-time file preview cards.",
                detail: "Traverse deep directory structures effortlessly with arrow keys, just like native macOS Finder.",
                actionTitle: "Activate Columns",
                action: { m in
                    m.viewMode = .columns
                }
            ),
            FeatureItem(
                title: "Finder Color Tags",
                badge: "NATIVE MACOS",
                category: .macos,
                icon: "tag.fill",
                iconColor: .orange,
                summary: "7 native macOS color labels synced directly with Finder and Spotlight.",
                detail: "Tag any file or folder with Red, Orange, Yellow, Green, Blue, Purple, or Gray. Filter instantly in the sidebar.",
                actionTitle: "Filter by Red Tag",
                action: { m in
                    m.selectedTagFilter = "Red"
                }
            ),
            FeatureItem(
                title: "Interactive Path Bar",
                badge: "FINDER HYBRID",
                category: .macos,
                icon: "location.fill",
                iconColor: .green,
                summary: "Bottom hierarchical breadcrumb bar with icons, quick jump, and drag-to-move.",
                detail: "Click any path segment to jump, drag files onto ancestors to move them, or right-click to open in Terminal.",
                actionTitle: "Toggle Path Bar",
                action: { m in
                    m.showPathBar.toggle()
                }
            ),
            FeatureItem(
                title: "Windows Explorer Keys",
                badge: "WORKFLOW",
                category: .windows,
                icon: "keyboard",
                iconColor: .purple,
                summary: "Muscle-memory shortcuts: Backspace, Alt+Arrows, F2 rename, and Enter.",
                detail: "Enjoy the speed of Windows Explorer navigation without giving up macOS look and feel.",
                actionTitle: "View Cheat Sheet",
                action: { _ in
                    if let url = URL(string: "pathway://shortcuts") {
                        NSWorkspace.shared.open(url)
                    }
                }
            ),
            FeatureItem(
                title: "AirDrop & Share Sheet",
                badge: "SHARING",
                category: .macos,
                icon: "square.and.arrow.up",
                iconColor: .teal,
                summary: "Native macOS sharing integration across toolbar, context menu, and preview cards.",
                detail: "Send selected files directly via AirDrop, Messages, Mail, or Notes without opening external apps.",
                actionTitle: "Share Current",
                action: { m in
                    // ShareLink handled in UI
                }
            ),
            FeatureItem(
                title: "New Folder with Selection",
                badge: "POWER TOOL • ⌃⌘N",
                category: .productivity,
                icon: "folder.badge.plus",
                iconColor: .yellow,
                summary: "Bundle selected items into a new folder and start renaming in one stroke.",
                detail: "Select any number of files and press ⌃⌘N. Fully undoable with ⌘Z.",
                actionTitle: "New Folder Now",
                action: { m in
                    m.newFolder()
                }
            ),
            FeatureItem(
                title: "Make Alias / Symbolic Links",
                badge: "MACOS • ⌃⌘A",
                category: .macos,
                icon: "link",
                iconColor: .indigo,
                summary: "Create native macOS symbolic links with automatic 'alias' naming.",
                detail: "Quickly create links to documents or project directories anywhere on your drives.",
                actionTitle: "Try Make Alias",
                action: { m in
                    m.makeAlias()
                }
            ),
            FeatureItem(
                title: "Quick Look & Preview Pane",
                badge: "INSPECTOR • ⌥⌘P",
                category: .productivity,
                icon: "eye.fill",
                iconColor: .pink,
                summary: "Full-folder spacebar cycling and side-by-side inspector with byte metrics.",
                detail: "Examine POSIX permissions, size-on-disk, creation dates, and live media playback.",
                actionTitle: "Toggle Preview",
                action: { m in
                    m.showPreview.toggle()
                }
            ),
            FeatureItem(
                title: "ZIP, TAR & Universal Unzip",
                badge: "ARCHIVES",
                category: .productivity,
                icon: "doc.zipper",
                iconColor: .orange,
                summary: "Create ZIP or TAR.GZ archives and extract .zip, .tar, .tgz, .bz2, or .xz with one right click.",
                detail: "Compress single or multiple files into standard ZIP or TAR archives. Extract directly here or neatly into a dedicated folder.",
                actionTitle: "Compress Selection",
                action: { m in
                    m.compress(format: .zip)
                }
            ),
            FeatureItem(
                title: "Smart Image Converter",
                badge: "GRAPHICS",
                category: .productivity,
                icon: "photo.on.rectangle",
                iconColor: .cyan,
                summary: "Convert images to JPEG, PNG, HEIC, TIFF, GIF, or combine into a multi-page PDF.",
                detail: "Batch convert any photo, graphic, or icon into your desired format right from the context menu without third-party converters.",
                actionTitle: "Convert Images",
                action: { m in
                    m.convertImages(to: .png)
                }
            ),
            FeatureItem(
                title: "Document Format Converter",
                badge: "DOCUMENTS",
                category: .productivity,
                icon: "doc.text",
                iconColor: .blue,
                summary: "Convert documents to PDF, Word (.docx), Rich Text (.rtf), Plain Text, or HTML.",
                detail: "Easily transform Word documents, text files, markdown, and rich text documents into clean PDFs or editable Word files.",
                actionTitle: "Convert to PDF",
                action: { m in
                    m.convertDocuments(to: .pdf)
                }
            ),
        ]
    }

    private var filteredFeatures: [FeatureItem] {
        features.filter { item in
            let matchesCategory = (selectedCategory == .all) ||
                (selectedCategory == .macos && item.category == .macos) ||
                (selectedCategory == .windows && item.category == .windows) ||
                (selectedCategory == .productivity && (item.category == .productivity || item.category == .macos))
            let matchesSearch = searchFilter.isEmpty ||
                item.title.localizedCaseInsensitiveContains(searchFilter) ||
                item.summary.localizedCaseInsensitiveContains(searchFilter)
            return matchesCategory && matchesSearch
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            categoryPicker
            Divider()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 320), spacing: 14)], spacing: 14) {
                    ForEach(filteredFeatures) { item in
                        FeatureCard(item: item, model: model) {
                            item.action(model)
                            dismiss()
                        }
                    }
                }
                .padding(20)
            }
            Divider()
            footer
        }
        .frame(width: 760, height: 620)
        .background(.regularMaterial)
    }

    private var header: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 50, height: 50)
                Image(systemName: "sparkles")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.white)
            }

            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 8) {
                    Text("Pathway Feature Store")
                        .font(.title2.weight(.bold))
                    Text("v1.0")
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Capsule().fill(Color.primary.opacity(0.08)))
                }
                Text("Discover superpowers, native macOS Finder tools, and Windows workflow shortcuts.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            TextField("Search features…", text: $searchFilter)
                .textFieldStyle(.roundedBorder)
                .frame(width: 170)
        }
        .padding(18)
    }

    private var categoryPicker: some View {
        HStack {
            Picker("Category", selection: $selectedCategory) {
                ForEach(FeatureCategory.allCases) { cat in
                    Text(cat.rawValue).tag(cat)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 440)

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .background(Color.primary.opacity(0.02))
    }

    private var footer: some View {
        HStack {
            Text("Re-open anytime from Help › Feature Store or the sparkles button in the toolbar.")
                .font(.caption)
                .foregroundStyle(.secondary)
            Spacer()
            Button("Done") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .keyboardShortcut(.defaultAction)
        }
        .padding(16)
        .background(.bar)
    }
}

private struct FeatureCard: View {
    let item: FeatureItem
    @ObservedObject var model: FileBrowserModel
    let onAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(item.iconColor.opacity(0.15))
                        .frame(width: 40, height: 40)
                    Image(systemName: item.icon)
                        .font(.system(size: 20))
                        .foregroundStyle(item.iconColor)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(item.title)
                        .font(.system(size: 14, weight: .bold))
                    Text(item.badge)
                        .font(.system(size: 9, weight: .bold))
                        .foregroundStyle(item.iconColor)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 1)
                        .background(Capsule().fill(item.iconColor.opacity(0.12)))
                }

                Spacer()
            }

            Text(item.summary)
                .font(.system(size: 12))
                .foregroundStyle(.primary.opacity(0.9))
                .fixedSize(horizontal: false, vertical: true)

            Text(item.detail)
                .font(.system(size: 11))
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: 4)

            Button(action: onAction) {
                Text(item.actionTitle)
                    .font(.system(size: 11, weight: .semibold))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .controlSize(.small)
        }
        .padding(14)
        .frame(minHeight: 180, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(nsColor: .windowBackgroundColor))
                .shadow(color: .black.opacity(0.06), radius: 6, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.primary.opacity(0.08), lineWidth: 1)
        )
    }
}
