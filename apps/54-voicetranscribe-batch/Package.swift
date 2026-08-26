// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "VoiceTranscribeBatch",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "VoiceTranscribeBatch", targets: ["VoiceTranscribeBatch"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "VoiceTranscribeBatch",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/VoiceTranscribeBatch"
        )
    ]
)
