import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class NotchShelfState: ObservableObject {
    @Published var isHovered: Bool = false
    @Published var items: [ShelfItem] = [
        ShelfItem(name: "design_system_tokens.json", type: .file, size: "14 KB", icon: "doc.text.fill"),
        ShelfItem(name: "https://linear.app/issue/MAC-102", type: .link, size: "Link", icon: "link"),
        ShelfItem(name: "screenshot_hero_v2.png", type: .image, size: "1.8 MB", icon: "photo.fill")
    ]
    
    struct ShelfItem: Identifiable {
        let id = UUID()
        let name: String
        let type: ItemType
        let size: String
        let icon: String
        
        enum ItemType {
            case file, link, image, text
        }
    }
    
    func removeItem(id: UUID) {
        items.removeAll { $0.id == id }
    }
    
    func clearShelf() {
        items.removeAll()
    }
}

struct NotchShelfView: View {
    @StateObject private var state = NotchShelfState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 10) {
            // Top Notch Handle
            HStack {
                Circle()
                    .fill(Color.primary.opacity(0.3))
                    .frame(width: 6, height: 6)
                Text("NotchShelf Drop Zone")
                    .font(.system(size: 11, weight: .bold))
                Spacer()
                Text("\(state.items.count) Staged Items")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            
            // Drop target
            VStack(spacing: 6) {
                Image(systemName: "tray.and.arrow.down.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(DSTheme.primaryGradient)
                Text("Drag files, links or images here to stage")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color.primary.opacity(0.02))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(style: StrokeStyle(lineWidth: 1.5, dash: [4]))
                    .foregroundColor(Color.primary.opacity(0.15))
            )
            .cornerRadius(8)
            
            // Item Shelf
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(state.items) { item in
                        VStack(spacing: 4) {
                            HStack {
                                Spacer()
                                Button(action: {
                                    state.removeItem(id: item.id)
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.system(size: 10))
                                        .foregroundColor(.secondary)
                                }
                                .buttonStyle(.plain)
                            }
                            
                            Image(systemName: item.icon)
                                .font(.system(size: 22))
                                .foregroundColor(.accentColor)
                            
                            Text(item.name)
                                .font(.system(size: 10, weight: .medium))
                                .lineLimit(1)
                                .frame(width: 80)
                            
                            Text(item.size)
                                .font(.system(size: 8, design: .monospaced))
                                .foregroundColor(.secondary)
                        }
                        .padding(8)
                        .glassCard(cornerRadius: 8)
                        .onDrag {
                            NSItemProvider(object: item.name as NSString)
                        }
                    }
                }
                .padding(.vertical, 4)
            }
            
            // Footer
            HStack {
                Button("Clear Shelf") {
                    state.clearShelf()
                }
                .buttonStyle(.plain)
                .font(.system(size: 10))
                .foregroundColor(.red)
                
                Spacer()
                
                Button("Quit") {
                    NSApp.terminate(nil)
                }
                .buttonStyle(.plain)
                .font(.system(size: 10))
                .foregroundColor(.secondary)
            }
        }
        .padding(12)
        .frame(width: 360, height: 260)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<NotchShelfView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = NotchShelfView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "tray.full",
            titleText: "NotchShelf",
            contentWidth: 360,
            contentHeight: 260
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
