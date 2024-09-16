import 'dart:ui';

part 'background_layer.dart';
part 'circle_layer.dart';
part 'fill_extrusion_layer.dart';
part 'fill_layer.dart';
part 'heatmap_layer.dart';
part 'hillshade_layer.dart';
part 'line_layer.dart';
part 'raster_layer.dart';
part 'symbol_layer.dart';

/// The base Layer class that can't be used directly.
sealed class Layer {
  const Layer({
    required this.id,
    this.metadata,
    this.source,
    this.sourceLayer,
    this.minZoom,
    this.maxZoom,
    this.paint,
    this.filter,
    this.layout,
  });

  /// Unique layer name.
  final String id;

  /// Arbitrary properties useful to track with the layer, but do not influence
  /// rendering. Properties should be prefixed to avoid collisions,
  /// like 'maplibre:'.
  final Map<String, Object?>? metadata;

  /// Name of a source description to be used for this layer. Required for all
  /// layer types except background.
  final String? source;

  /// Layer to use from a vector tile source. Required for vector tile sources;
  /// prohibited for all other source types, including GeoJSON sources.
  final String? sourceLayer;

  /// The minimum zoom level for the layer. At zoom levels less than the
  /// minzoom, the layer will be hidden.
  ///
  /// Needs to be in the range of [0,24].
  final double? minZoom;

  /// The maximum zoom level for the layer. At zoom levels equal to or greater
  /// than the maxzoom, the layer will be hidden.
  ///
  /// Needs to be in the range of [0,24].
  final double? maxZoom;

  /// A expression specifying conditions on source features. Only features that
  /// match the filter are displayed. Zoom expressions in filters are only
  /// evaluated at integer zoom levels. The feature-state expression is not
  /// supported in filter expressions.
  final Object? filter;

  /// Layout properties for the layer.
  final Object? layout;

  /// Default paint properties for this layer.
  final Object? paint;
}
