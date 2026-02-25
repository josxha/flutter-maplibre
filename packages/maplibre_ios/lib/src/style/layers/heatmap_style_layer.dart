part of 'style_layer.dart';

/// iOS implementation of [HeatmapStyleLayer].
class HeatmapStyleLayerIos extends StyleLayerIos<MLNHeatmapStyleLayer>
    implements HeatmapStyleLayer {
  /// Default constructor for a [HeatmapStyleLayerIos] instance.
  factory HeatmapStyleLayerIos({
    required String id,
    required String sourceId,
    required String? sourceLayerId,
    required Expression? filter,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<double> radius,
    required PropertyValue<double> weight,
    required PropertyValue<double> intensity,
    required PropertyValue<Color>? color,
    required PropertyValue<double> opacity,
  }) {
    final layer = HeatmapStyleLayerIos.fromNativeLayer(
      MLNHeatmapStyleLayer.new$()..initWithIdentifier(
        id.toNSString(),
        source: MLNSource()..initWithIdentifier(sourceId.toNSString()),
      ),
    );

    layer.minZoom = minZoom;
    layer.maxZoom = maxZoom;
    layer.visible = visible;
    layer.radius = radius;
    layer.weight = weight;
    layer.intensity = intensity;
    layer.color = color;
    layer.opacity = opacity;
    if (filter != null) layer.filter = filter;
    if (sourceLayerId != null) layer.sourceLayerId = sourceLayerId;
    return layer;
  }

  /// Construct a [HeatmapStyleLayerIos] from a ObjC layer.
  HeatmapStyleLayerIos.fromNativeLayer(super.ffiLayer)
    : super.fromNativeLayer();

  @override
  PropertyValue<double> get radius =>
      ffiLayer.heatmapRadius.toPropertyValue() ??
      HeatmapStyleLayer.defaultRadius;

  @override
  set radius(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.heatmapRadius = property.expression.toNSExpression();
    } else {
      ffiLayer.heatmapRadius = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double> get weight =>
      ffiLayer.heatmapWeight.toPropertyValue() ??
      HeatmapStyleLayer.defaultWeight;

  @override
  set weight(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.heatmapWeight = property.expression.toNSExpression();
    } else {
      ffiLayer.heatmapWeight = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double> get intensity =>
      ffiLayer.heatmapIntensity.toPropertyValue() ??
      HeatmapStyleLayer.defaultIntensity;

  @override
  set intensity(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.heatmapIntensity = property.expression.toNSExpression();
    } else {
      ffiLayer.heatmapIntensity = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<Color>? get color =>
      ffiLayer.heatmapColor.toColorPropertyValue();

  @override
  set color(PropertyValue<Color>? property) {
    if (property == null) {
      ffiLayer.heatmapColor = NSExpression.expressionForConstantValue(null);
    } else if (property.isExpression) {
      ffiLayer.heatmapColor = property.expression.toNSExpression();
    } else {
      ffiLayer.heatmapColor = NSExpression.expressionForConstantValue(
        property.value.toUIColor(),
      );
    }
  }

  @override
  PropertyValue<double> get opacity =>
      ffiLayer.heatmapOpacity.toPropertyValue() ??
      HeatmapStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.heatmapOpacity = property.expression.toNSExpression();
    } else {
      ffiLayer.heatmapOpacity = NSExpression.expressionForConstantValue(
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
