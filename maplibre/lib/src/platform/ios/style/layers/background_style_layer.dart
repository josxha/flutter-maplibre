import 'dart:ui';

import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/ios/style/layers/style_layer.dart';
import 'package:maplibre_ios/maplibre_ffi.g.dart';
import 'package:maplibre_ios/objective_c.dart';

/// A layer that contains circles for iOS platform.
class BackgroundStyleLayerIos extends StyleLayerIos<MLNBackgroundStyleLayer>
    implements BackgroundStyleLayer {
  /// Default constructor for a [BackgroundStyleLayerIos] instance.
  factory BackgroundStyleLayerIos({
    required String id,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<Color> color,
    required PropertyValue<String>? pattern,
    required PropertyValue<double> opacity,
    required bool visible,
  }) {
    return BackgroundStyleLayerIos.fromNativeLayer(
        MLNBackgroundStyleLayer.new$()..initWithIdentifier(id.toNSString()),
      )
      ..minZoom = minZoom
      ..maxZoom = maxZoom
      ..color = color
      ..opacity = opacity
      ..visible = visible
      ..pattern = pattern;
  }

  /// Construct a [BackgroundStyleLayerIos] from a ObjC layer.
  BackgroundStyleLayerIos.fromNativeLayer(super.ffiLayer)
    : super.fromNativeLayer();

  @override
  PropertyValue<Color> get color => ffiLayer.backgroundColor;

  @override
  set color(PropertyValue<Color> value) {
    ffiLayer.backgroundColor = NSExpression.expressionWithFormat(
      value.value.toHexString().toNSString(),
    );
    // TODO handle expressions
  }

  @override
  PropertyValue<double> get opacity => ffiLayer.backgroundOpacity;

  @override
  set opacity(PropertyValue<double> value) {
    ffiLayer.backgroundOpacity = NSExpression.expressionForConstantValue(
      value.value.toNSNumber(),
    );
    // TODO handle expressions
  }

  @override
  PropertyValue<String>? get pattern => ffiLayer.backgroundPattern;

  @override
  set pattern(PropertyValue<String>? value) {
    ffiLayer.backgroundOpacity = NSExpression.expressionForConstantValue(
      value?.value.toNSString(),
    );
    // TODO handle expressions
  }

  @override
  bool get visible => ffiLayer.isVisible;

  @override
  set visible(bool value) => ffiLayer.isVisible = value;
}
