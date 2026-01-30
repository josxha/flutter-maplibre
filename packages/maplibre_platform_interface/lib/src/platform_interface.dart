import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class MapLibrePlatform extends PlatformInterface {
  MapLibrePlatform() : super(token: _token);

  static final Object _token = Object();

  // A plugin can have a default implementation, as shown here, or `instance`
  // can be nullable, and the default instance can be null.
  static MapLibrePlatform? _instance;

  static MapLibrePlatform get instance =>
      _instance ??
      (throw UnsupportedError(
        'No MapLibrePlatform instance has been registered. '
        'This usually means that the MapLibre plugin has not been '
        'added as a dependency in pubspec.yaml.',
      ));

  /// Platform-specific implementations should set this to their own
  /// platform-specific class that extends [MapLibrePlatform] when they
  /// register themselves.
  static set instance(MapLibrePlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Return a platform specific [State<MapLibreMap>] object.
  MapLibreMapState createWidgetState();

  /// Return a platform specific [OfflineManager] object.
  Future<OfflineManager> createOfflineManager();

  /// Return a platform specific [PermissionManager] object.
  PermissionManager createPermissionManager();

  /// Return whether offline manager is supported on the current platform.
  bool get offlineManagerIsSupported => true;

  /// Return whether permission manager is supported on the current platform.
  bool get permissionManagerIsSupported => true;

  /// Return whether user location is supported on the current platform.
  bool get userLocationIsSupported => true;
}
