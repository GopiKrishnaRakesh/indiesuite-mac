import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing
import AudioVideoCore

class AudioMixState: ObservableObject {
    @Published var masterVolume: Double = 0.8
    @Published var activeOutputDevice: String = "MacBook Pro Speakers"
    
    @Published var appAudioStreams: [AppAudioStream] = [
        AppAudioStream(appName: "Spotify", icon: "music.note", volume: 0.75, isMuted: false),
        AppAudioStream(appName: "Google Chrome", icon: "globe", volume: 0.60, isMuted: false),
        AppAudioStream(appName: "Zoom / Meet", icon: "video.fill", volume: 0.90, isMuted: false),
        AppAudioStream(appName: "Discord", icon: "bubble.left.and.bubble.right.fill", volume: 0.50, isMuted: true)
    ]
    
    struct AppAudioStream: Identifiable {
        let id = UUID()
        let appName: String
        let icon: String
        var volume: Double
        var isMuted: Bool
    }
}

struct AudioMixView: View {
    @StateObject private var state = AudioMixState()
    @StateObject private var license = LicenseManager.shared
    
    let devices = ["MacBook Pro Speakers", "AirPods Pro (2nd Gen)", "Dell U2723QE Display Audio", "External USB DAC"]
    
    var body: some View {
        VStack(spacing: 12) {
            // Header
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "slider.vertical.3")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("AudioMix")
                        .font(.system(size: 15, weight: .bold))
                }
                
                Spacer()
                
                Picker("", selection: $state.activeOutputDevice) {
                    ForEach(devices, id: \.self) { dev in
                        Text(dev).tag(dev)
                    }
                }
                .pickerStyle(.menu)
                .font(.system(size: 10))
            }
            
            // Master Volume
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Image(systemName: "speaker.wave.3.fill")
                        .font(.system(size: 11))
                    Text("Master Output")
                        .font(.system(size: 11, weight: .bold))
                    Spacer()
                    Text("\(Int(state.masterVolume * 100))%")
                        .font(.system(size: 11, design: .monospaced))
                }
                
                Slider(value: $state.masterVolume, in: 0...1)
            }
            .padding(10)
            .glassCard(cornerRadius: 10)
            
            // Per App Volume Mixers
            VStack(alignment: .leading, spacing: 6) {
                Text("Per-App Volume Control")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.secondary)
                
                VStack(spacing: 6) {
                    ForEach($state.appAudioStreams) { $stream in
                        HStack {
                            Image(systemName: stream.icon)
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                                .frame(width: 20)
                            
                            Text(stream.appName)
                                .font(.system(size: 11, weight: .medium))
                                .frame(width: 85, alignment: .leading)
                            
                            Slider(value: $stream.volume, in: 0...1)
                                .disabled(stream.isMuted)
                            
                            Button(action: {
                                stream.isMuted.toggle()
                            }) {
                                Image(systemName: stream.isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                                    .font(.system(size: 11))
                                    .foregroundColor(stream.isMuted ? .red : .secondary)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(6)
                        .background(Color.primary.opacity(0.03))
                        .cornerRadius(6)
                    }
                }
            }
            
            // Footer
            HStack {
                Text("Zero-Latency CoreAudio Engine")
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
        .frame(width: 350, height: 400)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<AudioMixView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = AudioMixView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "slider.vertical.3",
            titleText: "AudioMix",
            contentWidth: 350,
            contentHeight: 400
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
