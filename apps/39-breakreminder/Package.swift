// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BreakReminder",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "BreakReminder", targets: ["BreakReminder"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "BreakReminder",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/BreakReminder"
        )
    ]
)
