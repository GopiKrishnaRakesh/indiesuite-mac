// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ArchiveExtractor",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "ArchiveExtractor", targets: ["ArchiveExtractor"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "ArchiveExtractor",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/ArchiveExtractor"
        )
    ]
)
