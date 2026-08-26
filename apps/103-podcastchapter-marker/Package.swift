// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PodcastChapterMarker",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "PodcastChapterMarker", targets: ["PodcastChapterMarker"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "PodcastChapterMarker",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/PodcastChapterMarker"
        )
    ]
)
