import 'dart:async';

import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/android/jni.dart' as jni;

/// MapLibre Android specific implementation of the [PermissionManager].
///
/// https://maplibre.org/maplibre-native/android/api/-map-libre%20-native%20-android/org.maplibre.android.location.permissions/-permissions-manager/index.html
class PermissionManagerAndroid implements PermissionManager {
  /// Create a new [PermissionManagerAndroid] instance.
  PermissionManagerAndroid();

  static JObject? get _jContext => jni.MapLibreRegistry.INSTANCE.getContext();

  static JObject? get _jActivity => jni.MapLibreRegistry.INSTANCE.getActivity();

  @override
  bool get locationPermissionsGranted =>
      jni.PermissionsManager.areLocationPermissionsGranted(_jContext);

  @override
  bool get runtimePermissionsRequired =>
      jni.PermissionsManager.areRuntimePermissionsRequired();

  @override
  bool get backgroundLocationPermissionGranted =>
      jni.PermissionsManager.isBackgroundLocationPermissionGranted(_jContext);

  @override
  Future<bool> requestLocationPermissions({required String explanation}) async {
    final completer = Completer<bool>();
    final listener = jni.PermissionsListener.implement(
      jni.$PermissionsListener(
        onExplanationNeeded: (permissionsToExplain) {
          // This method fires when the user gets prompted to accept the permissions.
          // No not handle the return here, onPermissionResult will still be called.
        },
        onPermissionResult: completer.complete,
      ),
    );
    final manager = jni.PermissionsManager(listener);
    manager.requestLocationPermissions(_jActivity);
    final result = await completer.future;
    listener.release();
    manager.release();
    return result;
  }
}
