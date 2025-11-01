#!/usr/bin/env bash

# Use for -target the same ios version that is returned by xcrun
# Build the MapLibre iOS SDK before running this script

xcrun --sdk iphonesimulator --show-sdk-path

swiftc \
    -c MapLibreIos.swift \
    -module-name maplibre_ios \
    -emit-objc-header-path MapLibreIos.h \
    -emit-library -o libmaplibreios.dylib \
    -target arm64-apple-ios18.5-simulator \
    -sdk $(xcrun --sdk iphonesimulator --show-sdk-path) \
    -F ../../../.build/MapLibre.xcframework/ios-arm64_x86_64-simulator/ \
    -framework MapLibre
