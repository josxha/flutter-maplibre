import 'dart:typed_data';

import 'package:maplibre/maplibre.dart';

/// The [StyleController] can be used to manipulate the style of
/// a [MapLibreMap]. It can be accessed via [MapController.style].
///
/// {@category Basic}
abstract interface class StyleController {
  /// Add a new source to the map.
  Future<void> addSource(Source source);

  /// Add a new layer to the map. The source must be added before adding it to
  /// the map.
  ///
  /// - `belowLayerId` The ID of an existing layer to insert the new layer before,
  /// resulting in the new layer appearing visually beneath the existing layer.
  /// - `aboveLayerId` The ID of an existing layer to insert the new layer after,
  /// resulting in the new layer appearing visually above the existing layer.\
  /// **Note:** `aboveLayerId` is only supported on Android platforms.
  /// On other platforms, this parameter will be ignored.
  ///
  /// If both `belowLayerId` and `aboveLayerId` are specified on Android,
  /// the `belowLayerId` will have priority and the layer will be inserted before
  /// the specified layer.
  ///
  /// If neither argument is specified, the layer will be appended to the end
  /// of the layers array and appear visually above all other layers.
  Future<void> addLayer(
    StyleLayer layer, {
    String? belowLayerId,
    String? aboveLayerId,
  });

  /// Update the data of a GeoJSON source.
  Future<void> updateGeoJsonSource({required String id, required String data});

  /// Removes the layer with the given ID from the map's style.
  Future<void> removeLayer(String id);

  /// Removes the source with the given ID from the map's style.
  Future<void> removeSource(String id);

  /// Get a list of all attributions from the map style.
  Future<List<String>> getAttributions();

  /// Get a list of all attributions from the map style.
  List<String> getAttributionsSync();

  /// Add an image to the map.
  Future<void> addImage(String id, Uint8List bytes);

  /// Add multiple images to the map.
  Future<void> addImages(Map<String, Uint8List> images);

  /// Removes an image from the map
  Future<void> removeImage(String id);

  /// Set the map projection.
  ///
  /// [MapProjection.globe] is currently on supported on web.
  void setProjection(MapProjection projection);

  /// Clean up resources.
  void dispose();
}

/// The map projections.
///
/// https://maplibre.org/maplibre-style-spec/projection/
enum MapProjection {
  /// The default web mercator projection.
  mercator,

  /// Globe projection. Only supported on web.
  globe,
}
