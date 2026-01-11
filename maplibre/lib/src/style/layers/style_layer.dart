import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/android/style/layers/background_style_layer.dart';
import 'package:maplibre/src/platform/ios/style/layers/background_style_layer.dart';
import 'package:maplibre/src/platform/web/style/layers/background_style_layer.dart';

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
abstract interface class StyleLayer {
  /// Unique layer name.
  String get id;

  /// The minimum zoom level for the layer. At zoom levels less than the
  /// minzoom, the layer will be hidden.
  ///
  /// Needs to be in the range of [0,24].
  double get minZoom;

  set minZoom(double value);

  /// The maximum zoom level for the layer. At zoom levels equal to or greater
  /// than the maxzoom, the layer will be hidden.
  ///
  /// Needs to be in the range of [0,24].
  double get maxZoom;

  set maxZoom(double value);
}

/// A [StyleLayer] that pulls its data from a [Source]. Basically every layer
/// except [BackgroundStyleLayer].
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract interface class StyleLayerWithSource extends StyleLayer {
  /// Name of a source description to be used for this layer. Required for all
  /// layer types except background.
  String get sourceId;

  set sourceId(String value);

  /// Layer to use from a vector tile source. Required for [VectorSource];
  /// prohibited for all other source types, including GeoJSON sources.
  String? get sourceLayerId;

  set sourceLayerId(String? value);

  /// A expression specifying conditions on source features. Only features that
  /// match the filter are displayed. Zoom expressions in filters are only
  /// evaluated at integer zoom levels. The feature-state expression is not
  /// supported in filter expressions.
  ///
  /// This property is only supported for layers that can render vector features
  /// from a source: [CircleStyleLayer], [FillStyleLayer],
  /// [FillExtrusionStyleLayer], [HeatmapStyleLayer], [LineStyleLayer]
  /// and [SymbolStyleLayer].
  List<Object>? get filter;

  set filter(List<Object>? value);
}
