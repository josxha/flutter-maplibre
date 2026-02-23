import 'dart:js_interop';
import 'dart:ui';

import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_web/src/interop/interop.dart' as js;
import 'package:maplibre_web/src/style/layers/style_layer.dart';

/// Helper class so that [CircleStyleLayerWeb] can mixing in the
/// [CircleStyleLayerMixin].
abstract class _CircleStyleLayerWeb
    extends StyleLayerWeb<js.LayerSpecification>
    implements CircleStyleLayer {
  _CircleStyleLayerWeb.fromNativeLayer(super.jsLayer)
    : super.fromNativeLayer();
}

/// Web implementation of [CircleStyleLayer].
class CircleStyleLayerWeb extends _CircleStyleLayerWeb
    with CircleStyleLayerMixin {
  /// Default constructor for a [CircleStyleLayerWeb] instance.
  CircleStyleLayerWeb({
    required String id,
    required String sourceId,
    required String? sourceLayerId,
    required Expression? filter,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<Offset> translate,
    required PropertyValue<ReferenceSpace> translateAnchor,
    required PropertyValue<double>? sortKey,
    required PropertyValue<double> radius,
    required PropertyValue<Color> color,
    required PropertyValue<double> blur,
    required PropertyValue<double> opacity,
    required PropertyValue<ReferenceSpace> pitchScale,
    required PropertyValue<ReferenceSpace> pitchAlignment,
    required PropertyValue<double> strokeWidth,
    required PropertyValue<Color> strokeColor,
    required PropertyValue<double> strokeOpacity,
  }) : super.fromNativeLayer(
         js.LayerSpecification(
           id: id,
           type: 'circle',
           maxzoom: maxZoom,
           minzoom: minZoom,
         ),
       ) {
    jsLayer.layout = layout.jsify();
    jsLayer.paint = paint.jsify();
  }

  @override
  PropertyValue<double> get blur => throw UnsupportedError('blur');

  @override
  set blur(PropertyValue<double> value) => throw UnsupportedError('blur');

  @override
  PropertyValue<Color> get color => throw UnsupportedError('color');

  @override
  set color(PropertyValue<Color> value) => throw UnsupportedError('color');

  @override
  Expression? get filter => throw UnsupportedError('filter');

  @override
  set filter(Expression? value) => throw UnsupportedError('filter');

  @override
  PropertyValue<double> get opacity => throw UnsupportedError('opacity');

  @override
  set opacity(PropertyValue<double> value) => throw UnsupportedError('opacity');

  @override
  PropertyValue<ReferenceSpace> get pitchAlignment => throw UnsupportedError('pitchAlignment');

  @override
  set pitchAlignment(PropertyValue<ReferenceSpace> value) => throw UnsupportedError('pitchAlignment');

  @override
  PropertyValue<ReferenceSpace> get pitchScale => throw UnsupportedError('pitchScale');

  @override
  set pitchScale(PropertyValue<ReferenceSpace> value) => throw UnsupportedError('pitchScale');

  @override
  PropertyValue<double> get radius => throw UnsupportedError('radius');

  @override
  set radius(PropertyValue<double> value) => throw UnsupportedError('radius');

  @override
  PropertyValue<double>? get sortKey => throw UnsupportedError('sortKey');

  @override
  set sortKey(PropertyValue<double>? value) => throw UnsupportedError('sortKey');

  @override
  String? get sourceLayerId => throw UnsupportedError('sourceLayerId');

  @override
  set sourceLayerId(String? value) => throw UnsupportedError('sourceLayerId');

  @override
  PropertyValue<Color> get strokeColor => throw UnsupportedError('strokeColor');

  @override
  set strokeColor(PropertyValue<Color> value) => throw UnsupportedError('strokeColor');

  @override
  PropertyValue<double> get strokeOpacity => throw UnsupportedError('strokeOpacity');

  @override
  set strokeOpacity(PropertyValue<double> value) => throw UnsupportedError('strokeOpacity');

  @override
  PropertyValue<double> get strokeWidth => throw UnsupportedError('strokeWidth');

  @override
  set strokeWidth(PropertyValue<double> value) => throw UnsupportedError('strokeWidth');

  @override
  PropertyValue<Offset> get translate => throw UnsupportedError('translate');

  @override
  set translate(PropertyValue<Offset> value) => throw UnsupportedError('translate');

  @override
  PropertyValue<ReferenceSpace> get translateAnchor => throw UnsupportedError('translateAnchor');

  @override
  set translateAnchor(PropertyValue<ReferenceSpace> value) => throw UnsupportedError('translateAnchor');

  @override
  String get sourceId => throw UnsupportedError('sourceId');

}
