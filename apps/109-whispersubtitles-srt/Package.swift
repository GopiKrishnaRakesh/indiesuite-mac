// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "WhisperSubtitlesSRT",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "WhisperSubtitlesSRT", targets: ["WhisperSubtitlesSRT"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "WhisperSubtitlesSRT",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/WhisperSubtitlesSRT"
        )
    ]
)
