// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MicMuteHUD",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "MicMuteHUD",
            targets: ["MicMuteHUD"]),
    ],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "MicMuteHUD",
            dependencies: [
                "DesignSystem",
                "AppKitKit",
                "Licensing"
            ],
            path: "Sources/MicMuteHUD"),
    ]
)
