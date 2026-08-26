// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PortSentry",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "PortSentry",
            targets: ["PortSentry"]),
    ],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "PortSentry",
            dependencies: [
                "DesignSystem",
                "AppKitKit",
                "Licensing"
            ]),
    ]
)
