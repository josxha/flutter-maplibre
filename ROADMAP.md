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
- macOS needs 14.3, above Flutter 3.47's 12.0, because of the C library's
  preset.
- Intel Macs and x86_64 simulators have no published C library.
- Touch tilt and double-tap-drag are untested on Windows touchscreens.
- The iOS integration tests stall on the macOS CI runners but pass on an
  arm64 Mac (Xcode 27.1, Flutter 3.47.7, headless simulator, with
  coverage). The watchdog's annotations should show where.
- The `maplibre_web` unit tests hang locally under `--platform chrome`.

## Known gaps

- Globe projection is missing on native.
- `UserLocationLayer` is not covered by the integration tests yet.
- Shared gestures: native pans stop dead on release (no fling), and zoom and
  rotation don't fling anywhere. The C API has no inertia, so it would run in
  Dart over animated camera deltas.
- Web lost gl-js keyboard navigation, shift-drag box zoom and the grab
  cursor, which the shared recognizer doesn't offer.
- Native lists no GeoJSON attributions of styles loaded from a network or
  `asset://` URL, as MapLibre Native drops them and the JSON is not at hand.
- Offline: merging a database (`mergeOfflineRegions`) is not tested. Web has
  no offline support; document a service worker cache as the alternative.

## Upstream (maplibre_native_ffi)

- The unreleased hook fix on main (the hook no longer forces a second build
  after its download) comes with the next release.
- A macOS preset that targets 12.0, Flutter's minimum.
- Libraries for x86_64 macOS and simulators.
- 15 of our 16 feedback points are still open; frame sync (#1) is only
  partly addressed.

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
