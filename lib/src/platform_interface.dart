import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/native/platform_native.dart';

/// https://pub.dev/packages/plugin_platform_interface#a-note-about-base
abstract base class PlatformInterface {
  /// Constructs a MapLibrePlatform.
  const PlatformInterface();

  /// The default instance of [MapLibrePlatform] to use.
  ///
  /// Defaults to [MapLibreNative].
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MapLibrePlatform] when
  /// they register themselves.
  static PlatformInterface instance = PlatformNative();

  State<MapLibreMap> createWidgetState();
}
