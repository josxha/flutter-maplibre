part of 'style_layer.dart';

/// Android implementation of [FillExtrusionStyleLayer].
class FillExtrusionStyleLayerAndroid
    extends StyleLayerAndroid<jni.FillExtrusionLayer>
    implements FillExtrusionStyleLayer {
  /// Default constructor for [FillExtrusionStyleLayerAndroid].
  factory FillExtrusionStyleLayerAndroid({
    required String id,
    required String sourceId,
    required double minZoom,
    required double maxZoom,
    required bool visible,
    required Expression? filter,
    required String? sourceLayerId,
    required PropertyValue<double> opacity,
    required PropertyValue<Color> color,
    required PropertyValue<String>? pattern,
    required PropertyValue<double> height,
    required PropertyValue<double> base,
    required PropertyValue<bool> verticalGradient,
    required PropertyValue<Offset> translate,
    required PropertyValue<ReferenceSpace> translateAnchor,
  }) => using((arena) {
    final layer = FillExtrusionStyleLayerAndroid.fromNativeLayer(
      jni.FillExtrusionLayer(
        id.toJString()..releasedBy(arena),
        sourceId.toJString()..releasedBy(arena),
      )..releasedBy(arena),
    );
    layer.minZoom = minZoom;
    layer.maxZoom = maxZoom;
    layer.visible = visible;
    layer.filter = filter;
    layer.sourceLayerId = sourceLayerId;
    layer.opacity = opacity;
    layer.color = color;
    layer.pattern = pattern;
    layer.height = height;
    layer.base = base;
    layer.verticalGradient = verticalGradient;
    layer.translate = translate;
    layer.translateAnchor = translateAnchor;
    return layer;
  });

  /// Construct an [FillExtrusionStyleLayerAndroid] from a JNI layer.
  FillExtrusionStyleLayerAndroid.fromNativeLayer(super.jLayer)
    : super.fromNativeLayer();

  @override
  PropertyValue<double> get base =>
      jLayer.getFillExtrusionBase().toDart(releaseOriginal: true) ??
      FillExtrusionStyleLayer.defaultBase;

  @override
  set base(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillExtrusionBase$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillExtrusionBase(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get color =>
      jLayer.getFillExtrusionColor().toDartColor(releaseOriginal: true) ??
      FillExtrusionStyleLayer.defaultColor;

  @override
  set color(PropertyValue<Color> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      jProperty = jni.PropertyFactory.fillExtrusionColor$2(
        value.expression.toJExpression(arena),
      );
    } else {
      final jValue = value.value.toHexString().toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillExtrusionColor$1(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  Expression? get filter => using((arena) {
    final jFilter = jLayer.getFilter()?..releasedBy(arena);
    if (jFilter == null) return null;
    return jFilter.toDart(releaseOriginal: true);
  });

  @override
  set filter(Expression? expression) => using((arena) {
    if (expression == null) {
      throw UnsupportedError(
        'Setting filter for FillExtrusionStyleLayer to null '
        'is not implemented yet.',
      );
    }
    final jFilter = expression.toJExpression(arena)?..releasedBy(arena);
    if (jFilter != null) jLayer.setFilter(jFilter);
  });

  @override
  PropertyValue<double> get height =>
      jLayer.getFillExtrusionHeight().toDart(releaseOriginal: true) ??
      FillExtrusionStyleLayer.defaultHeight;

  @override
  set height(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillExtrusionHeight$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillExtrusionHeight(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get opacity =>
      jLayer.getFillExtrusionOpacity().toDart(releaseOriginal: true) ??
      FillExtrusionStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillExtrusionOpacity$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillExtrusionOpacity(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<String>? get pattern =>
      jLayer.getFillExtrusionPattern().toDart(releaseOriginal: true);

  @override
  set pattern(PropertyValue<String>? value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value == null) {
      jProperty = jni.PropertyFactory.fillExtrusionPattern(null);
    } else if (value.isExpression) {
      jProperty = jni.PropertyFactory.fillExtrusionPattern$1(
        value.expression.toJExpression(arena),
      );
    } else {
      final jValue = value.value.toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillExtrusionPattern(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  String? get sourceLayerId =>
      jLayer.getSourceLayer().toDartString(releaseOriginal: true);

  @override
  set sourceLayerId(String? sourceLayerId) => using((arena) {
    final jValue = sourceLayerId?.toJString();
    jValue?.releasedBy(arena);
    jLayer.setSourceLayer(jValue);
  });

  @override
  PropertyValue<Offset> get translate =>
      jLayer.getFillExtrusionTranslate().toDartOffset(releaseOriginal: true) ??
      StyleLayerWithTranslate.defaultTranslate;

  @override
  set translate(PropertyValue<Offset> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillExtrusionTranslate$1(jExpression);
    } else {
      final jArray = value.value.toJFloatArray(arena);
      jProperty = jni.PropertyFactory.fillExtrusionTranslate(jArray);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<ReferenceSpace> get translateAnchor =>
      jLayer.getFillExtrusionTranslateAnchor().toDartReferenceSpace(
        releaseOriginal: true,
      ) ??
      StyleLayerWithTranslate.defaultTranslateAnchor;

  @override
  set translateAnchor(PropertyValue<ReferenceSpace> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillExtrusionTranslateAnchor$1(
        jExpression,
      );
    } else {
      final jValue = value.value.name.toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillExtrusionTranslateAnchor(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<bool> get verticalGradient =>
      jLayer.getFillExtrusionVerticalGradient().toDart(releaseOriginal: true) ??
      FillExtrusionStyleLayer.defaultVerticalGradient;

  @override
  set verticalGradient(PropertyValue<bool> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillExtrusionVerticalGradient$1(
        jExpression,
      );
    } else {
      final jValue = value.value.toJBoolean()..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillExtrusionVerticalGradient(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  String get sourceId =>
      jLayer.getSourceId().toDartString(releaseOriginal: true);
}
