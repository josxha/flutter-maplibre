part of 'style_layer.dart';

/// iOS implementation of [FillExtrusionStyleLayer].
class FillExtrusionStyleLayerIos
    extends StyleLayerIos<MLNFillExtrusionStyleLayer>
    implements FillExtrusionStyleLayer {
  /// Default constructor for a [FillExtrusionStyleLayerIos] instance.
  factory FillExtrusionStyleLayerIos({
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
  }) {
    final layer = FillExtrusionStyleLayerIos.fromNativeLayer(
      MLNFillExtrusionStyleLayer.new$()..initWithIdentifier(
        id.toNSString(),
        source: MLNSource()..initWithIdentifier(sourceId.toNSString()),
      ),
    );

    layer.minZoom = minZoom;
    layer.maxZoom = maxZoom;
    layer.visible = visible;
    if (filter != null) layer.filter = filter;
    if (sourceLayerId != null) layer.sourceLayerId = sourceLayerId;
    layer.opacity = opacity;
    layer.color = color;
    if (pattern != null) layer.pattern = pattern;
    layer.height = height;
    layer.base = base;
    layer.verticalGradient = verticalGradient;
    layer.translate = translate;
    layer.translateAnchor = translateAnchor;
    return layer;
  }

  /// Construct a [FillExtrusionStyleLayerIos] from a ObjC layer.
  FillExtrusionStyleLayerIos.fromNativeLayer(super.ffiLayer)
    : super.fromNativeLayer();

  @override
  PropertyValue<double> get opacity =>
      ffiLayer.fillExtrusionOpacity.toPropertyValue() ??
      FillExtrusionStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.fillExtrusionOpacity = property.expression.toNSExpression();
    } else {
      ffiLayer.fillExtrusionOpacity = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<Color> get color =>
      ffiLayer.fillExtrusionColor.toColorPropertyValue() ??
      FillExtrusionStyleLayer.defaultColor;

  @override
  set color(PropertyValue<Color> property) {
    if (property.isExpression) {
      ffiLayer.fillExtrusionColor = property.expression.toNSExpression();
    } else {
      ffiLayer.fillExtrusionColor = NSExpression.expressionForConstantValue(
        property.value.toUIColor(),
      );
    }
  }

  @override
  PropertyValue<String>? get pattern =>
      ffiLayer.fillExtrusionPattern.toPropertyValue();

  @override
  set pattern(PropertyValue<String>? property) {
    if (property == null) {
      throw UnsupportedError(
        'Removing the pattern property is not supported on iOS',
      );
    } else if (property.isExpression) {
      ffiLayer.fillExtrusionPattern = property.expression.toNSExpression();
    } else {
      ffiLayer.fillExtrusionPattern = NSExpression.expressionForConstantValue(
        property.value.toNSString(),
      );
    }
  }

  @override
  PropertyValue<double> get height =>
      ffiLayer.fillExtrusionHeight.toPropertyValue() ??
      FillExtrusionStyleLayer.defaultHeight;

  @override
  set height(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.fillExtrusionHeight = property.expression.toNSExpression();
    } else {
      ffiLayer.fillExtrusionHeight = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double> get base =>
      ffiLayer.fillExtrusionBase.toPropertyValue() ??
      FillExtrusionStyleLayer.defaultBase;

  @override
  set base(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.fillExtrusionBase = property.expression.toNSExpression();
    } else {
      ffiLayer.fillExtrusionBase = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<bool> get verticalGradient =>
      ffiLayer.fillExtrusionHasVerticalGradient.toPropertyValue() ??
      FillExtrusionStyleLayer.defaultVerticalGradient;

  @override
  set verticalGradient(PropertyValue<bool> property) {
    if (property.isExpression) {
      ffiLayer.fillExtrusionHasVerticalGradient = property.expression
          .toNSExpression();
    } else {
      ffiLayer.fillExtrusionHasVerticalGradient =
          NSExpression.expressionForConstantValue(property.value.toNSNumber());
    }
  }

  @override
  PropertyValue<Offset> get translate =>
      ffiLayer.fillExtrusionTranslation.toOffsetPropertyValue() ??
      StyleLayerWithTranslate.defaultTranslate;

  @override
  set translate(PropertyValue<Offset> property) {
    if (property.isExpression) {
      ffiLayer.fillExtrusionTranslation = property.expression.toNSExpression();
    } else {
      ffiLayer.fillExtrusionTranslation =
          NSExpression.expressionForConstantValue(
            [property.value.dx, property.value.dy].toNSArray(),
          );
    }
  }

  @override
  PropertyValue<ReferenceSpace> get translateAnchor =>
      ffiLayer.fillExtrusionTranslationAnchor.toEnumPropertyValue(
        ReferenceSpace.values,
      ) ??
      StyleLayerWithTranslate.defaultTranslateAnchor;

  @override
  set translateAnchor(PropertyValue<ReferenceSpace> property) {
    if (property.isExpression) {
      ffiLayer.fillExtrusionTranslationAnchor = property.expression
          .toNSExpression();
    } else {
      ffiLayer.fillExtrusionTranslationAnchor =
          NSExpression.expressionForConstantValue(
            property.value.name.toNSString(),
          );
    }
  }

  @override
  Expression? get filter => ffiLayer.predicate?.toExpression();

  @override
  set filter(Expression expression) {
    ffiLayer.predicate = expression.toNSPredicate();
  }

  @override
  String? get sourceLayerId => ffiLayer.sourceLayerIdentifier?.toDartString();

  @override
  set sourceLayerId(String? value) {
    ffiLayer.sourceLayerIdentifier = value?.toNSString();
  }

  @override
  String get sourceId => ffiLayer.sourceIdentifier!.toDartString();
}
