import SwiftUI

/// Vector Icon Registry for all IndieSuite apps
public struct AppVectorIcon: View {
    public let systemIconName: String
    public let gradient: LinearGradient
    public let size: CGFloat
    
    public init(systemIconName: String, gradient: LinearGradient = DSTheme.primaryGradient, size: CGFloat = 44) {
        self.systemIconName = systemIconName
        self.gradient = gradient
        self.size = size
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.25, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.12), Color.white.opacity(0.03)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: size * 0.25, style: .continuous)
                        .strokeBorder(gradient, lineWidth: 1.5)
                )
                .shadow(color: Color.black.opacity(0.3), radius: 6, x: 0, y: 3)
            
            Image(systemName: systemIconName)
                .font(.system(size: size * 0.48, weight: .semibold))
                .foregroundStyle(gradient)
        }
        .frame(width: size, height: size)
    }
}
