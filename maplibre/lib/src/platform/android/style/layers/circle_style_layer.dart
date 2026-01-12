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
    required String? sourceLayerId,
    required Expression? filter,
    required PropertyValue<Offset> translate,
    required PropertyValue<ReferenceSpace> translateAnchor,
    required PropertyValue<double>? sortKey,
    required PropertyValue<double> radius,
    required PropertyValue<double> blur,
    required PropertyValue<ReferenceSpace> pitchScale,
    required PropertyValue<ReferenceSpace> pitchAlignment,
    required PropertyValue<double> strokeWidth,
    required PropertyValue<Color> strokeColor,
    required PropertyValue<double> strokeOpacity,
  }) => using((arena) {
    final layer =
        CircleStyleLayerAndroid.fromNativeLayer(
            jni.CircleLayer(
              id.toJString()..releasedBy(arena),
              sourceId.toJString()..releasedBy(arena),
            ),
          )
          ..minZoom = minZoom
          ..maxZoom = maxZoom
          ..color = color
          ..opacity = opacity
          ..visible = visible
          ..filter = filter
          ..translate = translate
          ..translateAnchor = translateAnchor
          ..sortKey = sortKey
          ..radius = radius
          ..blur = blur
          ..pitchScale = pitchScale
          ..pitchAlignment = pitchAlignment
          ..strokeWidth = strokeWidth
          ..strokeColor = strokeColor
          ..strokeOpacity = strokeOpacity;
    if (sourceLayerId != null) layer.sourceLayerId = sourceLayerId;
    return layer;
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
  set filter(Expression? value) => using((arena) {
    final jFilter = value?.toJExpression(arena)?..releasedBy(arena);
    /// TODO handle null, MLN Android does not allow setting filter to null
    if (jFilter != null) jLayer.setFilter(jFilter);
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

  @override
  PropertyValue<ReferenceSpace> get pitchScale => using((arena) {
    final jProperty = jLayer.getCirclePitchScale()..releasedBy(arena);
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
  set pitchScale(PropertyValue<ReferenceSpace> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.circlePitchScale$1(jExpression);
    } else {
      final jValue = value.value.name.toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.circlePitchScale(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get radius => using((arena) {
    final jProperty = jLayer.getCircleRadius()..releasedBy(arena);
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
  set radius(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.circleRadius$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.circleRadius(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double>? get sortKey => using((arena) {
    final jProperty = jLayer.getCircleSortKey()..releasedBy(arena);
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
  set sortKey(PropertyValue<double>? value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value == null) {
      jProperty = jni.PropertyFactory.circleSortKey(null);
    } else if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.circleSortKey$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.circleSortKey(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  String get sourceId =>
      jLayer.getSourceId().toDartString(releaseOriginal: true);

  @override
  String? get sourceLayerId => using((arena) {
    final jValue = jLayer.getSourceLayer()..releasedBy(arena);
    return jValue.toDartString(releaseOriginal: true);
  });

  @override
  set sourceLayerId(String value) => using((arena) {
    final jValue = value.toJString()..releasedBy(arena);
    jLayer.setSourceLayer(jValue);
  });

  @override
  PropertyValue<Color> get strokeColor => using((arena) {
    final jProperty = jLayer.getCircleStrokeColor()..releasedBy(arena);
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
  set strokeColor(PropertyValue<Color> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      jProperty = jni.PropertyFactory.circleStrokeColor$2(
        value.expression.toJExpression(arena),
      );
    } else {
      final jValue = value.value.toHexString().toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.circleStrokeColor$1(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get strokeOpacity => using((arena) {
    final jProperty = jLayer.getCircleStrokeOpacity()..releasedBy(arena);
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
  set strokeOpacity(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.circleStrokeOpacity$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.circleStrokeOpacity(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get strokeWidth => using((arena) {
    final jProperty = jLayer.getCircleStrokeWidth()..releasedBy(arena);
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
  set strokeWidth(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.circleStrokeWidth$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.circleStrokeWidth(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Offset> get translate => using((arena) {
    final jProperty = jLayer.getCircleTranslate()..releasedBy(arena);
    if (jProperty.isExpression()) {
      final jExpression = jProperty.getExpression()!..releasedBy(arena);
      final expression = jExpression.toDartExpression(releaseOriginal: true);
      return PropertyValue.expression(expression);
    }
    final jValue = jProperty.getValue()!..releasedBy(arena);
    final x = jValue[0]!.floatValue(releaseOriginal: true);
    final y = jValue[1]!.floatValue(releaseOriginal: true);
    return PropertyValue.value(Offset(x, y));
  });

  @override
  set translate(PropertyValue<Offset> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.circleTranslate$1(jExpression);
    } else {
      final offset = value.value;
      final jArray = JArray(JFloat.nullableType, 2)..releasedBy(arena);
      jArray[0] = offset.dx.toJFloat()..releasedBy(arena);
      jArray[1] = offset.dy.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.circleTranslate(jArray);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<ReferenceSpace> get translateAnchor => using((arena) {
    final jProperty = jLayer.getCircleTranslateAnchor()..releasedBy(arena);
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
  set translateAnchor(PropertyValue<ReferenceSpace> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.circleTranslateAnchor$1(jExpression);
    } else {
      final jValue = value.value.name.toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.circleTranslateAnchor(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });
}
