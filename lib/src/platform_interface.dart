import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/native/platform_native.dart'
    if (dart.library.html) 'package:maplibre/src/web/platform_web.dart';

/// https://pub.dev/packages/plugin_platform_interface#a-note-about-base
abstract base class PlatformInterface {
  /// Constructs a MapLibrePlatform.
  const PlatformInterface();

  /// The default instance of [PlatformInterface] to use.
  ///
  /// Defaults to [PlatformNative].
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PlatformInterface] when
  /// they register themselves.
  static PlatformInterface instance = PlatformNative();

  /// Return a platform specific [State<MapLibreMap>] object.
  State<MapLibreMap> createWidgetState();
}
