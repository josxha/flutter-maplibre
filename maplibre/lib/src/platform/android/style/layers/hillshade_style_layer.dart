part of 'style_layer.dart';

/// Android implementation of [HillshadeStyleLayer].
class HillshadeStyleLayerAndroid extends StyleLayerAndroid<jni.HillshadeLayer>
    implements HillshadeStyleLayer {
  PropertyValue<NumberArray> _illuminationAltitude =
      HillshadeStyleLayer.defaultIlluminationAltitude;
  PropertyValue<HillshadeMethod> _method = HillshadeStyleLayer.defaultMethod;
  Expression? _filter;
  String? _sourceLayerId;

  /// Factory for a [HillshadeStyleLayerAndroid] instance.
  factory HillshadeStyleLayerAndroid({
    required String id,
    required String sourceId,
    required String? sourceLayerId,
    required Expression? filter,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<NumberArray> illuminationDirection,
    required PropertyValue<NumberArray> illuminationAltitude,
    required PropertyValue<IlluminationAnchor> illuminationAnchor,
    required PropertyValue<double> exaggeration,
    required PropertyValue<Color> shadowColor,
    required PropertyValue<Color> highlightColor,
    required PropertyValue<Color> accentColor,
    required PropertyValue<HillshadeMethod> method,
  }) => using((arena) {
    final layer =
        HillshadeStyleLayerAndroid.fromNativeLayer(
            jni.HillshadeLayer(
              id.toJString()..releasedBy(arena),
              sourceId.toJString()..releasedBy(arena),
            )..releasedBy(arena),
          )
          ..minZoom = minZoom
          ..maxZoom = maxZoom
          ..visible = visible
          ..illuminationDirection = illuminationDirection
          ..illuminationAltitude = illuminationAltitude
          ..illuminationAnchor = illuminationAnchor
          ..exaggeration = exaggeration
          ..shadowColor = shadowColor
          ..highlightColor = highlightColor
          ..accentColor = accentColor
          ..method = method
          ..filter = filter;
    if (sourceLayerId != null) layer.sourceLayerId = sourceLayerId;
    return layer;
  });

  /// Construct a [HillshadeStyleLayerAndroid] from a JNI layer.
  HillshadeStyleLayerAndroid.fromNativeLayer(super.jLayer)
    : super.fromNativeLayer();

  PropertyValue<T> _enumProperty<T extends Enum>(
    jni.PropertyValue<JString?> jProperty,
    List<T> values,
    PropertyValue<T> fallback,
  ) => using((arena) {
    jProperty.releasedBy(arena);
    if (jProperty.isExpression()) {
      final jExpression = jProperty.getExpression()?..releasedBy(arena);
      final expression = jExpression?.toDart(releaseOriginal: true);
      if (expression == null) return fallback;
      return PropertyValue.expression(expression);
    }
    final jValue = jProperty.getValue();
    if (jValue == null) return fallback;
    final value = jValue.toDartString(releaseOriginal: true);
    final match = values.firstWhere(
      (v) => v.name == value,
      orElse: () => fallback.value,
    );
    return PropertyValue.value(match);
  });

  PropertyValue<NumberArray> _numberArrayFrom(
    jni.PropertyValue<JFloat?> jProperty,
    PropertyValue<NumberArray> fallback,
  ) => using((arena) {
    jProperty.releasedBy(arena);
    if (jProperty.isExpression()) {
      final jExpression = jProperty.getExpression()?..releasedBy(arena);
      final expression = jExpression?.toDart(releaseOriginal: true);
      if (expression == null) return fallback;
      return PropertyValue.expression(expression);
    }
    final jValue = jProperty.getValue();
    if (jValue == null) return fallback;
    final value = jValue.floatValue(releaseOriginal: true).toDouble();
    return PropertyValue.value(NumberArray.number(value));
  });

  double _numberArrayToDouble(NumberArray value) =>
      value.isArray ? value.array.first : value.number;

  @override
  PropertyValue<NumberArray> get illuminationDirection => _numberArrayFrom(
    jLayer.getHillshadeIlluminationDirection(),
    HillshadeStyleLayer.defaultIlluminationDirection,
  );

  @override
  set illuminationDirection(PropertyValue<NumberArray> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.hillshadeIlluminationDirection$1(
        jExpression,
      );
    } else {
      final jValue = _numberArrayToDouble(value.value).toJFloat()
        ..releasedBy(arena);
      jProperty = jni.PropertyFactory.hillshadeIlluminationDirection(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<NumberArray> get illuminationAltitude => _illuminationAltitude;

  @override
  set illuminationAltitude(PropertyValue<NumberArray> value) {
    if (value != HillshadeStyleLayer.defaultIlluminationAltitude) {
      throw UnsupportedError(
        'HillshadeStyleLayer.illuminationAltitude is not supported on Android.',
      );
    }
    _illuminationAltitude = value;
  }

  @override
  PropertyValue<IlluminationAnchor> get illuminationAnchor => _enumProperty(
    jLayer.getHillshadeIlluminationAnchor(),
    IlluminationAnchor.values,
    HillshadeStyleLayer.defaultIlluminationAnchor,
  );

  @override
  set illuminationAnchor(PropertyValue<IlluminationAnchor> value) =>
      using((arena) {
        final jni.PropertyValue? jProperty;
        if (value.isExpression) {
          final jExpression = value.expression.toJExpression(arena)
            ?..releasedBy(arena);
          jProperty = jni.PropertyFactory.hillshadeIlluminationAnchor$1(
            jExpression,
          );
        } else {
          final jValue = value.value.name.toJString()..releasedBy(arena);
          jProperty = jni.PropertyFactory.hillshadeIlluminationAnchor(jValue);
        }
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<double> get exaggeration =>
      jLayer.getHillshadeExaggeration().toDart(releaseOriginal: true) ??
      HillshadeStyleLayer.defaultExaggeration;

  @override
  set exaggeration(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.hillshadeExaggeration$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.hillshadeExaggeration(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get shadowColor =>
      jLayer.getHillshadeShadowColor().toDartColor(releaseOriginal: true) ??
      HillshadeStyleLayer.defaultShadowColor;

  @override
  set shadowColor(PropertyValue<Color> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      jProperty = jni.PropertyFactory.hillshadeShadowColor$2(
        value.expression.toJExpression(arena),
      );
    } else {
      final jValue = value.value.toHexString().toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.hillshadeShadowColor$1(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get highlightColor =>
      jLayer.getHillshadeHighlightColor().toDartColor(releaseOriginal: true) ??
      HillshadeStyleLayer.defaultHighlightColor;

  @override
  set highlightColor(PropertyValue<Color> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      jProperty = jni.PropertyFactory.hillshadeHighlightColor$2(
        value.expression.toJExpression(arena),
      );
    } else {
      final jValue = value.value.toHexString().toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.hillshadeHighlightColor$1(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get accentColor =>
      jLayer.getHillshadeAccentColor().toDartColor(releaseOriginal: true) ??
      HillshadeStyleLayer.defaultAccentColor;

  @override
  set accentColor(PropertyValue<Color> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      jProperty = jni.PropertyFactory.hillshadeAccentColor$2(
        value.expression.toJExpression(arena),
      );
    } else {
      final jValue = value.value.toHexString().toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.hillshadeAccentColor$1(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<HillshadeMethod> get method => _method;

  @override
  set method(PropertyValue<HillshadeMethod> value) {
    if (value != HillshadeStyleLayer.defaultMethod) {
      throw UnsupportedError(
        'HillshadeStyleLayer.method is not supported on Android.',
      );
    }
    _method = value;
  }

  @override
  Expression? get filter => _filter;

  @override
  set filter(Expression? expression) {
    if (expression != null) {
      throw UnsupportedError(
        'HillshadeStyleLayer.filter is not supported on Android.',
      );
    }
    _filter = null;
  }

  @override
  String get sourceId =>
      jLayer.getSourceId().toDartString(releaseOriginal: true);

  @override
  String? get sourceLayerId => _sourceLayerId;

  @override
  set sourceLayerId(String? value) => using((arena) {
    _sourceLayerId = value;
    final jValue = value?.toJString();
    jValue?.releasedBy(arena);
    jLayer.setSourceLayer(jValue);
  });
}
