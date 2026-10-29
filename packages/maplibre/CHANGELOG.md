## unreleased

### Breaking Changes

- Removed `maplibre_android`, `maplibre_ios` and `maplibre_webview`. `maplibre`
  now uses `maplibre_web` in the browser and `maplibre_native`, built on the
  MapLibre Native C API, on every other platform. `maplibre_native` renders on
  Android, iOS, macOS, Windows and Linux.
- Removed the `MapOptions` properties of the removed packages:
  `androidMode`, `androidTextureMode`, `androidTranslucentTextureSurface`,
  `androidForegroundLoadColor` and `webviewDebugMode`, and the
  `AndroidPlatformViewMode` enum.
- `MapController.featuresAtPoint` and `MapController.featuresInRect` return a
  `Future`, because MapLibre Native answers feature queries asynchronously.
- Removed `MapController.queryLayers` and `QueriedLayer`. Use
  `featuresAtPoint` with `layerIds` to test layers, and the new
  `RenderedFeature.sourceId`, `RenderedFeature.sourceLayer` and
  `RenderedFeature.layerId` for the source and the style layer.
- `RenderedFeature` equality and `hashCode` compare `id`, `sourceId`,
  `sourceLayer` and `layerId`.
- Web: map gestures are recognized in Flutter, as on every other platform,
  instead of by MapLibre GL JS. Its keyboard navigation and shift-drag box
  zoom are gone. A wheel notch zooms as far as in MapLibre GL JS.
- Removed the `pointer_interceptor` dependency. Widgets over the map no longer
  need a `PointerInterceptor` on web; `WidgetLayer.allowInteraction` works the
  same on every platform.
- `OfflineManager.getOfflineRegion` returns null for an unknown region.
  `setOfflineTileCountLimit` and `runPackDatabaseAutomatically` were removed,
  as MapLibre Native offers neither.
- Removed `PermissionManager`, `MapController.enableLocation`,
  `MapController.trackLocation`, `MapController.userLocationIsSupported`,
  `BearingRenderMode` and `BearingTrackMode`. Show the user location with a
  `UserLocationLayer`, and ask for permissions with `geolocator` or
  `permission_handler`. `MapControlButtons` takes `tracking` and
  `onTrackingPressed` instead of `showTrackLocation`.

- `StyleController.addImage`, `addImages` and `addImageFromAssets` take a
  `pixelRatio` of image pixels per logical pixel, 1 by default, instead of
  using the device pixel ratio. An image of N pixels shows N logical pixels
  wide at an icon size of 1 on every platform and screen, so images grow by
  the device pixel ratio on high-DPI screens; pass the ratio the image was
  made for to keep their size.
- `addImageFromCanvas` and `addImageFromIconData` take their sizes in
  logical pixels and render at the device pixel ratio. `addImageFromCanvas`
  requires `width` and `height` as doubles, the `painter` draws in logical
  pixels, and `addImageFromIconData` makes a 48 pixel icon by default.

### Features

- `UserLocationLayer` shows a stream of `UserLocation`s on every platform
  and can track them; the new `maplibre_geolocator` package adapts
  `geolocator` positions.
- Gestures are shared by all platforms: drag, pinch and twist, scroll wheel,
  double tap, double tap and drag, two-finger tilt, and right-button or
  Ctrl + left-button rotate and tilt.
- Native: the `OfflineManager` downloads, lists, merges, updates and deletes
  regions, and maintains the ambient cache. New `updateRegionMetadata`,
  `invalidateRegion`, `resumeDownload` and `includeIdeographs`; failed
  resources are reported as `OfflineDownloadException`s on the download
  stream.
- Native: maps cache resources in `maplibre_native.db` in the app support
  directory, which also holds the offline regions.
- `StyleController.getLineLayer` returns a `LineStyleLayerController`, whose
  getters and setters read and update the layer's paint, starting with
  `lineGradient`. Setters don't wait for the map, so they can animate a
  layer every frame. `GeoJsonSource.lineMetrics` enables `line-progress`.
- `StyleController.addImageFromUiImage` adds a `dart:ui` `Image` to the
  map from its pixels, without encoding it.
- Native: built on `maplibre_native_ffi` 0.202610.3. Intel Macs are
  supported, maps share glyphs, readback on discrete GPUs is faster, and
  Android loads styles and tiles through `HttpURLConnection`, which follows
  the app's network security config: plain `http://` URLs need a
  `network-security-config` that permits cleartext for their hosts.
- Native: a map shows its initial camera and style in its first frame.
- Native: closing a map no longer blocks the UI thread while its tiles and
  GPU work finish.
- Native: glyph and sprite load errors are logged.

### Bug Fixes

- Web: widgets over the map no longer let taps and drags through to the map.
- Web: images added with `addImage`, `addImageFromIconData` and
  `addImageFromWidget` keep their size with the skwasm renderer
  (`--wasm`), which decoded and encoded them at the size of the view.
- `MarkerLayer` applies `textOpacity` (it used `iconOpacity`) and
  `iconTranslate`, and `PolylineLayer` applies `blur`.
- Native: `animateCamera`, `moveCamera` and `fitBounds` complete when the
  camera's transitions end, including when another move cancels them.
- Native: maps keep rendering in profile and release builds, where they
  stopped after about 30 frames.
- Native: `MapEventCameraIdle` follows the last transition of an
  animation.
- Native: a camera move from a short gesture is reported with
  `CameraChangeReason.apiGesture`.
- Native: removing a layer or source that does not exist is not an error.
- Native: `setProjection(MapProjection.globe)` keeps Mercator and logs once
  instead of throwing, as MapLibre Native has no globe projection.
- Native: adding a `VideoSource` throws an `UnsupportedError` (it threw an
  `UnimplementedError`), as MapLibre Native has no video sources.
- Native: attributions of tile sources are reported once they load.
- Native: GeoJSON sources report their attributions, from the style JSON
  and from `addSource`.
- Web: `OfflineManager.createInstance` and `PermissionManager()` throw an
  `UnsupportedError`.

## 0.3.7

Thanks for everyone who contributed in this release!
@glandais, @miakh, @teamacco, @Mazen-Embaby, @fmt-Println-MKO, @BartoszStasiurka

### Features

- Requires Dart 3.13 and Flutter 3.47 or newer.
- iOS: ffigen v22, code_assets v2, objective_c 9.5

### Bug Fixes

- Android: `OfflineManager.downloadRegion` no longer leaks a JNI global
  reference per status event, which aborted the process with a global
  reference table overflow partway through a large region download.
- Android: calls on a `StyleController` whose native style was already released
  are ignored instead of aborting the process with a JNI error.
- Android: remove the ktlint Gradle plugin, which broke builds of apps that
  depend on `maplibre_android`.
- Android: add a missing proguard rule for obfuscated release builds.
- iOS: fix a crash when setting hillshade `colorArray` and `numberArray` paint
  properties.
- iOS: fix `animateCamera()` crash when called before the native view has a
  layout size.
- iOS: tear down `MLNMapView` and its gesture recognizers when the map is
  disposed.
- iOS: preserve zoom levels, attribution, raster tile size, and supported DEM
  encoding when adding tile-template sources at runtime.
- Web: `fitBounds()` no longer reuses padding from a previous camera move.

## 0.3.6

Thanks for everyone who contributed in this release!
@emanuelesenis, @BartoszStasiurka, @D3CK3R, @Mazen-Embaby, @teamacco, @lukeboyden

### Features

- Android: MapLibre Native Android 13.5
- iOS: MapLibre Native iOS 6.29
- Android: jnigen 0.17
- iOS: hooks v2, native_toolchain_c 0.19
- Android: Migrate Plugin to Built-in Kotlin
- Support for the tolerance parameter in GeoJsonSource
- Add geometry field to RenderedFeature

### Bug Fixes

- Android: fix platform views are never removed from the internal registry,
  leaking a `FrameLayout` and its native map state per map create/dispose
  cycle.
- Android: `StyleController` now releases its native style reference when
  the owning `MapLibreMap` is disposed, instead of staying technically
  usable on a torn-down map.
- Android: fix `StyleController` and several map query methods
  (`updateGeoJsonSource`, `removeLayer`/`removeSource`/`removeImage`,
  `getLayerIds`, `getAttributionsSync`, `featuresAtPoint`/`featuresInRect`)
  leak JNI global references on every call.
- Android: camera listeners no longer block the calling Java thread on
  camera events.
- iOS: fix long tab took a long time to be registered
- iOS: fix SPM package resolved bootstrap
- iOS: fix GeoJSON rendering failure in obfuscated releases
- Android: fix proguard rules for obfuscated release builds
- skip re-serializing a GeoJSON source whose layer is unchanged.

## 0.3.5

This release contains a couple of bug fixes and improvements.
Thanks to @BartoszStasiurka for his contributions in this release!

- fix: set default `maxZoom` to 22 for `RasterSource`, `RasterDemSource` and `VectorSource`.
- fix: missing export of `DownloadProgress`
- Add `deleteRegion()` to `OfflineManager` by @BartoszStasiurka
- Android: fix `onStyleLoaded()` unreliable if style not loaded immediately
- Android: fix `featuresAtPoint` causes `ClassNotFoundException` in release builds
- Android: update MapLibre Native to 13.0
- Android: update `jni` to v1.0.0, `jnigen` to 0.16.0
- Android: fix symbol icons appear smaller than on other platforms.
- iOS: update MapLibre Native to 6.25

Full Changelog: [v0.3.4+1...v0.3.5](https://github.com/josxha/flutter-maplibre/compare/v0.3.4+1...v0.3.5)

## 0.3.4+1

### Bug Fixes

- Web: fix `addSource()` with raster and raster-dem source throws exception.
- WebView: fix `addImage()` results in image with wrong pixel ratio.
- iOS: fix `animateCamera()` causes the zoom level to jumps to the target zoom level.
- iOS: fix `onStyleLoaded()` callback is not called when style loads immediately.

### Maintenance

- Migrate website to zensical and update documentation.
- Improve pub.dev scores of packages.

Full Changelog: [v0.3.4...v0.3.4+1](https://github.com/josxha/flutter-maplibre/compare/v0.3.4...v0.3.4+1)

## 0.3.4

This feature release introduces a complete migration of the iOS platform to FFI and experimental support for Windows and macOS has been added using with web view. 
The package has also been restructured into a federated plugin with separate packages for each platform.

### New Features

- iOS: migrate iOS to a complete FFI implementation and remove all pigeon method channel usage.
- Add experimental Windows and macOS support with a web view.
- Migrate the package to a complete federated plugin with separate packages for each platform.
- Add `padding` parameter to `moveCamera()` and `animateCamera()`.

### Bug Fixes

- Fix `padding` parameter of `fitBounds()` doesn't account for device pixel ratio.
- iOS: fix don't call `setState()` if widget is not mounted.
- iOS: fix `listOfflineRegions()` throws exception if region packs are not available yet.
- Fix gesture callbacks return incorrect screen offset, caused by incorrect device pixel ratio conversion.
- Android: fix map disposal causes sometimes a crash.
- Web: fix missing device pixel ratio adjustment on `addImage()`

Full Changelog: [v0.3.3+2...v0.3.4](https://github.com/josxha/flutter-maplibre/compare/v0.3.3+2...v0.3.4)

## 0.3.3+2

### Bug Fixes

- Android: fix can't parse numeric array in layer properties
- Android: add missing `metadata` parameter to `OfflineRegion`

Full Changelog: [v0.3.3+1...v0.3.3+2](https://github.com/josxha/flutter-maplibre/compare/v0.3.3+1...v0.3.3+2)

## 0.3.3+1

### Bug Fixes

- Fix `addLayer()` throws double release error on Android
- Fix `filter` cannot be parsed on Android
- Tighten version constraint for `maplibre_ios` to fix pub.dev score

Full Changelog: [v0.3.3...v0.3.3+1](https://github.com/josxha/flutter-maplibre/compare/v0.3.3...v0.3.3+1)

## 0.3.3

This release focuses on stability improvements along with a few small enhancements. Notably, it is now possible to render a Flutter widget or canvas directly into an image and use it as a map marker without any delay.
Many thanks to @markszente and @BartoszStasiurka for their contributions to this release.

I would also like to extend my sincere gratitude to Thilko M., @oboukili, @ton-An, @YumNumm, and @smallTrogdor for helping fund the development of this package throughout 2025. Your support is truly appreciated!

### New Features

- update MapLibre Native on iOS to [6.21](https://github.com/maplibre/maplibre-native/blob/main/platform/ios/CHANGELOG.md#6210)
- update to [ffigen v20](https://pub.dev/packages/ffigen/changelog#2000), [objective_c v9](https://pub.dev/packages/objective_c/changelog#900)
- Add `padding` to `fitBounds()` on iOS.
- Render a Flutter `Widget` or `Canvas` into an image and use it as marker on the map.
- Add `sourceLayerId` to style layers for vector sources.
- Add `filter` expressions to style layers.

### Bug Fixes

- Fix iOS can't load style from file.
- Add missing `MapEventCameraIdle`, `MapEventStartMoveCamera` events on iOS.
- Fix `queryLayers()` throws exception on iOS when receiving numeric layer IDs.
- Fix `onCameraMoved()` callback returning altitude instead of zoom level on iOS.
- Fix invisible map on android when coming back from background.
- Fix double tap zoom interaction on iOS.

Full Changelog: [v0.3.2...v0.3.3](https://github.com/josxha/flutter-maplibre/compare/v0.3.2...v0.3.3)

## 0.3.2

Maintenance release that optimizes the package on `pub.dev` and fixes a bug in release builds on Android.

### New Features

- Upgrade MapLibre Native on Android to [12.2](https://github.com/maplibre/maplibre-native/blob/main/platform/android/CHANGELOG.md#1220).
- Optimize package size on `pub.dev` by restructuring the repository.
- Upgrade `jni` / `jnigen` to ^0.15.1.

### Bug Fixes

- Fix missing proguard rules for jni/jnigen causing issues in release builds on Android.

Full Changelog: [v0.3.1...v0.3.2](https://github.com/josxha/flutter-maplibre/compare/v0.3.1...v0.3.2)

## 0.3.1

This release brings a couple of new features and bug fixes. The android platform view creation has been migrated to Dart. Android is now completely free from method channels.

### New Features

- Add `minZoom`, `maxZoom` to layers.
- Bump MapLibre Native on Android to 12.0.+.
- Migrate android platform view creation to Dart.
- Throw exception if layer or source id already exists when adding programmatically.
- Add `aboveLayerId` and `atIndex` to `addLayer()`.
- Add `addImages()` to `StyleController` to add multiple images at once.
- Add `addImageFromAssets()` to load an image from Flutter assets.
- Add `addImageFromIconData` to add an image from Flutter icons.

### Bug Fixes

- Fix `allowInteraction` parameter in `WidgetLayer` not working on web.
- Fix pub.dev score.
- Fix `maxBounds` parameter
- Fix `linePattern` int array causing crash on iOS.

Full Changelog: [v0.3.0...v0.3.1](https://github.com/josxha/flutter-maplibre/compare/v0.3.0...v0.3.1)

## 0.3.0

In this release, I'm blazed to finally announce support for iOS. Similar to our other platforms, iOS uses FFI to natively interop between Dart and Swift/ObjC. Checkout
the [iOS documentation](https://flutter-maplibre.pages.dev/docs/getting-started/setup)
to get started.
A big thanks to @mhernz, @gabbopalma and @jt274 that helped with their awesome
contributions in this release!

This release introduces breaking changes. Head over to the [migration guide](https://flutter-maplibre.pages.dev/docs/migrate/upgrade-from-v0.2.x/) to learn more on how to update your implementation.

### New Features

- **Breaking** Require Flutter 3.35
- **Breaking** Migrate from `geotypes` to [geobase](https://pub.dev/packages/geobase).
- **Breaking** Return logical pixels in events on all platforms.
- **Breaking** Add `screenPoint` parameter to `MapEventUserInput` events to show the screen coordinates in logical pixels where the user interacted with the map.
- **Breaking** Rename `rotationDuration` in `MapCompass` to `nativeRotationDuration`.
- **Breaking** Multiple `MapController` functions are now called synchronously, their `*Sync()` overloads have been removed.
- **Breaking** All declarative layers now require a `FeatureCollection`. This allows users to add properties to their layers.
- Add iOS as supported platform with MapLibre Native iOS 6.19.
- Update MapLibre Native Android to 11.13
- Load map styles from Flutter assets, a JSON string or via URI.
- Add `setStyle()`, to know when the map style has loaded, listen to `onStyleLoaded()`.
- Add support for PMTiles on the web.
- Add `androidTranslucentTextureSurface` and `androidForegroundLoadColor` to use a translucent map.
- Add `MapScalebar.units` to support imperial units in the scalebar.
- Add `featuresAtPoint()` and `featuresInRect()` to `MapController`.
- Update to `pigeon` 26.0.0

### Bug Fixes

- Fix missing export of `BearingRenderMode`
- Remove `dart:io` import to fix pub.dev WASM compatibility detection

Full Changelog: [v0.2.2...v0.3.0](https://github.com/josxha/flutter-maplibre/compare/v0.2.2...v0.3.0)

## 0.2.2

Maintenance release and some new functionality. Thanks for your contribution in this release @jt274!

### New Features

- Migrate `requestLocationPermissions()` and `addLayer()` to use JNI
- Update `jni` and `jnigen` to v0.14
- Update `pigeon` to v25
- Migrate gradle DSL to Kotlin
- Add `LngLatBounds.fromPoints()` constructor.

...and numerous other dependencies updated in this release.

Full Changelog: [v0.2.1...v0.2.2](https://github.com/josxha/flutter-maplibre/compare/v0.2.1...v0.2.2)

## 0.2.1

This release builds upon the long anticipated merged threads in Flutter 3.29.0 which removes the need of switching threads. Furthermore, the release contains a couple of features and new fixes.

Thanks for your contributions for this release, @felix-larsen and @pamtbaau!

### New Features

- Upgrade MapLibre Native on Android to [11.8.0](https://github.com/maplibre/maplibre-native/blob/main/platform/android/CHANGELOG.md#1180) which introduces support for PMTiles.
- Add `removePinchOnPressed` and `webRotationSpeed` as parameters to the `MapCompass` widget.
- Allow the `SourceAttribution` widget to use multiple lines for its attributions.
- Underline an attribution link for a `SourceAttribution` widget when hovered with a cursor.
- Add the parameter `allowInteraction` to the `WidgetLayer` that allows widgets to detect gestures on these widgets.
- Reintroduce awaitable `moveCamera()`, `animateCamera()` and `fitCamera()` on Android.
- Use synchronous JNI calls on Android to prevent thread hopping.

### Bug Fixes

- Fix exceptions when the map widget rebuilds a lot in a short amount of time.
- Fix `moveCamera()`, `animateCamera()` and `fitCamera()` does not ignore null parameters.
- Fix app freeze on Android using Flutter 3.29.0 caused by the merged threads.
- Fix exception when adding a RasterSource programatically.

### Misc

- Update examples and documentation.
- Set minimum Flutter version to [3.29.0](https://discord.com/channels/951867686378409984/951879268227485707/1339719764574081148) and minimum Dart version to [3.7.0](https://discord.com/channels/951867686378409984/951879268227485707/1339719747981545485).
- Use the new code formatting.
- Upgrade pigeon to 24.

Full Changelog: [v0.2.0...v0.2.1](https://github.com/josxha/flutter-maplibre/compare/v0.2.0...v0.2.1)

## 0.2.0

This release is a collection of user affecting changes along a couple of new features and bug fixes.
Head over to the [migration guide](https://flutter-maplibre.pages.dev/docs/migrate/upgrade-from-v0.2.x/) to learn more on how to update your implementation.

A big thanks to @gabbopalma for his contributions in this release.

### Breaking Changes

- Rename the `Layer` postfix of the more low level style classes to `StyleLayer`.
- Remove web-only map controls (ScaleControl, GeolocateControl, AttributionControl, FullscreenControl, LogoControl, NavigationControl, TerrainControl).
- Remove MapLibre Native specific User Interface options (logo, attribution, compass).
- Rename `ZoomButtons` to `ControlButtons`.
- Move style related controller calls to the `StyleController` that can be accessed via a nullable `mapController.style` field.
- Return the `StyleController` in the `onStyleLoaded()` callback and in the `MapEventStyleLoaded` event.
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
- Add an internal `WidgetStateNative` for better code reuse in the upcoming iOS release.

## Bug Fixes

- Fix can't rotate with two fingers on web.
- Fix text overflow in the scale bar widget.
- Fix deprecations introduced in Flutter 3.27.

## Misc

- Enhance documentation.
- Build example app with java 21

Full Changelog: [v0.1.2...v0.2.0](https://github.com/josxha/flutter-maplibre/compare/v0.1.2...v0.2.0)

## 0.1.2

This release adds the last missing features for Android and Web, that are were planned for now. The package will continue its ongoing efforts for stability before iOS gets added as a supported platform.

### New Features

- Add `OfflineManager` for offline maps, cache management and bulk downloading.
- Add `PermissionsManager` to check and request location permissions.
- Add `WidgetLayer` to support widgets as Markers on the map.
- Add alternative Flutter platform view options for Texture Layer Hybrid Composition, Hybrid Composition, Virtual Display.
- Bump MapLibre Native on Android to version `11.6.+`.
- Add web-only controller functions `toScreenLocationSync()`, `toLngLatSync()`, `toScreenLocationsSync()`, `toLngLatsSync()`, `getMetersPerPixelAtLatitudeSync()` and `getVisibleRegionSync()`.
- Add `MapOptions.of(context)` and `MapOptions.maybeOf(context)`.
- Add `padding` and `alignment` parameters to the `MapScalebar` widget.

### Bug Fixes

- Fix WebAssembly builds.
- Remove unused `flutter_markdown` package.

### Misc

- Add unit tests, add Android integration tests.
- Use [codecov](https://app.codecov.io/gh/josxha/flutter-maplibre) to monitor test coverage.
- Improve file structure by using a `/platform` directory.

Full Changelog: [v0.1.1...v0.1.2](https://github.com/josxha/flutter-maplibre/compare/v0.1.1...v0.1.2)

## 0.1.1

### New Features

- Add `controller.queryLayers()` to check what layers have been clicked.
- Add scalebar, zoom buttons, compass and attribution widgets as a unified user interface.
- Improve hash distribution
- Add `MapOptions` parameters to toggle platform specific UIs.

### Bug Fixes

- Fix `controller.getVisibleRegion()` throws exception on Android.

Full Changelog: [v0.1.0...v0.1.1](https://github.com/josxha/flutter-maplibre/compare/v0.1.0...v0.1.1)

## 0.1.0

### Breaking Changes

- Use a "Web" prefix for all web-only controls, for example `WebGeolocateControl`.
- Rename web-only `MapOptions.controls` to `MapOptions.webControls`.
- Rename `jumpTo()` to `moveCamera()` and `flyTo()` to `animateCamera()`.
- Add `init` prefix to not modifiable `MapOptions` parameters.
- Remove click callbacks in favor of the event system.
- Bump minimum Flutter version to [3.24.0](https://medium.com/flutter/whats-new-in-flutter-3-24-6c040f87d1e4) (Minimum Dart version of [3.5.0](https://medium.com/dartlang/dart-3-5-6ca36259fa2f)).
- Can't await the end of `animateCamera()` in this version.

Read the [Upgrade Guide](https://flutter-maplibre.pages.dev/docs/migrate/upgrade-from-v0.2.x/) for
instructions on how to upgrade.

### New Features

- Bump MapLibre Android SDK to [11.5.1](https://github.com/maplibre/maplibre-native/releases/tag/android-v11.5.1).
- Add high level `AnnotationLayer`s as easy to use annotations.
- Use [jnigen](https://pub.dev/packages/jnigen) for direct interop with Java.
- Add user location to the map.
- Check Style for Kotlin

Full Changelog: [v0.0.2...v0.1.0](https://github.com/josxha/flutter-maplibre/compare/v0.0.2...v0.1.0)

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
- `flyTo()` returns after the animation completes or throws an exception if it has been cancelled.
- Deprecate `tilt` parameters in favor of `pitch`.
- Deprecate `onClick`, `onDoubleClick`, `onSecondaryClick` and `onLongClick` in favor of the event system.

### Bug fixes

- Fix `jumpTo()` never returns on Android.

Full Changelog: [v0.0.1+1...v0.0.2](https://github.com/josxha/flutter-maplibre/compare/v0.0.1+1...v0.0.2)

## 0.0.1+1

- Fix urls to website and embedded screenshots
- Remove unused `plugin_platform_interface` dependency

Full Changelog: [v0.0.1...v0.0.1+1](https://github.com/josxha/flutter-maplibre/compare/v0.0.1...v0.0.1+1)

## 0.0.1

- Initial release
- Implement map for android and web
- Add docs
