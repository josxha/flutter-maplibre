import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class MapLibrePlatform extends PlatformInterface {
  MapLibrePlatform() : super(token: _token);

  static final Object _token = Object();

  // A plugin can have a default implementation, as shown here, or `instance`
  // can be nullable, and the default instance can be null.
  static MapLibrePlatform _instance = _MapLibrePluginStub();

  static MapLibrePlatform get instance => _instance;

  /// Platform-specific implementations should set this to their own
  /// platform-specific class that extends [MapLibrePlatform] when they
  /// register themselves.
  static set instance(MapLibrePlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Return a platform specific [MapLibreMapState] object.
  MapLibreMapState createWidgetState() =>
      throw UnsupportedError('MapLibre is not supported on this platform.');

  /// Return a platform specific [OfflineManager] object.
  Future<OfflineManager> createOfflineManager() => throw UnsupportedError(
    'MapLibre OfflineManager is not supported on this platform.',
  );

  /// Return a platform specific [PermissionManager] object.
  PermissionManager createPermissionManager() => throw UnsupportedError(
    'MapLibre PermissionManager is not supported on this platform.',
  );

  /// Return whether offline manager is supported on the current platform.
  bool get offlineManagerIsSupported => false;

  /// Return whether permission manager is supported on the current platform.
  bool get permissionManagerIsSupported => false;

  /// Return whether user location is supported on the current platform.
  bool get userLocationIsSupported => false;
}

/// A stub implementation of the MapLibrePlatform interface.
///
/// This class is used when no actual platform implementation is provided so
/// that e.g. unit tests can still detect [offlineManagerIsSupported],
/// [permissionManagerIsSupported], and [userLocationIsSupported] without causing
/// errors.
class _MapLibrePluginStub extends MapLibrePlatform {}
