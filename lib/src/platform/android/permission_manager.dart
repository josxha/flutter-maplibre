import 'dart:async';

import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/android/extensions.dart';
import 'package:maplibre/src/platform/android/jni.dart' as jni;

/// MapLibre Android specific implementation of the [PermissionManager].
///
/// https://maplibre.org/maplibre-native/android/api/-map-libre%20-native%20-android/org.maplibre.android.location.permissions/-permissions-manager/index.html
class PermissionManagerAndroid implements PermissionManager {
  /// Create a new [PermissionManagerAndroid] instance.
  PermissionManagerAndroid();

  @override
  bool get locationPermissionsGranted => using((arena) {
    final jContext = Jni.getCachedApplicationContext().toJObject(arena);
    return jni.PermissionsManager.areLocationPermissionsGranted(jContext);
  });

  @override
  bool get runtimePermissionsRequired =>
      jni.PermissionsManager.areRuntimePermissionsRequired();

  @override
  bool get backgroundLocationPermissionGranted => using((arena) {
    final jContext = Jni.getCachedApplicationContext().toJObject(arena);
    return jni.PermissionsManager.isBackgroundLocationPermissionGranted(
      jContext,
    );
  });

  @override
  Future<bool> requestLocationPermissions({
    required String explanation,
  }) async => using((arena) async {
    final completer = Completer<bool>();
    final listener = jni.PermissionsListener.implement(
      jni.$PermissionsListener(
        onExplanationNeeded: (permissionsToExplain) {
          // This method fires when the user gets prompted to accept the permissions.
          // No not handle the return here, onPermissionResult will still be called.
        },
        onPermissionResult: completer.complete,
      ),
    )..releasedBy(arena);
    final jActivity = Jni.getApplicationClassLoader().toJObject(arena);
    jni.PermissionsManager(listener)
      ..releasedBy(arena)
      ..requestLocationPermissions(jActivity);
    return completer.future;
  });
}
