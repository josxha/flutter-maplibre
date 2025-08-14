#!/usr/bin/env bash

swiftc \
    -c MapLibreRegistry.swift \
    -module-name maplibre_ios \
    -emit-objc-header-path MapLibreRegistry.h \
    -emit-library -o libmaplibreios.dylib \
    -target arm64-apple-ios18.1-simulator \
    -sdk $(xcrun --sdk iphonesimulator --show-sdk-path) \
    -F ../../../.build/MapLibre.xcframework/ios-arm64_x86_64-simulator/
