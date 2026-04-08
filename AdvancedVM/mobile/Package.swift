// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "BlackBoxMobile",
    platforms: [.macOS(.v10_15)],
    products: [
        .executable(name: "launcher", targets: ["Launcher"]),
    ],
    dependencies: [
        // .package(url: "https://github.com/daltoniam/Starscream", from: "4.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "Launcher",
            dependencies: [],
            path: "."
        ),
    ]
)

