import 'dart:convert';
import 'dart:ui';

import 'package:maplibre_ios/src/maplibre_ffi.g.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:objective_c/objective_c.dart';

part 'background_style_layer.dart';
part 'circle_style_layer.dart';
// part 'fill_extrusion_style_layer.dart';
// part 'fill_style_layer.dart';
// part 'heatmap_style_layer.dart';
// part 'line_style_layer.dart';
// part 'raster_style_layer.dart';
// part 'symbol_style_layer.dart';

/// iOS implementation of [StyleLayer].
abstract class StyleLayerIos<FfiLayer extends MLNStyleLayer>
    implements StyleLayer {
  /// Construct an [StyleLayerIos] from a ObjC layer.
  StyleLayerIos.fromNativeLayer(this.ffiLayer);

  /// The ObjC layer instance.
  final FfiLayer ffiLayer;

  @override
  String get id => ffiLayer.identifier.toString();

  @override
  double get maxZoom => ffiLayer.maximumZoomLevel;

  @override
  set maxZoom(double value) => ffiLayer.maximumZoomLevel = value;

  @override
  double get minZoom => ffiLayer.minimumZoomLevel;

  @override
  set minZoom(double value) => ffiLayer.minimumZoomLevel = value;

  @override
  bool get visible => ffiLayer.isVisible;

  @override
  set visible(bool value) => ffiLayer.isVisible = value;
}
