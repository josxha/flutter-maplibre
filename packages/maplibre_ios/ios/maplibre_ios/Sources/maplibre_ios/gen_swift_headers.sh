#!/usr/bin/env bash
set -euo pipefail

# --- Resolve Flutter SDK root dynamically ---
# `which flutter` returns a path that may be a symlink (homebrew cask installs,
# fvm-managed SDKs, asdf, etc.). Resolve the real path before walking up to the
# SDK root, otherwise Flutter.xcframework lookup goes to the wrong place.
if ! command -v flutter >/dev/null 2>&1; then
  echo "❌ Flutter not found in PATH. Please ensure 'flutter' is installed and available."
  exit 1
fi

FLUTTER_BIN_REAL=$(perl -MCwd=abs_path -e 'print abs_path(shift)' "$(command -v flutter)")
FLUTTER_ROOT=$(dirname "$(dirname "$FLUTTER_BIN_REAL")")

SDK_PATH=$(xcrun --sdk iphonesimulator --show-sdk-path)
# Derive the simulator deployment-target from the currently-installed iOS SDK.
# Hardcoding (e.g. ios18.5) breaks when Xcode upgrades ship a newer SDK (26+)
# and this script isn't updated in lockstep.
SDK_VERSION=$(xcrun --sdk iphonesimulator --show-sdk-version)
SWIFT_TARGET="arm64-apple-ios${SDK_VERSION}-simulator"

# --- Locate Flutter framework for the iOS simulator ---
FLUTTER_FRAMEWORK_PATH="$FLUTTER_ROOT/bin/cache/artifacts/engine/ios/Flutter.xcframework/ios-arm64_x86_64-simulator"

if [ ! -d "$FLUTTER_FRAMEWORK_PATH" ]; then
  echo "❌ Flutter.xcframework not found at: $FLUTTER_FRAMEWORK_PATH"
  echo "Run 'flutter precache --ios' to download iOS engine artifacts."
  exit 1
fi

echo "✅ Using Flutter framework at: $FLUTTER_FRAMEWORK_PATH"
echo "✅ Using iOS SDK at: $SDK_PATH"
echo "✅ Swift target: $SWIFT_TARGET"

# --- Compile Swift sources and emit Objective-C headers ---
swiftc \
  -c Extensions.swift \
  -c FlutterApi.swift \
  -c Helpers.swift \
  -c MapLibreRegistry.swift \
  -module-name maplibre_ios \
  -emit-objc-header-path MapLibreIos.h \
  -emit-library -o libmaplibreios.dylib \
  -target "$SWIFT_TARGET" \
  -sdk "$SDK_PATH" \
  -F ../../../.build/MapLibre.xcframework/ios-arm64_x86_64-simulator/ \
  -F "$FLUTTER_FRAMEWORK_PATH" \
  -framework MapLibre \
  -framework Flutter

echo "✅ Swift headers generated successfully: MapLibreIos.h"
