import 'package:flutter/painting.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

part 'background_style_layer.dart';
part 'circle_style_layer.dart';
part 'color_relief_style_layer.dart';
part 'fill_extrusion_style_layer.dart';
part 'fill_style_layer.dart';
part 'heatmap_style_layer.dart';
part 'hillshade_style_layer.dart';
part 'line_style_layer.dart';
part 'raster_style_layer.dart';
part 'symbol_style_layer.dart';

/// WebView implementation of [StyleLayer].
abstract class StyleLayerWebView implements StyleLayer {
  /// Get the layout properties of the layer.
  Map<String, Object?> get layout;

  /// Get the paint properties of the layer.
  Map<String, Object?> get paint;
}
