part of 'style_layer.dart';

/// Web implementation of [ColorReliefStyleLayer].
class ColorReliefStyleLayerWeb extends StyleLayerWeb
    implements ColorReliefStyleLayer {
  /// Default constructor for a [ColorReliefStyleLayerWeb] instance.
  ColorReliefStyleLayerWeb({
    required String id,
    required String sourceId,
    required bool visible,
    required PropertyValue<Color>? color,
    required PropertyValue<double> opacity,
    required double minZoom,
    required double maxZoom,
  }) : super.fromNativeLayer(
         jsLayer: js.LayerSpecification(
           id: id,
           type: 'color-relief',
           maxzoom: maxZoom,
           minzoom: minZoom,
           source: sourceId,
           layout: createColorReliefLayout(visible: visible).jsify(),
           paint: createColorReliefPaint(
             color: color,
             opacity: opacity,
           ).jsify(),
         ),
       );

  @override
  PropertyValue<Color>? get color => requireMap
      .getPaintProperty(id, 'color-relief-color')
      .toColorPropertyValue();

  @override
  PropertyValue<double> get opacity =>
      requireMap
          .getPaintProperty(id, 'color-relief-opacity')
          .toPropertyValue() ??
      ColorReliefStyleLayer.defaultOpacity;

  @override
  String get sourceId => jsLayer.source!;

  @override
  set color(PropertyValue<Color>? property) => requireMap.setPaintProperty(
    id,
    'color-relief-color',
    property?.toJson().jsify(),
  );

  @override
  set opacity(PropertyValue<double> property) => requireMap.setPaintProperty(
    id,
    'color-relief-opacity',
    property.toJson().jsify(),
  );
}
