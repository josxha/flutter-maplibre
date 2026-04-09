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
    final layer = CircleStyleLayerAndroid.fromNativeLayer(
      jni.CircleLayer(
        id.toJString()..releasedBy(arena),
        sourceId.toJString()..releasedBy(arena),
      ),
    );
    layer.minZoom = minZoom;
    layer.maxZoom = maxZoom;
    layer.color = color;
    layer.opacity = opacity;
    layer.visible = visible;
    layer.translate = translate;
    layer.translateAnchor = translateAnchor;
    layer.sortKey = sortKey;
    layer.radius = radius;
    layer.blur = blur;
    layer.pitchScale = pitchScale;
    layer.pitchAlignment = pitchAlignment;
    layer.strokeWidth = strokeWidth;
    layer.strokeColor = strokeColor;
    layer.strokeOpacity = strokeOpacity;
    if (filter != null) layer.filter = filter;
    if (sourceLayerId != null) layer.sourceLayerId = sourceLayerId;
    return layer;
  });

  /// Construct an [CircleStyleLayerAndroid] from a JNI..
  CircleStyleLayerAndroid.fromNativeLayer(super.jLayer)
    : super.fromNativeLayer();

  @override
  PropertyValue<double> get opacity =>
      jLayer.circleOpacity.toDart(releaseOriginal: true) ??
      CircleStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.circleOpacity$1,
      onValue: (value) => jni.PropertyFactory.circleOpacity(
        value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get color =>
      jLayer.circleColor.toDartColor(releaseOriginal: true) ??
      CircleStyleLayer.defaultColor;

  @override
  set color(PropertyValue<Color> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.circleColor$2,
      onValue: (value) => jni.PropertyFactory.circleColor$1(
        value.toHexString().toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get blur =>
      jLayer.circleBlur.toDart(releaseOriginal: true) ??
      CircleStyleLayer.defaultBlur;

  @override
  set blur(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.circleBlur$1,
      onValue: (value) =>
          jni.PropertyFactory.circleBlur(value.toJFloat()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  Expression? get filter => using((arena) {
    final jFilter = jLayer.filter;
    if (jFilter == null) return null;
    return jFilter.toDart(releaseOriginal: true);
  });

  @override
  set filter(Expression expression) => using((arena) {
    final jFilter = expression.toJExpression(arena);
    if (jFilter != null) jLayer.filter = jFilter;
  });

  @override
  PropertyValue<ReferenceSpace> get pitchAlignment =>
      jLayer.circlePitchAlignment.toDartReferenceSpace(
        releaseOriginal: true,
      ) ??
      CircleStyleLayer.defaultPitchAlignment;

  @override
  set pitchAlignment(PropertyValue<ReferenceSpace> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.circlePitchAlignment$1,
      onValue: (value) => jni.PropertyFactory.circlePitchAlignment(
        value.name.toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<ReferenceSpace> get pitchScale =>
      jLayer.circlePitchScale.toDartReferenceSpace(
        releaseOriginal: true,
      ) ??
      CircleStyleLayer.defaultPitchScale;

  @override
  set pitchScale(PropertyValue<ReferenceSpace> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.circlePitchScale$1,
      onValue: (value) => jni.PropertyFactory.circlePitchScale(
        value.name.toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get radius =>
      jLayer.circleRadius.toDart(releaseOriginal: true) ??
      CircleStyleLayer.defaultRadius;

  @override
  set radius(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.circleRadius$1,
      onValue: (value) =>
          jni.PropertyFactory.circleRadius(value.toJFloat()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double>? get sortKey =>
      jLayer.circleSortKey.toDart(releaseOriginal: true);

  @override
  set sortKey(PropertyValue<double>? property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onNull: () => jni.PropertyFactory.circleSortKey(null),
      onExpression: jni.PropertyFactory.circleSortKey$1,
      onValue: (value) => jni.PropertyFactory.circleSortKey(
        value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  String get sourceId =>
      jLayer.sourceId.toDartString(releaseOriginal: true);

  @override
  String? get sourceLayerId {
    final id = jLayer.sourceLayer.toDartString(releaseOriginal: true);
    return id.isEmpty ? null : id;
  }

  @override
  set sourceLayerId(String value) => using((arena) {
    final jValue = value.toJString()..releasedBy(arena);
    jLayer.sourceLayer = jValue;
  });

  @override
  PropertyValue<Color> get strokeColor =>
      jLayer.circleStrokeColor.toDartColor(releaseOriginal: true) ??
      CircleStyleLayer.defaultStrokeColor;

  @override
  set strokeColor(PropertyValue<Color> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.circleStrokeColor$2,
      onValue: (value) => jni.PropertyFactory.circleStrokeColor$1(
        value.toHexString().toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get strokeOpacity =>
      jLayer.circleStrokeOpacity.toDart(releaseOriginal: true) ??
      CircleStyleLayer.defaultStrokeOpacity;

  @override
  set strokeOpacity(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.circleStrokeOpacity$1,
      onValue: (value) => jni.PropertyFactory.circleStrokeOpacity(
        value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get strokeWidth =>
      jLayer.circleStrokeWidth.toDart(releaseOriginal: true) ??
      CircleStyleLayer.defaultStrokeWidth;

  @override
  set strokeWidth(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.circleStrokeWidth$1,
      onValue: (value) => jni.PropertyFactory.circleStrokeWidth(
        value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Offset> get translate =>
      jLayer.circleTranslate.toDartOffset(releaseOriginal: true) ??
      StyleLayerWithTranslate.defaultTranslate;

  @override
  set translate(PropertyValue<Offset> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.circleTranslate$1,
      onValue: (value) =>
          jni.PropertyFactory.circleTranslate(value.toJFloatArray(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<ReferenceSpace> get translateAnchor =>
      jLayer.circleTranslateAnchor.toDartReferenceSpace(
        releaseOriginal: true,
      ) ??
      StyleLayerWithTranslate.defaultTranslateAnchor;

  @override
  set translateAnchor(PropertyValue<ReferenceSpace> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.circleTranslateAnchor$1,
      onValue: (value) => jni.PropertyFactory.circleTranslateAnchor(
        value.name.toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });
}
