// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ApiMockServer",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "ApiMockServer", targets: ["ApiMockServer"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "ApiMockServer",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/ApiMockServer"
        )
    ]
)
