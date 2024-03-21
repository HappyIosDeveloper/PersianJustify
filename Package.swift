// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PersianJustify",
    products: [
        .library(
            name: "PersianJustify",
            targets: ["PersianJustify"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ArtSabintsev/FontBlaster", from: "5.3.0"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.15.4"),
    ],
    targets: [
        .target(
            name: "PersianJustify"
        ),
        .testTarget(
            name: "PersianJustifyTests",
            dependencies: [
                "PersianJustify",
                "FontBlaster",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ],
            resources: [.process("Resources")]
        ),
    ]
)
