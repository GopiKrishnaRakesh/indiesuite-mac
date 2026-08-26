import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class TimeBridgeState: ObservableObject {

    @Published var zones: [ZoneTime] = [
        ZoneTime(city: "San Francisco", code: "PST", time: "16:30", diff: "-8h"),
        ZoneTime(city: "London", code: "GMT", time: "00:30", diff: "0h"),
        ZoneTime(city: "Tokyo", code: "JST", time: "09:30", diff: "+9h")
    ]
    struct ZoneTime: Identifiable {
        let id = UUID()
        let city: String
        let code: String
        let time: String
        let diff: String
    }

}

struct TimeBridgeView: View {
    @StateObject private var state = TimeBridgeState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "clock.badge.checkmark.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("TimeBridge")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Meeting Overlap Finder")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            
            VStack(spacing: 4) {
                ForEach(state.zones) { z in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(z.city)
                                .font(.system(size: 11, weight: .bold))
                            Text(z.code)
                                .font(.system(size: 9))
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text(z.time)
                            .font(.system(size: 12, weight: .bold, design: .monospaced))
                        Text(z.diff)
                            .font(.system(size: 9, design: .monospaced))
                            .foregroundColor(.secondary)
                    }
                    .padding(6)
                    .glassCard(cornerRadius: 6)
                }
            }

            
            HStack {
                Text("Indie Suite Pro Ready")
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
        .frame(width: 340, height: 360)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<TimeBridgeView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = TimeBridgeView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "clock.badge.checkmark.fill",
            titleText: "Timezones",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
