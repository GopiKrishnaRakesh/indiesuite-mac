// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AppKitKit",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "AppKitKit",
            targets: ["AppKitKit"]),
    ],
    dependencies: [
        .package(path: "../DesignSystem")
    ],
    targets: [
        .target(
            name: "AppKitKit",
            dependencies: [
                "DesignSystem"
            ]),
    ]
)
