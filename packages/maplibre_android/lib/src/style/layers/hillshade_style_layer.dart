part of 'style_layer.dart';

/// Android implementation of [HillshadeStyleLayer].
class HillshadeStyleLayerAndroid extends StyleLayerAndroid<jni.HillshadeLayer>
    implements HillshadeStyleLayer {
  /// Factory for a [HillshadeStyleLayerAndroid] instance.
  factory HillshadeStyleLayerAndroid({
    required String id,
    required String sourceId,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<NumberArray> illuminationDirection,
    // required PropertyValue<NumberArray> illuminationAltitude,
    required PropertyValue<IlluminationAnchor> illuminationAnchor,
    required PropertyValue<double> exaggeration,
    required PropertyValue<Color> shadowColor,
    required PropertyValue<Color> highlightColor,
    required PropertyValue<Color> accentColor,
    // required PropertyValue<HillshadeMethod> method,
  }) => using((arena) {
    final layer = HillshadeStyleLayerAndroid.fromNativeLayer(
      jni.HillshadeLayer(
        id.toJString()..releasedBy(arena),
        sourceId.toJString()..releasedBy(arena),
      ),
    );
    layer.minZoom = minZoom;
    layer.maxZoom = maxZoom;
    layer.visible = visible;
    layer.illuminationDirection = illuminationDirection;
    // layer.illuminationAltitude = illuminationAltitude;
    layer.illuminationAnchor = illuminationAnchor;
    layer.exaggeration = exaggeration;
    layer.shadowColor = shadowColor;
    layer.highlightColor = highlightColor;
    layer.accentColor = accentColor;
    // layer.method = method;
    return layer;
  });

  /// Construct a [HillshadeStyleLayerAndroid] from a JNI layer.
  HillshadeStyleLayerAndroid.fromNativeLayer(super.jLayer)
    : super.fromNativeLayer();

  @override
  PropertyValue<NumberArray> get illuminationDirection => using((arena) {
    final jProperty = jLayer.getHillshadeIlluminationDirection();
    if (jProperty.isNull$1()) {
      return HillshadeStyleLayer.defaultIlluminationDirection;
    }
    if (jProperty.isExpression()) {
      final jExpression = jProperty.getExpression()!..releasedBy(arena);
      final expression = jExpression.toDart(releaseOriginal: true);
      return PropertyValue.expression(expression);
    }
    final jValue = jProperty.getValue()?..releasedBy(arena);
    if (jValue == null) {
      return HillshadeStyleLayer.defaultIlluminationDirection;
    }
    final value = jValue.floatValue(releaseOriginal: true);
    return PropertyValue.value(NumberArray.number(value));
  });

  @override
  set illuminationDirection(PropertyValue<NumberArray> property) => using((
    arena,
  ) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.hillshadeIlluminationDirection$1,
      onValue: (value) {
        if (value.isArray) {
          final expression = Expression.literal(value.array);
          final jExpr = expression.toJExpression(arena);
          return jni.PropertyFactory.hillshadeIlluminationDirection$1(jExpr);
        } else {
          final jFloat = value.number.toJFloat();
          return jni.PropertyFactory.hillshadeIlluminationDirection(jFloat);
        }
      },
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<NumberArray> get illuminationAltitude => throw UnsupportedError(
    'Getting illuminationAltitude is not supported on Android '
    'https://github.com/maplibre/maplibre-native/issues/3396',
  );

  @override
  set illuminationAltitude(PropertyValue<NumberArray> value) {
    throw UnsupportedError(
      'Setting illuminationAltitude is not supported on Android '
      'https://github.com/maplibre/maplibre-native/issues/3396',
    );
  }

  @override
  PropertyValue<IlluminationAnchor> get illuminationAnchor =>
      jLayer.getHillshadeIlluminationAnchor().toDartEnum(
        values: IlluminationAnchor.values,
        releaseOriginal: true,
      ) ??
      HillshadeStyleLayer.defaultIlluminationAnchor;

  @override
  set illuminationAnchor(PropertyValue<IlluminationAnchor> value) =>
      using((arena) {
        final jProperty = value.apply(
          arena: arena,
          onExpression: jni.PropertyFactory.hillshadeIlluminationAnchor$1,
          onValue: (value) => jni.PropertyFactory.hillshadeIlluminationAnchor(
            value.name.toJString()..releasedBy(arena),
          ),
        );
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<double> get exaggeration =>
      jLayer.getHillshadeExaggeration().toDart(releaseOriginal: true) ??
      HillshadeStyleLayer.defaultExaggeration;

  @override
  set exaggeration(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.hillshadeExaggeration$1,
      onValue: (value) => jni.PropertyFactory.hillshadeExaggeration(
        value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get shadowColor =>
      jLayer.getHillshadeShadowColor().toDartColor(releaseOriginal: true) ??
      HillshadeStyleLayer.defaultShadowColor;

  @override
  set shadowColor(PropertyValue<Color> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.hillshadeShadowColor$2,
      onValue: (value) => jni.PropertyFactory.hillshadeShadowColor$1(
        value.toHexString().toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get highlightColor =>
      jLayer.getHillshadeHighlightColor().toDartColor(releaseOriginal: true) ??
      HillshadeStyleLayer.defaultHighlightColor;

  @override
  set highlightColor(PropertyValue<Color> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.hillshadeHighlightColor$2,
      onValue: (value) => jni.PropertyFactory.hillshadeHighlightColor$1(
        value.toHexString().toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get accentColor =>
      jLayer.getHillshadeAccentColor().toDartColor(releaseOriginal: true) ??
      HillshadeStyleLayer.defaultAccentColor;

  @override
  set accentColor(PropertyValue<Color> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.hillshadeAccentColor$2,
      onValue: (value) => jni.PropertyFactory.hillshadeAccentColor$1(
        value.toHexString().toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<HillshadeMethod> get method => throw UnsupportedError(
    'Getting method is not supported on Android '
    'https://github.com/maplibre/maplibre-native/issues/3396',
  );

  @override
  set method(PropertyValue<HillshadeMethod> value) {
    throw UnsupportedError(
      'Setting method is not supported on Android '
      'https://github.com/maplibre/maplibre-native/issues/3396',
    );
  }

  @override
  String get sourceId =>
      jLayer.getSourceId().toDartString(releaseOriginal: true);
}
