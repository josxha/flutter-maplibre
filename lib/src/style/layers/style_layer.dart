import 'dart:ui';

import 'package:maplibre/maplibre.dart';

part 'background_style_layer.dart';
part 'circle_style_layer.dart';
part 'fill_extrusion_style_layer.dart';
part 'fill_style_layer.dart';
part 'heatmap_style_layer.dart';
part 'hillshade_style_layer.dart';
part 'line_style_layer.dart';
part 'raster_style_layer.dart';
part 'symbol_style_layer.dart';

/// The base Layer class that can't be used directly.
///
/// {@category Style}
/// {@subCategory Style Layers}
interface class StyleLayer {
  /// Create a new [StyleLayer] instance.
  const StyleLayer({
    required this.id,
    this.layout = const {},
    this.paint = const {},
    this.metadata,
    this.minZoom,
    this.maxZoom,
    this.filter,
  });

  /// Unique layer name.
  final String id;

  /// Arbitrary properties useful to track with the layer, but do not influence
  /// rendering. Properties should be prefixed to avoid collisions,
  /// like 'maplibre:'.
  final Map<String, Object?>? metadata;

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
  final Map<String, Object> layout;

  /// Default paint properties for this layer.
  final Map<String, Object> paint;
}

/// A [StyleLayer] that pulls its data from a [Source]. Basically every layer
/// except [BackgroundStyleLayer].
///
/// {@category Style}
/// {@subCategory Style Layers}
interface class StyleLayerWithSource extends StyleLayer {
  /// const constructor for [StyleLayerWithSource].
  const StyleLayerWithSource({
    required super.id,
    required this.sourceId,
    super.paint = const {},
    super.layout = const {},
    super.metadata,
    super.minZoom,
    super.maxZoom,
    super.filter,
  });

  /// Name of a source description to be used for this layer. Required for all
  /// layer types except background.
  final String sourceId;
}
