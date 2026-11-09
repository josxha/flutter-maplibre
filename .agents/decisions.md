# Technical decisions

Each entry: the decision, then why.

## Architecture

- **Two platform packages: `maplibre_web` for the browser and `maplibre_native`
  for everything else.** One C API serves every native platform, so the
  per-platform packages (android, ios, webview) were removed.
- **The C API comes from the `maplibre_native_ffi` package on pub.dev
  (0.202611.0), whose build hook downloads the prebuilt C library of its
  release, checked against digests pinned in the package.** No submodule and
  no local C build are needed; `local_build` (see Build and CI) points the
  hook at one when the C library changes.
- **Rendering goes only through the texture registry, never platform views.**
  This keeps Flutter composition, transforms, and overlays working.
- **Windows and Linux render through Vulkan. Android renders through OpenGL
  ES by default, and through Vulkan when the app selects the Vulkan build.
  iOS and macOS render through Metal.** WGL and GLX/EGL need one pinned
  thread, which Dart can't guarantee, and the binding's texture APIs are
  Vulkan-first. On Android, OpenGL ES runs on every device,
  while Vulkan 1.1 drivers are missing or unreliable on many older ones.
- **The C library carries one backend, and Dart follows it at runtime.** The
  binding's build hook picks it per target (OpenGL ES on Android, Metal on
  iOS and macOS, Vulkan on Windows and Linux) unless
  `hooks.user_defines.maplibre_native_ffi.backend.<os>` names one, and `mln_supported_render_backend_mask()` tells `MapRenderer`
  which path to take. The workspace sets no backend.
- **Dart reaches the platform plugins through ffigen (Windows, Linux, iOS,
  macOS) and jnigen (Android), never method channels.** Calls are synchronous
  and typed, with no message encoding. The Windows and Linux plugin libraries
  export one C API, whose shared functions `desktop/` implements once, and
  keep their registered instances behind a mutex. Each platform defines
  only its own functions of that header; the bindings look a symbol up on
  first call, so Dart calls only those of its platform. On Android a Kotlin
  `MaplibreNativeApi` object holds each engine's texture registry, and
  SurfaceProducer callbacks reach Dart through a `SurfaceListener` that Dart
  implements as async listeners.
- **Plugin state is per engine, and every plugin call passes
  `PlatformDispatcher.instance.engineId`.** An app can run more than one
  engine in a process, such as one of a background service, and every engine
  registers its own plugin instance with its own texture registry, whose
  texture ids may repeat across engines. A texture is created and found in the
  plugin of the caller's engine, and an engine that goes away releases only
  its own textures (#677). The id maps to the plugin through public embedder
  APIs: `FlutterEngine.getEngineId()` at attach on Android, the plugin that the
  engine published (`valuePublishedByPlugin:`) on iOS and macOS, the engine's
  plugin registrar on Windows, and its texture registrar on Linux.
- **`MapRenderer` drives every platform the same way, and a `FrameTarget`
  per platform owns the texture and plugin calls.** The renderer demands a
  frame, hands each rendered one to the target on one serial GPU queue, and
  demands the next; targets attach the session, resize, present, end the
  session, and dispose the texture. Windows, Linux, iOS, and macOS share
  `RingTarget` (a ring of three images). Windows copies each frame on the
  GPU before releasing it; Linux, iOS and macOS keep it acquired while
  Flutter samples its slot (`holdsFrames`), and release it once the plugin
  reports the slot free. A resize releases the held frames first, as the
  session refuses to resize while it has a frame acquired.
- **The C library allocates the ring where it can (`LibraryRingTarget`:
  DXGI shared textures on Windows, IOSurfaces on iOS and macOS), and on
  Android presents to the Surface with a graphics context of its own.**
  Plugins then only hand frames to Flutter, with no Vulkan, Metal, EGL or JNI
  code. A resize is a session resize, after which the library hands out new
  images for the same slots, so Dart counts rings and the plugins open or
  wrap each image once per ring. Linux keeps a plugin-owned ring that the
  session borrows (`BorrowedRingTarget`): the library's dma-buf ring needs a
  DRM device that CI, WSL2 and software rendering lack, while opaque Vulkan
  memory works there.
- **Windows and Linux render on a Vulkan device that the C library creates
  (`VulkanDeviceHandle.create`) on Flutter's GPU**, which the plugin names
  through `maplibre_native_gpu_id`: the adapter LUID on Windows, the OpenGL
  device UUID on Linux. The device lives as long as the process and enables
  the external memory extensions the GPU has. On Linux the plugin allocates
  its ring images on it through the functions of its context.

## Windows

- **The session renders into the library's ring of three DXGI shared
  textures (`attachDxgiSharedTextureRing`), and the plugin copies each frame
  into one of three textures that Flutter shows as a DXGI GPU surface
  texture.** The plugin opens each ring texture once with
  `OpenSharedResource1` on its D3D11 device on Flutter's adapter. Flutter
  can't take the ring's textures directly: ANGLE opens only legacy shared
  handles, the library shares NT handles, and Flutter reopens a texture
  whenever the handle changes. The copy finishes before the frame is
  released, so the library never renders into a texture being copied. If
  sharing fails (no Vulkan device on the adapter's LUID, as with lavapipe in
  CI), frames are read back to the CPU into a pixel buffer texture.
- **No keyed mutex on the shared textures.** Flutter/ANGLE never acquire it.
  Tearing is unlikely but possible.
- **The C library is built with MSVC 14.37.** 14.44 needs LLVM 19 or newer.

## Linux

- **Frames reach Flutter as an `FlTextureGL` that samples the ring slots
  directly. MapLibre renders through Vulkan into a ring of RGBA8 images with
  exportable memory, which the plugin allocates on the library's device; `populate` imports each slot's opaque file descriptor
  once (`GL_EXT_memory_object_fd`) and returns the latest presented slot's
  texture.** Flutter 3.47 renders in EGL contexts of its own
  (`FlOpenGLManager`) that share nothing with any context a plugin can
  create, and `populate` is the only code that runs with one current, so
  every OpenGL call of the texture runs there. Opaque memory needs one GPU
  and driver on both sides: the library creates its Vulkan device on the
  OpenGL device UUID, the plugin checks the device and driver UUIDs, and checks the extensions,
  OpenGL ES 3.0 and the UUIDs again in Flutter's context on the first
  `populate`. If that fails, it logs a warning and the map shows nothing;
  otherwise failures fall back to an `FlPixelBufferTexture`, as on Windows.
- **A slot is in use while it is the front or shown slot, or until a fence
  says Flutter's draws that sampled it are done.** Flutter takes no fence for
  an external texture and samples the texture of the last `populate` until
  it populates again. So when `populate` moves Flutter to a new slot, it
  inserts a `glFenceSync` for the slot Flutter leaves, polls it, and waits
  for older fences, which are a frame old, so that at most one slot
  waits for its fence and a ring of three always has one to render into.
  `maplibre_native_gpu_texture_slot_in_use` reports this to Dart.
- **OpenGL objects are deleted in a later `populate`.** A resize moves the old
  ring's textures, memory objects and fences to a list that the texture's next
  `populate` deletes; a disposed texture hands them to a plugin-wide list that
  any texture's `populate` deletes. The objects of the last map stay until the
  process ends. Vulkan frees its side right away; the OpenGL memory objects
  keep the allocations alive.
- **The GPU IDs are read from an EGL context like Flutter's, once, when
  Dart first calls the plugin on the GTK main thread.** The plugin creates
  an OpenGL ES 2 context on the window's display (X11 or Wayland, as
  `FlOpenGLManager` does) and makes it current surfaceless on a short-lived
  thread of its own, since Mesa refuses it on the main thread where Flutter's
  contexts live. It checks OpenGL ES 3.0, `GL_EXT_memory_object_fd` and the
  UUIDs there, so a GPU whose OpenGL ES cannot import Vulkan memory falls
  back to CPU readback before a map is shown; the check in the first
  `populate` stays as a guard. The context is destroyed right after; the
  textures need no context of the plugin's own, so creating and presenting
  them works on any thread. If Dart's first call to the plugin is not on the
  main thread (unmerged threads), frames are read back to the CPU.
- **The plugin lives as long as the process.** Linux plugins get no
  shutdown call, and sessions on core workers can outlive the engine.

## Android

- **MapLibre presents to the Surface of a Flutter `SurfaceProducer` through
  `attachAndroidSurface`, with a graphics context that the C library
  creates: an EGL context on the default display (OpenGL ES build) or a
  Vulkan device and swapchain (Vulkan build), on the session's core
  worker.** This is zero-copy, works with Impeller and the ImageReader
  backend, and leaves the plugin without native code: Dart passes the
  Surface as a `jobject` with its thread's `JNIEnv*` (read through the
  JavaVM's `GetEnv`, as `package:jni` exposes neither publicly), and
  `initAndroid` gets the application context once. This replaced a JNI shim
  with its own EGL setup, Vulkan device and a render thread for
  caller-graphics-thread EGL sessions.
- **`onSurfaceCleanup` releases the session's target and pauses frame
  demands, and `onSurfaceAvailable` gives the session the current Surface
  again and resumes.** The session keeps its own reference to the window, so
  a frame in flight while Flutter destroys it finishes with
  `targetNotReady`. A resize that makes Flutter hand out a new Surface moves
  the session there with `setAndroidSurfaceTarget`; otherwise it is a
  session resize.
- **Sessions end with `RenderSessionHandle.release()`, not `abandon()`.**
  Release detaches a core-worker session off the UI thread and completes once
  no library thread touches the target, after which the plugin frees its
  texture or surface. Abandon blocked the UI thread on the map's tile work
  and GPU queue. Release reports nothing about kept objects; a Vulkan
  swapchain is kept only when the process exits or its queue fails to drain.
- **HTTP follows the app's network security config (0.202610.3), so
  cleartext needs the app's permission.** The example permits it for
  127.0.0.1 and localhost in its debug source set only, for the local test
  server of the integration tests.
- **The plugin ships no TLS verifier code.** The C library embeds the dex of
  its rustls-platform-verifier helper and loads it in `mln_android_init`, so
  the APK needs no Java classes or keep rules for it.

## iOS and macOS

- **One Objective-C plugin in `darwin/` serves both, with
  `sharedDarwinSource`, as a SwiftPM package only.** The Metal and CoreVideo
  code is the same on both; only the Flutter import differs. CocoaPods is
  deprecated (its trunk turns read-only on 2026-12-02) and Flutter uses
  Swift Package Manager by default since 3.44, so there is no podspec, and
  the example's iOS and macOS projects have no Podfile. The Flutter minimum
  of 3.47 means apps need no `flutter config` step.
- **Sessions render into the library's ring of three BGRA8 IOSurfaces
  (`attachIoSurfaceRing`), which the plugin wraps in pixel buffers
  (`CVPixelBufferCreateWithIOSurface`, once per ring), and the
  `FlutterTexture` returns the presented slot's buffer from
  `copyPixelBuffer`, without a copy or a wait.** BGRA8 is what Flutter's
  pixel buffer textures read. The frame's GPU writes completed before it
  became acquirable, so Flutter can sample it at once. Dart keeps the frame on
  screen acquired, so MapLibre renders into the other slots, and releases a
  frame it replaced once `maplibre_native_gpu_texture_slot_in_use` reports
  its slot free: not the presented slot, and neither of the last two slots
  Flutter took (it holds the last buffer until it takes the next, and a frame
  still on the GPU may read the one before). So MapLibre renders into one
  free slot while Flutter keeps up. `IOSurfaceIsInUse` can't tell: the ring's
  own buffer and texture keep every surface in use (use count 2), Flutter's
  texture raises nothing, and Flutter has dropped the buffer by the time it
  takes the next. It checks on each present and every
  4 ms while a replaced frame is held. A resize releases every held frame
  before the session resizes; Flutter keeps the old buffer it shows, which
  retains its surface.
  This replaced a blit into a `CVPixelBufferPool` buffer that the Dart UI
  thread waited for on every frame.
- **Dart finds the C API through `+[MaplibreNativePlugin symbols]`, called
  with `objc_msgSend`, not `DynamicLibrary.process()`.** SwiftPM links the
  plugin statically into the app, and release builds strip global symbols
  (Flutter's FFI docs ask apps to change `STRIP_STYLE` for this). The
  Objective-C runtime finds the class by name regardless, and the table keeps
  the functions from dead stripping. All of it lives in one `.m` file, which
  the generated plugin registrant pulls into the link.
- **Texture registration and unregistration run on the main thread, inline
  when Dart's UI thread is the main thread.** `textureFrameAvailable` runs on
  the calling thread.
- **`Package.swift` requires iOS 15.0 and macOS 14.3**, the deployment
  targets of the C library's Apple presets, so an app can't target systems
  where the library fails to load. The example's macOS target is 14.3. iOS
  matches Flutter 3.47's minimum; macOS is above its 12.0.
- **The example excludes x86_64 (macOS and the iOS simulator) and has the
  `network.client` entitlement on macOS.** The C library is published for
  arm64 only, and the sandbox blocks tile downloads without it.

## Threading and GPU

- **One process-wide VkDevice and VkQueue are shared by every map on
  Windows and Linux, without a queue lock.** The C library serializes every
  session's submits and presents per queue (`vulkan_queue_access.cpp`). A
  lock is only needed if host code uses the queue, and none does.
- **Widgets over the map follow the frame on screen, not the latest camera.**
  Each rendered frame result carries the view it drew; when Flutter can show
  that frame, the renderer creates its projection (`mapProjectionCreate`) and
  hands both to the map state. `camera` and screen locations come from it,
  so widget layers rebuild in the same
  Flutter frame as the map image. Camera events and `getCamera()` still
  report the latest camera, so `await moveCamera(...)` is followed by the new
  one. Exact on Windows. On Android Flutter takes the newest Surface
  image itself, so it can be off by a frame. The map takes its bounds,
  initial camera and style before the session attaches (`MapRenderer.create`
  `setUp`, which map creation runs once the map is ready), so the first frame
  already shows them. Events that arrive meanwhile wait for
  `MapRenderer.start()`, after `onMapCreated`. The native camera center is unwrapped to the visible
  world copy; projections keep it, while `CameraPosition` wraps the longitude
  into [-180, 180).
- **Dart calls the plugins on its UI thread.** Flutter's Windows and Linux
  texture registrar functions may be called from any thread. On Android the UI
  thread is the main thread, which SurfaceProducer needs, and its `JNIEnv*`
  is the one the C library gets with each Surface.
- **Every session uses the core-worker driver, with frame wakes drained on
  the Dart isolate.** Frame
  demands use `waitForUpdate`, so a demand renders only a newer map update and
  idle maps don't render, and every rendered frame is presented. The frame
  wake is a `Wake` with a Dart callback. A map's event mask holds the events the state always handles plus
  the ones whose `MapLibreMap` callback is set, and follows the widget
  (`setEventMask`), so per-frame render events are only queued while
  `onRenderFrame` listens. Runtime events arrive through
  `RuntimeHandle.setEventHandler`, which the binding calls on the isolate.
  Events that arrive before the first frame demand are kept until then.

## Public API

- **Network settings are static, on `MapLibreNetwork`, not in
  `MapOptions`.** On native the header rules and the URL transform belong to
  a runtime, and the `OfflineManager` has a runtime of its own, so a per-map
  option couldn't reach its downloads. `createRuntime()` applies them to
  every runtime and again on each change. On web, `transformRequest` reads
  them per request. Headers are native header rules (glob URL, first match
  wins) because the C API runs header callbacks synchronously on a library
  thread, which Dart can't answer; web matches the same globs in Dart. The
  URL transform is a Dart callback, set on native only while there is one,
  as each request then waits for Dart. Resource providers and the network
  status are not exposed yet.
- **Events are one `on…` callback per event on `MapLibreMap`, not one
  `onEvent` with a type switch.** A null callback is unsubscribed: native
  maps leave it out of the event mask, web maps don't listen to `render`,
  and the gesture detector registers no recognizer for it. A new event is a
  new optional parameter, while a new subclass of a sealed event passed to
  one callback broke every exhaustive switch. The events follow the ffi and
  gl-js events; per-axis camera events (gl-js `zoomstart`, `rotate` …), raw
  pointer events, box zoom, `styledata` and `dataabort` are left out on
  purpose, and offline events stay on `OfflineManager`.
- **`MapOptions.style` is a sealed `MapStyle` and declarative; there is no
  `setStyle`.** Backends switch on the type instead of guessing from the
  string, and a changed `style` loads the new style.
- **One sealed `CameraUpdate` (position, bounds, points, geometry) for
  `MapOptions.initCamera`, `moveCamera`, `animateCamera` and `cameraFor`;
  one sealed `CameraAnimation` (ease, fly) for how.** Both platforms have
  jump, ease and fly modes, so there are no platform-prefixed parameters.
  `initCamera` is null by default: null keeps the style's camera; a set camera
  replaces it as a whole, as both MapLibre Native and gl-js ignore the style
  camera once the camera changed. Fit targets are fitted before the first
  frame (native: `cameraFor*` in `setUp`; web: `cameraForBounds` + `jumpTo`
  right after the map is created, and again in the first post-frame callback,
  when the element has the size of its platform view). Native fits points
  with `cameraForLatLngs` and geometries with `cameraForGeometry`; web fits
  their bounding box. The ffi `CameraFitOptions` has no max zoom, so native
  clamps the fitted zoom.
- **`animateCamera` returns `completed` or `cancelled`.** Native reads the
  outcome from the ffi `endHandler`, but marks a gesture, `moveCamera` or
  `stopCamera` as cancelled itself, since the ffi counts a later camera write
  as completed. Web tags each animation's moves with event data and completes
  it on its `moveend`; a gesture, `moveCamera` or `stopCamera` cancels it
  first. Projection names stay `toScreenLocation`/`toLngLat` (as in
  maplibre-compose and the Android SDK); `project` would clash with
  `MapProjection`.
- **Bounds are geobase's `GeoBox`, and only the geobase types of the API are
  re-exported** (`show` lists in `maplibre` and
  `maplibre_platform_interface`). Backends import other geobase types from
  geobase directly.
- **Feature queries are async on every platform, and there is no
  `queryLayers`.** The C API only queries asynchronously, and its features
  carry their source and source layer but not their style layer, so
  `RenderedFeature` has `sourceId` and `sourceLayer`, and layer membership is
  queried with `layerIds`. Since 0.202610.3 query results also name their
  style layer, `RenderedFeature.layerId`; on web it comes from the gl-js
  feature's `layer.id`. The webview's `*Async` overloads went with the
  webview package.
- **One `queryRenderedFeatures(QueryGeometry, {layerIds, filter})`, like
  gl-js and the C API.** `QueryGeometry` is sealed: `.point`, `.rect` and
  `.viewport`. The C API also queries along a screen line string, but gl-js
  only takes a point or a box, so there is no `.line`. The C API has no
  viewport geometry, so native queries a box of the map's extent; gl-js
  queries without a geometry. `filter` is a typed `Expression<bool>`, the
  type of layer filters. `RenderedFeature.geometry` is a geobase `Geometry`,
  parsed from the GeoJSON that both platforms report, like sources and
  offline regions. `querySourceFeatures(sourceId, {sourceLayer, filter})`
  takes one source layer like gl-js; native passes it as the C API's list.
  Web returns no features for a missing source instead of letting gl-js
  throw, as native does.
- **GeoJSON data is a sealed `GeoJsonData`: geobase objects
  (`.featureCollection`, `.feature`, `.geometry`), decoded JSON (`.json`) or
  text (`.text`).** The raw forms skip building geobase objects for large
  data. Native passes decoded JSON to the C API (text is decoded in Dart
  first); web hands text to `JSON.parse` and only `jsify`s decoded JSON.
  gl-js `updateData` diffs and `getData` are not exposed, as the C API has
  neither. Nor are the GeoJSON source's `filter`, `generateId` and
  `promoteId`: MapLibre Native ignores them (checked on Linux, both in the
  source JSON and on data updates).
- **Clustering is an optional `GeoJsonCluster` on `GeoJsonSource`, not a
  separate source type.** Sources are immutable data, so the cluster queries
  live on `MapController` next to the other queries: native calls the typed
  cluster queries of the render session; web calls the methods of the gl-js
  `GeoJSONSource`.
- **`setProjection` takes an `Expression<MapProjection>`**, the projection
  definition of the style spec, so web can interpolate projections by zoom.
  `MapProjection` is a `StyleEnum`. gl-js reports `globe-mercator` for a
  globe that shows Mercator at the current zoom; the event maps it to
  `mercator`. The C API's `ProjectionMode` (axonometric, skew) is a render
  transform, not a projection, and is not exposed.
- **Image options are a shared `StyleImageOptions` next to `pixelRatio`**,
  which stays its own parameter because `addImageFromCanvas`,
  `addImageFromIconData` and `addImageFromWidget` derive it. Their option
  positions are logical pixels and are scaled to image pixels, like their
  sizes; the other methods take image pixels.
- **Every native map and the `OfflineManager` use one database,
  `maplibre_native.db` in the app support directory (`path_provider`).**
  Each map and the offline manager have a runtime of their own, and runtimes
  with the same `cache_path` share one database file source in the C
  library, so maps cache resources on disk and show downloaded regions.
  Without a cache path the C library keeps an in-memory database per
  runtime. On Android the offline manager initializes the C library through
  `MaplibreNativeApi.initialize`, as it creates no render target.
- **Offline downloads report their progress through the offline manager's
  runtime events.** A download observes its region and sets it active; the
  stream reports `offlineRegionStatusChanged` as progress, response errors
  as `OfflineResourceException`s, which the download retries, and an
  exceeded tile count limit as an `OfflineTileCountLimitException`.
  Cancelling the subscription sets the region inactive, and
  `resumeDownload` continues it. Metadata is UTF-8 JSON (#581).
- **Offline regions mirror the C API's definitions.**
  `OfflineRegionDefinition` is sealed, with a tile pyramid (bounds) and a
  geometry (a geobase `Geometry`, passed to the C API as decoded GeoJSON)
  variant, and `OfflineRegionStatus` carries every field of the C API's
  status. Geometry definitions compare by coordinates, since geobase
  geometries compare their coordinate lists by identity. MapLibre stores a
  tile that is not found (404) as empty, so only other failures reach the
  stream as errors.

- **User location is a Flutter layer, `UserLocationLayer`, fed by a
  `Stream<UserLocation>`; there is no `PermissionManager`.** It paints in
  Dart, so it works the same on every platform, and tracking runs in Dart
  over `animateCamera`. A translucent `Listener` stops the tracking on a drag
  or wheel. Permissions are left to `geolocator` or `permission_handler`;
  `maplibre_geolocator` adapts `geolocator` positions.

- **Expressions are a sealed `Expression<T>` of `Literal`, `Call` and
  `RawValue`, with static members and extensions, and layer properties take
  them directly.** The design is in issue #72: `T` is what it evaluates to,
  numbers are `num` because generics are covariant, overloads are extensions
  on the receiver type, and keyword clashes are renamed. `==` compares
  `toJson()` deeply. `RawValue` is an addition for what a style holds but
  `Call` (a list) can't: legacy function objects and colors the reader doesn't
  know, such as extended CSS names. They read back unchanged.
- **`StyleLayer` subclasses are generated from the style spec by
  `tool/codegen/style_layers.dart`, and the generated Dart is committed.**
  Every property is a typed getter, setter and optional constructor parameter,
  and transitions have typed ones (`colorTransition`). There are no `paint` or
  `layout` maps and no access by property name: names and JSON stay inside
  the package, except for `Expression.raw` and `StyleLayer.fromJson`/`toJson`,
  which also keep what a newer style spec adds. Setters can be synchronous
  because the state is in Dart, so there are no async `setX` methods.
  Layers keep only style JSON privately, and
  getters decode it on read, so what a style holds round trips unchanged and
  anything but a literal stays an `Expression.raw`. A literal list goes to the
  map in the plain form of the spec, without `literal`, which every property
  accepts. Colors are written as `#rrggbb`, or `rgba()` when translucent, as
  MapLibre Native's parser doesn't read hex with alpha.
- **Layer objects are their own controllers, as in the Android and iOS SDKs.**
  Once a layer is on a map its setters also send the change, fire-and-forget
  and in order (native: `MapHandle.discarding.setStyleLayerProperty`, which
  also takes `filter`, `minzoom`, `maxzoom` and `visibility`; web:
  `setPaintProperty`, `setLayoutProperty`, `setFilter`, `setLayerZoomRange`).
  Removing the layer or replacing the style detaches the object.
- **`StyleController.layers` and `sources` are own classes, not a `Map` or
  `List`, served synchronously from a cache behind a `StyleBackend` that each
  platform implements.** The cache and the argument checks are in
  `maplibre_platform_interface`, so both platforms behave the same and unit
  tests run against a recording backend. On style load native runs one
  `getLoadedStyleJson` query and web reads `getStyle()`; after that every
  change goes through this API. Changes apply to the cache at once and are
  undone if the map rejects them. What a TileJSON adds to a source comes in on
  source changes (`applyTileJson`) and is kept apart from the source as
  specified, so that an update doesn't carry it over.
- **`StyleController.batch` wraps its synchronous callback in a command group
  on native, ended in `finally`, and only runs it on web.** `LayerManager` uses
  it, so one rebuild shows in one frame.
- **`LayerManager` keeps the style layers it added and sets only what changed,
  compared by JSON (`StyleLayer.updateFrom`).** It re-creates a layer only when its type or source
  changes, below the next declarative layer, so the order stays.
- **Annotation layers take `Expression<T>` for their style fields, with const
  `.literal` defaults, and pass them on to their style layer.** That allows
  per feature styling and keeps the layers `const`. `==` works as expressions
  compare deeply. Colors keep their alpha in the CSS color, so `opacity` is a
  field of its own that multiplies it.
- **Style images have a size in logical pixels that the package keeps the
  same on every platform and screen.** `addImage` takes a `pixelRatio` of
  image pixels per logical pixel, 1 by default as in MapLibre GL JS, and
  passes it to `map.addImage` on web and to `StyleImageOptions` on native.
  The canvas, icon and widget helpers take logical sizes, render at the
  device pixel ratio and pass it on, so callers never scale by it.
- **Images don't go through Flutter's image codecs on web.** The skwasm
  renderer (`--wasm`) gives a decoded image the size of the view, and
  encodes a layer's image (`addImageFromWidget`) to a PNG of that size.
  Web `addImage` decodes bytes with the browser's `createImageBitmap`, and
  the helpers hand their `ui.Image` to `addImageFromUiImage`, which passes
  its raw pixels (straight RGBA on web, premultiplied on native).
- **Animations change paint, not data.** The animation page adds its path
  once and moves a `step` on `line-progress` in `LineStyleLayer.gradient`. A GeoJSON
  update per frame re-encodes the data in Dart, parses and indexes it on the
  UI thread (`geojsonSourceDataCreate` is synchronous) and re-tiles the
  source; a paint change does none of that.

## Gestures

- **Two options decide what gestures do: `MapOptions.movements`
  (`MapMovements`: `pan`, `zoom`, `rotate`, `pitch`) and
  `MapOptions.gestures` (`MapGestures`: `drag`, `pinch`, `scrollWheel`,
  ...), all on by default.** A gesture moves the camera only along the
  movements that are on. Grouping gestures by movement didn't fit, because a
  two-finger pinch pans, zooms and rotates, and a right-button drag rotates
  and tilts; the user wanted the two kinds of switch in separate options.
  Min/max options can't replace the movement switches: there is no bearing
  limit, and limits also clamp the camera that the app sets. The
  model is the one of maplibre-compose, whose `MapInteractions` allows the
  `pan`, `zoom`, `rotate` and `pitch` movements and whose
  `InteractionBindings` bind inputs that can't enable a disallowed
  movement. The input names are Flutter's (`pinch`, `scrollWheel`,
  `doubleTapDrag`, `fling`) rather than Compose's (`transform`, `scroll`,
  `tapDrag`, momentum), and `secondaryDrag` matches `onSecondaryClick`. The
  C API has no gesture switches, only `mln_map_apply_camera_delta`. A
  new gesture, or an option such as cooperative gestures for maps in a
  scrolling list, is a new optional field, not a breaking change. A switch
  exists only for a gesture `MapGestureDetector` recognizes: there are no
  keyboard or box zoom switches until those are implemented.
- **Drags are map events, and annotation layers build feature dragging on
  them (#544, #151).** `MapGestureDetector` reports `onDragStart` (where the
  pointer went down), `onDrag` and `onDragEnd` for one-finger and
  primary-mouse drags, also while panning is off. As with double taps,
  `MapEventDragStart.preventDefault()` keeps the drag from panning, and an
  async `onDragStart` holds the pan until it completes; a pan that was not
  prevented then catches up, so the map stays under the finger. A second
  finger ends the drag; a prevented drag's pinch doesn't move the camera
  until every pointer is up.
- **Annotation layers drag their features themselves with `draggable: true`
  (#151), and the app saves the drop in `onDragEnd`.** The user chose this
  over #151's first plan, where the app moved the feature with `setState` on
  every `onDrag`: that rebuilt the page and re-sent the whole layer's
  source per step, 36 ms with 1,000 and 140 ms with 10,000 points on Linux
  against about 30 ms with one, and it beat a map-level list of draggable
  layers, which loses the feature's index in its layer's list. On a drag
  start `MapLibreMapState` queries the draggable layers in a 24 px square,
  prefers the nearest point and prevents the pan. `LayerManager.startDrag`
  then copies the feature into a one-feature overlay source and layer
  (`maplibre-drag-*`, the layer's own style) above its layer and hides it
  there with a filter on its `maplibre:index` property, which every feature
  of a draggable layer's source gets; app ids stay untouched. Each step
  writes only the overlay, coalesced to the latest geometry while a write
  is in flight, so a step costs about 20 ms at any layer size (the frame).
  Geometries move by the pointer's screen delta per vertex (Point,
  LineString, Polygon). The layer stays controlled: after the drop, the
  overlay stays until the app's list has the new place and its source has
  re-tiled (250 ms after the write, so the old place doesn't flash), or goes
  away after the next frame if the app didn't save it, and the feature snaps
  back. `LayerFeatureEvent` is not generic, because `Layer<Feature<Point>>`
  sits in a `List<Layer>`, where reading a callback field typed by `G` fails
  its covariance check. Callbacks are left out of `Layer.==`; the
  constructor asserts that they come with `draggable`.
- **Annotation layers report taps and hovers on their features with
  `onClick`, `onEnter` and `onLeave` (#647), on the same
  `LayerFeatureEvent` as drags.** #645 named it `LayerDragEvent`; it was
  renamed before a release, so that one event serves every layer callback.
  A layer with any of these callbacks or `draggable` is `interactive`, which
  is part of `Layer.==` and gives its source the `maplibre:index` property.
  A tap queries the clickable layers at the point, and in the 24 px grab
  square if that finds nothing; the topmost layer and its nearest point win.
  Hover comes from new map events, `onPointerMove` (Flutter hover events:
  mice and styluses without a pressed button) and `onPointerLeave` (a
  `MouseRegion` that always wraps the detector, so that the child keeps its
  state). Each move queries the hovered layers at the point, coalesced to
  the latest move while a query runs, and enter/leave are tracked per layer
  like gl-js `mouseenter`/`mouseleave`, but per feature.
- **Style layers report taps and hovers with `onClick`, `onEnter` and
  `onLeave` on the `StyleLayer` object (#647), not with a declarative list
  on `MapLibreMap`.** Annotations are the declarative API and style layers
  the imperative one, so the callbacks are fields like the property setters,
  and constructor parameters of the types with vector features (from the
  generator). They end with the object: the map only calls a layer that is
  still `style.layers[id]`. The event is `StyleLayerFeatureEvent` with the
  `RenderedFeature`. Unlike annotation layers, every style layer under a tap
  reports it, as with gl-js `map.on('click', layerId)`. Enter/leave is per
  feature id, or per layer for features without one. The same query serves
  annotation and style layers. A callback set on a style layer doesn't
  rebuild the map, so `StyleLayers.callbacksChanged` notifies when a layer
  gets its first callback or loses its last one (setter, add, remove,
  dispose), and the map rebuilds to wire the detector's `onClick`,
  `onPointerMove` and `onPointerLeave` only while something needs them. One
  frame late is fine: no tap or move can come in between. The repaint
  triggers of the platforms don't help, they render a map frame and don't
  rebuild widgets.
- **One gesture recognizer in Dart serves every platform:
  `MapGestureDetector` in `maplibre_platform_interface`.** It sits there, not
  in `maplibre`, because the platform packages need it and `maplibre` depends
  on them. `MapLibreMapState.build` wraps the platform widget in it when the
  state returns a `gestureCamera`. Flutter hit-tests every pointer, so
  widgets over the map keep theirs.
- **The recognizer hands the platforms screen-space intents through
  `GestureCameraSink`, never map centers.** A step (`GestureCameraUpdate`)
  pans the content under one screen point to another, then zooms, rotates
  and tilts around a screen point. Each platform applies it with its own
  projection-aware camera engine, so a new projection (globe) needs no Dart
  change. `gestureEnd` carries a `GestureVelocity`: the pan's release
  velocity (of the focal point for more than one pointer, as Flutter reports
  only the last pointer's), and a pinch's zoom and rotation velocities from
  a `VelocityTracker` over the steps it applied; fling inertia runs in the
  platform. Discrete zooms (wheel, double tap) use `zoomBy`.
- **Native applies steps with `mln_map_apply_camera_delta`**, the C API's
  equivalent of mbgl's moveBy/scaleBy/rotateBy/pitchBy, one atomic delta per
  step with the gesture phase. A released gesture flings as the map's
  gesture momentum (`mln_gesture_momentum` on the end delta, with the core's
  default friction decay for pan, zoom and bearing), which the next
  gesture's begin stops. Native and web feel different on purpose: native
  uses the core's fling. The move ends from the end delta's transition end
  handler, which also runs at once for a release too slow to fling.
- **On web, Flutter is the only hit-tester.** The gl-js map is created with
  `interactive: false` and its container has `pointer-events: none`, so the
  browser hands every pointer to Flutter, and widgets over the map no longer
  leak taps and drags to gl-js. Clicks, double, secondary and long clicks
  come from `MapGestureDetector`. The `HtmlElementView` hit-tests as
  transparent: an opaque platform view joins the gesture arena first and
  wins every pointer the arena sweeps, so single and secondary taps (in real
  browsers too) never reached the tap recognizer. A right click or Ctrl +
  click that starts on the map suppresses the browser's context menu once.
- **Widgets over the map need no `PointerInterceptor`, so `maplibre` and
  `maplibre_web` dropped the package.** It only put an invisible HTML element
  under its child, so the browser would not route the pointer to the map's
  element; the map's element takes no pointers anymore. Non-interactive
  `WidgetLayer` markers still use `TranslucentPointer`, so drags that start
  on them pan the map on every platform.
- **Web applies steps with public gl-js camera calls of duration 0.** A pan
  puts `unproject(panFrom)` at `panTo` through `easeTo`'s `center` +
  `offset`, so the grabbed location stays under the pointer in every
  projection. gl-js's `around` drifts by up to 325 px on the globe (zoom 3,
  cursor in a corner), so zoom, rotation and pitch around a point don't use
  it: the web sink changes the camera, puts the location back with the pan
  step, reads the result and restores the camera, all without reporting
  events, and then applies the result in one `jumpTo`, or one animated
  `easeTo` for a double tap. Wheel, pinch and double-tap zoom then keep the
  location under the cursor within 0.01 px on the globe and on Mercator.
  One gesture reports one camera move, although gl-js fires
  movestart/moveend per step.
  A release flings with gl-js's own inertia constants (linearity 0.3,
  ease-out bezier; max speed and deceleration 1400 px/s and 2500 px/s² for
  pan, 40 and 20 levels for zoom, 360° and 1000° for bearing) in one
  `easeTo`, whose zoom and bearing target comes from the same exact-around
  step.
- **Globe on web needs no forwarding to gl-js handlers.** Measured with
  gl-js 5.24 at 1024×768: the grabbed point stays within 0.1 px at zoom 2 and
  above, also at 80° N and pitched 45°. At zoom 1 a drag from the center to
  near the globe's edge ends 8.6 px off, and one that starts near the pole
  98 px off. gl-js's own globe drag drifts as much or more (3–86 px over the
  same drags), so the fallback of forwarding pointer events to its handlers
  would not be better.
- **Double taps are only recognized while `onDoubleClick` is set or the
  zoom gesture is on.** A double tap recognizer holds every single tap
  until the double tap timeout, so `onClick` fires at once without one.
- **`MapEventDoubleClick.preventDefault()` stops the double tap zoom**, as
  in gl-js, rather than a `bool` return: a `bool?` callback rejects
  `(e) => setState(...)` and warns on block bodies without a return.
  `onDoubleClick` returns `FutureOr<void>` so it can query features first.
  It fires on the second press and the zoom runs on release, so the detector
  waits for the Future then; the double tap and drag zoom waits too and is
  prevented as well.
- **The gestures follow the platform conventions.** A two-finger twist turns
  the map with the fingers (negated bearing). Double tap and drag zooms
  (down zooms in, 150 px per level). Two fingers side by side dragged
  vertically tilt, as on MapLibre Android. A right-button or Ctrl +
  left-button drag rotates and tilts as in MapLibre GL JS: 0.8° bearing per
  horizontal pixel, flipped above the center so the map turns like a wheel,
  and 0.5° pitch per vertical pixel, up tilting further. A scroll wheel zooms
  1/450 level per CSS pixel, as GL JS (Flutter web divides the browser's
  wheel delta by the device pixel ratio except on macOS, so the recognizer
  multiplies it back); a trackpad pinch that arrives as a scale signal
  zooms by its scale.

## Tests

- **One Flutter app, `examples`, runs the integration tests.** Its platform
  folders are already set up for the C library (arm64 only, the macOS
  network entitlement, Swift Package Manager), so a second app would only
  duplicate them. The packages have no example apps. `all_test.dart` runs
  the suite in one launch, as each launch builds and starts the app.
- **Unit tests cover what needs no platform** (models, annotation layers,
  the UI widgets against a mocked `MapController`, the gesture recognizer).
  Integration tests cover what each platform implements: rendering,
  camera, projection, style, queries, gestures.
- **Integration tests wait for what they assert.** Map commands and runtime
  events are asynchronous and screen locations follow the frame on screen,
  so the `TestMap` helpers pump until an event, a camera, a shown frame or a
  feature query matches, with a timeout, instead of fixed delays. Styles are
  inline JSON or assets; only tests named "(network)" load remote styles.
- **CI runs the integration tests on every platform, rendering in software**
  (SwiftShader in the Android emulator, lavapipe on Linux and Windows, the
  macOS VMs' paravirtualized Metal), and uploads their coverage per
  platform. On Windows the map then falls back to CPU readback. The iOS
  run goes through `.github/scripts/watchdog.sh`, which stops it after 10
  minutes without output and reports the stall as annotations, because the
  job log needs a sign-in and annotations don't. flutter test sometimes
  never attaches to the app on the CI simulator (Flutter 3.47.7 and 3.47.8;
  the app logs its VM service and waits, no MapLibre thread exists), so the
  watchdog stops a run once the VM service has listened for two minutes
  without a test starting, and CI starts it again, up to three times. The
  Windows runner runs elevated, and an elevated Vulkan loader ignores
  `VK_DRIVER_FILES`, so CI registers lavapipe in the registry.
- **The recognizer is unit tested against a recording `GestureCameraSink`**
  (`maplibre_platform_interface/test`). `examples/integration_test/gestures_test.dart`
  checks each platform's camera end to end.
- **`linux/test/gl_texture_test.cc` checks the Linux zero-copy path without
  Flutter**, against stand-ins for the few Flutter functions the plugin
  calls: the GPU IDs from the EGL probe of a real window, a Vulkan device on
  its UUID that the plugin adopts as it adopts the library's, and exported
  images that `populate` imports and returns in an EGL
  context that shares nothing with GDK's, as Flutter's, also across a resize
  and the disposal of a texture. It checks which slots are in use. It passes on Mesa's lavapipe and
  llvmpipe, which share memory, so it runs without a GPU.
- **Projection integration tests run at zoom 4.** At the minimum zoom of a
  wide desktop window the world is narrower than the window, and screen
  corners wrap to the neighbouring world copy.

## Build and CI

- **A local C build is named in the root `pubspec.yaml` as
  `hooks.user_defines.maplibre_native_ffi.local_build`, a maplibre-native-ffi
  CMake build root.** The hook takes `<preset>/install` under it for each
  target, so one setting serves every platform and Android ABI.
- **ffigen, jnigen and the style layer generator run from `tool/codegen`, a
  package outside the workspace.** The generator pins the npm version of the
  style spec and downloads its `v8.json`; the spec isn't committed. Outside the workspace, the binding's build hook doesn't run
  during code generation. jnigen uses the example app's Gradle classpath.
  The Kotlin API takes and returns only Android types (`Context`,
  `Surface`), which jnigen binds as stubs, so classes compiled against any
  `android.jar` give the same bindings.
- **`package:jni` is also an FFI plugin on Windows and Linux.** It builds
  there but stays unused.
- **CI builds and tests against the published C library.** No job builds it
  from source.
- **CI has no build-only jobs for platforms the integration tests run on.**
  Each integration test job builds the example app for its platform. Only
  the web wasm build has its own job, as the tests run the JavaScript build.

## Known gaps

- MapLibre Native moves to the style's camera on load only while no camera
  change happened, and `mln_map_set_bounds` counts as one (it always passes
  bounds, even `unbounded`). The C API has no getter for the style's camera.
  So a map without `MapOptions.initCamera` sets its camera constraints after
  the first style loaded, and frames before that are unconstrained.
- `maplibre_native_ffi` has no call to change the tiles or the TileJSON URL of
  raster, raster DEM and vector sources. `StyleControllerNative` removes the
  layers that use the source, swaps the source and adds the layers back at
  their positions, in one command group. `getStyleSource` is lossy (no
  inline tiles or GeoJSON data), so sources are read from
  `getLoadedStyleJson` instead.
- `getLoadedStyleJson` returns the style document as it was parsed, so it only
  fills the cache on load.
- Feature queries on native don't return layers in their order, and layers with
  the same layout share one symbol placement. So the tests check the order of
  layers through symbol placement, with icons of slightly different sizes.
- `MapHandle.setStyleUrl` and `setStyleJson` complete once the style
  document parsed, and fail when it doesn't load. The map state only submits
  the style and doesn't wait: later commands run after it anyway, a failure
  reaches `onError` through the loading failed event, and a newer style
  cancels an older one.
- `setGeoJsonSourceData` prepares the data in the background, but the binding
  still `jsonEncode`s it, so `GeoJsonData.text` is decoded in Dart and
  encoded again. Newer data cancels data that isn't ready yet, which
  `setGeoJsonData` treats as done.
- The C API has no setter for the offline tile count limit and no automatic
  database packing, so `setOfflineTileCountLimit` and
  `runPackDatabaseAutomatically` were removed from the `OfflineManager`.

- Missing on native: the globe and vertical perspective projections and
  video sources. MapLibre Native implements none of them, and the C API has
  no setting for them (`mln_map_set_projection_mode` only sets axonometric
  and skew; `MLN_STYLE_SOURCE_TYPE_VIDEO` only names the type).
  `setProjection` with anything but Mercator logs once and keeps Mercator,
  so pages that ask for a globe still show a map; adding a `VideoSource` throws an `UnsupportedError`, as a layer on it
  could not render.
- iOS and macOS pass the integration tests on an arm64 Mac (Xcode 27.1,
  macOS 27.0.1, iPhone 17 simulator on iOS 27.0) against the 0.202610.2
  release library, but have not run on an iOS device. 0.202610.3 adds a
  macOS x64 library, so Intel Macs build; none has run the tests.
- Linux passes the integration tests in WSL2 (WSLg, Mesa llvmpipe and
  lavapipe, Flutter 3.47.9) and under Xvfb, on zero-copy and on CPU readback.
  Not checked on a desktop with a GPU, where Flutter's OpenGL ES context may
  lack `GL_EXT_memory_object_fd`; Wayland compositors share frames as
  dma-buf EGLImages instead, which would be the alternative. Painting a map before its first frame crashed the
  raster thread until the texture callbacks set a `GError` with
  their `FALSE`, which Flutter's engine dereferences.
- x86_64 iOS simulators have no published C library (0.202610.3 publishes a
  macOS x64 one).
- The C library targets macOS 14.3, above Flutter 3.47's minimum of 12.0,
  so apps must raise their macOS target. MapLibre Native itself requires
  14.3 (its `CMakeLists.txt` fails below it), so `maplibre_native_ffi`
  can't lower it.
- The macOS presets also offer Vulkan and OpenGL. Selecting either with
  `backend.macos` makes a macOS map throw `UnsupportedError`, since the
  plugin only integrates Metal.
- The zero-copy Metal path passed on macOS and the iOS simulator with the
  plugin's own ring, with MapLibre rendering into the one free slot; the
  library's IOSurface ring has only run in CI. Not checked: iOS devices, and
  whether a GPU read of Flutter outlasts the two slots the ring holds for it
  (tearing; none seen).
- The DXGI shared texture ring has not run with a GPU: CI's lavapipe has no
  adapter LUID, so Windows CI reads frames back.
- Touch tilt and double-tap-drag are not tested on Windows touchscreens.
- Web lost gl-js's keyboard navigation and shift-drag box zoom, which the
  shared recognizer doesn't offer, and its grab cursor.
