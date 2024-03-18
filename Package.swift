// swift-tools-version: 5.10
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
    targets: [
        .target(
            name: "PersianJustify"
        ),
        .testTarget(
            name: "PersianJustifyTests",
            dependencies: ["PersianJustify"]
        ),
    ]
)
