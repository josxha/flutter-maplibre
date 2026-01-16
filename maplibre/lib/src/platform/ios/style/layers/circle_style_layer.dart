import 'dart:ui';

import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/ios/style/layers/style_layer.dart';
import 'package:maplibre_ios/maplibre_ffi.g.dart';
import 'package:maplibre_ios/objective_c.dart';

/// iOS implementation of [CircleStyleLayer].
class CircleStyleLayerIos extends StyleLayerIos<MLNCircleStyleLayer>
    implements CircleStyleLayer {
  /// Default constructor for a [CircleStyleLayerIos] instance.
  factory CircleStyleLayerIos({
    required String id,
    required String sourceId,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<double> blur,
    required PropertyValue<Color> color,
    required Expression? filter,
    required PropertyValue<double> opacity,
    required PropertyValue<ReferenceSpace> pitchAlignment,
    required PropertyValue<ReferenceSpace> pitchScale,
    required PropertyValue<double> radius,
    required PropertyValue<double>? sortKey,
    required String? sourceLayerId,
    required PropertyValue<Color> strokeColor,
    required PropertyValue<double> strokeOpacity,
    required PropertyValue<double> strokeWidth,
    required PropertyValue<Offset> translate,
    required PropertyValue<ReferenceSpace> translateAnchor,
    required bool visible,
  }) {
    final layer = CircleStyleLayerIos.fromNativeLayer(
      MLNCircleStyleLayer.new$()..initWithIdentifier(
        id.toNSString(),
        source: MLNSource()..initWithIdentifier(sourceId.toNSString()),
      ),
    );
    layer
      ..minZoom = minZoom
      ..maxZoom = maxZoom
      ..blur = blur
      ..color = color
      ..filter = filter
      ..opacity = opacity
      ..pitchAlignment = pitchAlignment
      ..pitchScale = pitchScale
      ..radius = radius
      ..sortKey = sortKey
      ..sourceLayerId = sourceLayerId
      ..strokeColor = strokeColor
      ..strokeOpacity = strokeOpacity
      ..strokeWidth = strokeWidth
      ..translate = translate
      ..translateAnchor = translateAnchor
      ..visible = visible;
    if (sourceLayerId != null) {
      layer.ffiLayer.sourceLayerIdentifier = sourceLayerId.toNSString();
    }
    return layer;
  }

  /// Construct a [CircleStyleLayerIos] from a ObjC layer.
  CircleStyleLayerIos.fromNativeLayer(super.ffiLayer) : super.fromNativeLayer();

  @override
  PropertyValue<double> get blur {
    throw UnimplementedError();
  }

  @override
  set blur(PropertyValue<double> value) {
    throw UnimplementedError();
  }

  @override
  PropertyValue<Color> get color {
    throw UnimplementedError();
  }

  @override
  set color(PropertyValue<Color> value) {
    throw UnimplementedError();
  }

  @override
  Expression? get filter {
    throw UnimplementedError();
  }

  @override
  set filter(Expression? value) {
    throw UnimplementedError();
  }

  @override
  PropertyValue<double> get opacity {
    throw UnimplementedError();
  }

  @override
  set opacity(PropertyValue<double> value) {
    throw UnimplementedError();
  }

  @override
  PropertyValue<ReferenceSpace> get pitchAlignment {
    throw UnimplementedError();
  }

  @override
  set pitchAlignment(PropertyValue<ReferenceSpace> value) {
    throw UnimplementedError();
  }

  @override
  PropertyValue<ReferenceSpace> get pitchScale {
    throw UnimplementedError();
  }

  @override
  set pitchScale(PropertyValue<ReferenceSpace> value) {
    throw UnimplementedError();
  }

  @override
  PropertyValue<double> get radius {
    throw UnimplementedError();
  }

  @override
  set radius(PropertyValue<double> value) {
    throw UnimplementedError();
  }

  @override
  PropertyValue<double>? get sortKey {
    throw UnimplementedError();
  }

  @override
  set sortKey(PropertyValue<double>? value) {
    throw UnimplementedError();
  }

  @override
  String? get sourceLayerId {
    throw UnimplementedError();
  }

  @override
  set sourceLayerId(String? value) {
    throw UnimplementedError();
  }

  @override
  PropertyValue<Color> get strokeColor {
    throw UnimplementedError();
  }

  @override
  set strokeColor(PropertyValue<Color> value) {
    throw UnimplementedError();
  }

  @override
  PropertyValue<double> get strokeOpacity {
    throw UnimplementedError();
  }

  @override
  set strokeOpacity(PropertyValue<double> value) {
    throw UnimplementedError();
  }

  @override
  PropertyValue<double> get strokeWidth {
    throw UnimplementedError();
  }

  @override
  set strokeWidth(PropertyValue<double> value) {
    throw UnimplementedError();
  }

  @override
  PropertyValue<Offset> get translate {
    throw UnimplementedError();
  }

  @override
  set translate(PropertyValue<Offset> value) {
    throw UnimplementedError();
  }

  @override
  PropertyValue<ReferenceSpace> get translateAnchor {
    throw UnimplementedError();
  }

  @override
  set translateAnchor(PropertyValue<ReferenceSpace> value) {
    throw UnimplementedError();
  }

  @override
  String get sourceId => ffiLayer.sourceIdentifier!.toDartString();
}
