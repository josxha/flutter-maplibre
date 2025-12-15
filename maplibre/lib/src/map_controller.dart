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

  /// Convert a latitude/longitude coordinate to a screen location in logical
  /// pixels.
  Offset toScreenLocation(Geographic lngLat);

  /// Get the latitude/longitude coordinate for a screen location in logical
  /// pixels.
  Geographic toLngLat(Offset screenLocation);

  /// Convert a latitude/longitude coordinate to a screen location in logical
  /// pixels.
  List<Offset> toScreenLocations(List<Geographic> lngLats);

  /// Get the latitude/longitude coordinate for a screen location in logical
  /// pixels.
  List<Geographic> toLngLats(List<Offset> screenLocations);

  /// Instantly move the map camera to a new location.
  void moveCamera({
    Geographic? center,
    double? zoom,
    double? bearing,
    double? pitch,
  });

  /// Animate the map camera to a new location.
  Future<void> animateCamera({
    Geographic? center,
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

  /// Returns the distance spanned by one logical pixel at the specified
  /// latitude and current zoom level.
  ///
  /// The distance between pixels decreases as the latitude approaches the
  /// poles. This relationship parallels the relationship between longitudinal
  /// coordinates at different latitudes.
  double getMetersPerPixelAtLatitude(double latitude);

  /// The smallest bounding box that includes the visible region.
  LngLatBounds getVisibleRegion();

  /// Queries the map for layers containing rendered features which intersect
  /// with a given [screenLocation] measured in logical pixels.
  List<QueriedLayer> queryLayers(Offset screenLocation);

  /// Returns an array of rendered map features that intersect with a given
  /// screen location measured in logical pixels.
  ///
  /// If [layerIds] is non-null, only features from those layers will be
  /// returned.
  ///
  /// NOTE: features may appear multiple times in query results, for example if
  /// they cross tile boundaries.
  ///
  /// Returns an empty list if either the map or underlying render surface has
  /// been destroyed.
  // TODO(mhernz): add filter parameter
  //
  // [filter] is an array of filter expressions. If provided, only features
  // that match all of the filters will be returned.
  List<RenderedFeature> featuresAtPoint(Offset point, {List<String>? layerIds});

  /// Returns an array of rendered map features that intersect with a given
  /// on-screen rectangle measured in logical pixels.
  ///
  /// If [layerIds] is non-null, only features from those layers will be
  /// returned.
  ///
  /// NOTE: features may appear multiple times in query results, for example if
  /// they cross tile boundaries.
  ///
  /// Returns an empty list if either the map or underlying render surface has
  /// been destroyed.
  // TODO(mhernz): add filter parameter
  //
  // [filter] is an array of filter expressions. If provided, only features
  // that match all of the filters will be returned.
  List<RenderedFeature> featuresInRect(Rect rect, {List<String>? layerIds});

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
