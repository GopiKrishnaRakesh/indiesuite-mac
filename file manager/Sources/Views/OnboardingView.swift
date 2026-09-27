import SwiftUI

/// First-launch Setup & Permissions Assistant to ensure a frictionless, prompt-free macOS experience.
struct OnboardingView: View {
    @ObservedObject var model: FileBrowserModel
    @StateObject private var permissions = PermissionManager.shared
    @Environment(\.dismiss) private var dismiss
    @State private var showingFeatureStore = false

    var body: some View {
        Group {
            if showingFeatureStore {
                FeatureStoreView(model: model)
            } else {
                permissionsStep
            }
        }
    }

    private var permissionsStep: some View {
        VStack(spacing: 0) {
            header
            Divider()
            ScrollView {
                VStack(spacing: 20) {
                    fullDiskAccessCard
                    foldersAccessCard
                }
                .padding(24)
            }
            Divider()
            footer
        }
        .frame(width: 680, height: 580)
        .background(.regularMaterial)
    }

    private var header: some View {
        HStack(spacing: 16) {
            Image(nsImage: NSApp.applicationIconImage)
                .resizable()
                .frame(width: 56, height: 56)

            VStack(alignment: .leading, spacing: 3) {
                Text("Welcome to Pathway")
                    .font(.title2.weight(.bold))
                Text("Let's configure file permissions so your browsing experience is completely smooth.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(20)
    }

    // Recommended Option: Full Disk Access
    private var fullDiskAccessCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label("Full Disk Access", systemImage: "internaldrive")
                    .font(.headline)
                Spacer()
                if permissions.hasFullDiskAccess {
                    statusTag("Enabled", color: .green, icon: "checkmark.circle.fill")
                } else {
                    statusTag("Recommended", color: .blue, icon: "star.fill")
                }
            }

            Text("Granting Full Disk Access permanently eliminates all individual macOS prompts for your Desktop, Documents, Downloads, and external drives.")
                .font(.system(size: 12))
                .foregroundStyle(.secondary)

            HStack {
                Button {
                    permissions.openFullDiskAccessSettings()
                } label: {
                    Label(
                        permissions.hasFullDiskAccess ? "System Settings (Granted)" : "Open Full Disk Access Settings",
                        systemImage: "gearshape"
                    )
                    .font(.system(size: 12, weight: .semibold))
                }
                .buttonStyle(.borderedProminent)
                .tint(permissions.hasFullDiskAccess ? .green : .accentColor)

                if !permissions.hasFullDiskAccess {
                    Text("Turn on the toggle next to Pathway.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(nsColor: .windowBackgroundColor))
                .shadow(color: .black.opacity(0.04), radius: 4, y: 1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(permissions.hasFullDiskAccess ? Color.green.opacity(0.4) : Color.accentColor.opacity(0.3), lineWidth: 1.5)
        )
    }

    // Alternative Option: Authorize Standard Folders
    private var foldersAccessCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Label("Authorize Primary Folders", systemImage: "folder.badge.gearshape")
                    .font(.headline)
                Spacer()
                Text("One-Click Setup")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }

            Text("Prefer not to grant Full Disk Access? Trigger the system consent dialogs now so macOS won't interrupt you while browsing.")
                .font(.system(size: 12))
                .foregroundStyle(.secondary)

            // Checklist
            HStack(spacing: 20) {
                folderStatusRow("Desktop", isGranted: permissions.hasDesktopAccess || permissions.hasFullDiskAccess)
                folderStatusRow("Documents", isGranted: permissions.hasDocumentsAccess || permissions.hasFullDiskAccess)
                folderStatusRow("Downloads", isGranted: permissions.hasDownloadsAccess || permissions.hasFullDiskAccess)
            }

            HStack {
                Button {
                    permissions.requestAllFolderPermissions()
                } label: {
                    if permissions.isRequesting {
                        ProgressView().controlSize(.small).padding(.horizontal, 8)
                    } else {
                        Label("Authorize Primary Folders Now", systemImage: "hand.tap.fill")
                            .font(.system(size: 12, weight: .semibold))
                    }
                }
                .buttonStyle(.bordered)
                .disabled(permissions.isRequesting || permissions.hasFullDiskAccess)

                Spacer()
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(nsColor: .windowBackgroundColor))
                .shadow(color: .black.opacity(0.04), radius: 4, y: 1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.primary.opacity(0.08), lineWidth: 1)
        )
    }

    private func folderStatusRow(_ name: String, isGranted: Bool) -> some View {
        HStack(spacing: 6) {
            Image(systemName: isGranted ? "checkmark.circle.fill" : "circle.dashed")
                .foregroundStyle(isGranted ? Color.green : Color.secondary)
            Text(name)
                .font(.system(size: 12, weight: .medium))
        }
    }

    private func statusTag(_ title: String, color: Color, icon: String) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon).font(.system(size: 10))
            Text(title).font(.system(size: 11, weight: .semibold))
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 3)
        .background(Capsule().fill(color.opacity(0.15)))
        .foregroundStyle(color)
    }

    private var footer: some View {
        HStack {
            Button("Skip for Now") {
                completeSetup(openFeatureStore: false)
            }
            .buttonStyle(.plain)
            .foregroundStyle(.secondary)
            .font(.caption)

            Spacer()

            Button {
                completeSetup(openFeatureStore: true)
            } label: {
                HStack(spacing: 6) {
                    Text("Explore Feature Store")
                    Image(systemName: "arrow.right")
                }
                .font(.system(size: 12, weight: .semibold))
            }
            .buttonStyle(.borderedProminent)
            .keyboardShortcut(.defaultAction)
        }
        .padding(18)
        .background(.bar)
    }

    private func completeSetup(openFeatureStore: Bool) {
        UserDefaults.standard.set(true, forKey: "hasCompletedSetup")
        if openFeatureStore {
            showingFeatureStore = true
        } else {
            dismiss()
        }
    }
}
