#!/usr/bin/env bash
set -euo pipefail

# --- Resolve Flutter SDK root dynamically ---
if ! command -v flutter >/dev/null 2>&1; then
  echo "❌ Flutter not found in PATH. Please ensure 'flutter' is installed and available."
  exit 1
fi

FLUTTER_ROOT=$(dirname $(dirname $(which flutter)))
SDK_PATH=$(xcrun --sdk iphonesimulator --show-sdk-path)

# --- Locate Flutter framework for the iOS simulator ---
FLUTTER_FRAMEWORK_PATH="$FLUTTER_ROOT/bin/cache/artifacts/engine/ios/Flutter.xcframework/ios-arm64_x86_64-simulator"

if [ ! -d "$FLUTTER_FRAMEWORK_PATH" ]; then
  echo "❌ Flutter.xcframework not found at: $FLUTTER_FRAMEWORK_PATH"
  echo "Run 'flutter precache --ios' to download iOS engine artifacts."
  exit 1
fi

echo "✅ Using Flutter framework at: $FLUTTER_FRAMEWORK_PATH"
echo "✅ Using iOS SDK at: $SDK_PATH"

# --- Compile Swift sources and emit Objective-C headers ---
swiftc \
  -c MapLibreRegistry.swift \
  -c Extensions.swift \
  -c Helpers.swift \
  -module-name maplibre_ios \
  -emit-objc-header-path MapLibreIos.h \
  -emit-library -o libmaplibreios.dylib \
  -target arm64-apple-ios18.5-simulator \
  -sdk "$SDK_PATH" \
  -F ../../../.build/MapLibre.xcframework/ios-arm64_x86_64-simulator/ \
  -F "$FLUTTER_FRAMEWORK_PATH" \
  -framework MapLibre \
  -framework Flutter

echo "✅ Swift headers generated successfully: MapLibreIos.h"