import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The interface that federated plugin implementations of MapLibre can
/// implement.
abstract class MapLibrePlatform extends PlatformInterface {
  /// Constructs a MapLibrePlatform.
  MapLibrePlatform() : super(token: _token);

  static final Object _token = Object();

  // A plugin can have a default implementation, as shown here, or `instance`
  // can be nullable, and the default instance can be null.
  static MapLibrePlatform _instance = _MapLibrePluginStub();

  /// The default instance of [MapLibrePlatform] to use.
  /// Platform-specific plugins should override this with their own
  /// implementation of [MapLibrePlatform].
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

  /// Return whether offline manager is supported on the current platform.
  bool get offlineManagerIsSupported => false;
}

/// A stub implementation of the MapLibrePlatform interface.
///
/// This class is used when no actual platform implementation is provided so
/// that e.g. unit tests can still detect [offlineManagerIsSupported] without
/// causing errors.
class _MapLibrePluginStub extends MapLibrePlatform {}
