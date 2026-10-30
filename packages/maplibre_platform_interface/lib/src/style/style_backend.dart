import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// What [StyleLayers] and [StyleSources] need from a platform. They keep the
/// state and check the arguments; these calls only reach the map.
///
/// Calls must reach the map in the order they were made, and the methods that
/// return a future must make their map call before their first `await`.
///
/// {@category Style}
abstract interface class StyleBackend {
  /// Adds the layer of the style JSON [json], below [belowLayerId] or on top.
  Future<void> addLayer(Map<String, Object?> json, {String? belowLayerId});

  /// Removes the layer [id].
  Future<void> removeLayer(String id);

  /// Moves the layer [id] below [belowLayerId] or to the top.
  void moveLayer(String id, {String? belowLayerId});

  /// Sets a paint property of the layer [layerId]. A null [value] resets it.
  void setPaintProperty(String layerId, String name, Object? value);

  /// Sets a layout property of the layer [layerId]. A null [value] resets it.
  void setLayoutProperty(String layerId, String name, Object? value);

  /// Sets the filter of the layer [layerId]. A null [filter] removes it.
  void setFilter(String layerId, Object? filter);

  /// Sets the zoom range of the layer [layerId].
  void setZoomRange(String layerId, double minZoom, double maxZoom);

  /// Adds [source].
  Future<void> addSource(Source source);

  /// Removes the source [id].
  Future<void> removeSource(String id);

  /// Sets the GeoJSON string [data] of the GeoJSON source [id].
  Future<void> setGeoJsonData(String id, String data);

  /// Makes the GeoJSON source [id] load its data from [url].
  Future<void> setGeoJsonUrl(String id, String url);

  /// Sets the [coordinates] of the image source [id].
  Future<void> setImageCoordinates(String id, LngLatQuad coordinates);

  /// Replaces the tile URLs of the raster, raster DEM or vector source [id].
  /// [specification] is its source JSON with the new [tiles].
  Future<void> setTiles(
    String id,
    List<String> tiles,
    Map<String, Object?> specification,
  );

  /// Replaces the TileJSON URL of the raster, raster DEM or vector source [id].
  /// [specification] is its source JSON with the new [url].
  Future<void> setTileJsonUrl(
    String id,
    String url,
    Map<String, Object?> specification,
  );
}
