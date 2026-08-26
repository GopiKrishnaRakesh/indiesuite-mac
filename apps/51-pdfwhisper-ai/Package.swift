// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PDFWhisperAI",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "PDFWhisperAI", targets: ["PDFWhisperAI"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "PDFWhisperAI",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/PDFWhisperAI"
        )
    ]
)
