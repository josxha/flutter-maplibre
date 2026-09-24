part of 'style_layer.dart';

/// Web implementation of [CircleStyleLayer].
class CircleStyleLayerWebView extends StyleLayerWebView
    implements CircleStyleLayer {
  /// Construct a [CircleStyleLayerWebView] with the given properties.
  CircleStyleLayerWebView({
    required this.id,
    required this.sourceId,
    required this.sourceLayerId,
    required this.filter,
    required this.visible,
    required this.minZoom,
    required this.maxZoom,
    required this.translate,
    required this.translateAnchor,
    required this.sortKey,
    required this.radius,
    required this.color,
    required this.blur,
    required this.opacity,
    required this.pitchScale,
    required this.pitchAlignment,
    required this.strokeWidth,
    required this.strokeColor,
    required this.strokeOpacity,
  });

  @override
  Map<String, Object?> get layout =>
      createCircleLayout(visible: visible, sortKey: sortKey);

  @override
  Map<String, Object?> get paint => createCirclePaint(
    radius: radius,
    color: color,
    blur: blur,
    opacity: opacity,
    translate: translate,
    translateAnchor: translateAnchor,
    pitchScale: pitchScale,
    pitchAlignment: pitchAlignment,
    strokeWidth: strokeWidth,
    strokeColor: strokeColor,
    strokeOpacity: strokeOpacity,
  );

  @override
  PropertyValue<double> blur;

  @override
  PropertyValue<Color> color;

  @override
  Expression? filter;

  @override
  double maxZoom;

  @override
  double minZoom;

  @override
  PropertyValue<double> opacity;

  @override
  PropertyValue<ReferenceSpace> pitchAlignment;

  @override
  PropertyValue<ReferenceSpace> pitchScale;

  @override
  PropertyValue<double> radius;

  @override
  PropertyValue<double>? sortKey;

  @override
  String? sourceLayerId;

  @override
  PropertyValue<Color> strokeColor;

  @override
  PropertyValue<double> strokeOpacity;

  @override
  PropertyValue<double> strokeWidth;

  @override
  PropertyValue<Offset> translate;

  @override
  PropertyValue<ReferenceSpace> translateAnchor;

  @override
  bool visible;

  @override
  final String id;

  @override
  final String sourceId;
}
