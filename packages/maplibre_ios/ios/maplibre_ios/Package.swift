// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "maplibre_ios",
    platforms: [
        .iOS("12.0"),
    ],
    products: [
        .library(name: "maplibre-ios", targets: ["maplibre_ios"]),
    ],
    dependencies: [
        // Needs to be the same version as in ../maplibre_ios.podspec
        .package(url: "https://github.com/maplibre/maplibre-gl-native-distribution", .upToNextMinor(from: "6.21.0")),
    ],
    targets: [
        .target(
            name: "maplibre_ios",
            dependencies: [
                .product(name: "MapLibre", package: "maplibre-gl-native-distribution"),
            ],
            cSettings: [
                .headerSearchPath("include/maplibre_ios"),
            ]
        ),
    ]
)
