# Roadmap

Open work for flutter-maplibre, as of October 2026. The native rewrite on
the MapLibre Native C API lives on the `maplibre-native-ffi` branch
([#585](https://github.com/josxha/flutter-maplibre/pull/585), draft).
Known gaps are tracked in detail in [`.agents/decisions.md`](.agents/decisions.md).

## Finish the native rewrite (#585)

### Ship the branch

- Push the local commits (`5464acdc` fixes, `df4bbc54` test rework) so CI
  runs the integration tests on all six platforms for the first time.
- Run the integration tests on Linux, macOS and iOS. Only Windows, an
  Android emulator and web have passed so far.
- Run on a Linux machine through Flutter: check the zero-copy path against
  `MAPLIBRE_NATIVE_DISABLE_ZERO_COPY=1` and look for the CPU readback
  fallback log line.
- Run iOS and macOS against the 0.202610.2 release library (they were only
  run against a local C build), and on a real iOS device.
- Check the software-Vulkan setup on the Windows CI runner.
- Check the `maplibre_web` unit tests, which hung locally under
  `--platform chrome`.
- Mark #585 ready for review once CI is green.

### Known gaps to close

- Web tests: a single tap or secondary tap never reaches the map (double
  taps and long presses do). Find out whether real browser clicks are
  affected; the two tests are skipped on web.
- iOS simulator: `MapScalebar show and update` is off by about 1.3 px at
  zoom 4, because the scalebar and the test take their latitude at
  different points.
- `OfflineManager` is not implemented on native, though the C API has
  offline regions.
- `PermissionManager`, user location and globe projection are missing on
  native.
- Shared gestures: native pans stop dead on release (no fling), and zoom and
  rotation don't fling anywhere. The C API has no inertia, so it would run in
  Dart over animated camera deltas.
- Web lost gl-js keyboard navigation, shift-drag box zoom and the grab
  cursor, which the shared recognizer doesn't offer.
- The wheel zooms half as far on 2x screens on web, since Flutter divides
  Chrome's wheel delta by the device pixel ratio.
- Android frame sync: an OpenGL ES map wakes its render thread through the
  Dart isolate; the binding now takes `Wake.native`, so the JNI shim could
  wake it directly. Two OpenGL ES maps still use two threads and contexts,
  though the C library can now share one graphics thread.
- Metal copies every frame on the GPU and waits on the Dart UI thread.
- MapLibre Native reports no GeoJSON source attributions, so
  `getAttributions` lists them on web only.
- The C library's Apple presets target macOS 14.3 and iOS 15.0, above the
  plugin's `Package.swift` minimums (10.15 and 13). Raise the minimums or
  get the presets lowered.
- Intel Macs and x86_64 simulators have no published C library.
- Touch tilt and double-tap-drag are untested on Windows touchscreens.

### Upstream (maplibre-native-ffi)

- Pick up the unreleased hook fix on main (the hook no longer forces a
  second build after its download) with the next release.
- 15 of our 16 feedback points are still open; frame sync (#1) is only
  partly addressed.
- Note new API gaps in `.agents/decisions.md` as they come up.

## Open issues

- v0.4.0 milestone: static typed expressions (#72), initial bounds fit in
  the constructor (#500), `ImageSource` from a local file (#502),
  miscellaneous changes (#402).
- Location: expose a user location stream (#528), unify location and
  support it on web (#233), `MapEventTrackingModeChanged` (#430).
- Features: custom HTTP headers for tile requests (#383, PR #573 open),
  feature tap and drag events (#151), animated marker position (#311), map
  centering offset (#246), static map configurations (#236).
- Bugs to recheck against the native rewrite, since most were filed against
  the old Android and iOS packages: #581, #535 (offline), #555 (Android
  source updates), #544 (`MapEventUserInput` on drags), #499 and #498 (iOS),
  #301 (Android `ImageReader`). #477 (Vulkan on Android) is done on the
  branch.

## Way forward

### maplibre-gl-js v6

- PR #586 was closed unmerged: v6 is breaking for apps (gl-js is ESM-only,
  so `index.html` must import it as a module), so it is planned for 0.4.0.
  The branch `web/maplibre-gl-js-v6` still exists.
- Rebase it onto the native rewrite rather than main, as both change the
  setup docs and the release tooling.
- Keep the clear `StateError` when `maplibregl` isn't loaded, and document
  that v5 keeps working.
- Run the web integration tests against v6 in CI.

### CRUD on layers and sources

- Today `StyleController` can only add and remove layers and sources,
  update GeoJSON data and list layer ids.
- The ffi binding already offers introspection (`listStyleLayers`,
  `getStyleLayer`, `getStyleLayerJson`, `listStyleSources`,
  `getStyleSource`) and updates (`setStyleLayerProperty` for paint, layout,
  filter, source, zoom range; `moveStyleLayer`; command groups to apply
  several changes in one frame). gl-js covers the same with
  `setPaintProperty`, `setLayoutProperty`, `setFilter`, `moveLayer` and
  `getStyle`.
- Add to the interface: get a layer or source, set and get a paint or
  layout property, set a filter, set a zoom range, move a layer, and update
  a source (tiles, URL, image coordinates).
- Read layers back into the typed `Layer`/`Source` classes; fall back to
  raw JSON for properties they don't model.
- Batch changes on native with command groups, so a set of edits shows in
  one frame.
- Give the style classes `==` and `hashCode`, so the declarative layers can
  diff properties and update in place instead of removing and re-adding.

### Offline support

- Implement `OfflineManager` on native over the C API's offline regions,
  replacing the old Android and iOS implementations.
- Cover download, list, merge, delete and progress events with integration
  tests on a local style and tiles.
- Carry over the fixes for #581 (non-ASCII metadata) and #535 (glyph URL
  `regex_error`), and test both cases.
- Keep MBTiles (`mbtiles://`) as the simple offline path, now supported on
  every native platform.
- Web stays unsupported; document a service worker cache as the
  alternative.

### User location and permissions

- The native plugins have no location component today (the old Android
  and iOS SDKs had one). A Flutter layer fed by a position stream would
  work the same on every platform including web (#233, #528).
- Built-in permissions: no extra dependency for users, but we would
  maintain Kotlin, Objective-C and desktop code for every OS's permission
  model, outside what a map library should own.
- Recommend `permission_handler` and `geolocator`: both are widely used and
  many apps already depend on them. `geolocator` covers mobile, web and
  desktop; `permission_handler` covers mobile, web and Windows, while
  `geolocator` itself can ask for location permission elsewhere.
- Recommendation: drop `PermissionManager` from the interface. Take a
  `Stream` of positions (or a small `LocationProvider` interface), and ship
  an optional `geolocator` adapter so it works with one line. Document
  `permission_handler` for asking permissions.
- Tracking modes and `MapEventTrackingModeChanged` (#430) then live in Dart
  and behave the same everywhere.

### Statically typed expressions (#72)

- Today expressions are raw `List`/`Map` JSON.
- Add a typed builder that maps one-to-one to the style spec (`get`,
  `match`, `interpolate`, `step`, `case`, `coalesce`, math, comparison),
  with Dart types for the result (`Expression<double>`, `Expression<Color>`,
  …), serializing to the same JSON.
- Generate it from the style spec's `v8.json` with a script in
  `tool/codegen`, so it stays in sync with MapLibre. The layer and source
  classes are hand-written today and could be generated the same way.
- Accept either a literal or an `Expression<T>` for each layer property.
- Start with filters and data-driven paint, the most common uses, and keep
  raw JSON as an escape hatch.
- Build it after layer CRUD, so the setters take typed values from the
  start.

### Suggested order

1. Ship the native rewrite (#585) as 0.4.0-dev.
2. maplibre-gl-js v6 on top of it.
3. Layer and source CRUD.
4. Typed expressions.
5. User location as a Flutter layer, with the permission decision above.
6. Offline on native.
