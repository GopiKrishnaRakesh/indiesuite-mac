// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PixelHamsterDesktop",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "PixelHamsterDesktop", targets: ["PixelHamsterDesktop"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "PixelHamsterDesktop",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/PixelHamsterDesktop"
        )
    ]
)
