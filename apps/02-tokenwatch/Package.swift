// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TokenWatch",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "TokenWatch",
            targets: ["TokenWatch"]),
    ],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "TokenWatch",
            dependencies: [
                "DesignSystem",
                "AppKitKit",
                "Licensing"
            ]),
    ]
)
