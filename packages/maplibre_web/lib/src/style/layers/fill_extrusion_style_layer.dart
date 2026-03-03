part of 'style_layer.dart';

/// Web implementation of [FillExtrusionStyleLayer].
class FillExtrusionStyleLayerWeb extends StyleLayerWeb
    implements FillExtrusionStyleLayer {
  /// Default constructor for a [FillExtrusionStyleLayerWeb] instance.
  FillExtrusionStyleLayerWeb({
    required String id,
    required String sourceId,
    required String? sourceLayerId,
    required Expression? filter,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<double> opacity,
    required PropertyValue<Color> color,
    required PropertyValue<String>? pattern,
    required PropertyValue<double> height,
    required PropertyValue<double> base,
    required PropertyValue<bool> verticalGradient,
    required PropertyValue<Offset> translate,
    required PropertyValue<ReferenceSpace> translateAnchor,
  }) : super.fromNativeLayer(
         jsLayer: js.LayerSpecification(
           id: id,
           type: 'fill-extrusion',
           maxzoom: maxZoom,
           minzoom: minZoom,
           source: sourceId,
           layout: createFillExtrusionLayout(visible: visible).jsify(),
           paint: createFillExtrusionPaint(
             opacity: opacity,
             color: color,
             pattern: pattern,
             height: height,
             base: base,
             verticalGradient: verticalGradient,
             translate: translate,
             translateAnchor: translateAnchor,
           ).jsify(),
         ),
       ) {
    if (sourceLayerId case final id?) jsLayer.sourceLayer = id;
    if (filter case final filter?) jsLayer.filter = filter.json.jsify()!;
  }

  @override
  PropertyValue<double> get opacity =>
      requireMap
          .getPaintProperty(id, 'fill-extrusion-opacity')
          .toPropertyValue<double>() ??
      FillExtrusionStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> property) => requireMap.setPaintProperty(
    id,
    'fill-extrusion-opacity',
    property.toJson().jsify(),
  );

  @override
  PropertyValue<Color> get color =>
      requireMap
          .getPaintProperty(id, 'fill-extrusion-color')
          .toColorPropertyValue() ??
      FillExtrusionStyleLayer.defaultColor;

  @override
  set color(PropertyValue<Color> property) => requireMap.setPaintProperty(
    id,
    'fill-extrusion-color',
    property.toJson().jsify(),
  );

  @override
  PropertyValue<String>? get pattern => requireMap
      .getPaintProperty(id, 'fill-extrusion-pattern')
      .toPropertyValue<String>();

  @override
  set pattern(PropertyValue<String>? property) => requireMap.setPaintProperty(
    id,
    'fill-extrusion-pattern',
    property?.toJson().jsify(),
  );

  @override
  PropertyValue<double> get height =>
      requireMap
          .getPaintProperty(id, 'fill-extrusion-height')
          .toPropertyValue<double>() ??
      FillExtrusionStyleLayer.defaultHeight;

  @override
  set height(PropertyValue<double> property) => requireMap.setPaintProperty(
    id,
    'fill-extrusion-height',
    property.toJson().jsify(),
  );

  @override
  PropertyValue<double> get base =>
      requireMap
          .getPaintProperty(id, 'fill-extrusion-base')
          .toPropertyValue<double>() ??
      FillExtrusionStyleLayer.defaultBase;

  @override
  set base(PropertyValue<double> property) => requireMap.setPaintProperty(
    id,
    'fill-extrusion-base',
    property.toJson().jsify(),
  );

  @override
  PropertyValue<bool> get verticalGradient =>
      requireMap
          .getPaintProperty(id, 'fill-extrusion-vertical-gradient')
          .toPropertyValue<bool>() ??
      FillExtrusionStyleLayer.defaultVerticalGradient;

  @override
  set verticalGradient(PropertyValue<bool> property) =>
      requireMap.setPaintProperty(
        id,
        'fill-extrusion-vertical-gradient',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<Offset> get translate =>
      requireMap
          .getPaintProperty(id, 'fill-extrusion-translate')
          .toOffsetPropertyValue() ??
      StyleLayerWithTranslate.defaultTranslate;

  @override
  set translate(PropertyValue<Offset> property) => requireMap.setPaintProperty(
    id,
    'fill-extrusion-translate',
    property.toJson().jsify(),
  );

  @override
  PropertyValue<ReferenceSpace> get translateAnchor =>
      requireMap
          .getPaintProperty(id, 'fill-extrusion-translate-anchor')
          .toEnumPropertyValue(ReferenceSpace.values) ??
      StyleLayerWithTranslate.defaultTranslateAnchor;

  @override
  set translateAnchor(PropertyValue<ReferenceSpace> property) =>
      requireMap.setPaintProperty(
        id,
        'fill-extrusion-translate-anchor',
        property.toJson().jsify(),
      );

  @override
  Expression? get filter =>
      Expression.fromJson(jsLayer.filter.dartify()! as List<Object?>);

  @override
  set filter(Expression value) => jsLayer.filter = value.json.jsify()!;

  @override
  String? get sourceLayerId => jsLayer.sourceLayer;

  @override
  set sourceLayerId(String? value) => jsLayer.sourceLayer = value;

  @override
  String get sourceId => jsLayer.source!;
}
