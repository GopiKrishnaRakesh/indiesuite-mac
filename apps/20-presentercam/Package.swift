// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PresenterCam",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "PresenterCam", targets: ["PresenterCam"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "PresenterCam",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/PresenterCam"
        )
    ]
)
