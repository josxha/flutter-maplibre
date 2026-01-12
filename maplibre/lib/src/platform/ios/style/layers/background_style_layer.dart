import 'dart:convert';
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
  PropertyValue<Color> get color {
    throw UnimplementedError();
    /*final nsExpression = ffiLayer.backgroundColor;
    if (nsExpression.isKindOfClass()) {
      return PropertyValue.value();
    } else {
      nsExpression.mgl_jsonExpressionObject;
    }*/
  }

  @override
  set color(PropertyValue<Color> value) {
    if (value.isExpression) {
      Helpers.parseExpressionWithPropertyName(
        'background-color'.toNSString(),
        expression: jsonEncode(value.expression).toNSString(),
      );
    } else {
      ffiLayer.backgroundColor = NSExpression.expressionWithFormat(
        value.value.toHexString().toNSString(),
      );
    }
  }

  @override
  PropertyValue<double> get opacity => throw UnimplementedError();

  @override
  set opacity(PropertyValue<double> value) {
    if (value.isExpression) {
      Helpers.parseExpressionWithPropertyName(
        'background-opacity'.toNSString(),
        expression: jsonEncode(value.expression).toNSString(),
      );
    } else {
      ffiLayer.backgroundOpacity = NSExpression.expressionForConstantValue(
        value.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<String>? get pattern => throw UnimplementedError();

  @override
  set pattern(PropertyValue<String>? value) {
    if (value == null) {
      throw UnimplementedError();
      // ffiLayer.backgroundPattern = null;
    } else if (value.isExpression) {
      Helpers.parseExpressionWithPropertyName(
        'background-pattern'.toNSString(),
        expression: jsonEncode(value.expression).toNSString(),
      );
    } else {
      ffiLayer.backgroundPattern = NSExpression.expressionForConstantValue(
        value.value.toNSString(),
      );
    }
  }
}
