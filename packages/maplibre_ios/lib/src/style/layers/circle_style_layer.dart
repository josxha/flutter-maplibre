part of 'style_layer.dart';

/// iOS implementation of [CircleStyleLayer].
class CircleStyleLayerIos extends StyleLayerIos<MLNCircleStyleLayer>
    implements CircleStyleLayer {
  /// Default constructor for a [CircleStyleLayerIos] instance.
  factory CircleStyleLayerIos({
    required String id,
    required String sourceId,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<double> blur,
    required PropertyValue<Color> color,
    required Expression? filter,
    required PropertyValue<double> opacity,
    required PropertyValue<ReferenceSpace> pitchAlignment,
    required PropertyValue<ReferenceSpace> pitchScale,
    required PropertyValue<double> radius,
    required PropertyValue<double>? sortKey,
    required String? sourceLayerId,
    required PropertyValue<Color> strokeColor,
    required PropertyValue<double> strokeOpacity,
    required PropertyValue<double> strokeWidth,
    required PropertyValue<Offset> translate,
    required PropertyValue<ReferenceSpace> translateAnchor,
    required bool visible,
  }) {
    final layer = CircleStyleLayerIos.fromNativeLayer(
      MLNCircleStyleLayer.new$()..initWithIdentifier(
        id.toNSString(),
        source: MLNSource()..initWithIdentifier(sourceId.toNSString()),
      ),
    );
    layer.minZoom = minZoom;
    layer.maxZoom = maxZoom;
    layer.blur = blur;
    layer.color = color;
    if (filter != null) layer.filter = filter;
    layer.opacity = opacity;
    layer.pitchAlignment = pitchAlignment;
    layer.pitchScale = pitchScale;
    layer.radius = radius;
    layer.sortKey = sortKey;
    layer.sourceLayerId = sourceLayerId;
    layer.strokeColor = strokeColor;
    layer.strokeOpacity = strokeOpacity;
    layer.strokeWidth = strokeWidth;
    layer.translate = translate;
    layer.translateAnchor = translateAnchor;
    layer.visible = visible;
    if (sourceLayerId != null) {
      layer.ffiLayer.sourceLayerIdentifier = sourceLayerId.toNSString();
    }
    return layer;
  }

  /// Construct a [CircleStyleLayerIos] from a ObjC layer.
  CircleStyleLayerIos.fromNativeLayer(super.ffiLayer) : super.fromNativeLayer();

  @override
  PropertyValue<double> get blur {
    throw UnimplementedError();
  }

  @override
  set blur(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.circleBlur = property.expression.toNSExpression()!;
    } else {
      ffiLayer.circleBlur = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<Color> get color {
    throw UnimplementedError();
  }

  @override
  set color(PropertyValue<Color> property) {
    if (property.isExpression) {
      ffiLayer.circleColor = property.expression.toNSExpression()!;
    } else {
      ffiLayer.circleColor = NSExpression.expressionForConstantValue(
        property.value.toUIColor(),
      );
    }
  }

  @override
  Expression? get filter {
    throw UnimplementedError();
  }

  @override
  set filter(Expression expression) {
    ffiLayer.predicate = expression.toNSPredicate();
  }

  @override
  PropertyValue<double> get opacity {
    throw UnimplementedError();
  }

  @override
  set opacity(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.circleOpacity = property.expression.toNSExpression()!;
    } else {
      ffiLayer.circleOpacity = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<ReferenceSpace> get pitchAlignment {
    throw UnimplementedError();
  }

  @override
  set pitchAlignment(PropertyValue<ReferenceSpace> property) {
    if (property.isExpression) {
      ffiLayer.circlePitchAlignment = property.expression.toNSExpression()!;
    } else {
      ffiLayer.circlePitchAlignment = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<ReferenceSpace> get pitchScale {
    throw UnimplementedError();
  }

  @override
  set pitchScale(PropertyValue<ReferenceSpace> property) {
    if (property.isExpression) {
      ffiLayer.circlePitchScale = property.expression.toNSExpression()!;
    } else {
      ffiLayer.circlePitchScale = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<double> get radius {
    throw UnimplementedError();
  }

  @override
  set radius(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.circleRadius = property.expression.toNSExpression()!;
    } else {
      ffiLayer.circleRadius = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double>? get sortKey {
    throw UnimplementedError();
  }

  @override
  set sortKey(PropertyValue<double>? property) {
    if (property == null) {
      ffiLayer.circleSortKey = NSExpression.expressionForConstantValue(null);
    } else if (property.isExpression) {
      ffiLayer.circleSortKey = property.expression.toNSExpression()!;
    } else {
      ffiLayer.circleSortKey = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  String? get sourceLayerId => ffiLayer.sourceLayerIdentifier?.toDartString();

  @override
  set sourceLayerId(String? property) {
    ffiLayer.sourceLayerIdentifier = property?.toNSString();
  }

  @override
  PropertyValue<Color> get strokeColor {
    throw UnimplementedError();
  }

  @override
  set strokeColor(PropertyValue<Color> property) {
    if (property.isExpression) {
      ffiLayer.circleStrokeColor = property.expression.toNSExpression()!;
    } else {
      ffiLayer.circleStrokeColor = NSExpression.expressionForConstantValue(
        property.value.toUIColor(),
      );
    }
  }

  @override
  PropertyValue<double> get strokeOpacity {
    throw UnimplementedError();
  }

  @override
  set strokeOpacity(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.circleStrokeOpacity = property.expression.toNSExpression()!;
    } else {
      ffiLayer.circleStrokeOpacity = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double> get strokeWidth {
    throw UnimplementedError();
  }

  @override
  set strokeWidth(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.circleStrokeWidth = property.expression.toNSExpression()!;
    } else {
      ffiLayer.circleStrokeWidth = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<Offset> get translate {
    throw UnimplementedError();
  }

  @override
  set translate(PropertyValue<Offset> property) {
    if (property.isExpression) {
      ffiLayer.circleTranslate = property.expression.toNSExpression()!;
    } else {
      ffiLayer.circleTranslate = NSExpression.expressionForConstantValue(
        [property.value.dx, property.value.dy].toNSArray(),
      );
    }
  }

  @override
  PropertyValue<ReferenceSpace> get translateAnchor {
    throw UnimplementedError();
  }

  @override
  set translateAnchor(PropertyValue<ReferenceSpace> property) {
    if (property.isExpression) {
      ffiLayer.circleTranslateAnchor = property.expression.toNSExpression()!;
    } else {
      ffiLayer.circleTranslateAnchor = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  String get sourceId => ffiLayer.sourceIdentifier!.toDartString();
}
