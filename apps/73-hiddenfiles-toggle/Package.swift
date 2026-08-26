// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "HiddenFilesToggle",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "HiddenFilesToggle", targets: ["HiddenFilesToggle"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "HiddenFilesToggle",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/HiddenFilesToggle"
        )
    ]
)
