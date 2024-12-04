import 'package:maplibre/src/platform_interface.dart';

/// The Permission Manager provides functionality to check if location
/// permissions are granted and can request permissions.
///
/// The [PermissionManager] cannot be used on web.
///
/// {@category Basic}
abstract interface class PermissionManager {
  factory PermissionManager() =>
      PlatformInterface.instance.createPermissionManager();

  /// Returns true if access to background location is granted.
  bool get backgroundLocationPermissionGranted;

  /// Returns true if either access to coarse location or to fine location
  /// is granted.
  bool get locationPermissionsGranted;

  /// Check if the operating system requires to ask for location permissions
  /// at runtime.
  bool get runtimePermissionsRequired;

  /// Request runtime location permissions.
  Future<bool> requestLocationPermissions({required String explanation});
}
