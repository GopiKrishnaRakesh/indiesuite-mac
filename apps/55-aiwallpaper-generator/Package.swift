// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AIWallpaperGenerator",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "AIWallpaperGenerator", targets: ["AIWallpaperGenerator"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "AIWallpaperGenerator",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/AIWallpaperGenerator"
        )
    ]
)
