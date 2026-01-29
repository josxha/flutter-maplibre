import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/inherited_model.dart';

/// The [MapOptions] class is used to set default values for the [MapLibreMap]
/// widget.
///
/// {@category Basic}
@immutable
class MapOptions {
  /// Creates a new [MapOptions] instance. See fields for more information.
  const MapOptions({
    this.initStyle = 'https://demotiles.maplibre.org/style.json',
    this.initZoom = 0,
    this.initCenter,
    @Deprecated('Renamed to initPitch') double? pitch,
    double initPitch = 0,
    this.initBearing = 0,
    this.minZoom = 0,
    this.maxZoom = 22,
    this.minPitch = 0,
    this.maxPitch = 60,
    this.maxBounds,
    this.gestures = const MapGestures.all(),
    this.androidTextureMode = true,
    this.androidMode = AndroidPlatformViewMode.tlhc_vd,
    this.androidTranslucentTextureSurface = false,
    this.androidForegroundLoadColor = Colors.transparent,
    this.webviewDebugMode = false,
  }) : initPitch = pitch ?? initPitch;

  /// Find the [MapOptions] of the closest [MapLibreMap] in the widget tree.
  /// Returns null if called outside of the [MapLibreMap.children].
  static MapOptions? maybeOf(BuildContext context) =>
      MapLibreInheritedModel.maybeMapControllerOf(context)?.options;

  /// Find the [MapOptions] of the closest [MapLibreMap] in the widget tree.
  /// Throws an [StateError] if called outside of the [MapLibreMap.children].
  static MapOptions of(BuildContext context) =>
      maybeOf(context) ??
      (throw StateError('Unable to find an instance of MapOptions'));

  /// A JSON string representing a valid MapLibre style document, or a URL
  /// pointing to such a document.
  ///
  /// If not set, the default MapLibre style is used
  /// (https://demotiles.maplibre.org/style.json).
  ///
  /// If you need to change to a different map style later on,
  /// use [MapController.setStyle].
  final String initStyle;

  /// The initial zoom level.
  final double initZoom;

  /// The initial pitch level. Minimum is 0 and maximum is 85 on web and 60 on
  /// other platforms.
  final double initPitch;

  /// The initial bearing of the map. Defaults to 0 (north on top).
  /// 360 is exactly one loop.
  final double initBearing;

  /// The initial center on the map.
  final Geographic? initCenter;

  /// The minimum zoom level. Allowed values are 0-24. Defaults to 0.
  final double minZoom;

  /// The maximum zoom level. Allowed values are 0-24. Defaults to 22.
  final double maxZoom;

  /// The minimum camera pitch / tilt. Allowed values on web are 0-85. Allowed
  /// values on other platforms are 0-60, bigger values will get ignored.
  ///
  /// Defaults to 0.
  final double minPitch;

  /// The maximum camera pitch / tilt. Allowed values on web are 0-85. Allowed
  /// values on other platforms are 0-60, bigger values will get ignored.
  final double maxPitch;

  /// The maximum bounding box of the map camera. No constraints are in place
  /// if set to `null`.
  final LngLatBounds? maxBounds;

  /// Enable and disable some or all map gestures.
  final MapGestures gestures;

  /// The platform view type used on android.
  ///
  /// https://docs.flutter.dev/platform-integration/android/platform-views
  final AndroidPlatformViewMode androidMode;

  /// Toggle the texture mode on Android.
  ///
  /// textureMode comes at a significant performance penalty.
  /// https://maplibre.org/maplibre-native/android/api/-map-libre%20-native%20-android/org.maplibre.android.maps/-map-libre-map-options/texture-mode.html
  final bool androidTextureMode;

  /// Toggle the translucent texture surface mode on Android.
  /// This enables textureMode and comes at a significant performance penalty.
  ///
  /// **NOTE**! This may cause **buffer management issues** on some Android devices, so [AndroidPlatformViewMode.hc] use is recommended.
  final bool androidTranslucentTextureSurface;

  /// The MapView foreground color that is used when the map surface is being created.
  final Color androidForegroundLoadColor;

  /// Enable webview debug mode. This enables additional logging if the map is
  /// rendered using a webview. Also, it allows to show the webview devtools
  /// by pressing F12 while the map has focus.
  /// Defaults to false.
  final bool webviewDebugMode;
}
