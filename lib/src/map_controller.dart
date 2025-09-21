import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/inherited_model.dart';

/// The [MapController] can be used to control, update and manipulate a
/// rendered [MapLibreMap].
///
/// {@category Basic}
abstract interface class MapController {
  /// Find the [MapController] of the closest [MapLibreMap] in the widget tree.
  /// Returns null if called outside of the [MapLibreMap.children].
  static MapController? maybeOf(BuildContext context) =>
      MapLibreInheritedModel.maybeMapControllerOf(context);

  /// Find the [MapController] of the closest [MapLibreMap] in the widget tree.
  /// Throws an [StateError] if called outside of the [MapLibreMap.children].
  static MapController of(BuildContext context) =>
      maybeOf(context) ??
      (throw StateError('Unable to find an instance of MapController'));

  /// Get the [MapOptions] from [MapLibreMap.options].
  MapOptions get options;

  /// Get the [StyleController] for the map. It returns null null if
  /// accessed before [MapLibreMap.onStyleLoaded] has been called.
  StyleController? get style;

  /// Convert a latitude/longitude coordinate to a screen location.
  // TODO: can be made sync when flutter platform and ui thread are merged
  Future<Offset> toScreenLocation(Position lngLat);

  /// Get the latitude/longitude coordinate for a screen location.
  // TODO: can be made sync when flutter platform and ui thread are merged
  Future<Position> toLngLat(Offset screenLocation);

  /// Convert a latitude/longitude coordinate to a screen location.
  // TODO: can be made sync when flutter platform and ui thread are merged
  Future<List<Offset>> toScreenLocations(List<Position> lngLats);

  /// Get the latitude/longitude coordinate for a screen location.
  // TODO: can be made sync when flutter platform and ui thread are merged
  Future<List<Position>> toLngLats(List<Offset> screenLocations);

  /// Convert a latitude/longitude coordinate to a screen location.
  Offset toScreenLocationSync(Position lngLat);

  /// Get the latitude/longitude coordinate for a screen location.
  Position toLngLatSync(Offset screenLocation);

  /// Convert a latitude/longitude coordinate to a screen location.
  List<Offset> toScreenLocationsSync(List<Position> lngLats);

  /// Get the latitude/longitude coordinate for a screen location.
  List<Position> toLngLatsSync(List<Offset> screenLocations);

  /// Instantly move the map camera to a new location.
  Future<void> moveCamera({
    Position? center,
    double? zoom,
    double? bearing,
    double? pitch,
  });

  /// Animate the map camera to a new location.
  Future<void> animateCamera({
    Position? center,
    double? zoom,
    double? bearing,
    double? pitch,
    Duration nativeDuration = const Duration(seconds: 2),
    double webSpeed = 1.2,
    Duration? webMaxDuration,
  });

  /// Animate the map camera to a new location.
  Future<void> fitBounds({
    required LngLatBounds bounds,
    double? bearing,
    double? pitch,
    Duration nativeDuration = const Duration(seconds: 2),
    double webSpeed = 1.2,
    Duration? webMaxDuration,
    Offset offset = Offset.zero,
    double webMaxZoom = double.maxFinite,
    bool webLinear = false,
    EdgeInsets padding = EdgeInsets.zero,
  });

  /// Get the current camera position on the map.
  MapCamera getCamera();

  /// Get the current camera position on the map.
  MapCamera? get camera;

  /// Returns the distance spanned by one pixel at the specified latitude and
  /// current zoom level.
  ///
  /// The distance between pixels decreases as the latitude approaches the
  /// poles. This relationship parallels the relationship between longitudinal
  /// coordinates at different latitudes.
  // TODO: can be made sync when flutter platform and ui thread are merged
  Future<double> getMetersPerPixelAtLatitude(double latitude);

  /// The smallest bounding box that includes the visible region.
  // TODO: can be made sync when flutter platform and ui thread are merged
  Future<LngLatBounds> getVisibleRegion();

  /// Returns the distance spanned by one pixel at the specified latitude and
  /// current zoom level.
  ///
  /// The distance between pixels decreases as the latitude approaches the
  /// poles. This relationship parallels the relationship between longitudinal
  /// coordinates at different latitudes.
  double getMetersPerPixelAtLatitudeSync(double latitude);

  /// The smallest bounding box that includes the visible region.
  LngLatBounds getVisibleRegionSync();

  /// Queries the map for rendered features.
  Future<List<QueriedLayer>> queryLayers(Offset screenLocation);

  /// Show the user location on the map
  Future<void> enableLocation({
    Duration fastestInterval = const Duration(milliseconds: 750),
    Duration maxWaitTime = const Duration(seconds: 1),
    bool pulseFade = true,
    bool accuracyAnimation = true,
    bool compassAnimation = true,
    bool pulse = true,
    BearingRenderMode bearingRenderMode = BearingRenderMode.gps,
  });

  /// Track the user location on the map
  ///
  /// Set [trackLocation] to false if only the bearing should get tracked
  /// (defaults to true).
  ///
  /// Use [trackBearing] to set if the bearing should get tracked according to
  /// the GPS location, compass direction or ignored.
  Future<void> trackLocation({
    bool trackLocation = true,
    BearingTrackMode trackBearing = BearingTrackMode.gps,
  });

  /// Asynchronously change the style of the map. [style] can be a JSON string
  /// representing a valid MapLibre style document, or a URL pointing to such a
  /// document.
  ///
  /// To know when the style has been loaded, you can listen to the
  /// [MapLibreMap.onStyleLoaded] callback or wait for a [MapEventStyleLoaded]
  /// event.
  ///
  /// All layers added with [StyleController.addLayer] will be removed.
  /// You can apply them again after the style has been loaded.
  // TODO(mhernz): what kind of URLs?
  void setStyle(String style);
}

/// The mode how the bearing should get tracked on the map.
/// Used in [MapController.trackLocation].
///
/// {@category Basic}
enum BearingTrackMode {
  /// No bearing tracking.
  none,

  /// Use the bearing provided by the compass sensor.
  compass,

  /// Use the bearing provided by the GPS location (normalized).
  gps,
}

/// The mode how render the location on the map.
/// Used in [MapController.enableLocation].
///
/// {@category Basic}
enum BearingRenderMode {
  /// Do not display the current bearing.
  none,

  /// Use the device compass to render the bearing.
  compass,

  /// Use the GPS location data to render the bearing.
  gps,
}
