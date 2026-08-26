// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PromptDock",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "PromptDock",
            targets: ["PromptDock"]),
    ],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "PromptDock",
            dependencies: [
                "DesignSystem",
                "AppKitKit",
                "Licensing"
            ],
            path: "Sources/PromptDock"),
    ]
)
