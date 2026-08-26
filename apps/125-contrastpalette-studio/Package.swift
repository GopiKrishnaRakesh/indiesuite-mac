// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ContrastPaletteStudio",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "ContrastPaletteStudio", targets: ["ContrastPaletteStudio"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "ContrastPaletteStudio",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/ContrastPaletteStudio"
        )
    ]
)
