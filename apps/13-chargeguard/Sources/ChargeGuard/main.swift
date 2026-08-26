import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class ChargeGuardState: ObservableObject {
    @Published var chargeLimitThreshold: Double = 80.0
    @Published var isLimitingEnabled: Bool = true
    @Published var currentBatteryLevel: Int = 78
    @Published var isPluggedIn: Bool = true
    @Published var batteryTempC: Double = 28.4
    @Published var dischargeWattage: Double = 14.2
    @Published var cycleCount: Int = 142
    @Published var batteryHealthPercentage: Int = 98
}

struct ChargeGuardView: View {
    @StateObject private var state = ChargeGuardState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {
            // Header
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "bolt.batteryblock.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("ChargeGuard")
                        .font(.system(size: 15, weight: .bold))
                }
                
                Spacer()
                
                Toggle("Limit Active", isOn: $state.isLimitingEnabled)
                    .font(.system(size: 10))
            }
            
            // Battery Status Hero Card
            VStack(spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(state.currentBatteryLevel)%")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                        Text(state.isPluggedIn ? "Power Connected • Holding at 80%" : "On Battery Power")
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Circle()
                        .fill(Color.green.opacity(0.18))
                        .frame(width: 44, height: 44)
                        .overlay(
                            Image(systemName: "bolt.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.green)
                        )
                }
                
                // Charge Ceiling Slider
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Maximum Charge Ceiling")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(Int(state.chargeLimitThreshold))%")
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                    }
                    
                    Slider(value: $state.chargeLimitThreshold, in: 50...100, step: 5)
                }
            }
            .padding(12)
            .glassCard(cornerRadius: 12)
            
            // Telemetry Grid
            HStack(spacing: 6) {
                MetricBadge(title: "Health", value: "\(state.batteryHealthPercentage)%", icon: "heart.fill", tint: .pink)
                MetricBadge(title: "Cycles", value: "\(state.cycleCount)", icon: "arrow.triangle.2.circlepath", tint: .blue)
                MetricBadge(title: "Temp", value: String(format: "%.1f°C", state.batteryTempC), icon: "thermometer.medium", tint: .orange)
            }
            
            // Footer
            HStack {
                Text("SMC Hardware Protection Active")
                    .font(.system(size: 9))
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
        .frame(width: 350, height: 380)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<ChargeGuardView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ChargeGuardView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "bolt.batteryblock.fill",
            titleText: "80%",
            contentWidth: 350,
            contentHeight: 380
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
