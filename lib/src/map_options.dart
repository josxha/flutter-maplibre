import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/inherited_model.dart';

/// The [MapOptions] class is used to set default values for the [MapLibreMap]
/// widget.
@immutable
class MapOptions {
  /// Default constructor for the [MapOptions].
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

  /// The style URL that should get used. If not set, the default MapLibre style
  /// is used (https://demotiles.maplibre.org/style.json).
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
  final Position? initCenter;

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
}
