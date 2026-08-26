// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "FocusSloth",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "FocusSloth", targets: ["FocusSloth"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "FocusSloth",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/FocusSloth"
        )
    ]
)
