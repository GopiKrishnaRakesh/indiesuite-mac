import SwiftUI

public enum DSTheme {
    // MARK: - Vibrant Accents
    public static let primaryGradient = LinearGradient(
        colors: [Color(red: 0.38, green: 0.35, blue: 0.98), Color(red: 0.65, green: 0.32, blue: 0.98)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    public static let emeraldGradient = LinearGradient(
        colors: [Color(red: 0.06, green: 0.78, blue: 0.58), Color(red: 0.02, green: 0.62, blue: 0.44)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    public static let amberGradient = LinearGradient(
        colors: [Color(red: 0.98, green: 0.65, blue: 0.18), Color(red: 0.92, green: 0.44, blue: 0.12)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    public static let roseGradient = LinearGradient(
        colors: [Color(red: 0.96, green: 0.28, blue: 0.44), Color(red: 0.88, green: 0.18, blue: 0.36)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    public static let cyanGradient = LinearGradient(
        colors: [Color(red: 0.12, green: 0.74, blue: 0.96), Color(red: 0.25, green: 0.52, blue: 0.98)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // MARK: - Surfaces & Glassmorphism
    public static let glassBackground = Color(nsColor: .windowBackgroundColor).opacity(0.72)
    public static let glassBorder = Color.white.opacity(0.14)
    public static let glassHighlight = Color.white.opacity(0.08)
    
    public static let cardBackground = Color(nsColor: .controlBackgroundColor).opacity(0.55)
    public static let secondaryCardBackground = Color(nsColor: .controlBackgroundColor).opacity(0.35)
}

public struct GlassCardModifier: ViewModifier {
    var cornerRadius: CGFloat = 12
    var strokeColor: Color = DSTheme.glassBorder
    
    public init(cornerRadius: CGFloat = 12, strokeColor: Color = DSTheme.glassBorder) {
        self.cornerRadius = cornerRadius
        self.strokeColor = strokeColor
    }
    
    public func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(strokeColor, lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 4)
    }
}

public extension View {
    func glassCard(cornerRadius: CGFloat = 12, strokeColor: Color = DSTheme.glassBorder) -> some View {
        self.modifier(GlassCardModifier(cornerRadius: cornerRadius, strokeColor: strokeColor))
    }
}
