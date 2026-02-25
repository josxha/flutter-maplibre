part of 'style_layer.dart';

/// iOS implementation of [FillStyleLayer].
class FillStyleLayerIos extends StyleLayerIos<MLNFillStyleLayer>
    implements FillStyleLayer {
  /// Default constructor for a [FillStyleLayerIos] instance.
  factory FillStyleLayerIos({
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
    required PropertyValue<bool> antialias,
    required PropertyValue<Color> color,
    required PropertyValue<double> opacity,
    required PropertyValue<Color> outlineColor,
    required PropertyValue<String>? pattern,
  }) {
    final layer = FillStyleLayerIos.fromNativeLayer(
      MLNFillStyleLayer.new$()..initWithIdentifier(
        id.toNSString(),
        source: MLNSource()..initWithIdentifier(sourceId.toNSString()),
      ),
    );

    layer.minZoom = minZoom;
    layer.maxZoom = maxZoom;
    layer.visible = visible;
    if (filter != null) layer.filter = filter;
    if (sourceLayerId != null) layer.sourceLayerId = sourceLayerId;
    if (sortKey != null) layer.sortKey = sortKey;
    layer.translate = translate;
    layer.translateAnchor = translateAnchor;
    layer.antialias = antialias;
    layer.color = color;
    layer.opacity = opacity;
    layer.outlineColor = outlineColor;
    layer.pattern = pattern;
    return layer;
  }

  /// Construct a [FillStyleLayerIos] from a ObjC layer.
  FillStyleLayerIos.fromNativeLayer(super.ffiLayer) : super.fromNativeLayer();

  @override
  PropertyValue<bool> get antialias =>
      ffiLayer.fillAntialias.toPropertyValue() ??
      FillStyleLayer.defaultAntialias;

  @override
  set antialias(PropertyValue<bool> property) {
    if (property.isExpression) {
      ffiLayer.fillAntialias = property.expression.toNSExpression();
    } else {
      ffiLayer.fillAntialias = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<Color> get color =>
      ffiLayer.fillColor.toColorPropertyValue() ?? FillStyleLayer.defaultColor;

  @override
  set color(PropertyValue<Color> property) {
    if (property.isExpression) {
      ffiLayer.fillColor = property.expression.toNSExpression();
    } else {
      ffiLayer.fillColor = NSExpression.expressionForConstantValue(
        property.value.toUIColor(),
      );
    }
  }

  @override
  PropertyValue<double> get opacity =>
      ffiLayer.fillOpacity.toPropertyValue() ?? FillStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.fillOpacity = property.expression.toNSExpression();
    } else {
      ffiLayer.fillOpacity = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<Color> get outlineColor =>
      ffiLayer.fillOutlineColor.toColorPropertyValue() ??
      FillStyleLayer.defaultOutlineColor;

  @override
  set outlineColor(PropertyValue<Color> property) {
    if (property.isExpression) {
      ffiLayer.fillOutlineColor = property.expression.toNSExpression();
    } else {
      ffiLayer.fillOutlineColor = NSExpression.expressionForConstantValue(
        property.value.toUIColor(),
      );
    }
  }

  @override
  PropertyValue<String>? get pattern => ffiLayer.fillPattern.toPropertyValue();

  @override
  set pattern(PropertyValue<String>? property) {
    if (property == null) {
      ffiLayer.fillPattern = NSExpression.expressionForConstantValue(null);
    } else if (property.isExpression) {
      ffiLayer.fillPattern = property.expression.toNSExpression();
    } else {
      ffiLayer.fillPattern = NSExpression.expressionForConstantValue(
        property.value.toNSString(),
      );
    }
  }

  @override
  PropertyValue<Offset> get translate =>
      ffiLayer.fillTranslation.toOffsetPropertyValue() ??
      StyleLayerWithTranslate.defaultTranslate;

  @override
  set translate(PropertyValue<Offset> property) {
    if (property.isExpression) {
      ffiLayer.fillTranslation = property.expression.toNSExpression();
    } else {
      ffiLayer.fillTranslation = NSExpression.expressionForConstantValue(
        [property.value.dx, property.value.dy].toNSArray(),
      );
    }
  }

  @override
  PropertyValue<ReferenceSpace> get translateAnchor =>
      ffiLayer.fillTranslationAnchor.toEnumPropertyValue(
        ReferenceSpace.values,
      ) ??
      StyleLayerWithTranslate.defaultTranslateAnchor;

  @override
  set translateAnchor(PropertyValue<ReferenceSpace> property) {
    if (property.isExpression) {
      ffiLayer.fillTranslationAnchor = property.expression.toNSExpression();
    } else {
      ffiLayer.fillTranslationAnchor = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<double>? get sortKey => ffiLayer.fillSortKey.toPropertyValue();

  @override
  set sortKey(PropertyValue<double>? property) {
    if (property == null) {
      ffiLayer.fillSortKey = NSExpression.expressionForConstantValue(null);
    } else if (property.isExpression) {
      ffiLayer.fillSortKey = property.expression.toNSExpression();
    } else {
      ffiLayer.fillSortKey = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
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
