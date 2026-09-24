part of 'style_layer.dart';

/// Web implementation of [BackgroundStyleLayer].
class BackgroundStyleLayerWeb extends StyleLayerWeb
    implements BackgroundStyleLayer {
  /// Default constructor for a [BackgroundStyleLayerWeb] instance.
  BackgroundStyleLayerWeb({
    required String id,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<Color> color,
    required PropertyValue<String>? pattern,
    required PropertyValue<double> opacity,
    required bool visible,
  }) : super.fromNativeLayer(
         jsLayer: js.LayerSpecification(
           id: id,
           type: 'background',
           maxzoom: maxZoom,
           minzoom: minZoom,
           layout: createBackgroundLayout(visible: visible).jsify(),
           paint: createBackgroundPaint(
             color: color,
             pattern: pattern,
             opacity: opacity,
           ).jsify(),
         ),
       );

  @override
  PropertyValue<Color> get color =>
      requireMap
          .getPaintProperty(id, 'background-color')
          .toColorPropertyValue() ??
      BackgroundStyleLayer.defaultColor;

  @override
  set color(PropertyValue<Color> value) {
    requireMap.setPaintProperty(id, 'background-color', value.toJson().jsify());
  }

  @override
  PropertyValue<double> get opacity =>
      requireMap
          .getPaintProperty(id, 'background-opacity')
          .toPropertyValue<double>() ??
      BackgroundStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> value) => requireMap.setPaintProperty(
    id,
    'background-opacity',
    value.toJson().jsify(),
  );

  @override
  PropertyValue<String>? get pattern => requireMap
      .getPaintProperty(id, 'background-pattern')
      .toPropertyValue<String>();

  @override
  set pattern(PropertyValue<String>? value) => requireMap.setPaintProperty(
    id,
    'background-pattern',
    value?.toJson().jsify(),
  );
}
