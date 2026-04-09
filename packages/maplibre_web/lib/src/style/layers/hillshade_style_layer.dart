part of 'style_layer.dart';

/// Web implementation of [HillshadeStyleLayer].
class HillshadeStyleLayerWeb extends StyleLayerWeb
    implements HillshadeStyleLayer {
  /// Default constructor for a [HillshadeStyleLayerWeb] instance.
  HillshadeStyleLayerWeb({
    required String id,
    required String sourceId,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<NumberArray> illuminationDirection,
    required PropertyValue<NumberArray> illuminationAltitude,
    required PropertyValue<IlluminationAnchor> illuminationAnchor,
    required PropertyValue<double> exaggeration,
    required PropertyValue<List<Color>> shadowColor,
    required PropertyValue<List<Color>> highlightColor,
    required PropertyValue<Color> accentColor,
    required PropertyValue<HillshadeMethod> method,
  }) : super.fromNativeLayer(
         jsLayer: js.LayerSpecification(
           id: id,
           type: 'hillshade',
           maxzoom: maxZoom,
           minzoom: minZoom,
           source: sourceId,
           layout: createHillshadeLayout(visible: visible).jsify(),
           paint: createHillshadePaint(
             illuminationDirection: illuminationDirection,
             illuminationAltitude: illuminationAltitude,
             illuminationAnchor: illuminationAnchor,
             exaggeration: exaggeration,
             shadowColor: shadowColor,
             highlightColor: highlightColor,
             accentColor: accentColor,
             method: method,
           ).jsify(),
         ),
       );

  @override
  PropertyValue<NumberArray> get illuminationDirection =>
      requireMap
          .getPaintProperty(id, 'hillshade-illumination-direction')
          .toNumberArrayPropertyValue() ??
      HillshadeStyleLayer.defaultIlluminationDirection;

  @override
  set illuminationDirection(PropertyValue<NumberArray> property) =>
      requireMap.setPaintProperty(
        id,
        'hillshade-illumination-direction',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<NumberArray> get illuminationAltitude =>
      requireMap
          .getPaintProperty(id, 'hillshade-illumination-altitude')
          .toNumberArrayPropertyValue() ??
      HillshadeStyleLayer.defaultIlluminationAltitude;

  @override
  set illuminationAltitude(PropertyValue<NumberArray> property) =>
      requireMap.setPaintProperty(
        id,
        'hillshade-illumination-altitude',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<IlluminationAnchor> get illuminationAnchor =>
      requireMap
          .getPaintProperty(id, 'hillshade-illumination-anchor')
          .toEnumPropertyValue(IlluminationAnchor.values) ??
      HillshadeStyleLayer.defaultIlluminationAnchor;

  @override
  set illuminationAnchor(PropertyValue<IlluminationAnchor> property) =>
      requireMap.setPaintProperty(
        id,
        'hillshade-illumination-anchor',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<double> get exaggeration =>
      requireMap
          .getPaintProperty(id, 'hillshade-exaggeration')
          .toPropertyValue<double>() ??
      HillshadeStyleLayer.defaultExaggeration;

  @override
  set exaggeration(PropertyValue<double> property) =>
      requireMap.setPaintProperty(
        id,
        'hillshade-exaggeration',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<List<Color>> get shadowColor =>
      requireMap
          .getPaintProperty(id, 'hillshade-shadow-color')
          .toColorListPropertyValue() ??
      HillshadeStyleLayer.defaultShadowColor;

  @override
  set shadowColor(PropertyValue<List<Color>> property) => requireMap.setPaintProperty(
    id,
    'hillshade-shadow-color',
    property.toJson().jsify(),
  );

  @override
  PropertyValue<List<Color>> get highlightColor =>
      requireMap
          .getPaintProperty(id, 'hillshade-highlight-color')
          .toColorListPropertyValue() ??
      HillshadeStyleLayer.defaultHighlightColor;

  @override
  set highlightColor(PropertyValue<List<Color>> property) =>
      requireMap.setPaintProperty(
        id,
        'hillshade-highlight-color',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<Color> get accentColor =>
      requireMap
          .getPaintProperty(id, 'hillshade-accent-color')
          .toColorPropertyValue() ??
      HillshadeStyleLayer.defaultAccentColor;

  @override
  set accentColor(PropertyValue<Color> property) => requireMap.setPaintProperty(
    id,
    'hillshade-accent-color',
    property.toJson().jsify(),
  );

  @override
  PropertyValue<HillshadeMethod> get method =>
      requireMap
          .getPaintProperty(id, 'hillshade-method')
          .toEnumPropertyValue(HillshadeMethod.values) ??
      HillshadeStyleLayer.defaultMethod;

  @override
  set method(PropertyValue<HillshadeMethod> property) => requireMap
      .setPaintProperty(id, 'hillshade-method', property.toJson().jsify());

  @override
  String get sourceId => jsLayer.source!;
}
