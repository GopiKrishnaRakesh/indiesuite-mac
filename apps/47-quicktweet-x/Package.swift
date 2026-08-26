// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "QuickTweetX",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "QuickTweetX", targets: ["QuickTweetX"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "QuickTweetX",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/QuickTweetX"
        )
    ]
)
