// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "EyeBlinkCoach",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "EyeBlinkCoach", targets: ["EyeBlinkCoach"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "EyeBlinkCoach",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/EyeBlinkCoach"
        )
    ]
)
