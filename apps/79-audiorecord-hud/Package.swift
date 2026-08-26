// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AudioRecordHUD",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "AudioRecordHUD", targets: ["AudioRecordHUD"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "AudioRecordHUD",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/AudioRecordHUD"
        )
    ]
)
