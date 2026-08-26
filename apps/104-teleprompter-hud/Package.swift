// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TeleprompterHUD",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "TeleprompterHUD", targets: ["TeleprompterHUD"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "TeleprompterHUD",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/TeleprompterHUD"
        )
    ]
)
