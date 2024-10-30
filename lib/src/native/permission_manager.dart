import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/native/jni/jni.dart' as jni;

/// MapLibre Android specific implementation of the [PermissionManager].
///
/// https://maplibre.org/maplibre-native/android/api/-map-libre%20-native%20-android/org.maplibre.android.location.permissions/-permissions-manager/index.html
class PermissionManagerNative implements PermissionManager {
  /// Create a new [PermissionManagerNative] instance.
  PermissionManagerNative() {
    _jManager = jni.PermissionsManager(
      jni.PermissionsListener.implement(
        jni.$PermissionsListener(
          onExplanationNeeded: (list) {
            print('onExplanationNeeded: $list');
          },
          onPermissionResult: (granted) {
            print('onPermissionResult: $granted');
          },
        ),
      ),
    );
    _listener =
        jni.PluginRegistry_RequestPermissionsResultListener.implement(
      jni.$PluginRegistry_RequestPermissionsResultListener(
        onRequestPermissionsResult: (requestCode, permissions, grantResults) {
          print('onRequestPermissionsResult: $requestCode, $permissions, $grantResults');
          _jManager.onRequestPermissionsResult(requestCode, permissions, grantResults);
          return true;
        },
      ),
    );
    _activityBinding.addRequestPermissionsResultListener(_listener);
    /*binding.addRequestPermissionsResultListener { requestCode, permissions, grantResults ->
    PermissionsManager().onRequestPermissionsResult(requestCode, permissions, grantResults)
    true
    }*/
  }

  late final jni.PermissionsManager _jManager;
  late final jni.PluginRegistry_RequestPermissionsResultListener _listener;

  static JObject get _jContext => jni.MapLibreRegistry.INSTANCE.getContext();

  static JObject get _jActivity => jni.MapLibreRegistry.INSTANCE.getActivity();
  final jni.ActivityPluginBinding _activityBinding =
      jni.MapLibreRegistry.INSTANCE.getActivityPluginBinding();

  @override
  bool get areLocationPermissionsGranted =>
      jni.PermissionsManager.areLocationPermissionsGranted(_jContext);

  @override
  bool get areRuntimePermissionsRequired =>
      jni.PermissionsManager.areRuntimePermissionsRequired();

  @override
  bool get isBackgroundLocationPermissionGranted =>
      jni.PermissionsManager.isBackgroundLocationPermissionGranted(_jContext);

  @override
  void requestLocationPermissions() =>
      _jManager.requestLocationPermissions(_jActivity);

  @override
  void dispose() {
    _jManager.release();
    _activityBinding.removeRequestPermissionsResultListener(_listener);
  }
}
