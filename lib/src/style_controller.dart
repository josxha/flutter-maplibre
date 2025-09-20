import 'package:flutter/foundation.dart';
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
  /// `belowLayerId` The ID of an existing layer to insert the new layer before,
  /// resulting in the new layer appearing visually beneath the existing layer.
  /// If this argument is not specified, the layer will be appended to the end
  /// of the layers array and appear visually above all other layers.
  Future<void> addLayer(StyleLayer layer, {String? belowLayerId});

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

  @visibleForTesting
  /// For testing purposes only. Will be replaced with a public API.
  List<String> getLayerIds();

  /// Add an image to the map.
  Future<void> addImage(String id, Uint8List bytes);

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
