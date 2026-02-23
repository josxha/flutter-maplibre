part of 'style_layer.dart';

/// Android implementation of [LineStyleLayer].
class LineStyleLayerAndroid extends StyleLayerAndroid<jni.LineLayer>
    implements LineStyleLayer {
  /// Factory for a [LineStyleLayerAndroid] instance.
  factory LineStyleLayerAndroid({
    required String id,
    required String sourceId,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required String? sourceLayerId,
    required Expression? filter,
    required PropertyValue<double>? sortKey,
    required PropertyValue<Offset> translate,
    required PropertyValue<ReferenceSpace> translateAnchor,
    required PropertyValue<LineCap> cap,
    required PropertyValue<LineJoin> join,
    required PropertyValue<double> miterLimit,
    required PropertyValue<double> roundLimit,
    required PropertyValue<double> opacity,
    required PropertyValue<Color> color,
    required PropertyValue<double> width,
    required PropertyValue<double> gapWidth,
    required PropertyValue<double> offset,
    required PropertyValue<double> blur,
    required PropertyValue<List<double>>? dashArray,
    required PropertyValue<String>? pattern,
    required PropertyValue<Color>? gradient,
  }) => using((arena) {
    final layer = LineStyleLayerAndroid.fromNativeLayer(
      jni.LineLayer(
        id.toJString()..releasedBy(arena),
        sourceId.toJString()..releasedBy(arena),
      ),
    );
    layer.minZoom = minZoom;
    layer.maxZoom = maxZoom;
    layer.visible = visible;
    if (filter != null) layer.filter = filter;
    layer.sortKey = sortKey;
    layer.translate = translate;
    layer.translateAnchor = translateAnchor;
    layer.cap = cap;
    layer.join = join;
    layer.miterLimit = miterLimit;
    layer.roundLimit = roundLimit;
    layer.opacity = opacity;
    layer.color = color;
    layer.width = width;
    layer.gapWidth = gapWidth;
    layer.offset = offset;
    layer.blur = blur;
    layer.dashArray = dashArray;
    layer.pattern = pattern;
    layer.gradient = gradient;
    if (sourceLayerId != null) layer.sourceLayerId = sourceLayerId;
    return layer;
  });

  /// Construct a [LineStyleLayerAndroid] from a JNI layer.
  LineStyleLayerAndroid.fromNativeLayer(super.jLayer) : super.fromNativeLayer();

  @override
  PropertyValue<LineCap> get cap =>
      jLayer.getLineCap().toDartEnum(
        values: LineCap.values,
        releaseOriginal: true,
      ) ??
      LineStyleLayer.defaultCap;

  @override
  set cap(PropertyValue<LineCap> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.lineCap$1,
      onValue: (value) => jni.PropertyFactory.lineCap(
        value.name.toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<LineJoin> get join =>
      jLayer.getLineJoin().toDartEnum(
        values: LineJoin.values,
        releaseOriginal: true,
      ) ??
      LineStyleLayer.defaultJoin;

  @override
  set join(PropertyValue<LineJoin> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.lineJoin$1,
      onValue: (value) => jni.PropertyFactory.lineJoin(
        value.name.toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get miterLimit =>
      jLayer.getLineMiterLimit().toDart(releaseOriginal: true) ??
      LineStyleLayer.defaultMiterLimit;

  @override
  set miterLimit(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.lineMiterLimit$1,
      onValue: (value) => jni.PropertyFactory.lineMiterLimit(
        value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get roundLimit =>
      jLayer.getLineRoundLimit().toDart(releaseOriginal: true) ??
      LineStyleLayer.defaultRoundLimit;

  @override
  set roundLimit(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.lineRoundLimit$1,
      onValue: (value) => jni.PropertyFactory.lineRoundLimit(
        value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get opacity =>
      jLayer.getLineOpacity().toDart(releaseOriginal: true) ??
      LineStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.lineOpacity$1,
      onValue: (value) =>
          jni.PropertyFactory.lineOpacity(value.toJFloat()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get color =>
      jLayer.getLineColor().toDartColor(releaseOriginal: true) ??
      LineStyleLayer.defaultColor;

  @override
  set color(PropertyValue<Color> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.lineColor$2,
      onValue: (value) => jni.PropertyFactory.lineColor$1(
        value.toHexString().toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get width =>
      jLayer.getLineWidth().toDart(releaseOriginal: true) ??
      LineStyleLayer.defaultWidth;

  @override
  set width(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.lineWidth$1,
      onValue: (value) =>
          jni.PropertyFactory.lineWidth(value.toJFloat()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get gapWidth =>
      jLayer.getLineGapWidth().toDart(releaseOriginal: true) ??
      LineStyleLayer.defaultGapWidth;

  @override
  set gapWidth(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.lineGapWidth$1,
      onValue: (value) =>
          jni.PropertyFactory.lineGapWidth(value.toJFloat()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get offset =>
      jLayer.getLineOffset().toDart(releaseOriginal: true) ??
      LineStyleLayer.defaultOffset;

  @override
  set offset(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.lineOffset$1,
      onValue: (value) =>
          jni.PropertyFactory.lineOffset(value.toJFloat()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get blur =>
      jLayer.getLineBlur().toDart(releaseOriginal: true) ??
      LineStyleLayer.defaultBlur;

  @override
  set blur(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.lineBlur$1,
      onValue: (value) =>
          jni.PropertyFactory.lineBlur(value.toJFloat()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<List<double>>? get dashArray =>
      jLayer.getLineDasharray().toDartDoubleList(releaseOriginal: true);

  @override
  set dashArray(PropertyValue<List<double>>? property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.lineDasharray$1,
      onValue: (value) {
        final jArray = value.toJFloatArray(arena);
        return jni.PropertyFactory.lineDasharray(jArray);
      },
      onNull: () => jni.PropertyFactory.lineDasharray(null),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<String>? get pattern =>
      jLayer.getLinePattern().toDart(releaseOriginal: true);

  @override
  set pattern(PropertyValue<String>? property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.linePattern$1,
      onValue: (value) =>
          jni.PropertyFactory.linePattern(value.toJString()..releasedBy(arena)),
      onNull: () => jni.PropertyFactory.linePattern(null),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color>? get gradient =>
      jLayer.getLineGradient().toDartColor(releaseOriginal: true);

  @override
  set gradient(PropertyValue<Color>? property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.lineGradient$2,
      onValue: (value) => jni.PropertyFactory.lineGradient$1(
        value.toHexString().toJString()..releasedBy(arena),
      ),
      onNull: () => jni.PropertyFactory.lineGradient$1(null),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Offset> get translate =>
      jLayer.getLineTranslate().toDartOffset(releaseOriginal: true) ??
      StyleLayerWithTranslate.defaultTranslate;

  @override
  set translate(PropertyValue<Offset> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.lineTranslate$1,
      onValue: (value) =>
          jni.PropertyFactory.lineTranslate(value.toJFloatArray(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<ReferenceSpace> get translateAnchor =>
      jLayer.getLineTranslateAnchor().toDartReferenceSpace(
        releaseOriginal: true,
      ) ??
      StyleLayerWithTranslate.defaultTranslateAnchor;

  @override
  set translateAnchor(PropertyValue<ReferenceSpace> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.lineTranslateAnchor$1,
      onValue: (value) => jni.PropertyFactory.lineTranslateAnchor(
        value.name.toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double>? get sortKey =>
      jLayer.getLineSortKey().toDart(releaseOriginal: true);

  @override
  set sortKey(PropertyValue<double>? property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.lineSortKey$1,
      onValue: (value) =>
          jni.PropertyFactory.lineSortKey(value.toJFloat()..releasedBy(arena)),
      onNull: () => jni.PropertyFactory.lineSortKey(null),
    );
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
  set filter(Expression expression) => using((arena) {
    final jFilter = expression.toJExpression(arena)?..releasedBy(arena);
    if (jFilter != null) jLayer.setFilter(jFilter);
  });

  @override
  String get sourceId =>
      jLayer.getSourceId().toDartString(releaseOriginal: true);

  @override
  String? get sourceLayerId =>
      jLayer.getSourceLayer().toDartString(releaseOriginal: true);

  @override
  set sourceLayerId(String? value) => using((arena) {
    final jValue = value?.toJString();
    jValue?.releasedBy(arena);
    jLayer.setSourceLayer(jValue);
  });
}
