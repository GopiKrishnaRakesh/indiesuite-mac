// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ScreenDimmerFocus",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "ScreenDimmerFocus", targets: ["ScreenDimmerFocus"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "ScreenDimmerFocus",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/ScreenDimmerFocus"
        )
    ]
)
