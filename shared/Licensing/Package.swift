// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Licensing",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "Licensing",
            targets: ["Licensing"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Licensing",
            dependencies: []),
    ]
)
