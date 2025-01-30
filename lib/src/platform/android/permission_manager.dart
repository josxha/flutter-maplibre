import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/android/jni/jni.dart' as jni;
import 'package:maplibre/src/platform/pigeon.g.dart';

/// MapLibre Android specific implementation of the [PermissionManager].
///
/// https://maplibre.org/maplibre-native/android/api/-map-libre%20-native%20-android/org.maplibre.android.location.permissions/-permissions-manager/index.html
class PermissionManagerAndroid implements PermissionManager {
  /// Create a new [PermissionManagerAndroid] instance.
  PermissionManagerAndroid();

  final _api = PermissionManagerHostApi();

  static JObject? get _jContext => jni.MapLibreRegistry.INSTANCE.getContext();

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
    return _api.requestLocationPermissions(explanation: explanation);
  }
}
