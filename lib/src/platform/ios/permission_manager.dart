import 'package:maplibre/maplibre.dart';

/// iOS specific implementation of the [PermissionManager].
class PermissionManagerIos implements PermissionManager {
  /// Create a new [PermissionManagerIos] instance.
  const PermissionManagerIos();

  @override
  // TODO: implement backgroundLocationPermissionGranted
  bool get backgroundLocationPermissionGranted => throw UnimplementedError();

  @override
  // TODO: implement locationPermissionsGranted
  bool get locationPermissionsGranted => false;

  @override
  Future<bool> requestLocationPermissions({required String explanation}) {
    // TODO: implement requestLocationPermissions
    throw UnimplementedError();
  }

  @override
  // TODO: implement runtimePermissionsRequired
  bool get runtimePermissionsRequired => throw UnimplementedError();
}
