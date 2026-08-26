// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "NpmOutdatedHUD",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "NpmOutdatedHUD", targets: ["NpmOutdatedHUD"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "NpmOutdatedHUD",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/NpmOutdatedHUD"
        )
    ]
)
