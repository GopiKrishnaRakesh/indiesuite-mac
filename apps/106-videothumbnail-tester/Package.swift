// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "VideoThumbnailTester",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "VideoThumbnailTester", targets: ["VideoThumbnailTester"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "VideoThumbnailTester",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/VideoThumbnailTester"
        )
    ]
)
