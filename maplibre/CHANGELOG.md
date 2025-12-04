## 0.3.2

Maintenance release that optimizes the package on `pub.dev` and fixes a bug
in release builds on Android.

### New Features

- Optimize package size on `pub.dev` by restructuring the repository.
- Upgrade `jni` / `jnigen` to ^0.15.1.

### Bug Fixes

- Fix missing proguard rules for jni/jnigen causing issues in release builds on
  Android.

Full
Changelog: [v0.3.1...v0.3.2](https://github.com/josxha/flutter-maplibre/compare/v0.3.1...v0.3.2)

## 0.3.1

This release brings a couple of new features and bug fixes.
The android platform view creation has been migrated to Dart. Android is now
completely free from method channels.

### New Features

- Add `minZoom`, `maxZoom` to layers.
- Bump MapLibre Native on Android to 12.0.+.
- Migrate android platform view creation to Dart.
- Throw exception if layer or source id already exists when adding
  programmatically.
- Add `aboveLayerId` and `atIndex` to `addLayer()`.
- Add `addImages()` to `StyleController` to add multiple images at once.
- Add `addImageFromAssets()` to load an image from Flutter assets.
- Add `addImageFromIconData` to add an image from Flutter icons.

### Bug Fixes

- Fix `allowInteraction` parameter in `WidgetLayer` not working on web.
- Fix pub.dev score.
- Fix `maxBounds` parameter
- Fix `linePattern` int array causing crash on iOS.

Full
Changelog: [v0.3.0...v0.3.1](https://github.com/josxha/flutter-maplibre/compare/v0.3.0...v0.3.1)

## 0.3.0

In this release, I'm blazed to finally announce support for iOS.
Similar to our other platforms, iOS uses FFI to natively interop between Dart
and Swift/ObjC. Checkout
the [iOS documentation](https://flutter-maplibre.pages.dev/docs/getting-started/setup-ios)
to get started.
A big thanks to @mhernz, @gabbopalma and @jt274 that helped with their awesome
contributions in this release!

This release introduces breaking changes. Head over to
the [migration guide](https://flutter-maplibre.pages.dev/docs/upgrade) to learn
more on how to update your implementation.

### New Features

- **Breaking** Require Flutter 3.35
- **Breaking** Migrate from `geotypes`
  to [geobase](https://pub.dev/packages/geobase).
- **Breaking** Return logical pixels in events on all platforms.
- **Breaking** Add `screenPoint` parameter to `MapEventUserInput` events to show
  the screen coordinates in logical pixels where the user interacted with the
  map.
- **Breaking** Rename `rotationDuration` in `MapCompass` to
  `nativeRotationDuration`.
- **Breaking** Multiple `MapController` functions are now called synchronously,
  their `*Sync()` overloads have been removed.
- **Breaking** All declarative layers now require a `FeatureCollection`. This
  allows users to add properties to their layers.
- Add iOS as supported platform with MapLibre Native iOS 6.19.
- Update MapLibre Native Android to 11.13
- Load map styles from Flutter assets, a JSON string or via URI.
- Add `setStyle()`, to know when the map style has loaded, listen to
  `onStyleLoaded()`.
- Add support for PMTiles on the web.
- Add `androidTranslucentTextureSurface` and `androidForegroundLoadColor` to use
  a translucent map.
- Add `MapScalebar.units` to support imperial units in the scalebar.
- Add `featuresAtPoint()` and `featuresInRect()` to `MapController`.
- Update to `pigeon` 26.0.0

### Bug Fixes

- Fix missing export of `BearingRenderMode`
- Remove `dart:io` import to fix pub.dev WASM compatibility detection

Full
Changelog: [v0.2.2...v0.3.0](https://github.com/josxha/flutter-maplibre/compare/v0.2.2...v0.3.0)

## 0.2.2

Maintenance release and some new functionality.
Thanks for your contribution in this release @jt274!

### New Features

- Migrate `requestLocationPermissions()` and `addLayer()` to use JNI
- Update `jni` and `jnigen` to v0.14
- Update `pigeon` to v25
- Migrate gradle DSL to Kotlin
- Add `LngLatBounds.fromPoints()` constructor.

...and numerous other dependencies updated in this release.

Full
Changelog: [v0.2.1...v0.2.2](https://github.com/josxha/flutter-maplibre/compare/v0.2.1...v0.2.2)

## 0.2.1

This release builds upon the long anticipated merged threads in Flutter 3.29.0
which removes the need of switching threads. Furthermore, the release contains a
couple of features and new fixes.

Thanks for your contributions for this release, @felix-larsen and @pamtbaau!

### New Features

- Upgrade MapLibre Native on Android
  to [11.8.0](https://github.com/maplibre/maplibre-native/blob/main/platform/android/CHANGELOG.md#1180)
  which introduces support for PMTiles.
- Add `removePinchOnPressed` and `webRotationSpeed` as parameters to the
  `MapCompass` widget.
- Allow the `SourceAttribution` widget to use multiple lines for its
  attributions.
- Underline an attribution link for a `SourceAttribution` widget when hovered
  with a cursor.
- Add the parameter `allowInteraction` to the `WidgetLayer` that allows widgets
  to detect gestures on these widgets.
- Reintroduce awaitable `moveCamera()`, `animateCamera()` and `fitCamera()` on
  Android.
- Use synchronous JNI calls on Android to prevent thread hopping.

### Bug Fixes

- Fix exceptions when the map widget rebuilds a lot in a short amount of time.
- Fix `moveCamera()`, `animateCamera()` and `fitCamera()` does not ignore null
  parameters.
- Fix app freeze on Android using Flutter 3.29.0 caused by the merged threads.
- Fix exception when adding a RasterSource programatically.

### Misc

- Update examples and documentation.
- Set minimum Flutter version
  to [3.29.0](https://discord.com/channels/951867686378409984/951879268227485707/1339719764574081148)
  and minimum Dart version
  to [3.7.0](https://discord.com/channels/951867686378409984/951879268227485707/1339719747981545485).
- Use the new code formatting.
- Upgrade pigeon to 24.

Full
Changelog: [v0.2.0...v0.2.1](https://github.com/josxha/flutter-maplibre/compare/v0.2.0...v0.2.1)

## 0.2.0

This release is a collection of user affecting changes along a couple of new
features and bug fixes.
Head over to
the [migration guide](https://flutter-maplibre.pages.dev/docs/upgrade) to learn
more on how to update your implementation.

A big thanks to @gabbopalma for his contributions in this release.

### Breaking Changes

- Rename the `Layer` postfix of the more low level style classes
  to `StyleLayer`.
- Remove web-only map controls (ScaleControl, GeolocateControl,
  AttributionControl, FullscreenControl, LogoControl, NavigationControl,
  TerrainControl).
- Remove MapLibre Native specific User Interface options (logo, attribution,
  compass).
- Rename `ZoomButtons` to `ControlButtons`.
- Move style related controller calls to the `StyleController` that can be
  accessed via a nullable `mapController.style` field.
- Return the `StyleController` in the `onStyleLoaded()` callback and in
  the `MapEventStyleLoaded` event.
- An `ImageSource` now requires a static typed `LngLatQuad` object.
- Set the minimum required Flutter version to 3.27.

### New Features

- Bump MapLibre Native on Android to 11.7.+.
- Bump MapLibre GL JS on Web to version 5.
- Add `style.setProjection()` to switch to globe projection programmatically.
- Add a user location button to the `ControlButtons`.
- Bump ktlint to 0.4.19 and gradle to 8.6.1.
- Bump jni and jnigen to 0.13.0 and migrate bindings.
- Widen the gradle dependency constraints to allow patch updates.
- Add logo as pub.dev screenshot.
- Structure the API docs in topics.
- Add an internal `WidgetStateNative` for better code reuse in the upcoming iOS
  release.

## Bug Fixes

- Fix can't rotate with two fingers on web.
- Fix text overflow in the scale bar widget.
- Fix deprecations introduced in Flutter 3.27.

## Misc

- Enhance documentation.
- Build example app with java 21

Full
Changelog: [v0.1.2...v0.2.0](https://github.com/josxha/flutter-maplibre/compare/v0.1.2...v0.2.0)

## 0.1.2

This release adds the last missing features for Android and Web, that are were
planned for now. The package will continue its ongoing efforts for stability
before iOS gets added as a supported platform.

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

### Bug Fixes

- Fix WebAssembly builds.
- Remove unused `flutter_markdown` package.

### Misc

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
