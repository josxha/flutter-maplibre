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
- **Windows and Linux render through Vulkan. Android renders through OpenGL
  ES by default, and through Vulkan when the app selects the Vulkan build.
  iOS and macOS render through Metal.** WGL and GLX/EGL need one pinned
  thread, which Dart can't guarantee, and the binding's texture APIs are
  Vulkan-first. On Android, OpenGL ES runs on every device,
  while Vulkan 1.1 drivers are missing or unreliable on many older ones.
- **The C library carries one backend, and Dart follows it at runtime.** The
  binding's build hook picks it per target (OpenGL ES on Android, Vulkan on
  Windows and Linux) unless `hooks.user_defines.maplibre_native_ffi.backend`
  names one, and `mln_supported_render_backend_mask()` tells `MapRenderer`
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
  resize, each frame copied on the GPU before release).
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
- **Each OpenGL ES map has a plugin-owned native render thread that services
  its caller-graphics-thread session.** EGL surface targets require
  `MLN_RENDER_DRIVER_CALLER_GRAPHICS_THREAD`, so rendering runs where
  `mln_render_session_service_driver_work` is called, and the Dart isolate
  runs on the Android main thread. The session's `driverWorkWake` reaches the
  isolate, which wakes the thread through jnigen; the Dart binding only takes
  Dart wakes. `RenderSessionHandle.id` is the raw `mln_render_session`, so the
  JNI shim calls the C function it resolves with `dlsym`. One thread per map,
  because the C API binds a session to the first thread that services it and
  a dedicated context stays current there between renders. Teardown detaches
  on that thread (abandon would keep the GL objects until process exit), then
  stops it.
- **The plugin creates its own Vulkan 1.1 device (graphics queue +
  `VK_KHR_swapchain`) for the Vulkan build.** Flutter doesn't share its
  device with plugins.
- **`onSurfaceCleanup` pauses frame demands, and `onSurfaceAvailable` moves the
  session to the new Surface.** The old `VkSurfaceKHR` is destroyed only after
  the session has left it. An old `EGLSurface` is destroyed once
  `set_opengl_surface_target` completes; it can still be current on the render
  thread until the next frame, and EGL defers destroying it until then.
- **A VkSurfaceKHR stays alive when `abandon` quarantines its swapchain.** The
  C API requires the parent to outlive kept children.
- **The patched rustls-platform-verifier `CertificateVerifier.kt` is vendored
  verbatim, along with its licenses and keep rules.** The C library calls it
  over JNI for TLS. ktlint skips it.

## iOS and macOS

- **One Objective-C plugin in `darwin/` serves both, with
  `sharedDarwinSource`, as a SwiftPM package only.** The Metal and CoreVideo
  code is the same on both; only the Flutter import differs. CocoaPods is
  deprecated and being phased out of Flutter, so there is no podspec, and the
  example's iOS and macOS projects are deintegrated from it. Apps need
  `flutter config --enable-swift-package-manager`.
- **Sessions render into a borrowed ring of three private BGRA8 Metal
  textures, and each acquired frame is blitted into a pixel buffer from an
  IOSurface-backed `CVPixelBufferPool`, which the `FlutterTexture` returns
  from `copyPixelBuffer`.** BGRA8 is what Flutter's pixel buffer textures
  read, and the session-owned ring is RGBA8, which a blit can't swizzle.
  Copying keeps the ring free while Flutter still samples the previous frame,
  as the D3D11 copy does on Windows; the pool only reuses a buffer once
  Flutter has let go of it. The plugin waits for the blit before the frame is
  released with CPU-complete sync, because Flutter samples on its own command
  queue, which Metal doesn't order with ours.
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
- **The example excludes x86_64 (macOS and the iOS simulator) and has the
  `network.client` entitlement on macOS.** The C library is published for
  arm64 only, and the sandbox blocks tile downloads without it.

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
- **Dart calls the plugins on its UI thread.** Flutter's Windows and Linux
  texture registrar functions may be called from any thread. On Android the UI
  thread is the main thread, which SurfaceProducer needs.
- **Vulkan sessions use the core-worker driver, OpenGL ES sessions a render
  thread of the plugin, with frame and event wakes drained on the Dart
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
  1/450 level per pixel, as GL JS; a trackpad pinch that arrives as a scale
  signal zooms by its scale.

## Tests

- **The recognizer is unit tested against a recording `GestureCameraSink`**
  (`maplibre_platform_interface/test`). The integration tests in
  `examples/integration_test/gestures_test.dart` check each platform's
  camera end to end.
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
- iOS and macOS were written without a Mac and have not been built or run.
- Linux has not been built through Flutter or run on a Linux machine: the
  plugin compiles with `-Wall -Werror` and `gl_texture_test` passes in WSL,
  which had no network for a Flutter build. The zero-copy path assumes that
  Flutter's OpenGL contexts share textures with GDK contexts of its window,
  that Flutter on Linux renders with OpenGL (an `FlTextureGL` does nothing
  for a Vulkan renderer), and that Dart's UI thread is the GTK main thread.
  To check it: build `linux-gnu-x64-vulkan` (the snapshot lags the pinned
  binding), `dart tool/use_native_build.dart linux-gnu-x64-vulkan`, run
  `flutter test integration_test/main.dart -d linux` in `examples` with and
  without `MAPLIBRE_NATIVE_DISABLE_ZERO_COPY=1`, and look for the
  "falling back to CPU readback" log line.
- Intel Macs and x86_64 simulators have no published C library.
- The backend user-define applies to every target, and the macOS presets
  also offer Vulkan and OpenGL. With either, a macOS map throws
  `UnsupportedError`, since the plugin only integrates Metal.
- The Metal path copies every frame on the GPU and waits for the copy on the
  Dart UI thread. Holding the shown frame acquired, or a shared event, could
  drop the copy or the wait.
- The Dart binding lacks `queue_lock`. The Python binding has it.
- The binding's build hook takes one local install prefix and rejects other
  targets, so it can't pick a preset per target (needed for multi-ABI
  Android builds).
- Touch tilt and double-tap-drag are not tested on Windows touchscreens.
- The `backend: vulkan` user-define that opts Android into Vulkan applies to
  every target, but iOS only has Metal builds of the C library, so an app
  that targets iOS can't build with it. The binding's hook would need a
  backend per platform.
- An OpenGL ES map wakes its render thread through the Dart isolate, a hop a
  native wake would save. The binding only accepts Dart callbacks as wakes.
- Two OpenGL ES maps render on two threads with two contexts. A shared
  thread would need the session to make its dedicated context current again
  after another session's render, which it skips.
- Web lost gl-js's keyboard navigation and shift-drag box zoom, which the
  shared recognizer doesn't offer, and its grab cursor. Zoom and rotation
  don't fling, only pans.
- The wheel zooms 1/450 level per logical pixel everywhere. Flutter web
  divides Chrome's wheel delta by the device pixel ratio, so on a 2x screen
  a wheel notch zooms half as far as in plain gl-js.
- Native maps ignore the fling velocity of `gestureEnd`: a released pan
  stops dead. The C API has no inertia, so it would run in Dart over
  animated camera deltas.
