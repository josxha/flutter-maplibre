import 'package:flutter/foundation.dart';
import 'package:maplibre/maplibre.dart';

/// The [MapOptions] class is used to set default values for the [MapLibreMap]
/// widget.
@immutable
class MapOptions {
  /// Default constructor for the [MapOptions].
  const MapOptions({
    this.style = 'https://demotiles.maplibre.org/style.json',
    this.zoom = 0,
    this.center,
    @Deprecated('Renamed to pitch') double? tilt,
    double pitch = 0,
    this.bearing = 0,
    this.webControls = const [],
    this.minZoom = 0,
    this.maxZoom = 22,
    this.minPitch = 0,
    this.maxPitch = 60,
    this.maxBounds,
    this.gestures = const MapGestures.all(),
  }) : pitch = tilt ?? pitch;

  /// The style URL that should get used. If not set, the default MapLibre style
  /// is used (https://demotiles.maplibre.org/style.json).
  final String style;

  /// The initial zoom level.
  final double zoom;

  /// The initial pitch level. Minimum is 0 and maximum is 85 on web and 60 on
  /// other platforms.
  final double pitch;

  /// Initial pitch level
  @Deprecated('Renamed to pitch')
  double get tilt => pitch;

  /// The initial bearing of the map. Defaults to 0 (north on top).
  /// 360 is exactly one loop.
  final double bearing;

  /// The initial center on the map.
  final Position? center;

  /// A list of user interface control buttons that should get used.
  ///
  /// Only supported on web.
  final List<WebMapControl> webControls;

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
}
