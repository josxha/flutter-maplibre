import 'package:maplibre_android/src/jni.g.dart' as jni;

/// Registry for platform views.
abstract class Registry {
  /// The platform views mapped by their view IDs.
  static final platformViews = <int, jni.FrameLayout>{};

  /// The map views mapped by their view IDs.
  static final mapViews = <int, jni.MapView>{};
}
