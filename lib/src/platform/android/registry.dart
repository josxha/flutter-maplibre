import 'package:maplibre/src/platform/android/jni.dart' as jni;

/// Registry for platform views.
abstract class Registry {
  /// The platform views mapped by their view IDs.
  static final platformViews = <int, jni.FrameLayout>{};
}
