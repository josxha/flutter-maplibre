import 'package:maplibre/maplibre.dart';

/// WebView specific implementation of the [PermissionManager].
class PermissionManagerWebView implements PermissionManager {
  /// Create a new [PermissionManagerWebView] instance.
  const PermissionManagerWebView();

  @override
  bool get backgroundLocationPermissionGranted => true;

  @override
  bool get locationPermissionsGranted => true;

  @override
  Future<bool> requestLocationPermissions({required String explanation}) async {
    return true;
  }

  @override
  bool get runtimePermissionsRequired => false;
}
