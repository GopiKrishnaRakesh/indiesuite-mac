// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "RegexForge",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "RegexForge", targets: ["RegexForge"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "RegexForge",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/RegexForge"
        )
    ]
)
