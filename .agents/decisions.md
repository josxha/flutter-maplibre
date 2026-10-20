# Technical decisions

Each entry: the decision, then why.

## Architecture

- **Two platform packages: `maplibre_web` for the browser and `maplibre_native`
  for everything else.** One C API serves every native platform, so the
  per-platform packages (android, ios, webview) were removed.
- **The C API comes from `maplibre/maplibre-native-ffi` PR #760, as a
  submodule pinned to `16e9efc2a`.** The binding is a path dependency, so
  `maplibre` can't publish until the binding is on pub.dev.
- **Rendering goes only through the texture registry, never platform views.**
  This keeps Flutter composition, transforms, and overlays working.
- **Every native platform renders through Vulkan.** WGL needs one pinned
  thread, which Dart can't guarantee, and the binding's surface and texture
  APIs are Vulkan-first.
- **Dart reaches the platform plugins through ffigen (Windows) and jnigen
  (Android), never method channels.** Calls are synchronous and typed, with
  no message encoding. The Windows plugin DLL exports a C API and keeps its
  one registered instance behind a mutex. On Android a Kotlin
  `MaplibreNativeApi` object holds the engine's texture registry, and
  SurfaceProducer callbacks reach Dart through a `SurfaceListener` that Dart
  implements as async listeners.

## Windows

- **Frames reach Flutter as a triple-buffered ring of D3D11 textures shared
  with Vulkan, shown as a DXGI GPU surface texture.** If sharing fails, frames
  are read back to the CPU into a pixel buffer texture.
- **No keyed mutex on the shared textures.** Flutter/ANGLE never acquire it.
  Tearing is unlikely but possible.
- **The C library is built with MSVC 14.37.** 14.44 needs LLVM 19 or newer.

## Android

- **MapLibre presents through a Vulkan swapchain on the Surface of a Flutter
  `SurfaceProducer`.** This is zero-copy, works with Impeller and the
  ImageReader backend, and needs no Android-specific code in the C API.
- **The plugin creates its own Vulkan 1.1 device (graphics queue +
  `VK_KHR_swapchain`).** Flutter doesn't share its device with plugins.
- **`onSurfaceCleanup` pauses frame demands, and `onSurfaceAvailable` moves the
  session to the new Surface.** The old `VkSurfaceKHR` is destroyed only after
  the session has left it.
- **A VkSurfaceKHR stays alive when `abandon` quarantines its swapchain.** The
  C API requires the parent to outlive kept children.
- **The patched rustls-platform-verifier `CertificateVerifier.kt` is vendored
  verbatim, along with its licenses and keep rules.** The C library calls it
  over JNI for TLS. ktlint skips it.
- **The workspace sets `hooks.user_defines.maplibre_native_ffi.backend:
  vulkan`.** The downloaded Android library defaults to OpenGL ES.

## Threading and GPU

- **One process-wide VkDevice and VkQueue are shared by every map, without
  `mln_queue_lock`.** The C library serializes every session's submits and
  presents per queue (`vulkan_queue_access.cpp`). A lock is only needed if
  host code uses the queue, and none does. The Dart binding doesn't expose
  `queue_lock` yet.
- **Widgets over the map follow the frame on screen, not the latest camera.**
  Each rendered frame's `session.createProjection()` (taken before the next
  demand) reaches the map state when Flutter can show that frame. `camera`
  and screen locations come from it, so widget layers rebuild in the same
  Flutter frame as the map image. Camera events and `getCamera()` still
  report the latest camera, so `await moveCamera(...)` is followed by the new
  one. Exact on Windows. On Android Flutter takes the newest Surface
  image itself, so it can be off by a frame. Frames that drew a map update
  older than the initial camera are skipped, because they can reach Flutter
  after `onMapCreated`.
- **Dart calls the plugins on its UI thread.** Flutter's Windows texture
  registrar functions may be called from any thread. On Android the UI
  thread is the main thread, which SurfaceProducer needs.
- **Sessions use the core-worker driver, with wakes drained on the Dart
  isolate.** Frame demands use `ifNeeded | waitForUpdate` (plus `present` on
  Android), so idle maps don't render.

## Public API

- **Feature queries are async on every platform, and there is no
  `queryLayers`.** The C API only queries asynchronously, and its features
  carry their source and source layer but not their style layer, so
  `RenderedFeature` has `sourceId` and `sourceLayer`, and layer membership is
  queried with `layerIds`. The webview's `*Async` overloads went with the
  webview package.

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
  come from `MapGestureDetector`. A right click or Ctrl + click that starts
  on the map suppresses the browser's context menu once.
- **Web applies steps with public gl-js camera calls, each an `easeTo` of
  duration 0.** A pan puts `unproject(panFrom)` at `panTo` through
  `center` + `offset`, so the grabbed location stays under the pointer in
  every projection; zoom, rotation and pitch use `around`. One gesture
  reports one camera move, although gl-js fires movestart/moveend per step.
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
  1/450 level per pixel, as GL JS; a trackpad pinch that arrives as a scale
  signal zooms by its scale.

## Tests

- **The recognizer is unit tested against a recording `GestureCameraSink`**
  (`maplibre_platform_interface/test`). The integration tests in
  `examples/integration_test/gestures_test.dart` check each platform's
  camera end to end.
- **Projection integration tests run at zoom 4.** At the minimum zoom of a
  wide desktop window the world is narrower than the window, and screen
  corners wrap to the neighbouring world copy.

## Build and CI

- **`tool/use_native_build.dart` points the build hook at a local C build.**
  The hook takes one prefix and checks its target. The tool runs from the
  repo root so the hook doesn't run first for the host.
- **ffigen and jnigen run from `tool/codegen`, a package outside the
  workspace.** ffigen 23 and jnigen 1.0.1 need `code_assets ^2`, while the
  binding pins `^1.2`. Outside the workspace, the binding's build hook doesn't
  run either. jnigen uses the example app's Gradle classpath.
- **`package:jni` is also an FFI plugin on Windows and Linux.** It builds
  there but stays unused.
- **The Windows CI job builds the C library from the submodule and caches it
  by submodule commit.** Other jobs use the upstream snapshot from the
  binding's main branch, not PR #760.

## Known gaps

- Missing on native: globe projection, user location and permissions.
- The Dart binding lacks `queue_lock`. The Python binding has it.
- The binding's build hook takes one local install prefix and rejects other
  targets, so it can't pick a preset per target (needed for multi-ABI
  Android builds). `upstream/0001-dart-hook-build-root.patch` lets the
  pointer name `build/` and picks `build/<preset>/install` per target. Once
  it lands upstream, `tool/use_native_build.dart` can write `build/` once.
- Touch tilt and double-tap-drag are not tested on Windows touchscreens.
- Web lost gl-js's keyboard navigation and shift-drag box zoom, which the
  shared recognizer doesn't offer, and its grab cursor. Zoom and rotation
  don't fling, only pans.
- The wheel zooms 1/450 level per logical pixel everywhere. Flutter web
  divides Chrome's wheel delta by the device pixel ratio, so on a 2x screen
  a wheel notch zooms half as far as in plain gl-js.
- Native maps ignore the fling velocity of `gestureEnd`: a released pan
  stops dead. The C API has no inertia, so it would run in Dart over
  animated camera deltas.
