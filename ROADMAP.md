# Roadmap

Open work on the flutter-maplibre packages, as of October 2026. Known gaps
are tracked in detail in [`.agents/decisions.md`](.agents/decisions.md).

## Native platforms

- Linux: run the integration tests through Flutter on a Linux machine, and
  check the zero-copy path against `MAPLIBRE_NATIVE_DISABLE_ZERO_COPY=1`
  (look for the CPU readback fallback log line). Windows, macOS, an iOS
  simulator, an Android emulator and web pass.
- iOS devices: run the integration tests on one, which also checks
  shared-storage render targets of the Metal ring.
- Metal: no check sees Flutter's GPU reads of a slot, so the ring holds the
  last two slots Flutter took. Look for tearing on a device under load.
- macOS needs 14.3, above Flutter 3.47's 12.0: MapLibre Native itself
  refuses to build for less (its `CMakeLists.txt` fails below 14.3), so the
  C library can't lower it.
- Intel Macs: 0.202610.3 publishes a macOS x64 library and the example
  builds universal apps, but no Intel Mac has run the tests. x86_64 iOS
  simulators still have no library.
- Linux in a cloud container (Xvfb, llvmpipe and lavapipe): the integration
  tests crash Flutter's raster thread after a few tests, before and after
  the 0.202610.3 update, on the zero-copy and the CPU path. Check whether
  it is the container's GL or our GL texture.
- Profile and release builds: check on a device that maps keep rendering
  with the package's own frame wake (see Upstream).
- Touch tilt and double-tap-drag are untested on Windows touchscreens.
- On the iOS simulator in CI, flutter test sometimes never attaches to the
  app (3.47.7 and 3.47.8): the app logs its VM service, and no test starts.
  The watchdog restarts such a run, up to three times; the cause in
  flutter_tools is open.
- The `maplibre_web` unit tests hang locally under `--platform chrome`.

## Known gaps

- Globe projection is missing on native.
- `UserLocationLayer` is not covered by the integration tests yet.
- Windows: `geolocator_windows` reports an unmeasured heading as 0, so the
  heading cone of a resting PC points north.
- Shared gestures: native pans stop dead on release (no fling), and zoom and
  rotation don't fling anywhere. The C API has no inertia, so it would run in
  Dart over animated camera deltas.
- Web lost gl-js keyboard navigation, shift-drag box zoom and the grab
  cursor, which the shared recognizer doesn't offer.
- Native lists no GeoJSON attributions of styles loaded from a network or
  `asset://` URL, as MapLibre Native drops them and the JSON is not at hand.
- Offline: merging a database (`mergeOfflineRegions`) and resuming a paused
  download are not tested. Web has no offline support; document a service
  worker cache as the alternative.

## Upstream (maplibre_native_ffi)

Checked against the 0.202610.3 release (Dart package, C headers and the
pinned MapLibre Native commit `36132b0`); none is fixed on upstream main
yet. Report each with its evidence.

- Offline regions with a `maxZoom` of infinity download no tiles on x86-64
  (tile pyramid and geometry), although the C API documents infinity as
  "each tile source's own maximum zoom". The ffi passes infinity through to
  MapLibre Native, whose `util::coveringZoomLevel` casts the zoom to
  `int32_t`: undefined behavior that gives `INT32_MIN` on x86-64, so the
  zoom range ends below its start. Seen in our Linux integration tests and
  reproduced with the same cast; arm64 saturates and may work. Until it is
  fixed, the docs of `OfflineRegionDefinition.maxZoom` ask for a finite
  value.
- Profile and release maps freeze after about 30 frames. A render
  session's callback registrations (its frame wake) are kept only in
  `NativeHandleState._callbackRoots`, a field that is written and never
  read (`// ignore: unused_field`), so AOT drops it and the wake is
  collected. `@pragma('vm:entry-point')` on the field fixed it in a profile
  build on Windows (165 of 165 frames shown); `lifecycle.dart` is unchanged
  in 0.202610.3. `maplibre_native` works around it with a frame wake of its
  own; drop that once upstream fixes it.
- `GeoJsonSourceDataHandle.create` is synchronous: the C API prepares the
  data before it returns, so large GeoJSON updates block the calling (UI)
  thread. The Dart binding also always `jsonEncode`s its argument, so a
  GeoJSON string must be decoded in Dart and is encoded again. The C API
  allows preparing on another thread, so an async variant that takes the
  text would keep large updates out of the frame.
- No library for x86_64 iOS simulators: 0.202610.3 publishes only
  `ios-simulator-arm64`, and there is no preset for x86_64.

## Open issues

- Static typed expressions (#72), initial bounds fit in the constructor
  (#500), `ImageSource` from a local file (#502), miscellaneous changes
  (#402).
- Features: custom HTTP headers for tile requests (#383, PR #573 open),
  feature tap and drag events (#151), animated marker position (#311), map
  centering offset (#246), static map configurations (#236).
- Bugs to recheck against the native rewrite, since most were filed against
  the old Android and iOS packages: #581, #535 (offline), #555 (Android
  source updates), #544 (`MapEventUserInput` on drags), #499 and #498 (iOS),
  #301 (Android `ImageReader`).

## Features

### maplibre-gl-js v6

- v6 is breaking for apps: gl-js is ESM-only, so `index.html` must import
  it as a module. Earlier work is on the `web/maplibre-gl-js-v6` branch.
- Keep the clear `StateError` when `maplibregl` isn't loaded, and keep v5
  working.
- Run the web integration tests against v6.

### CRUD on layers and sources

- Today `StyleController` can add and remove layers and sources, update
  GeoJSON data, list layer ids, and read and set a line layer's
  `lineGradient` through `getLineLayer`. More properties and layer types
  follow the getter/setter pattern of `LineStyleLayerController`.
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
  one frame. Use `MapHandle.discarding` for setters that need no result, as
  gesture deltas and `LineStyleLayerController` already do.
- Give the style classes `==` and `hashCode`, so the declarative layers can
  diff properties and update in place instead of removing and re-adding.

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
- Native tests can check the builder against MapLibre itself:
  `StyleExpressionHandle` (0.202610.3) parses and evaluates an expression
  without a map.

### Custom tile loading

- Both platforms support it:
  - Web: gl-js `addProtocol(scheme, loadFn)` serves any request on a custom
    scheme (`mytiles://…`) from a JS function returning bytes. We already use
    it internally for `pmtiles://`. `transformRequest` rewrites URLs and
    headers.
  - Native: the ffi runtime's `setResourceProvider` takes routes (URL or
    glob patterns per resource kind) and a callback that answers each request
    with `ResourceRequestHandle.complete(response)`, hands it back with
    `passThrough()`, and can watch for cancellation.
    `setResourceTransform` rewrites URLs. Neither is used by
    `maplibre_native` yet.
- Public API: a `TileProvider`-style callback, registered per scheme or URL
  pattern, that gets the URL and resource kind and returns bytes, an error,
  or "not handled" so the request goes through the network loader. Make it
  async, and cancel it when the map drops the request.
- A URL transform on the same API covers custom headers and auth tokens
  (#383, PR #573) on both platforms.
- Check whether the native provider sees requests on custom schemes, or
  only on http(s) URLs. If only http(s), document routes on a placeholder
  host instead of a scheme, so one style works on web and native.
- Use cases: tiles from a local database or app bundle, encrypted tiles,
  signed URLs, and generated tiles.

### Suggested order

1. maplibre-gl-js v6.
2. Layer and source CRUD.
3. Typed expressions.
4. Custom tile loading and request transforms.
