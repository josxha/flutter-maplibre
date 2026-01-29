#!/usr/bin/env bash

# Usage: ./build_maplibre.sh
#
# This script assumes that you have cloned maplibre-native as 'maplibre-native'
# (with --recurse-submodules) as a sibling of the flutter-maplibre repository.
#
# If successful, the script will output .build/MapLibre.xcframework

set -e

mkdir -p .build
script_dir=$(pwd)
cd ../../../maplibre-native
bazel build //platform/ios:MapLibre.dynamic \
    --compilation_mode=dbg \
    --copt=-Wno-unused-but-set-variable \
    --cxxopt=-Wno-unused-but-set-variable \
    --copt=-fdebug-compilation-dir="$(pwd)" \
    --cxxopt=-fdebug-compilation-dir="$(pwd)" \
    --features=dead_strip,thin_lto \
    --objc_enable_binary_stripping \
    --spawn_strategy=local \
    --//:renderer=metal \
    --apple_generate_dsym \
    --output_groups=+dsyms 2>&1 | tee "$script_dir/.build/build.log"
cd bazel-bin/platform/ios
rm -rf MapLibre.xcframework
unzip MapLibre.dynamic.xcframework.zip
mv MapLibre.xcframework MapLibre.xcframework.tmp

xcodebuild -create-xcframework \
    -framework MapLibre.xcframework.tmp/ios-arm64_x86_64-simulator/MapLibre.framework \
    -debug-symbols "$(pwd)"/MapLibre.dynamic_dsyms/MapLibre_ios_simulator.framework.dSYM \
    -framework MapLibre.xcframework.tmp/ios-arm64/MapLibre.framework \
    -debug-symbols "$(pwd)"/MapLibre.dynamic_dsyms/MapLibre_ios_device.framework.dSYM \
    -output MapLibre.xcframework

rm -rf MapLibre.xcframework.tmp
cp -rf "$(pwd)/MapLibre.xcframework" "$script_dir/.build/MapLibre.xcframework/"
date "+%Y-%m-%d %H:%M:%S" > "$script_dir/.build/time.txt"