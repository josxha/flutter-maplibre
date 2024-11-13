import 'package:flutter/foundation.dart';

/// The base [WebMapControl] class that is the parent of all web-only user
/// interface buttons.
@immutable
@Deprecated('Use the `User Interface` widgets in MapLibreMap `children` field.')
sealed class WebMapControl {
  @Deprecated(
      'Use the `User Interface` widgets in MapLibreMap `children` field.')
  const WebMapControl();
}

/// A `ScaleControl` control displays the ratio of a distance on the map to the
/// corresponding distance on the ground.
@immutable
@Deprecated('Use the `User Interface` widgets in MapLibreMap `children` field.')
class WebScaleControl extends WebMapControl {
  /// Default constructor for the [WebScaleControl].
  @Deprecated(
      'Use the `User Interface` widgets in MapLibreMap `children` field.')
  const WebScaleControl({
    this.maxWidth = 100,
    this.unit = Unit.metric,
  });

  /// The maximum length of the scale control in pixels.
  final num maxWidth;

  /// Unit of the distance (`'imperial'`, `'metric'` or `'nautical'`).
  final Unit unit;
}

/// The unit type for length to use for the [WebScaleControl]
@Deprecated(
    'WebScaleControl is deprecated. Use the `User Interface` widgets in MapLibreMap `children` field.')
enum Unit {
  /// Use the imperial system with units like inch, foot, yard or mile.
  imperial,

  /// Use the metric system with units like mm, cm, m or km.
  metric,

  /// use the nautical system with units like sm.
  nautical
}

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
@Deprecated('Use the `User Interface` widgets in MapLibreMap `children` field.')
class WebGeolocateControl extends WebMapControl {
  /// Default constructor for the [WebGeolocateControl].
  @Deprecated(
      'Use the `User Interface` widgets in MapLibreMap `children` field.')
  const WebGeolocateControl({
    this.positionOptions = const WebPositionOptions(),
    this.fitBoundsOptions,
    this.trackUserLocation = false,
    this.showAccuracyCircle = true,
    this.showUserLocation = true,
  });

  /// A Geolocation API
  /// [PositionOptions](https://developer.mozilla.org/en-US/docs/Web/API/PositionOptions)
  /// object.
  final WebPositionOptions positionOptions;

  /// A options object to use when the map is panned and zoomed to the user's
  /// location. The default is to use a `maxZoom` of 15 to limit how far the
  /// map will zoom in for very accurate locations.
  final WebFitBoundsOptions? fitBoundsOptions;

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

/// Options for the [WebGeolocateControl].
@immutable
@Deprecated('Use the `User Interface` widgets in MapLibreMap `children` field.')
class WebPositionOptions {
  /// Default constructor for the [WebPositionOptions].
  // TODO add fields
  @Deprecated(
      'Use the `User Interface` widgets in MapLibreMap `children` field.')
  const WebPositionOptions({
    this.enableHighAccuracy = false,
    this.timeout = const Duration(seconds: 6),
    this.maximumAge = Duration.zero,
  });

  /// Set to true if the displayed user location should have an high accuracy.
  final bool enableHighAccuracy;

  /// The timeout [Duration] after which the location fetching fails.
  final Duration timeout;

  /// The maximum [Duration] between user location updates.
  final Duration maximumAge;
}

/// Options to specify the map bounds.
@immutable
@Deprecated('Use the `User Interface` widgets in MapLibreMap `children` field.')
class WebFitBoundsOptions {
  /// Default constructor for the [WebFitBoundsOptions].
  // TODO add fields
  @Deprecated(
      'Use the `User Interface` widgets in MapLibreMap `children` field.')
  const WebFitBoundsOptions();
}

/// An `AttributionControl` control presents the map's attribution information.
/// By default, the attribution control is expanded (regardless of map width).
@immutable
@Deprecated('Use the `User Interface` widgets in MapLibreMap `children` field.')
class WebAttributionControl extends WebMapControl {
  /// Default constructor for the [WebAttributionControl].
  @Deprecated(
      'Use the `User Interface` widgets in MapLibreMap `children` field.')
  const WebAttributionControl({
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
@Deprecated('Use the `User Interface` widgets in MapLibreMap `children` field.')
class WebFullscreenControl extends WebMapControl {
  /// Default constructor for the [WebFullscreenControl].
  @Deprecated(
      'Use the `User Interface` widgets in MapLibreMap `children` field.')
  const WebFullscreenControl();
}

/// A `LogoControl` is a control that adds the watermark.
@immutable
@Deprecated('Use the `User Interface` widgets in MapLibreMap `children` field.')
class WebLogoControl extends WebMapControl {
  /// Default constructor for the [WebLogoControl].
  @Deprecated(
      'Use the `User Interface` widgets in MapLibreMap `children` field.')
  const WebLogoControl({this.compact});

  /// If `true`, force a compact logo. If `false`, force the full logo.
  ///
  /// The default is a responsive logo that collapses when the map is less
  /// than 640 pixels wide.
  final bool? compact;
}

/// A `NavigationControl` control contains zoom buttons and a compass.
@immutable
@Deprecated('Use the `User Interface` widgets in MapLibreMap `children` field.')
class WebNavigationControl extends WebMapControl {
  /// Default constructor for the [WebNavigationControl].
  @Deprecated(
      'Use the `User Interface` widgets in MapLibreMap `children` field.')
  const WebNavigationControl({
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
@Deprecated('Use the `User Interface` widgets in MapLibreMap `children` field.')
class WebTerrainControl extends WebMapControl {
  /// Default constructor for the [WebTerrainControl].
  @Deprecated(
      'Use the `User Interface` widgets in MapLibreMap `children` field.')
  const WebTerrainControl({required this.source});

  /// The source from the style
  final String source;
}
