// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PetPalsDesktop",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "PetPalsDesktop", targets: ["PetPalsDesktop"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "PetPalsDesktop",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/PetPalsDesktop"
        )
    ]
)
