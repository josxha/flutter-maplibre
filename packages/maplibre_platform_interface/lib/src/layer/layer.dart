import 'package:flutter/foundation.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// This class is the base for all annotation layer classes.
///
/// {@category Layers}
@immutable
abstract class Layer<G extends Feature<Geometry>> {
  /// Creates a [Layer] with the given list of geometry features and optional
  /// zoom levels.
  const Layer({required this.list, this.minZoom = 0, this.maxZoom = 24});

  /// The [List] of geometry features.
  final List<G> list;

  /// The minimum zoom level that the [Layer] is displayed.
  final double minZoom;

  /// The maximum zoom level that the [Layer] is displayed.
  final double maxZoom;

  /// Get a unique source id.
  String getSourceId(int index) => 'maplibre-source-$index';

  /// Get a unique layer id.
  String getLayerId(int index) => 'maplibre-layer-$index';

  /// Build the paint properties.
  Map<String, Object> getPaint();

  /// Build the layout properties.
  Map<String, Object> getLayout();

  /// Create the [Source] that backs this layer. Override this to customize the
  /// source, e.g. to enable clustering on a [GeoJsonSource].
  GeoJsonSource createSource(int index) => GeoJsonSource(
    id: getSourceId(index),
    data: FeatureCollection(list).toText(),
  );

  /// Add the annotation layer to the map.
  StyleLayer createStyleLayer(int index);

  /// Create all [StyleLayer]s that render this layer. Defaults to a single
  /// layer created by [createStyleLayer]. Override this to render multiple
  /// layers from a single source, e.g. clustered markers.
  List<StyleLayer> createStyleLayers(int index) => [createStyleLayer(index)];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Layer &&
          runtimeType == other.runtimeType &&
          list == other.list &&
          minZoom == other.minZoom &&
          maxZoom == other.maxZoom;

  @override
  int get hashCode => Object.hash(minZoom, maxZoom, list);
}
