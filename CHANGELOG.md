## 0.1.2

With this release, Android and Web are

### New Features

- Add `OfflineManager` for offline maps, cache management and bulk downloading.
- Add `PermissionsManager` to check and request location permissions.
- Add `WidgetLayer` to support widgets as Markers on the map.
- Add alternative Flutter platform view options for Texture Layer Hybrid
  Composition, Hybrid Composition, Virtual Display.
- Bump MapLibre Native on Android to version `11.6.+`.
- Add web-only controller functions `toScreenLocationSync()`,
  `toLngLatSync()`, `toScreenLocationsSync()`, `toLngLatsSync()`,
  `getMetersPerPixelAtLatitudeSync()` and `getVisibleRegionSync()`.
- Add `MapOptions.of(context)` and `MapOptions.maybeOf(context)`.
- Add `padding` and `alignment` parameters to the `MapScalebar` widget.

## Bug Fixes

- Fix WebAssembly builds.
- Remove unused `flutter_markdown` package.

## Misc

- Add unit tests, add Android integration tests.
- Use [codecov](https://app.codecov.io/gh/josxha/flutter-maplibre) to monitor
  test coverage.
- Improve file structure by using a `/platform` directory.

Full
Changelog: [v0.1.1...v0.1.2](https://github.com/josxha/flutter-maplibre/compare/v0.1.1...v0.1.2)

## 0.1.1

### New Features

- Add `controller.queryLayers()` to check what layers have been clicked.
- Add scalebar, zoom buttons, compass and attribution widgets as a unified user
  interface.
- Improve hash distribution
- Add `MapOptions` parameters to toggle platform specific UIs.

### Bug Fixes

- Fix `controller.getVisibleRegion()` throws exception on Android.

Full
Changelog: [v0.1.0...v0.1.1](https://github.com/josxha/flutter-maplibre/compare/v0.1.0...v0.1.1)

## 0.1.0

### Breaking Changes

- Use a "Web" prefix for all web-only controls, for
  example `WebGeolocateControl`.
- Rename web-only `MapOptions.controls` to `MapOptions.webControls`.
- Rename `jumpTo()` to `moveCamera()` and `flyTo()` to `animateCamera()`.
- Add `init` prefix to not modifiable `MapOptions` parameters.
- Remove click callbacks in favor of the event system.
- Bump minimum Flutter version
  to [3.24.0](https://medium.com/flutter/whats-new-in-flutter-3-24-6c040f87d1e4)
  (Minimum Dart version
  of [3.5.0](https://medium.com/dartlang/dart-3-5-6ca36259fa2f)).
- Can't await the end of `animateCamera()` in this version.

Read the [Upgrade Guide](https://flutter-maplibre.pages.dev/docs/upgrade) for
instructions on how to upgrade.

### New Features

- Bump MapLibre Android SDK
  to [11.5.1](https://github.com/maplibre/maplibre-native/releases/tag/android-v11.5.1).
- Add high level `AnnotationLayer`s as easy to use annotations.
- Use [jnigen](https://pub.dev/packages/jnigen) for direct interop with Java.
- Add user location to the map.
- Check Style for Kotlin

Full
Changelog: [v0.0.2...v0.1.0](https://github.com/josxha/flutter-maplibre/compare/v0.0.2...v0.1.0)

## 0.0.2

### New Features

- Add event system to the map.
- Bump MapLibre Native on Android to version 11.5.0.
- Bump other gradle dependencies.
- Add and remove sources to the active map style programmatically.
- Add and remove layers to the active map style programmatically.
- Add `minZoom`, `maxZoom`, `minPitch`, `maxPitch` and `maxBounds` parameter.
- Add duration parameters to `flyTo()`.
- Add option to disable some or all input gestures.
- `flyTo()` returns after the animation completes or throws an exception if it
  has been cancelled.
- Deprecate `tilt` parameters in favor of `pitch`.
- Deprecate `onClick`, `onDoubleClick`, `onSecondaryClick` and `onLongClick` in
  favor of the event system.

### Bug fixes

- Fix `jumpTo()` never returns on Android.

Full
Changelog: [v0.0.1+1...v0.0.2](https://github.com/josxha/flutter-maplibre/compare/v0.0.1+1...v0.0.2)

## 0.0.1+1

- Fix urls to website and embedded screenshots
- Remove unused `plugin_platform_interface` dependency

Full
Changelog: [v0.0.1...v0.0.1+1](https://github.com/josxha/flutter-maplibre/compare/v0.0.1...v0.0.1+1)

## 0.0.1

- Initial release
- Implement map for android and web
- Add docs
