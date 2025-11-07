import 'package:ffi/ffi.dart';
import 'package:maplibre/src/platform/android/functions.dart';
import 'package:maplibre/src/platform/android/jni.dart' as jni;
import 'package:maplibre/src/platform/android/registry.dart';

/// The members of this class are called by the native Android code.
final class FlutterApi with jni.$FlutterApi {
  /// Creates a new Flutter API instance.
  const FlutterApi();

  @override
  jni.PlatformView createPlatformView(int viewId) => using((arena) {
    final jContext = getJContext();

    // MapLibre.getInstance needs to be called before creating the map.
    jni.MapLibre.getInstance(jContext);
    jni.Logger.setVerbosity(jni.Logger.WARN);

    final view = jni.FrameLayout(jContext);
    Registry.platformViews[viewId] = view;
    final platformView = jni.PlatformView.implement(
      jni.$PlatformView(
        getView: () => view,
        onFlutterViewAttached: (view) {},
        onFlutterViewDetached: () {},
        dispose: () {},
        onInputConnectionLocked: () {},
        onInputConnectionUnlocked: () {},
      ),
    );
    return platformView;
  });
}
