import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/pigeon.g.dart';

/// MapLibre Android specific implementation of the [PermissionManager].
///
/// https://maplibre.org/maplibre-native/android/api/-map-libre%20-native%20-android/org.maplibre.android.location.permissions/-permissions-manager/index.html
class PermissionManagerAndroid implements PermissionManager {
  @override
  // TODO: implement backgroundLocationPermissionGranted
  bool get backgroundLocationPermissionGranted => throw UnimplementedError();

  @override
  // TODO: implement locationPermissionsGranted
  bool get locationPermissionsGranted => throw UnimplementedError();

  @override
  Future<bool> requestLocationPermissions({required String explanation}) {
    // TODO: implement requestLocationPermissions
    throw UnimplementedError();
  }

  @override
  // TODO: implement runtimePermissionsRequired
  bool get runtimePermissionsRequired => throw UnimplementedError();

}
