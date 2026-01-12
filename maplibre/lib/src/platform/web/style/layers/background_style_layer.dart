import 'dart:js_interop';
import 'dart:ui';

import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/web/interop/interop.dart' as js;
import 'package:maplibre/src/platform/web/style/layers/style_layer.dart';

/// A layer that contains circles for web platform.
class BackgroundStyleLayerWeb extends StyleLayerWeb<js.LayerSpecification>
    implements BackgroundStyleLayer {
  /// Default constructor for a [BackgroundStyleLayerWeb] instance.
  BackgroundStyleLayerWeb({
    required String id,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<Color> color,
    required PropertyValue<String>? pattern,
    required PropertyValue<double> opacity,
    required bool visible,
  }) : super.fromNativeLayer(
         js.LayerSpecification(
           id: id,
           type: 'background',
           layout: <String, Object?>{}.jsify()!,
           paint: <String, Object?>{}.jsify()!,
           maxzoom: maxZoom,
           minzoom: minZoom,
         ),
       ) {
    this.color = color;
    this.opacity = opacity;
    this.visible = visible;
    this.pattern = pattern;
  }

  @override
  PropertyValue<Color> get color => throw UnimplementedError();

  @override
  set color(PropertyValue<Color> value) {
    // TODO handle
  }

  @override
  PropertyValue<double> get opacity => throw UnimplementedError();

  @override
  set opacity(PropertyValue<double> value) {
    // TODO handle
  }

  @override
  PropertyValue<String>? get pattern => throw UnimplementedError();

  @override
  set pattern(PropertyValue<String>? value) {
    // TODO handle
  }
}
