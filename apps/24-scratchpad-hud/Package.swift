// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ScratchPadHUD",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "ScratchPadHUD", targets: ["ScratchPadHUD"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "ScratchPadHUD",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/ScratchPadHUD"
        )
    ]
)
