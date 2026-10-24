// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "maplibre_native",
    platforms: [
        .iOS("15.0"),
        .macOS("14.3"),
    ],
    products: [
        .library(name: "maplibre-native", targets: ["maplibre_native"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "maplibre_native",
            dependencies: [],
            cSettings: [
                .headerSearchPath("include/maplibre_native"),
            ],
            linkerSettings: [
                .linkedFramework("CoreVideo"),
                .linkedFramework("Metal"),
            ]
        ),
    ]
)
