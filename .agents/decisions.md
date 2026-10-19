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
  Flutter frame as the map image. Camera events still report the latest
  camera. Exact on Windows. On Android Flutter takes the newest Surface
  image itself, so it can be off by a frame.
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

- **Gestures are recognized in Dart and applied as camera deltas.** A
  two-finger twist turns the map with the fingers (negated bearing). Double
  tap and drag zooms (down zooms in, 150 px per level). Two fingers side by
  side dragged vertically tilt, as on MapLibre Android. Right-mouse drag
  rotates and tilts on desktop.

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
