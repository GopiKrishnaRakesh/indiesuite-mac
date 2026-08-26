// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "HttpHeaderInspector",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "HttpHeaderInspector", targets: ["HttpHeaderInspector"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "HttpHeaderInspector",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/HttpHeaderInspector"
        )
    ]
)
