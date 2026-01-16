part of 'style_layer.dart';

/// Android implementation of [CircleStyleLayer].
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
  PropertyValue<double> get opacity =>
      jLayer.getCircleOpacity().toDart(releaseOriginal: true) ??
      CircleStyleLayer.defaultOpacity;

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
  PropertyValue<Color> get color =>
      jLayer.getCircleColor().toDartColor(releaseOriginal: true) ??
      CircleStyleLayer.defaultColor;

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
  PropertyValue<double> get blur =>
      jLayer.getCircleBlur().toDart(releaseOriginal: true) ??
      CircleStyleLayer.defaultBlur;

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
    return jFilter.toDart(releaseOriginal: true);
  });

  @override
  set filter(Expression? expression) => using((arena) {
    if (expression == null) {
      throw UnsupportedError(
        'Setting filter for CircleStyleLayer to null '
        'is not implemented yet.',
      );
    }
    final jFilter = expression.toJExpression(arena)?..releasedBy(arena);
    if (jFilter != null) jLayer.setFilter(jFilter);
  });

  @override
  PropertyValue<ReferenceSpace> get pitchAlignment =>
      jLayer.getCirclePitchAlignment().toDartReferenceSpace(
        releaseOriginal: true,
      ) ??
      CircleStyleLayer.defaultPitchAlignment;

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
  PropertyValue<ReferenceSpace> get pitchScale =>
      jLayer.getCirclePitchScale().toDartReferenceSpace(
        releaseOriginal: true,
      ) ??
      CircleStyleLayer.defaultPitchScale;

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
  PropertyValue<double> get radius =>
      jLayer.getCircleRadius().toDart(releaseOriginal: true) ??
      CircleStyleLayer.defaultRadius;

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
  PropertyValue<double>? get sortKey =>
      jLayer.getCircleSortKey().toDart(releaseOriginal: true);

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
  String? get sourceLayerId =>
      jLayer.getSourceLayer().toDartString(releaseOriginal: true);

  @override
  set sourceLayerId(String value) => using((arena) {
    final jValue = value.toJString()..releasedBy(arena);
    jLayer.setSourceLayer(jValue);
  });

  @override
  PropertyValue<Color> get strokeColor =>
      jLayer.getCircleStrokeColor().toDartColor(releaseOriginal: true) ??
      CircleStyleLayer.defaultStrokeColor;

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
  PropertyValue<double> get strokeOpacity =>
      jLayer.getCircleStrokeOpacity().toDart(releaseOriginal: true) ??
      CircleStyleLayer.defaultStrokeOpacity;

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
  PropertyValue<double> get strokeWidth =>
      jLayer.getCircleStrokeWidth().toDart(releaseOriginal: true) ??
      CircleStyleLayer.defaultStrokeWidth;

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
  PropertyValue<Offset> get translate =>
      jLayer.getCircleTranslate().toDartOffset(releaseOriginal: true) ??
      StyleLayerWithTranslate.defaultTranslate;

  @override
  set translate(PropertyValue<Offset> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.circleTranslate$1(jExpression);
    } else {
      final jArray = value.value.toJFloatArray(arena);
      jProperty = jni.PropertyFactory.circleTranslate(jArray);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<ReferenceSpace> get translateAnchor =>
      jLayer.getCircleTranslateAnchor().toDartReferenceSpace(
        releaseOriginal: true,
      ) ??
      StyleLayerWithTranslate.defaultTranslateAnchor;

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
