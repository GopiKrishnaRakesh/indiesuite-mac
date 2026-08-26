import SwiftUI

public struct MetricBadge: View {
    public let title: String
    public let value: String
    public let icon: String
    public let tint: Color
    
    public init(title: String, value: String, icon: String, tint: Color = .blue) {
        self.title = title
        self.value = value
        self.icon = icon
        self.tint = tint
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(tint.opacity(0.18))
                    .frame(width: 28, height: 28)
                Image(systemName: icon)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(tint)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                    .foregroundColor(.primary)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .glassCard(cornerRadius: 10)
    }
}

public struct StatusDot: View {
    public let isActive: Bool
    public let activeColor: Color
    
    public init(isActive: Bool, activeColor: Color = .green) {
        self.isActive = isActive
        self.activeColor = activeColor
    }
    
    public var body: some View {
        Circle()
            .fill(isActive ? activeColor : Color.gray.opacity(0.4))
            .frame(width: 8, height: 8)
            .overlay(
                Circle()
                    .stroke(isActive ? activeColor.opacity(0.5) : Color.clear, lineWidth: 2)
                    .scaleEffect(isActive ? 1.5 : 1.0)
                    .opacity(isActive ? 0.6 : 0)
            )
            .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: isActive)
    }
}

public struct PrimaryActionButton: View {
    public let title: String
    public let icon: String
    public let gradient: LinearGradient
    public let action: () -> Void
    
    public init(title: String, icon: String = "", gradient: LinearGradient = DSTheme.primaryGradient, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.gradient = gradient
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if !icon.isEmpty {
                    Image(systemName: icon)
                        .font(.system(size: 13, weight: .bold))
                }
                Text(title)
                    .font(.system(size: 13, weight: .semibold))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(gradient)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .shadow(color: Color.black.opacity(0.15), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }
}

public struct HotkeyPill: View {
    public let keyCombination: String
    
    public init(keyCombination: String) {
        self.keyCombination = keyCombination
    }
    
    public var body: some View {
        Text(keyCombination)
            .font(.system(size: 11, weight: .semibold, design: .monospaced))
            .padding(.horizontal, 6)
            .padding(.vertical, 3)
            .background(Color.primary.opacity(0.08))
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.primary.opacity(0.12), lineWidth: 1)
            )
            .foregroundColor(.secondary)
    }
}
