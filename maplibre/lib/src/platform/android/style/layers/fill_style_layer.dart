part of 'style_layer.dart';

/// Android implementation of [FillStyleLayer].
class FillStyleLayerAndroid extends StyleLayerAndroid<jni.FillLayer>
    implements FillStyleLayer {
  /// Default constructor for [FillStyleLayerAndroid].
  factory FillStyleLayerAndroid({
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
    required PropertyValue<Offset> translate,
    required PropertyValue<ReferenceSpace> translateAnchor,
    required PropertyValue<bool> antialias,
    required PropertyValue<Color> outlineColor,
  }) => using((arena) {
    final layer = FillStyleLayerAndroid.fromNativeLayer(
      jni.FillLayer(
        id.toJString()..releasedBy(arena),
        sourceId.toJString()..releasedBy(arena),
      )..releasedBy(arena),
    );
    layer.minZoom = minZoom;
    layer.maxZoom = maxZoom;
    layer.visible = visible;
    layer.filter = filter;
    if (sourceLayerId != null) layer.sourceLayerId = sourceLayerId;
    layer.opacity = opacity;
    layer.color = color;
    layer.pattern = pattern;
    layer.translate = translate;
    layer.translateAnchor = translateAnchor;
    layer.antialias = antialias;
    layer.outlineColor = outlineColor;
    return layer;
  });

  /// Construct an [FillStyleLayerAndroid] from a JNI layer.
  FillStyleLayerAndroid.fromNativeLayer(super.jLayer) : super.fromNativeLayer();

  @override
  PropertyValue<bool> get antialias =>
      jLayer.getFillAntialias().toDart(releaseOriginal: true) ??
      FillStyleLayer.defaultAntialias;

  @override
  set antialias(PropertyValue<bool> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillAntialias$1(jExpression);
    } else {
      final jValue = value.value.toJBoolean()..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillAntialias(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get color =>
      jLayer.getFillColor().toDartColor(releaseOriginal: true) ??
      FillStyleLayer.defaultColor;

  @override
  set color(PropertyValue<Color> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      jProperty = jni.PropertyFactory.fillColor$2(
        value.expression.toJExpression(arena),
      );
    } else {
      final jValue = value.value.toHexString().toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillColor$1(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get opacity =>
      jLayer.getFillOpacity().toDart(releaseOriginal: true) ??
      FillStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillOpacity$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillOpacity(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get outlineColor =>
      jLayer.getFillOutlineColor().toDartColor(releaseOriginal: true) ??
      FillStyleLayer.defaultOutlineColor;

  @override
  set outlineColor(PropertyValue<Color> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      jProperty = jni.PropertyFactory.fillOutlineColor$2(
        value.expression.toJExpression(arena),
      );
    } else {
      final jValue = value.value.toHexString().toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillOutlineColor$1(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<String>? get pattern =>
      jLayer.getFillPattern().toDart(releaseOriginal: true);

  @override
  set pattern(PropertyValue<String>? value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value == null) {
      jProperty = jni.PropertyFactory.fillPattern(null);
    } else if (value.isExpression) {
      jProperty = jni.PropertyFactory.fillPattern$1(
        value.expression.toJExpression(arena),
      );
    } else {
      final jValue = value.value.toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillPattern(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Offset> get translate =>
      jLayer.getFillTranslate().toDartOffset(releaseOriginal: true) ??
      StyleLayerWithTranslate.defaultTranslate;

  @override
  set translate(PropertyValue<Offset> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillTranslate$1(jExpression);
    } else {
      final jArray = value.value.toJFloatArray(arena);
      jProperty = jni.PropertyFactory.fillTranslate(jArray);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<ReferenceSpace> get translateAnchor =>
      jLayer.getFillTranslateAnchor().toDartReferenceSpace(
        releaseOriginal: true,
      ) ??
      StyleLayerWithTranslate.defaultTranslateAnchor;

  @override
  set translateAnchor(PropertyValue<ReferenceSpace> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillTranslateAnchor$1(jExpression);
    } else {
      final jValue = value.value.name.toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillTranslateAnchor(jValue);
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
  PropertyValue<double>? get sortKey =>
      jLayer.getFillSortKey().toDart(releaseOriginal: true);

  @override
  String get sourceId =>
      jLayer.getSourceId().toDartString(releaseOriginal: true);

  @override
  Expression? get filter => using((arena) {
    final jFilter = jLayer.getFilter()?..releasedBy(arena);
    if (jFilter == null) return null;
    return jFilter.toDart(releaseOriginal: true);
  });

  @override
  set sortKey(PropertyValue<double>? value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value == null) {
      jProperty = jni.PropertyFactory.fillSortKey(null);
    } else if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillSortKey$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.fillSortKey(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  set filter(Expression? expression) => using((arena) {
    if (expression == null) {
      throw UnsupportedError(
        'Setting filter for FillStyleLayer to null is not supported.',
      );
    }
    final jFilter = expression.toJExpression(arena)?..releasedBy(arena);
    if (jFilter != null) jLayer.setFilter(jFilter);
  });
}
