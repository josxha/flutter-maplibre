part of 'style_layer.dart';

/// iOS implementation of [HillshadeStyleLayer].
class HillshadeStyleLayerIos extends StyleLayerIos<MLNHillshadeStyleLayer>
    implements HillshadeStyleLayer {
  /// Default constructor for a [HillshadeStyleLayerIos] instance.
  factory HillshadeStyleLayerIos({
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
  }) {
    final layer = HillshadeStyleLayerIos.fromNativeLayer(
      MLNHillshadeStyleLayer.new$()..initWithIdentifier(
        id.toNSString(),
        source: MLNSource()..initWithIdentifier(sourceId.toNSString()),
      ),
    );

    layer.minZoom = minZoom;
    layer.maxZoom = maxZoom;
    layer.visible = visible;
    layer.illuminationDirection = illuminationDirection;
    layer.illuminationAnchor = illuminationAnchor;
    layer.exaggeration = exaggeration;
    layer.shadowColor = shadowColor;
    layer.highlightColor = highlightColor;
    layer.accentColor = accentColor;
    return layer;
  }

  /// Construct a [HillshadeStyleLayerIos] from a ObjC layer.
  HillshadeStyleLayerIos.fromNativeLayer(super.ffiLayer)
    : super.fromNativeLayer();

  @override
  PropertyValue<NumberArray> get illuminationDirection {
    final expression = ffiLayer.hillshadeIlluminationDirection;
    if (expression.expressionType ==
        NSExpressionType.NSConstantValueExpressionType) {
      final value = expression.constantValue;
      if (value == null) {
        return HillshadeStyleLayer.defaultIlluminationDirection;
      }
      if (NSArray.isA(value)) {
        final nsArray = NSArray.as(value);
        final list = List.generate(
          nsArray.count,
          growable: false,
          (index) =>
              NSNumber.as(nsArray.objectAtIndex(index)).numValue.toDouble(),
        );
        return PropertyValue.value(NumberArray.array(list));
      } else {
        final number = NSNumber.as(value).numValue.toDouble();
        return PropertyValue.value(NumberArray.number(number));
      }
    }
    return expression.toPropertyValue() ??
        HillshadeStyleLayer.defaultIlluminationDirection;
  }

  @override
  set illuminationDirection(PropertyValue<NumberArray> property) {
    if (property.isExpression) {
      ffiLayer.hillshadeIlluminationDirection = property.expression
          .toNSExpression();
    } else {
      final value = property.value;
      final nsValue = value.isArray
          ? value.array.map((e) => e.toNSNumber()).toNSObject()
          : value.number.toNSNumber();
      ffiLayer.hillshadeIlluminationDirection =
          NSExpression.expressionForConstantValue(nsValue);
    }
  }

  @override
  PropertyValue<NumberArray> get illuminationAltitude => throw UnsupportedError(
    'Getting illuminationAltitude is not supported on iOS '
    'https://github.com/maplibre/maplibre-native/issues/3396',
  );

  @override
  set illuminationAltitude(PropertyValue<NumberArray> property) {
    throw UnsupportedError(
      'Setting illuminationAltitude is not supported on iOS '
      'https://github.com/maplibre/maplibre-native/issues/3396',
    );
  }

  @override
  PropertyValue<IlluminationAnchor> get illuminationAnchor =>
      ffiLayer.hillshadeIlluminationAnchor.toEnumPropertyValue(
        IlluminationAnchor.values,
      ) ??
      HillshadeStyleLayer.defaultIlluminationAnchor;

  @override
  set illuminationAnchor(PropertyValue<IlluminationAnchor> property) {
    if (property.isExpression) {
      ffiLayer.hillshadeIlluminationAnchor = property.expression
          .toNSExpression();
    } else {
      ffiLayer.hillshadeIlluminationAnchor =
          NSExpression.expressionForConstantValue(
            property.value.name.toNSString(),
          );
    }
  }

  @override
  PropertyValue<double> get exaggeration =>
      ffiLayer.hillshadeExaggeration.toPropertyValue() ??
      HillshadeStyleLayer.defaultExaggeration;

  @override
  set exaggeration(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.hillshadeExaggeration = property.expression.toNSExpression();
    } else {
      ffiLayer.hillshadeExaggeration = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<Color> get shadowColor =>
      ffiLayer.hillshadeShadowColor.toColorPropertyValue() ??
      HillshadeStyleLayer.defaultShadowColor;

  @override
  set shadowColor(PropertyValue<Color> property) {
    if (property.isExpression) {
      ffiLayer.hillshadeShadowColor = property.expression.toNSExpression();
    } else {
      ffiLayer.hillshadeShadowColor = NSExpression.expressionForConstantValue(
        property.value.toUIColor(),
      );
    }
  }

  @override
  PropertyValue<Color> get highlightColor =>
      ffiLayer.hillshadeHighlightColor.toColorPropertyValue() ??
      HillshadeStyleLayer.defaultHighlightColor;

  @override
  set highlightColor(PropertyValue<Color> property) {
    if (property.isExpression) {
      ffiLayer.hillshadeHighlightColor = property.expression.toNSExpression();
    } else {
      ffiLayer.hillshadeHighlightColor =
          NSExpression.expressionForConstantValue(property.value.toUIColor());
    }
  }

  @override
  PropertyValue<Color> get accentColor =>
      ffiLayer.hillshadeAccentColor.toColorPropertyValue() ??
      HillshadeStyleLayer.defaultAccentColor;

  @override
  set accentColor(PropertyValue<Color> property) {
    if (property.isExpression) {
      ffiLayer.hillshadeAccentColor = property.expression.toNSExpression();
    } else {
      ffiLayer.hillshadeAccentColor = NSExpression.expressionForConstantValue(
        property.value.toUIColor(),
      );
    }
  }

  @override
  PropertyValue<HillshadeMethod> get method => throw UnsupportedError(
    'Getting method is not supported on iOS '
    'https://github.com/maplibre/maplibre-native/issues/3396',
  );

  @override
  set method(PropertyValue<HillshadeMethod> property) {
    throw UnsupportedError(
      'Setting method is not supported on iOS '
      'https://github.com/maplibre/maplibre-native/issues/3396',
    );
  }

  @override
  String get sourceId => ffiLayer.sourceIdentifier!.toDartString();
}
