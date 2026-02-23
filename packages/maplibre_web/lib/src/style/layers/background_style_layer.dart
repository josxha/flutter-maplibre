import 'dart:js_interop';
import 'dart:ui';

import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_web/src/interop/interop.dart' as js;
import 'package:maplibre_web/src/style/layers/style_layer.dart';

/// Helper class so that [BackgroundStyleLayerWeb] can mixing in the
/// [BackgroundStyleLayerMixin].
abstract class _BackgroundStyleLayerWeb
    extends StyleLayerWeb<js.LayerSpecification>
    implements BackgroundStyleLayer {
  _BackgroundStyleLayerWeb.fromNativeLayer(super.jsLayer)
    : super.fromNativeLayer();
}

/// Web implementation of [BackgroundStyleLayer].
class BackgroundStyleLayerWeb extends _BackgroundStyleLayerWeb
    with BackgroundStyleLayerMixin {
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
           maxzoom: maxZoom,
           minzoom: minZoom,
         ),
       ) {
    this.color = color;
    this.opacity = opacity;
    this.visible = visible;
    this.pattern = pattern;
    jsLayer.layout = layout.jsify();
    jsLayer.paint = paint.jsify();
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
