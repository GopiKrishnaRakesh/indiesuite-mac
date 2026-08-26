// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ClipToMarkdownThread",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "ClipToMarkdownThread", targets: ["ClipToMarkdownThread"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "ClipToMarkdownThread",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/ClipToMarkdownThread"
        )
    ]
)
