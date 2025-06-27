// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "mobile_core_test",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "mobile_core_test",
            targets: ["mobile_core_test"]),
    ],
    targets: [
        .target(
            name: "mobile_core_test",
            path: "Sources/mobile_core_test"),
        .testTarget(
            name: "mobile_core_testTests",
            dependencies: []
        ),
    ]
)
