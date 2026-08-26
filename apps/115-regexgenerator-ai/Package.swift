// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "RegexGeneratorAI",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "RegexGeneratorAI", targets: ["RegexGeneratorAI"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "RegexGeneratorAI",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/RegexGeneratorAI"
        )
    ]
)
