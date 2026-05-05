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
  PropertyValue<Color> get color =>
      ffiLayer.backgroundColor.toColorPropertyValue() ??
      BackgroundStyleLayer.defaultColor;

  @override
  set color(PropertyValue<Color> property) {
    if (property.isExpression) {
      ffiLayer.backgroundColor = property.expression.toNSExpression();
    } else {
      ffiLayer.backgroundColor = NSExpression.expressionForConstantValue(
        property.value.toUIColor(),
      );
    }
  }

  @override
  PropertyValue<double> get opacity =>
      ffiLayer.backgroundOpacity.toPropertyValue() ??
      BackgroundStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.backgroundOpacity = property.expression.toNSExpression();
    } else {
      ffiLayer.backgroundOpacity = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<String>? get pattern =>
      ffiLayer.backgroundPattern.toPropertyValue();

  @override
  set pattern(PropertyValue<String>? property) {
    if (property == null) {
      throw UnsupportedError(
        'Removing the pattern property is not supported on iOS',
      );
    } else if (property.isExpression) {
      ffiLayer.backgroundPattern = property.expression.toNSExpression();
    } else {
      ffiLayer.backgroundPattern = NSExpression.expressionForConstantValue(
        property.value.toNSString(),
      );
    }
  }
}
