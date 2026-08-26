// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ClipboardDiff",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "ClipboardDiff", targets: ["ClipboardDiff"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "ClipboardDiff",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/ClipboardDiff"
        )
    ]
)
