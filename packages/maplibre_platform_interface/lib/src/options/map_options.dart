import 'package:flutter/widgets.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_platform_interface/src/widget/inherited_model.dart';

part 'map_gestures.dart';

/// The [MapOptions] class is used to set default values for the [MapLibreMap]
/// widget.
///
/// {@category Basic}
@immutable
class MapOptions {
  /// Creates a new [MapOptions] instance. See fields for more information.
  const MapOptions({
    this.style = MapStyle.demo,
    this.initCamera,
    this.minZoom = 0,
    this.maxZoom = 22,
    this.minPitch = 0,
    this.maxPitch = 60,
    this.maxBounds,
    this.gestures = const MapGestures(),
    this.fastPforEnabled = false,
  });

  /// Find the [MapOptions] of the closest [MapLibreMap] in the widget tree.
  /// Returns null if called outside of the [MapLibreMap.children].
  static MapOptions? maybeOf(BuildContext context) =>
      MapLibreInheritedModel.maybeMapControllerOf(context)?.options;

  /// Find the [MapOptions] of the closest [MapLibreMap] in the widget tree.
  /// Throws an [StateError] if called outside of the [MapLibreMap.children].
  static MapOptions of(BuildContext context) =>
      maybeOf(context) ??
      (throw StateError('Unable to find an instance of MapOptions'));

  /// The style of the map. Defaults to the MapLibre demo style
  /// ([MapStyle.demo]).
  ///
  /// The map loads a new style when this changes, which removes the layers
  /// added with [StyleLayers.add]. [MapLibreMap.onStyleLoaded] reports each
  /// loaded style.
  final MapStyle style;

  /// The camera that the map starts with, at a position
  /// ([CameraUpdate.position]) or fitted to a target, such as bounds
  /// ([CameraUpdate.bounds]).
  ///
  /// If null, the map starts at the camera of its style (the style's
  /// `center`, `zoom`, `bearing` and `pitch`). Changes after the map was
  /// created have no effect; move the camera with [MapController] instead.
  final CameraUpdate? initCamera;

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
  final GeoBox? maxBounds;

  /// Enable and disable some or all map gestures.
  final MapGestures gestures;

  /// Whether the map decodes MapLibre Tile (MLT) vector tiles that use
  /// FastPFOR integer encodings. Defaults to false, as in MapLibre Native.
  ///
  /// Without it, MapLibre Native drops each such tile with the warning
  /// `MLT parse failed: FastPFOR decoding is not enabled`. Servers such as
  /// Martin use FastPFOR when they encode MLT, so enable it for their tiles.
  ///
  /// Read once, when the map is created: changing it later has no effect.
  ///
  /// Supported platforms: native only. MapLibre GL JS always decodes
  /// FastPFOR, so the web ignores it.
  final bool fastPforEnabled;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapOptions &&
          style == other.style &&
          initCamera == other.initCamera &&
          minZoom == other.minZoom &&
          maxZoom == other.maxZoom &&
          minPitch == other.minPitch &&
          maxPitch == other.maxPitch &&
          maxBounds == other.maxBounds &&
          gestures == other.gestures &&
          fastPforEnabled == other.fastPforEnabled;

  @override
  int get hashCode => Object.hash(
    style,
    initCamera,
    minZoom,
    maxZoom,
    minPitch,
    maxPitch,
    maxBounds,
    gestures,
    fastPforEnabled,
  );
}
