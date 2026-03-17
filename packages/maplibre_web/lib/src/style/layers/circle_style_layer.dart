part of 'style_layer.dart';

/// Web implementation of [CircleStyleLayer].
class CircleStyleLayerWeb extends StyleLayerWeb implements CircleStyleLayer {
  /// Default constructor for a [CircleStyleLayerWeb] instance.
  CircleStyleLayerWeb({
    required String id,
    required String sourceId,
    required String? sourceLayerId,
    required Expression? filter,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<Offset> translate,
    required PropertyValue<ReferenceSpace> translateAnchor,
    required PropertyValue<double>? sortKey,
    required PropertyValue<double> radius,
    required PropertyValue<Color> color,
    required PropertyValue<double> blur,
    required PropertyValue<double> opacity,
    required PropertyValue<ReferenceSpace> pitchScale,
    required PropertyValue<ReferenceSpace> pitchAlignment,
    required PropertyValue<double> strokeWidth,
    required PropertyValue<Color> strokeColor,
    required PropertyValue<double> strokeOpacity,
  }) : super.fromNativeLayer(
         jsLayer: js.LayerSpecification(
           id: id,
           type: 'circle',
           maxzoom: maxZoom,
           minzoom: minZoom,
           source: sourceId,
           layout: createCircleLayout(
             visible: visible,
             sortKey: sortKey,
           ).jsify(),
           paint: createCirclePaint(
             color: color,
             blur: blur,
             opacity: opacity,
             pitchScale: pitchScale,
             pitchAlignment: pitchAlignment,
             radius: radius,
             strokeWidth: strokeWidth,
             strokeColor: strokeColor,
             strokeOpacity: strokeOpacity,
             translate: translate,
             translateAnchor: translateAnchor,
           ).jsify(),
         ),
       ) {
    if (sourceLayerId case final id?) jsLayer.sourceLayer = id;
    if (filter case final filter?) jsLayer.filter = filter.json.jsify();
  }

  @override
  PropertyValue<double> get blur =>
      requireMap
          .getPaintProperty(id, 'circle-blur')
          .toPropertyValue<double>() ??
      CircleStyleLayer.defaultBlur;

  @override
  set blur(PropertyValue<double> value) =>
      requireMap.setPaintProperty(id, 'circle-blur', value.toJson().jsify());

  @override
  PropertyValue<Color> get color =>
      requireMap.getPaintProperty(id, 'circle-color').toColorPropertyValue() ??
      CircleStyleLayer.defaultColor;

  @override
  set color(PropertyValue<Color> value) =>
      requireMap.setPaintProperty(id, 'circle-color', value.toJson().jsify());

  @override
  Expression? get filter =>
      Expression.fromJson(jsLayer.filter.dartify()! as List<Object?>);

  @override
  set filter(Expression value) => jsLayer.filter = value.json.jsify();

  @override
  PropertyValue<double> get opacity =>
      requireMap
          .getPaintProperty(id, 'circle-opacity')
          .toPropertyValue<double>() ??
      CircleStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> value) =>
      requireMap.setPaintProperty(id, 'circle-opacity', value.toJson().jsify());

  @override
  PropertyValue<ReferenceSpace> get pitchAlignment =>
      requireMap
          .getPaintProperty(id, 'circle-pitch-alignment')
          .toEnumPropertyValue(ReferenceSpace.values) ??
      CircleStyleLayer.defaultPitchAlignment;

  @override
  set pitchAlignment(PropertyValue<ReferenceSpace> value) => requireMap
      .setPaintProperty(id, 'circle-pitch-alignment', value.toJson().jsify());

  @override
  PropertyValue<ReferenceSpace> get pitchScale =>
      requireMap
          .getPaintProperty(id, 'circle-pitch-scale')
          .toEnumPropertyValue(ReferenceSpace.values) ??
      CircleStyleLayer.defaultPitchScale;

  @override
  set pitchScale(PropertyValue<ReferenceSpace> value) => requireMap
      .setPaintProperty(id, 'circle-pitch-scale', value.toJson().jsify());

  @override
  PropertyValue<double> get radius =>
      requireMap
          .getPaintProperty(id, 'circle-radius')
          .toPropertyValue<double>() ??
      CircleStyleLayer.defaultRadius;

  @override
  set radius(PropertyValue<double> value) =>
      requireMap.setPaintProperty(id, 'circle-radius', value.toJson().jsify());

  @override
  PropertyValue<double>? get sortKey => requireMap
      .getLayoutProperty(id, 'circle-sort-key')
      .toPropertyValue<double>();

  @override
  set sortKey(PropertyValue<double>? value) => requireMap.setLayoutProperty(
    id,
    'circle-sort-key',
    value?.toJson().jsify(),
  );

  @override
  String? get sourceLayerId => jsLayer.sourceLayer;

  @override
  set sourceLayerId(String? value) => jsLayer.sourceLayer = value;

  @override
  PropertyValue<Color> get strokeColor =>
      requireMap
          .getPaintProperty(id, 'circle-stroke-color')
          .toColorPropertyValue() ??
      CircleStyleLayer.defaultStrokeColor;

  @override
  set strokeColor(PropertyValue<Color> value) => requireMap.setPaintProperty(
    id,
    'circle-stroke-color',
    value.toJson().jsify(),
  );

  @override
  PropertyValue<double> get strokeOpacity =>
      requireMap
          .getPaintProperty(id, 'circle-stroke-opacity')
          .toPropertyValue<double>() ??
      CircleStyleLayer.defaultStrokeOpacity;

  @override
  set strokeOpacity(PropertyValue<double> value) => requireMap.setPaintProperty(
    id,
    'circle-stroke-opacity',
    value.toJson().jsify(),
  );

  @override
  PropertyValue<double> get strokeWidth =>
      requireMap
          .getPaintProperty(id, 'circle-stroke-width')
          .toPropertyValue<double>() ??
      CircleStyleLayer.defaultStrokeWidth;

  @override
  set strokeWidth(PropertyValue<double> value) => requireMap.setPaintProperty(
    id,
    'circle-stroke-width',
    value.toJson().jsify(),
  );

  @override
  PropertyValue<Offset> get translate =>
      requireMap
          .getPaintProperty(id, 'circle-translate')
          .toOffsetPropertyValue() ??
      StyleLayerWithTranslate.defaultTranslate;

  @override
  set translate(PropertyValue<Offset> value) => requireMap.setPaintProperty(
    id,
    'circle-translate',
    value.toJson().jsify(),
  );

  @override
  PropertyValue<ReferenceSpace> get translateAnchor =>
      requireMap
          .getPaintProperty(id, 'circle-translate-anchor')
          .toEnumPropertyValue(ReferenceSpace.values) ??
      StyleLayerWithTranslate.defaultTranslateAnchor;

  @override
  set translateAnchor(PropertyValue<ReferenceSpace> value) => requireMap
      .setPaintProperty(id, 'circle-translate-anchor', value.toJson().jsify());

  @override
  String get sourceId => jsLayer.source!;
}
