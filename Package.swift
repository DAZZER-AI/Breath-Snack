// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "BreatheSnack",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(name: "BreatheSnackCore", targets: ["BreatheSnackCore"]),
        .library(name: "BreatheSnackUI", targets: ["BreatheSnackUI"])
    ],
    targets: [
        .target(name: "BreatheSnackCore"),
        .target(name: "BreatheSnackUI", dependencies: ["BreatheSnackCore"]),
        .testTarget(name: "BreatheSnackCoreTests", dependencies: ["BreatheSnackCore"])
    ]
)
