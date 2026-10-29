# Technical decisions

Each entry: the decision, then why.

## Architecture

- **Two platform packages: `maplibre_web` for the browser and `maplibre_native`
  for everything else.** One C API serves every native platform, so the
  per-platform packages (android, ios, webview) were removed.
- **The C API comes from the `maplibre_native_ffi` package on pub.dev
  (0.202610.3), whose build hook downloads the prebuilt C library of its
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
  export one C API, implemented once in `desktop/`, and keep their one
  registered instance behind a mutex. On Android a Kotlin
  `MaplibreNativeApi` object holds the engine's texture registry, and
  SurfaceProducer callbacks reach Dart through a `SurfaceListener` that Dart
  implements as async listeners.
- **`MapRenderer` drives every platform the same way, and a `FrameTarget`
  per platform owns the texture and plugin calls.** The renderer demands a
  frame, hands each rendered one to the target on one serial GPU queue, and
  demands the next; targets attach the session, resize, present, end the
  session, and dispose the texture. Windows, Linux, iOS, and macOS share
  `BorrowedRingTarget` (a plugin-owned ring of three images, replaced on
  resize). Windows and Linux copy each frame on the GPU before releasing it;
  iOS and macOS keep it acquired while Flutter samples its slot.
- **Windows and Linux share the Vulkan device code and the C API
  implementation in `desktop/`; only the texture interop differs.** The
  device matches Flutter's GPU by adapter LUID on Windows and by the OpenGL
  device UUID on Linux, and enables `VK_KHR_external_memory_win32` or
  `_fd`.

## Windows

- **Frames reach Flutter as a triple-buffered ring of D3D11 textures shared
  with Vulkan, shown as a DXGI GPU surface texture.** If sharing fails, frames
  are read back to the CPU into a pixel buffer texture.
- **No keyed mutex on the shared textures.** Flutter/ANGLE never acquire it.
  Tearing is unlikely but possible.
- **The C library is built with MSVC 14.37.** 14.44 needs LLVM 19 or newer.

## Linux

- **Frames reach Flutter as an `FlTextureGL`. MapLibre renders through
  Vulkan into a ring of RGBA8 images with exportable memory, which OpenGL
  imports as opaque file descriptors (`GL_EXT_memory_object_fd`); each frame
  is blitted into one of three plain GL textures that Flutter samples.** This
  mirrors the D3D11 copy on Windows: the ring is free once the copy returns,
  and the copy never targets the texture Flutter shows or fetched last, since
  Flutter takes no fence for external textures. The plugin waits for the
  copy with `glFinish`. Opaque memory needs one GPU and driver on both sides,
  so the plugin creates its Vulkan device on the OpenGL device UUID and
  checks the driver UUIDs. Otherwise frames are read back into an
  `FlPixelBufferTexture`, as on Windows.
- **The plugin copies in its own GDK OpenGL context, created from Flutter's
  window, so it shares textures with Flutter's contexts.** GDK contexts may
  only be used on the GTK main thread, so zero-copy textures need Dart's UI
  thread to be the main thread (merged threads); the plugin checks
  `g_main_context_is_owner` and falls back to the pixel buffer otherwise. It
  restores the context that was current after each use. OpenGL goes through
  libepoxy, which GTK already loads.
- **The plugin lives as long as the process.** Linux plugins get no
  shutdown call, and sessions on core workers can outlive the engine.

## Android

- **MapLibre presents to the Surface of a Flutter `SurfaceProducer`, through
  an EGL window surface (OpenGL ES) or a Vulkan swapchain.** This is
  zero-copy, works with Impeller and the ImageReader backend, and needs no
  Android-specific code in the C API.
- **OpenGL ES sessions own a dedicated EGL context
  (`MLN_OPENGL_CONTEXT_OWNERSHIP_DEDICATED`, GLES client API, no share
  context).** Nothing samples their output in GL, so they need no share
  group with Flutter. The plugin initializes `EGL_DEFAULT_DISPLAY` once and
  never terminates it, as Flutter shares the display and the C API needs it
  through teardown. It picks an RGBA8888 ES 3 window config with depth and
  stencil, with pbuffer support where offered for the session's teardown
  fallback.
- **One plugin-owned native render thread services the caller-graphics-thread
  sessions of all OpenGL ES maps, each with its dedicated context.** EGL
  surface targets require `MLN_RENDER_DRIVER_CALLER_GRAPHICS_THREAD`, so
  rendering runs where `mln_render_session_service_driver_work` is called,
  and the Dart isolate runs on the Android main thread. Each map registers a
  render client whose `Wake.native` (callback and release from the JNI shim,
  the client as user data) wakes the thread directly, without a hop through
  the isolate; the release frees the client once the C library drops the
  wake. `RenderSessionHandle.id` is the raw `mln_render_session`, so the
  shim calls the C function it resolves with `dlsym`. The C API binds a
  session to the first thread that services it, and lets dedicated sessions
  share it; the thread services pending sessions in turn. Teardown detaches
  the session there (disposing an attached caller-thread session abandons
  it, which keeps the GL objects until process exit), then removes the
  client and closes the session. The thread lives as long as the process.
- **The plugin creates its own Vulkan 1.1 device (graphics queue +
  `VK_KHR_swapchain`) for the Vulkan build.** Flutter doesn't share its
  device with plugins.
- **`onSurfaceCleanup` pauses frame demands, and `onSurfaceAvailable` moves the
  session to the new Surface.** The old `VkSurfaceKHR` is destroyed only after
  the session has left it. An old `EGLSurface` is destroyed once
  `set_opengl_surface_target` completes; it can still be current on the render
  thread until the next frame, and EGL defers destroying it until then.
- **Sessions end with `RenderSessionHandle.close()`, not `abandon()`.** Close
  detaches a core-worker session off the UI thread and completes once no
  library thread touches the target, after which the plugin frees its
  texture or surface. Abandon blocked the UI thread on the map's tile work
  and GPU queue. Close reports nothing about kept objects; a Vulkan swapchain
  is kept only when the process exits or its queue fails to drain.
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
- **Sessions render into a borrowed ring of three IOSurface-backed BGRA8
  pixel buffers, whose Metal textures come from a `CVMetalTextureCache`, and
  the `FlutterTexture` returns the presented slot's buffer from
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
  4 ms while a replaced frame is held. A resize releases every held frame once
  the session moved to the new ring; Flutter keeps the old buffer it shows.
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

- **One process-wide VkDevice and VkQueue are shared by every map, without
  `mln_queue_lock`.** The C library serializes every session's submits and
  presents per queue (`vulkan_queue_access.cpp`). A lock is only needed if
  host code uses the queue, and none does. The binding takes one as
  `QueueLock.native` from host native code.
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
  world copy; projections keep it, while `MapCamera` wraps the longitude
  into [-180, 180).
- **Dart calls the plugins on its UI thread.** Flutter's Windows and Linux
  texture registrar functions may be called from any thread. On Android the UI
  thread is the main thread, which SurfaceProducer needs.
- **Vulkan sessions use the core-worker driver, OpenGL ES sessions the render
  thread of the plugin, with frame wakes drained on the Dart isolate.** Frame demands use `waitForUpdate` (plus `present` on
  Android); since 0.202610.3 a demand without `force` renders only a newer
  map update, so idle maps don't render. The frame wake is a `Wake.native`
  over two `NativeCallable.listener`s that the package owns (see Known
  gaps). A map's `MapOptions.eventMask` limits its events to the ones the
  state handles, so per-frame render events are never queued. Runtime events arrive through
  `RuntimeHandle.setEventHandler`, which the binding calls on the isolate.
  Events that arrive before the first frame demand are kept until then.

## Public API

- **Feature queries are async on every platform, and there is no
  `queryLayers`.** The C API only queries asynchronously, and its features
  carry their source and source layer but not their style layer, so
  `RenderedFeature` has `sourceId` and `sourceLayer`, and layer membership is
  queried with `layerIds`. Since 0.202610.3 query results also name their
  style layer, `RenderedFeature.layerId`; on web it comes from the gl-js
  feature's `layer.id`. The webview's `*Async` overloads went with the
  webview package.
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

- **Layer properties are read and updated through per-type controllers with
  getters and setters** (`StyleController.getLineLayer` returns a
  `LineStyleLayerController`). The lookup fetches the properties the
  controller models, so getters are synchronous on every platform although
  native queries are async; setters update that cache and send the change
  without waiting (native: a discarding `setStyleLayerProperty` command), so
  an animation can set one every frame. Only `line-gradient` is modeled so
  far; more properties and layer types follow the same pattern.
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
  once and moves a `step` on `line-progress` in `line-gradient`. A GeoJSON
  update per frame re-encodes the data in Dart, parses and indexes it on the
  UI thread (`geojsonSourceDataCreate` is synchronous) and re-tiles the
  source; a paint change does none of that.

## Gestures

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
  change. `gestureEnd` carries the pan's release velocity; fling inertia
  runs in the platform. Discrete zooms (wheel, double tap) use `zoomBy`.
- **Native applies steps with `mln_map_apply_camera_delta`**, the C API's
  equivalent of mbgl's moveBy/scaleBy/rotateBy/pitchBy, one atomic delta per
  step with the gesture phase. Native maps don't fling yet.
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
  A released pan flings with gl-js's own pan inertia constants (linearity
  0.3, max speed 1400 px/s, deceleration 2500 px/s², ease-out bezier).
- **Globe on web needs no forwarding to gl-js handlers.** Measured with
  gl-js 5.24 at 1024×768: the grabbed point stays within 0.1 px at zoom 2 and
  above, also at 80° N and pitched 45°. At zoom 1 a drag from the center to
  near the globe's edge ends 8.6 px off, and one that starts near the pole
  98 px off. gl-js's own globe drag drifts as much or more (3–86 px over the
  same drags), so the fallback of forwarding pointer events to its handlers
  would not be better.
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
  calls: a GDK context of a real window, the device on its UUID, exported
  images that OpenGL imports, and the present copy, read back through
  `populate`, also across a resize. It passes on Mesa's lavapipe and
  llvmpipe, which share memory, so it runs without a GPU.
- **Projection integration tests run at zoom 4.** At the minimum zoom of a
  wide desktop window the world is narrower than the window, and screen
  corners wrap to the neighbouring world copy.

## Build and CI

- **A local C build is named in the root `pubspec.yaml` as
  `hooks.user_defines.maplibre_native_ffi.local_build`, a maplibre-native-ffi
  CMake build root.** The hook takes `<preset>/install` under it for each
  target, so one setting serves every platform and Android ABI.
- **ffigen and jnigen run from `tool/codegen`, a package outside the
  workspace.** Outside the workspace, the binding's build hook doesn't run
  during code generation. jnigen uses the example app's Gradle classpath.
- **`package:jni` is also an FFI plugin on Windows and Linux.** It builds
  there but stays unused.
- **CI builds and tests against the published C library.** No job builds it
  from source.
- **CI has no build-only jobs for platforms the integration tests run on.**
  Each integration test job builds the example app for its platform. Only
  the web wasm build has its own job, as the tests run the JavaScript build.

## Known gaps

- MapLibre Native drops the attribution of GeoJSON sources, so
  `StyleControllerNative` takes it from the style JSON and from `addSource`.
  For a style loaded from an http(s), `mapbox://` or `asset://` URL the JSON
  is not at hand, so its GeoJSON attributions are missing on native.
- In profile and release builds (AOT) of `maplibre_native_ffi` 0.202610.2
  and 0.202610.3, a native map stopped showing frames after about 30. The
  write-only `NativeHandleState._callbackRoots`
  (`lib/src/internal/lifecycle/lifecycle.dart`) is tree-shaken, and a
  render session's queued registrations are rooted only there, so its frame
  wake was collected and wakes were dropped. `@pragma('vm:entry-point')` on
  the field fixes it (checked on Windows through a local override). Until
  upstream fixes it, `MapRenderer` attaches with its own `_FrameWake`:
  listener callables that it owns, closed by the wake's release. Map and
  runtime registrations (event handler, camera transition ends) are rooted
  through fields the binding reads, so they are not affected.
- `GeoJsonSourceDataHandle.create` parses and indexes GeoJSON on the calling
  thread, so large GeoJSON updates block the UI thread. An async variant
  would move it off. `synchronous_tiling` only decides whether tiles are cut
  inline on update or on a worker afterwards.
- The C API has no setter for the offline tile count limit and no automatic
  database packing, so `setOfflineTileCountLimit` and
  `runPackDatabaseAutomatically` were removed from the `OfflineManager`.

- Missing on native: the globe projection and video sources. MapLibre Native
  implements neither, and the C API has no setting for them
  (`mln_map_set_projection_mode` only sets axonometric and skew;
  `MLN_STYLE_SOURCE_TYPE_VIDEO` only names the type). `setProjection(globe)`
  logs once and keeps Mercator, so pages that ask for a globe still show a
  map; adding a `VideoSource` throws an `UnsupportedError`, as a layer on it
  could not render.
- iOS and macOS pass the integration tests on an arm64 Mac (Xcode 27.1,
  macOS 27.0.1, iPhone 17 simulator on iOS 27.0) against the 0.202610.2
  release library, but have not run on an iOS device. 0.202610.3 adds a
  macOS x64 library, so Intel Macs build; none has run the tests.
- Linux has not been built through Flutter or run on a Linux machine: the
  plugin compiles with `-Wall -Werror` and `gl_texture_test` passes in WSL,
  which had no network for a Flutter build. The zero-copy path assumes that
  Flutter's OpenGL contexts share textures with GDK contexts of its window,
  that Flutter on Linux renders with OpenGL (an `FlTextureGL` does nothing
  for a Vulkan renderer), and that Dart's UI thread is the GTK main thread.
  To check it: run
  `flutter test integration_test/all_test.dart -d linux` in `examples` with and
  without `MAPLIBRE_NATIVE_DISABLE_ZERO_COPY=1`, and look for the
  "falling back to CPU readback" log line.
- Intel Macs and x86_64 simulators have no published C library.
- The C library's macOS preset targets 14.3, above Flutter 3.47's minimum of
  12.0, so apps must raise their macOS target. Lowering it is up to
  `maplibre_native_ffi`.
- The macOS presets also offer Vulkan and OpenGL. Selecting either with
  `backend.macos` makes a macOS map throw `UnsupportedError`, since the
  plugin only integrates Metal.
- The zero-copy Metal path passes on macOS and the iOS simulator, with
  MapLibre rendering into the one free slot. Not checked: shared-storage
  render targets on iOS devices, and whether a GPU read of Flutter outlasts
  the two slots the ring holds for it (tearing; none seen).
- Touch tilt and double-tap-drag are not tested on Windows touchscreens.
- Web lost gl-js's keyboard navigation and shift-drag box zoom, which the
  shared recognizer doesn't offer, and its grab cursor. Zoom and rotation
  don't fling, only pans.
- Native maps ignore the fling velocity of `gestureEnd`: a released pan
  stops dead. The C API has no inertia, so it would run in Dart over
  animated camera deltas.
