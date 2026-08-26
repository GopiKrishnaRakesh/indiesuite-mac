// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "QuickPollCreator",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "QuickPollCreator", targets: ["QuickPollCreator"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "QuickPollCreator",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/QuickPollCreator"
        )
    ]
)
