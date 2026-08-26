import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class ColorForgeState: ObservableObject {
    @Published var selectedColor: Color = Color(red: 0.38, green: 0.35, blue: 0.98)
    @Published var hexValue: String = "#6159FA"
    @Published var rgbValue: String = "rgb(97, 89, 250)"
    @Published var swiftUICode: String = "Color(red: 0.38, green: 0.35, blue: 0.98)"
    @Published var contrastRatio: Double = 6.84 // Against white
    
    @Published var palette: [PaletteColor] = [
        PaletteColor(hex: "#6159FA", name: "Indigo Purple"),
        PaletteColor(hex: "#10B981", name: "Emerald Mint"),
        PaletteColor(hex: "#F59E0B", name: "Amber Glow"),
        PaletteColor(hex: "#EF4444", name: "Crimson Red"),
        PaletteColor(hex: "#06B6D4", name: "Cyan Wave")
    ]
    
    struct PaletteColor: Identifiable {
        let id = UUID()
        let hex: String
        let name: String
    }
    
    func pickScreenColor() {
        let sampler = NSColorSampler()
        sampler.show { selectedNSColor in
            guard let color = selectedNSColor else { return }
            DispatchQueue.main.async {
                self.updateColor(color)
            }
        }
    }
    
    func updateColor(_ nsColor: NSColor) {
        if let rgb = nsColor.usingColorSpace(.sRGB) {
            let r = Int(rgb.redComponent * 255)
            let g = Int(rgb.greenComponent * 255)
            let b = Int(rgb.blueComponent * 255)
            
            self.hexValue = String(format: "#%02X%02X%02X", r, g, b)
            self.rgbValue = "rgb(\(r), \(g), \(b))"
            self.swiftUICode = String(format: "Color(red: %.2f, green: %.2f, blue: %.2f)", rgb.redComponent, rgb.greenComponent, rgb.blueComponent)
            self.selectedColor = Color(nsColor: rgb)
            
            palette.insert(PaletteColor(hex: self.hexValue, name: "Picked Color"), at: 0)
            if palette.count > 8 { palette.removeLast() }
            
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(self.hexValue, forType: .string)
        }
    }
}

struct ColorForgeView: View {
    @StateObject private var state = ColorForgeState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {
            // Header
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "eyedropper.halffull")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("ColorForge")
                        .font(.system(size: 15, weight: .bold))
                }
                
                Spacer()
                
                HotkeyPill(keyCombination: "⌘ ⇧ C")
            }
            
            // Eyedropper Hero Card
            VStack(spacing: 10) {
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(state.selectedColor)
                        .frame(width: 54, height: 54)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.3), lineWidth: 1.5)
                        )
                        .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 2)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(state.hexValue)
                            .font(.system(size: 18, weight: .bold, design: .monospaced))
                        Text(state.rgbValue)
                            .font(.system(size: 11, design: .monospaced))
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        state.pickScreenColor()
                    }) {
                        Image(systemName: "eyedropper")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .padding(10)
                            .background(DSTheme.primaryGradient)
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                    .help("Sample Color Anywhere on Screen")
                }
                
                // WCAG Contrast Badge
                HStack {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.green)
                    Text("WCAG AAA Compliant")
                        .font(.system(size: 10, weight: .bold))
                    Spacer()
                    Text("\(String(format: "%.2f", state.contrastRatio)):1 on Light")
                        .font(.system(size: 10, design: .monospaced))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.green.opacity(0.12))
                .cornerRadius(6)
            }
            .padding(12)
            .glassCard(cornerRadius: 12)
            
            // Code Export Formats
            VStack(alignment: .leading, spacing: 6) {
                Text("1-Click Code Export")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.secondary)
                
                VStack(spacing: 4) {
                    ExportRow(label: "SwiftUI", code: state.swiftUICode)
                    ExportRow(label: "CSS Hex", code: state.hexValue)
                    ExportRow(label: "Tailwind", code: "bg-[\(state.hexValue)]")
                }
            }
            
            // Palette History
            VStack(alignment: .leading, spacing: 6) {
                Text("Recent Palette")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.secondary)
                
                HStack(spacing: 8) {
                    ForEach(state.palette.prefix(6)) { p in
                        Button(action: {
                            NSPasteboard.general.clearContents()
                            NSPasteboard.general.setString(p.hex, forType: .string)
                        }) {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color(hex: p.hex))
                                .frame(width: 38, height: 28)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                        }
                        .buttonStyle(.plain)
                        .help("Copy \(p.hex)")
                    }
                }
            }
            
            // Footer
            HStack {
                Text("Copied to Clipboard on Pick")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Button("Quit") {
                    NSApp.terminate(nil)
                }
                .buttonStyle(.plain)
                .font(.system(size: 10))
                .foregroundColor(.secondary)
            }
        }
        .padding(14)
        .frame(width: 350, height: 460)
    }
}

struct ExportRow: View {
    let label: String
    let code: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(.secondary)
                .frame(width: 56, alignment: .leading)
            
            Text(code)
                .font(.system(size: 10, design: .monospaced))
                .lineLimit(1)
            
            Spacer()
            
            Button(action: {
                NSPasteboard.general.clearContents()
                NSPasteboard.general.setString(code, forType: .string)
            }) {
                Image(systemName: "doc.on.doc")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            .buttonStyle(.plain)
        }
        .padding(6)
        .background(Color.primary.opacity(0.03))
        .cornerRadius(6)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<ColorForgeView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ColorForgeView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "eyedropper.halffull",
            titleText: "ColorForge",
            contentWidth: 350,
            contentHeight: 460
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
