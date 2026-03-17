part of 'style_layer.dart';

/// Web implementation of [HeatmapStyleLayer].
class HeatmapStyleLayerWeb extends StyleLayerWeb implements HeatmapStyleLayer {
  /// Default constructor for a [HeatmapStyleLayerWeb] instance.
  HeatmapStyleLayerWeb({
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
  }) : super.fromNativeLayer(
         jsLayer: js.LayerSpecification(
           id: id,
           type: 'heatmap',
           maxzoom: maxZoom,
           minzoom: minZoom,
           source: sourceId,
           layout: createHeatmapLayout(visible: visible).jsify(),
           paint: createHeatmapPaint(
             radius: radius,
             weight: weight,
             intensity: intensity,
             color: color,
             opacity: opacity,
           ).jsify(),
         ),
       ) {
    if (sourceLayerId case final id?) jsLayer.sourceLayer = id;
    if (filter case final filter?) jsLayer.filter = filter.json.jsify();
  }

  @override
  PropertyValue<double> get radius =>
      requireMap
          .getPaintProperty(id, 'heatmap-radius')
          .toPropertyValue<double>() ??
      HeatmapStyleLayer.defaultRadius;

  @override
  set radius(PropertyValue<double> property) => requireMap.setPaintProperty(
    id,
    'heatmap-radius',
    property.toJson().jsify(),
  );

  @override
  PropertyValue<double> get weight =>
      requireMap
          .getPaintProperty(id, 'heatmap-weight')
          .toPropertyValue<double>() ??
      HeatmapStyleLayer.defaultWeight;

  @override
  set weight(PropertyValue<double> property) => requireMap.setPaintProperty(
    id,
    'heatmap-weight',
    property.toJson().jsify(),
  );

  @override
  PropertyValue<double> get intensity =>
      requireMap
          .getPaintProperty(id, 'heatmap-intensity')
          .toPropertyValue<double>() ??
      HeatmapStyleLayer.defaultIntensity;

  @override
  set intensity(PropertyValue<double> property) => requireMap.setPaintProperty(
    id,
    'heatmap-intensity',
    property.toJson().jsify(),
  );

  @override
  PropertyValue<Color>? get color =>
      requireMap.getPaintProperty(id, 'heatmap-color').toColorPropertyValue();

  @override
  set color(PropertyValue<Color>? property) => requireMap.setPaintProperty(
    id,
    'heatmap-color',
    property?.toJson().jsify(),
  );

  @override
  PropertyValue<double> get opacity =>
      requireMap
          .getPaintProperty(id, 'heatmap-opacity')
          .toPropertyValue<double>() ??
      HeatmapStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> property) => requireMap.setPaintProperty(
    id,
    'heatmap-opacity',
    property.toJson().jsify(),
  );

  @override
  Expression? get filter =>
      Expression.fromJson(jsLayer.filter.dartify()! as List<Object?>);

  @override
  set filter(Expression? value) => jsLayer.filter = value!.json.jsify();

  @override
  String? get sourceLayerId => jsLayer.sourceLayer;

  @override
  set sourceLayerId(String? value) => jsLayer.sourceLayer = value;

  @override
  String get sourceId => jsLayer.source!;
}
