// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let supportedPlatforms: [SupportedPlatform]? = [
    .macOS(.v12),
    .iOS(.v15)
]

let package = Package(
    name: "YCNetwork",
    platforms: supportedPlatforms,
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "YCNetwork",
            targets: ["YCNetwork"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "YCNetwork"),
        .testTarget(
            name: "YCNetworkTests",
            dependencies: ["YCNetwork"]),
    ]
)
