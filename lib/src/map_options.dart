import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geotypes/geotypes.dart';

@immutable
class MapOptions {
  const MapOptions({
    this.style = 'https://demotiles.maplibre.org/style.json',
    this.zoom = 0,
    this.center,
    this.controls = const [],
    this.onClick,
    this.onDoubleClick,
    this.onSecondaryClick,
  });

  final String style;
  final double zoom;
  final Position? center;
  final List<MapControl> controls;
  final OnClickCallback? onClick;
  final OnClickCallback? onDoubleClick;
  final OnClickCallback? onSecondaryClick;

  Map<String, Object?> toJson() => <String, Object?>{
        'style': style,
        'zoom': zoom,
        'center':
            center == null ? null : {'lng': center!.lng, 'lat': center!.lat},
      };
}

@immutable
sealed class MapControl {
  const MapControl();
}

/// A `ScaleControl` control displays the ratio of a distance on the map to the
/// corresponding distance on the ground.
@immutable
class ScaleControl extends MapControl {
  const ScaleControl({
    this.maxWidth = 100,
    this.unit = Unit.metric,
  });

  /// The maximum length of the scale control in pixels.
  final num maxWidth;

  /// Unit of the distance (`'imperial'`, `'metric'` or `'nautical'`).
  final Unit unit;
}

/// The unit type for length to use for the [ScaleControl]
enum Unit { imperial, metric, nautical }

/// A `GeolocateControl` control provides a button that uses the browser's
/// geolocation API to locate the user on the map.
///
/// Not all browsers support geolocation, and some users may disable the
/// feature. Geolocation support for modern browsers including Chrome requires
/// sites to be served over HTTPS. If geolocation support is not available,
/// the `GeolocateControl` will show as disabled.
///
/// The zoom level applied will depend on the accuracy of the geolocation
/// provided by the device.
///
/// The `GeolocateControl` has two modes. If `trackUserLocation` is `false`
/// (default) the control acts as a button, which when pressed will set the
/// map's camera to target the user location. If the user moves, the map won't
/// update. This is most suited for the desktop. If `trackUserLocation` is
/// `true` the control acts as a toggle button that when active the user's
/// location is actively monitored for changes. In this mode the
/// `GeolocateControl` has three interaction states:
/// * active - the map's camera automatically updates as the user's location
///   changes, keeping the location dot in the center. Initial state and upon
///   clicking the `GeolocateControl` button.
/// * passive - the user's location dot automatically updates, but the map's
///   camera does not. Occurs upon the user initiating a map movement.
/// * disabled - occurs if Geolocation is not available, disabled or denied.
///
/// These interaction states can't be controlled programmatically, rather they
/// are set based on user interactions.
@immutable
class GeolocateControl extends MapControl {
  const GeolocateControl({
    this.positionOptions = const PositionOptions(),
    this.fitBoundsOptions,
    this.trackUserLocation = false,
    this.showAccuracyCircle = true,
    this.showUserLocation = true,
  });

  /// A Geolocation API
  /// [PositionOptions](https://developer.mozilla.org/en-US/docs/Web/API/PositionOptions)
  /// object.
  final PositionOptions positionOptions;

  /// A options object to use when the map is panned and zoomed to the user's
  /// location. The default is to use a `maxZoom` of 15 to limit how far the
  /// map will zoom in for very accurate locations.
  final FitBoundsOptions? fitBoundsOptions;

  /// If `true` the `GeolocateControl` becomes a toggle button and when active
  /// the map will receive updates to the user's location as it changes.
  final bool trackUserLocation;

  /// By default, if `showUserLocation` is `true`, a transparent circle will be
  /// drawn around the user location indicating the accuracy (95% confidence
  /// level) of the user's location. Set to `false` to disable. Always
  /// disabled when `showUserLocation` is `false`.
  final bool showAccuracyCircle;

  /// By default a dot will be shown on the map at the user's location.
  /// Set to `false` to disable.
  final bool showUserLocation;
}

@immutable
class PositionOptions {
  // TODO add fields
  const PositionOptions({
    this.enableHighAccuracy = false,
    this.timeout = const Duration(seconds: 6),
    this.maximumAge = Duration.zero,
  });

  final bool enableHighAccuracy;
  final Duration timeout;
  final Duration maximumAge;
}

@immutable
class FitBoundsOptions {
  // TODO add fields
  const FitBoundsOptions();
}

/// An `AttributionControl` control presents the map's attribution information.
/// By default, the attribution control is expanded (regardless of map width).
@immutable
class AttributionControl extends MapControl {
  const AttributionControl({
    this.compact = true,
    this.customAttribution =
        '<a href="https://maplibre.org/" target="_blank">MapLibre</a>',
  });

  /// If `true`, the attribution control will always collapse when moving the
  /// map. If `false`,
  /// * force the expanded attribution control. The default is a responsive
  ///   attribution that collapses when the user moves the map on maps less
  ///   than 640 pixels wide.
  /// * **Attribution should not be collapsed if it can comfortably fit on
  ///   the map. `compact` should only be used to modify default attribution
  ///   when map size makes it impossible to fit default attribution and when
  ///   the automatic compact resizing for default settings are not
  ///   sufficient.**
  final bool compact;

  /// Attributions to show in addition to any other attributions.
  // TODO support string and Array<string>
  final String customAttribution;
}

/// A `FullscreenControl` control contains a button for toggling the map in and
/// out of fullscreen mode.
///  * When [requestFullscreen](https://developer.mozilla.org/en-US/docs/Web/API/Element/requestFullscreen)
///    is not supported, fullscreen is handled via CSS properties.
///  * The map's `cooperativeGestures` option is temporarily disabled while
///    the map.
///  * is in fullscreen mode, and is restored when the map exist
///    fullscreen mode.
@immutable
class FullscreenControl extends MapControl {
  const FullscreenControl();
}

/// A `LogoControl` is a control that adds the watermark.
@immutable
class LogoControl extends MapControl {
  const LogoControl({this.compact});

  /// If `true`, force a compact logo. If `false`, force the full logo.
  ///
  /// The default is a responsive logo that collapses when the map is less
  /// than 640 pixels wide.
  final bool? compact;
}

/// A `NavigationControl` control contains zoom buttons and a compass.
@immutable
class NavigationControl extends MapControl {
  const NavigationControl({
    this.showCompass = true,
    this.showZoom = true,
    this.visualizePitch = false,
  });

  /// If `true` the compass button is included.
  final bool showCompass;

  /// If `true` the zoom-in and zoom-out buttons are included.
  final bool showZoom;

  /// If `true` the pitch is visualized by rotating X-axis of compass.
  final bool visualizePitch;
}

/// A `TerrainControl` control contains a button for turning the terrain on
/// and off.
@immutable
class TerrainControl extends MapControl {
  const TerrainControl({required this.source});

  /// The source from the style
  final String source;
}

typedef OnClickCallback = void Function(Position point);
