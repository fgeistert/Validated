// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Validated",
    products: [
        .library(
            name: "Validated",
            targets: ["Validated"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Validated",
            dependencies: [],
            path: "Validated/Sources"
        ),
        .testTarget(
            name: "ValidatedTests",
            dependencies: ["Validated"],
            path: "ValidatedTests/Tests"
        ),
    ]
)
