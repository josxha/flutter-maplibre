part of 'style_layer.dart';

/// iOS implementation of [BackgroundStyleLayer].
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
    if (nsExpression.expressionType == NSExpressionType.NSConstantValueExpressionType) {
      final colorValue = UIColor.as(nsExpression.constantValue!);
      return PropertyValue(colorValue.toDartColor());
    }*/
  }

  @override
  set color(PropertyValue<Color> property) {
    if (property.isExpression) {
      ffiLayer.backgroundColor = Helpers.parseExpressionWithPropertyName(
        'background-color'.toNSString(),
        expression: jsonEncode(property.expression).toNSString(),
      )!;
    } else {
      // UIColor
      ffiLayer.backgroundColor = Helpers.parseExpressionWithPropertyName(
        'background-color'.toNSString(),
        expression: property.value.toHexString().toNSString(),
      )!;
    }
  }

  @override
  PropertyValue<double> get opacity => throw UnimplementedError();

  @override
  set opacity(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.backgroundColor = Helpers.parseExpressionWithPropertyName(
        'background-opacity'.toNSString(),
        expression: jsonEncode(property.expression).toNSString(),
      )!;
    } else {
      ffiLayer.backgroundColor = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<String>? get pattern => throw UnimplementedError();

  @override
  set pattern(PropertyValue<String>? property) {
    if (property == null) {
      ffiLayer.backgroundPattern = NSExpression.expressionForConstantValue(
        null,
      );
    } else if (property.isExpression) {
      ffiLayer.backgroundColor = Helpers.parseExpressionWithPropertyName(
        'background-opacity'.toNSString(),
        expression: jsonEncode(property.expression).toNSString(),
      )!;
    } else {
      ffiLayer.backgroundColor = NSExpression.expressionForConstantValue(
        property.value.toNSString(),
      );
    }
  }
}
