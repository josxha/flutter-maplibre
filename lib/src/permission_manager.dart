/// The Permission Manager provides functionality to check if location
/// permissions are granted and can request permissions.
abstract interface class PermissionManager {
  /// Returns true if access to background location is granted.
  bool get isBackgroundLocationPermissionGranted;

  /// Returns true if either access to coarse location or to fine location
  /// is granted.
  bool get areLocationPermissionsGranted;

  /// Check if the operating system requires to ask for location permissions
  /// at runtime.
  bool get areRuntimePermissionsRequired;

  /// Request runtime location permissions.
  void requestLocationPermissions();

  /// Call this function when you don't need the [PermissionManager] any
  /// longer to free resources.
  void dispose();
}
