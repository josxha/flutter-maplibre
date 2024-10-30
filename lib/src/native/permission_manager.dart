import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/native/jni/jni.dart' as jni;
import 'package:maplibre/src/native/permission_manager_pigeon.g.dart';

/// MapLibre Android specific implementation of the [PermissionManager].
///
/// https://maplibre.org/maplibre-native/android/api/-map-libre%20-native%20-android/org.maplibre.android.location.permissions/-permissions-manager/index.html
class PermissionManagerNative implements PermissionManager {
  /// Create a new [PermissionManagerNative] instance.
  PermissionManagerNative();

  final _api = PermissionManagerHostApi();

  static JObject get _jContext => jni.MapLibreRegistry.INSTANCE.getContext();

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
  Future<bool> requestLocationPermissions() async {
    return _api.requestLocationPermissions(explanation: 'Test explanation');
  }

  @override
  void dispose() {}
}
