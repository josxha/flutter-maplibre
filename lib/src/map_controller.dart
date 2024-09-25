import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:maplibre/maplibre.dart';

/// The [MapController] can be used to control, update and manipulate a
/// rendered [MapLibreMap].
abstract interface class MapController {
  /// Convert a latitude/longitude coordinate to a screen location.
  Future<Offset> toScreenLocation(Position lngLat);

  /// Get the latitude/longitude coordinate for a screen location.
  Future<Position> toLngLat(Offset screenLocation);

  /// Instantly move the map camera to a new location.
  Future<void> jumpTo({
    Position? center,
    double? zoom,
    double? bearing,
    double? pitch,
    @Deprecated('Renamed to pitch') double? tilt,
  });

  /// Animate the map camera to a new location.
  Future<void> flyTo({
    Position? center,
    double? zoom,
    double? bearing,
    double? pitch,
    @Deprecated('Renamed to pitch') double? tilt,
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

  /// Add a [Marker] to the map.
  ///
  /// Only supported on web.
  Future<Marker> addMarker(Marker marker);

  /// Add a new source to the map.
  Future<void> addSource(Source source);

  /// Add a new layer to the map. The source must be added before adding it to
  /// the map.
  ///
  /// `belowLayerId` The ID of an existing layer to insert the new layer before,
  /// resulting in the new layer appearing visually beneath the existing layer.
  /// If this argument is not specified, the layer will be appended to the end
  /// of the layers array and appear visually above all other layers.
  Future<void> addLayer(Layer layer, {String? belowLayerId});

  /// Update the data of a GeoJSON source.
  Future<void> updateGeoJsonSource({required String id, required String data});

  /// Removes the layer with the given ID from the map's style.
  Future<void> removeLayer(String id);

  /// Removes the source with the given ID from the map's style.
  Future<void> removeSource(String id);

  /// Get the current camera position on the map.
  Future<MapCamera> getCamera();

  /// Returns the distance spanned by one pixel at the specified latitude and
  /// current zoom level.
  ///
  /// The distance between pixels decreases as the latitude approaches the
  /// poles. This relationship parallels the relationship between longitudinal
  /// coordinates at different latitudes.
  Future<double> getMetersPerPixelAtLatitude(double latitude);

  /// The smallest bounding box that includes the visible region.
  Future<LngLatBounds> getVisibleRegion();

  /// Add an image to the map.
  Future<void> addImage(String id, Uint8List bytes);

  /// Removes an image from the map
  Future<void> removeImage(String id);
}
