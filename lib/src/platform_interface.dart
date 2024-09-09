import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/native/platform_method_channel.dart';

/// https://pub.dev/packages/plugin_platform_interface#a-note-about-base
abstract base class MapLibrePlatform {
  /// Constructs a MapLibrePlatform.
  const MapLibrePlatform();

  /// The default instance of [MapLibrePlatform] to use.
  ///
  /// Defaults to [MapLibreNative].
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MapLibrePlatform] when
  /// they register themselves.
  static MapLibrePlatform instance = PlatformMethodChannel();

  MapControllerInternal createMapController(MapLibreMap widget);
}
