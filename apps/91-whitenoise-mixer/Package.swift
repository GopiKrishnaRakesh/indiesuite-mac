// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "WhiteNoiseMixer",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "WhiteNoiseMixer", targets: ["WhiteNoiseMixer"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "WhiteNoiseMixer",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/WhiteNoiseMixer"
        )
    ]
)
