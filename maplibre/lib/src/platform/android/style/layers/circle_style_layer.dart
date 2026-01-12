part of 'style_layer.dart';

/// A layer that contains circles for Android platform.
class CircleStyleLayerAndroid extends StyleLayerAndroid<jni.CircleLayer>
    implements CircleStyleLayer {
  /// Factory for a [CircleStyleLayerAndroid] instance.
  factory CircleStyleLayerAndroid({
    required String id,
    required String sourceId,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<Color> color,
    required PropertyValue<double> opacity,
    required bool visible,
  }) => using((arena) {
    return CircleStyleLayerAndroid.fromNativeLayer(
        jni.CircleLayer(
          id.toJString()..releasedBy(arena),
          sourceId.toJString()..releasedBy(arena),
        ),
      )
      ..minZoom = minZoom
      ..maxZoom = maxZoom
      ..color = color
      ..opacity = opacity
      ..visible = visible;
  });

  /// Construct an [CircleStyleLayerAndroid] from a JNI..
  CircleStyleLayerAndroid.fromNativeLayer(super.jLayer)
    : super.fromNativeLayer();

  @override
  PropertyValue<double> get opacity => using((arena) {
    final jProperty = jLayer.getCircleOpacity()..releasedBy(arena);
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
      jProperty = jni.PropertyFactory.circleOpacity$1(jExpression);
    } else {
      final jValue = property.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.circleOpacity(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get color => using((arena) {
    final jProperty = jLayer.getCircleColor()..releasedBy(arena);
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
      jProperty = jni.PropertyFactory.circleColor$2(
        property.expression.toJExpression(arena),
      );
    } else {
      final jValue = property.value.toHexString().toJString()
        ..releasedBy(arena);
      jProperty = jni.PropertyFactory.circleColor$1(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get blur => using((arena) {
    final jProperty = jLayer.getCircleBlur()..releasedBy(arena);
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
  set blur(PropertyValue<double> property) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (property.isExpression) {
      final jExpression = property.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.circleBlur$1(jExpression);
    } else {
      final jValue = property.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.circleBlur(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  Expression? get filter => using((arena) {
    final jFilter = jLayer.getFilter();
    if (jFilter == null) return null;
    return jFilter.toDartExpression(releaseOriginal: true);
  });

  @override
  PropertyValue<ReferenceSpace> get pitchAlignment => using((arena) {
    final jProperty = jLayer.getCirclePitchAlignment()..releasedBy(arena);
    if (jProperty.isExpression()) {
      final jExpression = jProperty.getExpression()!;
      final expression = jExpression.toDartExpression(releaseOriginal: true);
      return PropertyValue.expression(expression);
    }
    final jValue = jProperty.getValue()!..releasedBy(arena);
    final stringValue = jValue.toDartString(releaseOriginal: true);
    final value = ReferenceSpace.values.firstWhere(
      (e) => e.name == stringValue,
    );
    return PropertyValue.value(value);
  });

  @override
  set pitchAlignment(PropertyValue<ReferenceSpace> property) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (property.isExpression) {
      final jExpression = property.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.circlePitchAlignment$1(jExpression);
    } else {
      final jValue = property.value.name.toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.circlePitchAlignment(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });
}
