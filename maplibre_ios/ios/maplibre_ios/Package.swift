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
    // FOR PREBUILT LIBRARY
    .package(url: "https://github.com/maplibre/maplibre-gl-native-distribution", .upToNextMinor(from: "6.19.0")),
    .package(url: "https://github.com/mattgallagher/CwlCatchException.git", .upToNextMinor(from: "2.2.0")),
  ],
  targets: [
    .target(
      name: "maplibre_ios",
      dependencies: [
        // FOR PREBUILT LIBRARY
        .product(name: "MapLibre", package: "maplibre-gl-native-distribution"),

        // FOR LOCAL LIBRARY
        // "MapLibre",

        .product(name: "CwlCatchException", package: "CwlCatchException"),
      ],
      cSettings: [
        .headerSearchPath("include/maplibre_ios"),
      ]
    ),
    // FOR LOCAL LIBRARY
    // .binaryTarget(
    //   name: "MapLibre",
    //   path: "../.build/MapLibre.xcframework",
    // ),
  ]
)
