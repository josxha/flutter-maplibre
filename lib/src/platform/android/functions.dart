import 'package:jni/jni.dart';
import 'package:maplibre/src/platform/android/jni.dart';

/// Get the Android [Context]. Requires an [arena] parameter by whom it can
/// get released.
Context getJContext([Arena? arena]) {
  final context = Context.fromReference(Jni.getCachedApplicationContext());
  if (arena != null) context.releasedBy(arena);
  return context;
}

/// Get the Android [Activity]. Requires an [arena] parameter by whom it can
/// get released.
Activity getJActivity(Arena arena) =>
    Activity.fromReference(Jni.getCurrentActivity())..releasedBy(arena);
