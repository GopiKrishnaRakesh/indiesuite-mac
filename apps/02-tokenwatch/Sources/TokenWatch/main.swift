import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class TokenWatchState: ObservableObject {
    @Published var totalMonthCost: Double = 42.85
    @Published var todayCost: Double = 3.40
    @Published var budgetLimit: Double = 100.00
    @Published var activeProvider: String = "All Providers"
    
    @Published var providers: [ProviderSpend] = [
        ProviderSpend(name: "Anthropic Claude", cost: 24.50, tokens: "1.2M", icon: "brain.head.profile", color: Color(red: 0.85, green: 0.45, blue: 0.3)),
        ProviderSpend(name: "OpenAI GPT-4o", cost: 12.10, tokens: "850K", icon: "sparkles", color: Color(red: 0.1, green: 0.65, blue: 0.5)),
        ProviderSpend(name: "Google Gemini 2.0", cost: 4.80, tokens: "3.4M", icon: "bolt.fill", color: Color(red: 0.25, green: 0.55, blue: 0.95)),
        ProviderSpend(name: "Groq Llama 3.3", cost: 1.45, tokens: "920K", icon: "flame.fill", color: Color(red: 0.95, green: 0.4, blue: 0.1))
    ]
    
    @Published var recentRequests: [APIRequestLog] = [
        APIRequestLog(model: "claude-3-7-sonnet", tokens: 4120, cost: 0.038, latency: "820ms", project: "Web-App"),
        APIRequestLog(model: "gpt-4o", tokens: 1840, cost: 0.012, latency: "640ms", project: "CLI-Tool"),
        APIRequestLog(model: "gemini-2.0-flash", tokens: 8500, cost: 0.003, latency: "380ms", project: "Scraper")
    ]
    
    struct ProviderSpend: Identifiable {
        let id = UUID()
        let name: String
        let cost: Double
        let tokens: String
        let icon: String
        let color: Color
    }
    
    struct APIRequestLog: Identifiable {
        let id = UUID()
        let model: String
        let tokens: Int
        let cost: Double
        let latency: String
        let project: String
    }
}

struct TokenWatchView: View {
    @StateObject private var state = TokenWatchState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 14) {
            // Header
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "creditcard.and.123")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("TokenWatch")
                        .font(.system(size: 15, weight: .bold))
                }
                
                Spacer()
                
                Text("Updated 2m ago")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            
            // Spend Overview Metrics
            HStack(spacing: 8) {
                MetricBadge(
                    title: "This Month",
                    value: String(format: "$%.2f", state.totalMonthCost),
                    icon: "chart.line.uptrend.xyaxis",
                    tint: .green
                )
                
                MetricBadge(
                    title: "Today's Burn",
                    value: String(format: "$%.2f", state.todayCost),
                    icon: "flame.fill",
                    tint: .orange
                )
                
                MetricBadge(
                    title: "Budget Cap",
                    value: String(format: "$%.0f", state.budgetLimit),
                    icon: "target",
                    tint: .blue
                )
            }
            
            // Progress Bar towards monthly budget
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Budget Consumption")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(Int((state.totalMonthCost / state.budgetLimit) * 100))%")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(.primary)
                }
                
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.primary.opacity(0.08))
                            .frame(height: 6)
                        
                        Capsule()
                            .fill(DSTheme.emeraldGradient)
                            .frame(width: geo.size.width * CGFloat(min(state.totalMonthCost / state.budgetLimit, 1.0)), height: 6)
                    }
                }
                .frame(height: 6)
            }
            .padding(10)
            .glassCard(cornerRadius: 10)
            
            // Provider Breakdown List
            VStack(alignment: .leading, spacing: 8) {
                Text("Cost by AI Provider")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.secondary)
                
                VStack(spacing: 6) {
                    ForEach(state.providers) { p in
                        HStack {
                            Circle()
                                .fill(p.color.opacity(0.2))
                                .frame(width: 22, height: 22)
                                .overlay(
                                    Image(systemName: p.icon)
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(p.color)
                                )
                            
                            Text(p.name)
                                .font(.system(size: 11, weight: .medium))
                            
                            Spacer()
                            
                            Text(p.tokens)
                                .font(.system(size: 10, design: .monospaced))
                                .foregroundColor(.secondary)
                                .padding(.trailing, 6)
                            
                            Text(String(format: "$%.2f", p.cost))
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                        }
                        .padding(6)
                        .background(Color.primary.opacity(0.03))
                        .cornerRadius(6)
                    }
                }
            }
            
            // Recent Live Request Stream
            VStack(alignment: .leading, spacing: 6) {
                Text("Live Request Stream")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.secondary)
                
                VStack(spacing: 4) {
                    ForEach(state.recentRequests) { req in
                        HStack {
                            Text(req.model)
                                .font(.system(size: 10, weight: .semibold, design: .monospaced))
                            Spacer()
                            Text(req.project)
                                .font(.system(size: 9))
                                .padding(.horizontal, 4)
                                .padding(.vertical, 1)
                                .background(Color.blue.opacity(0.12))
                                .foregroundColor(.blue)
                                .cornerRadius(3)
                            Text(req.latency)
                                .font(.system(size: 9, design: .monospaced))
                                .foregroundColor(.secondary)
                            Text(String(format: "$%.3f", req.cost))
                                .font(.system(size: 10, weight: .bold, design: .monospaced))
                        }
                        .padding(.vertical, 3)
                        .padding(.horizontal, 6)
                    }
                }
                .glassCard(cornerRadius: 8)
            }
            
            // Footer
            HStack {
                Button("+ Add API Key") {}
                    .buttonStyle(.plain)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.accentColor)
                
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
        .frame(width: 350, height: 490)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<TokenWatchView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = TokenWatchView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "creditcard.and.123",
            titleText: "$42.85",
            contentWidth: 350,
            contentHeight: 490
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
