import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// https://pub.dev/packages/plugin_platform_interface#a-note-about-base
abstract base class PlatformInterface {
  /// Constructs a MapLibrePlatform.
  const PlatformInterface();

  /// The instance of [PlatformInterface] to use.
  ///
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PlatformInterface] when
  /// they register themselves.
  static late PlatformInterface instance;

  /// Return a platform specific [State<MapLibreMap>] object.
  MapLibreMapState createWidgetState();

  /// Return a platform specific [OfflineManager] object.
  Future<OfflineManager> createOfflineManager();

  /// Return a platform specific [PermissionManager] object.
  PermissionManager createPermissionManager();
}
