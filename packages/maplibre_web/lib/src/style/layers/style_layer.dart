import 'dart:js_interop';

import 'package:flutter/painting.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_web/src/extensions.dart';
import 'package:maplibre_web/src/interop/interop.dart' as js;

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

/// Web implementation of [StyleLayer].
abstract class StyleLayerWeb implements StyleLayer {
  /// Construct an [StyleLayerWeb] from a JNI layer.
  StyleLayerWeb.fromNativeLayer({required this.jsLayer, this.jsMap});

  /// The JavaScript layer instance.
  final js.LayerSpecification jsLayer;

  js.JsMap? jsMap;

  js.JsMap get requireMap =>
      jsMap ?? (throw StateError('Map is not attached to the layer'));

  @override
  String get id => jsLayer.id;

  @override
  double get maxZoom => jsLayer.maxzoom ?? StyleLayer.defaultMaxZoom;

  @override
  set maxZoom(double value) => jsLayer.maxzoom = value;

  @override
  double get minZoom => jsLayer.minzoom ?? StyleLayer.defaultMinZoom;

  @override
  set minZoom(double value) => jsLayer.minzoom = value;

  @override
  bool get visible =>
      requireMap.getPaintProperty(id, 'visibility').toString() == 'visible';

  @override
  set visible(bool value) => requireMap.setPaintProperty(
    id,
    'visibility',
    (value ? 'visible' : 'none').toJS,
  );
}
