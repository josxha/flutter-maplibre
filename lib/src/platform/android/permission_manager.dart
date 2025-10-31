import 'dart:async';

import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/android/functions.dart';
import 'package:maplibre/src/platform/android/jni.dart' as jni;

/// MapLibre Android specific implementation of the [PermissionManager].
///
/// https://maplibre.org/maplibre-native/android/api/-map-libre%20-native%20-android/org.maplibre.android.location.permissions/-permissions-manager/index.html
class PermissionManagerAndroid implements PermissionManager {
  /// Create a new [PermissionManagerAndroid] instance.
  PermissionManagerAndroid();

  @override
  bool get locationPermissionsGranted => using(
    (arena) => jni.PermissionsManager.areLocationPermissionsGranted(
      getJContext(arena),
    ),
  );

  @override
  bool get runtimePermissionsRequired =>
      jni.PermissionsManager.areRuntimePermissionsRequired();

  @override
  bool get backgroundLocationPermissionGranted => using(
    (arena) => jni.PermissionsManager.isBackgroundLocationPermissionGranted(
      getJContext(arena),
    ),
  );

  @override
  Future<bool> requestLocationPermissions({
    required String explanation,
  }) async => using((arena) async {
    final completer = Completer<bool>();
    final listener = jni.PermissionsListener.implement(
      _PermissionsListener(WeakReference(completer)),
    )..releasedBy(arena);
    final jActivity = getJActivity(arena);
    jni.PermissionsManager(listener)
      ..releasedBy(arena)
      ..requestLocationPermissions(jActivity);
    return completer.future;
  });
}

final class _PermissionsListener with jni.$PermissionsListener {
  const _PermissionsListener(this.weakCompleter);

  final WeakReference<Completer<bool>> weakCompleter;

  @override
  void onExplanationNeeded(JList<JString?>? permissionsToExplain) {
    // This method fires when the user gets prompted to accept the permissions.
    // No not handle the return here, onPermissionResult will still be called.
  }

  @override
  void onPermissionResult(bool result) {
    weakCompleter.target?.complete(result);
  }

}