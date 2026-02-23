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
    required PropertyValue<double>? sortKey,
  }) => using((arena) {
    final layer = FillStyleLayerAndroid.fromNativeLayer(
      jni.FillLayer(
        id.toJString()..releasedBy(arena),
        sourceId.toJString()..releasedBy(arena),
      ),
    );
    layer.minZoom = minZoom;
    layer.maxZoom = maxZoom;
    layer.visible = visible;
    if (filter != null) layer.filter = filter;
    if (sourceLayerId != null) layer.sourceLayerId = sourceLayerId;
    layer.opacity = opacity;
    layer.color = color;
    layer.pattern = pattern;
    layer.translate = translate;
    layer.translateAnchor = translateAnchor;
    layer.antialias = antialias;
    layer.outlineColor = outlineColor;
    if (sortKey != null) layer.sortKey = sortKey;
    return layer;
  });

  /// Construct an [FillStyleLayerAndroid] from a JNI layer.
  FillStyleLayerAndroid.fromNativeLayer(super.jLayer) : super.fromNativeLayer();

  @override
  PropertyValue<bool> get antialias =>
      jLayer.getFillAntialias().toDart(releaseOriginal: true) ??
      FillStyleLayer.defaultAntialias;

  @override
  set antialias(PropertyValue<bool> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.fillAntialias$1,
      onValue: (value) => jni.PropertyFactory.fillAntialias(
        value.toJBoolean()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get color =>
      jLayer.getFillColor().toDartColor(releaseOriginal: true) ??
      FillStyleLayer.defaultColor;

  @override
  set color(PropertyValue<Color> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.fillColor$2,
      onValue: (value) => jni.PropertyFactory.fillColor$1(
        value.toHexString().toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get opacity =>
      jLayer.getFillOpacity().toDart(releaseOriginal: true) ??
      FillStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.fillOpacity$1,
      onValue: (value) =>
          jni.PropertyFactory.fillOpacity(value.toJFloat()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get outlineColor =>
      jLayer.getFillOutlineColor().toDartColor(releaseOriginal: true) ??
      FillStyleLayer.defaultOutlineColor;

  @override
  set outlineColor(PropertyValue<Color> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.fillOutlineColor$2,
      onValue: (value) => jni.PropertyFactory.fillOutlineColor$1(
        value.toHexString().toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<String>? get pattern =>
      jLayer.getFillPattern().toDart(releaseOriginal: true);

  @override
  set pattern(PropertyValue<String>? property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.fillPattern$1,
      onValue: (value) =>
          jni.PropertyFactory.fillPattern(value.toJString()..releasedBy(arena)),
      onNull: () => jni.PropertyFactory.fillPattern(null),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Offset> get translate =>
      jLayer.getFillTranslate().toDartOffset(releaseOriginal: true) ??
      StyleLayerWithTranslate.defaultTranslate;

  @override
  set translate(PropertyValue<Offset> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.fillTranslate$1,
      onValue: (value) =>
          jni.PropertyFactory.fillTranslate(value.toJFloatArray(arena)),
    );
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
  set translateAnchor(PropertyValue<ReferenceSpace> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.fillTranslateAnchor$1,
      onValue: (value) => jni.PropertyFactory.fillTranslateAnchor(
        value.name.toJString()..releasedBy(arena),
      ),
      onNull: () => jni.PropertyFactory.fillTranslateAnchor(null),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  String? get sourceLayerId =>
      jLayer.getSourceLayer().toDartString(releaseOriginal: true);

  @override
  set sourceLayerId(String? value) => using((arena) {
    final jValue = value?.toJString();
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
  set sortKey(PropertyValue<double>? property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.fillSortKey$1,
      onValue: (value) =>
          jni.PropertyFactory.fillSortKey(value.toJFloat()..releasedBy(arena)),
      onNull: () => jni.PropertyFactory.fillSortKey(null),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  set filter(Expression expression) => using((arena) {
    final jFilter = expression.toJExpression(arena)?..releasedBy(arena);
    if (jFilter != null) jLayer.setFilter(jFilter);
  });
}
