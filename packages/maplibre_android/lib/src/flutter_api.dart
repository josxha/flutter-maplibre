import 'package:ffi/ffi.dart';
import 'package:maplibre_android/src/functions.dart';
import 'package:maplibre_android/src/jni.g.dart' as jni;
import 'package:maplibre_android/src/registry.dart';

/// The members of this class are called by the native Android code.
final class FlutterApi with jni.$FlutterApi {
  /// Creates a new Flutter API instance.
  const FlutterApi();

  @override
  jni.PlatformView createPlatformView(int viewId) => using((arena) {
    final jContext = getJContext();

    // MapLibre.getInstance needs to be called before creating the map.
    jni.MapLibre.getInstance(jContext);
    jni.Logger.verbosity = jni.Logger.WARN;

    final view = jni.FrameLayout(jContext);
    Registry.platformViews[viewId] = view;
    final platformView = jni.PlatformView.implement(
      jni.$PlatformView(
        getView: () => view,
        onFlutterViewAttached: (view) {},
        onFlutterViewDetached: () {},
        // The engine guarantees no further calls into this platform view
        // after dispose, so this is the last point where the container can
        // be unpinned. Without it the Registry entry keeps the FrameLayout
        // (and the destroyed MapView it contains) alive forever.
        dispose: () {
          Registry.platformViews.remove(viewId)?.release();
        },
        onInputConnectionLocked: () {},
        onInputConnectionUnlocked: () {},
      ),
    );
    return platformView;
  });
}
