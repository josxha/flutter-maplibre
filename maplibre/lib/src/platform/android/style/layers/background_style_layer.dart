part of 'style_layer.dart';

/// A layer that contains circles for Android platform.
class BackgroundStyleLayerAndroid extends StyleLayerAndroid<jni.BackgroundLayer>
    implements BackgroundStyleLayer {
  /// Factory for a [BackgroundStyleLayerAndroid] instance.
  factory BackgroundStyleLayerAndroid({
    required String id,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<Color> color,
    required PropertyValue<String>? pattern,
    required PropertyValue<double> opacity,
    required bool visible,
  }) => using((arena) {
    return BackgroundStyleLayerAndroid.fromNativeLayer(
        jni.BackgroundLayer(id.toJString()..releasedBy(arena)),
      )
      ..minZoom = minZoom
      ..maxZoom = maxZoom
      ..color = color
      ..opacity = opacity
      ..visible = visible
      ..pattern = pattern;
  });

  /// Construct an [BackgroundStyleLayerAndroid] from a JNI..
  BackgroundStyleLayerAndroid.fromNativeLayer(super.jLayer)
    : super.fromNativeLayer();

  @override
  PropertyValue<double> get opacity => using((arena) {
    final jProperty = jLayer.getBackgroundOpacity()..releasedBy(arena);
    if (jProperty.isExpression()) {
      final jExpression = jProperty.getExpression()!..releasedBy(arena);
      final expression = jExpression.toDartExpression(releaseOriginal: true);
      return PropertyValue.expression(expression);
    }
    final jValue = jProperty.getValue()!..releasedBy(arena);
    final value = jValue.floatValue(releaseOriginal: true);
    return PropertyValue.value(value);
  });

  @override
  set opacity(PropertyValue<double> property) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (property.isExpression) {
      final jExpression = property.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.backgroundOpacity$1(jExpression);
    } else {
      final jValue = property.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.backgroundOpacity(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<String>? get pattern => using((arena) {
    final jProperty = jLayer.getBackgroundPattern()..releasedBy(arena);
    if (jProperty.isNull$1()) {
      return null;
    }
    if (jProperty.isExpression()) {
      final jExpression = jProperty.getExpression()!..releasedBy(arena);
      final expression = jExpression.toDartExpression(releaseOriginal: true);
      return PropertyValue.expression(expression);
    }
    final jValue = jProperty.getValue()?..releasedBy(arena);
    final value = jValue?.toDartString(releaseOriginal: true);
    return PropertyValue.value(value!);
  });

  @override
  set pattern(PropertyValue<String>? property) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (property == null) {
      jProperty = jni.PropertyFactory.backgroundPattern(null);
    } else if (property.isExpression) {
      jProperty = jni.PropertyFactory.backgroundPattern$1(
        property.expression.toJExpression(arena),
      );
    } else {
      final jValue = property.value.toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.backgroundPattern(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get color => using((arena) {
    final jProperty = jLayer.getBackgroundColor()..releasedBy(arena);
    if (jProperty.isExpression()) {
      final jExpression = jProperty.getExpression()!..releasedBy(arena);
      final expression = jExpression.toDartExpression(releaseOriginal: true);
      return PropertyValue.expression(expression);
    }
    final jValue = jProperty.getColorInt()!..releasedBy(arena);
    final value = jValue.intValue(releaseOriginal: true);
    return PropertyValue.value(Color(value));
  });

  @override
  set color(PropertyValue<Color> property) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (property.isExpression) {
      jProperty = jni.PropertyFactory.backgroundColor$2(
        property.expression.toJExpression(arena),
      );
    } else {
      final jValue = property.value.toHexString().toJString()
        ..releasedBy(arena);
      jProperty = jni.PropertyFactory.backgroundColor$1(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });
}
