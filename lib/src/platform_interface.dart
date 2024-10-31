import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/map_state.dart';
import 'package:maplibre/src/native/platform_impl.dart'
    if (dart.library.html) 'package:maplibre/src/web/platform_impl.dart';

/// https://pub.dev/packages/plugin_platform_interface#a-note-about-base
abstract base class PlatformInterface {
  /// Constructs a MapLibrePlatform.
  const PlatformInterface();

  /// The default instance of [PlatformInterface] to use.
  ///
  /// Defaults to [PlatformImpl].
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PlatformInterface] when
  /// they register themselves.
  static PlatformInterface instance = PlatformImpl();

  /// Return a platform specific [State<MapLibreMap>] object.
  MapLibreMapState createWidgetState();

  /// Return a platform specific [OfflineManager] object.
  Future<OfflineManager> createOfflineManager();

  /// Return a platform specific [PermissionManager] object.
  PermissionManager createPermissionManager();
}
