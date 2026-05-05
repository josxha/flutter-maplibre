part of 'style_layer.dart';

/// WebView implementation of [FillExtrusionStyleLayer].
class FillExtrusionStyleLayerWebView extends StyleLayerWebView
    implements FillExtrusionStyleLayer {
  /// Creates a fill extrusion style layer.
  FillExtrusionStyleLayerWebView({
    required this.id,
    required this.sourceId,
    required this.minZoom,
    required this.maxZoom,
    required this.visible,
    required this.filter,
    required this.sourceLayerId,
    required this.opacity,
    required this.color,
    required this.pattern,
    required this.height,
    required this.base,
    required this.verticalGradient,
    required this.translate,
    required this.translateAnchor,
  });

  @override
  Map<String, Object?> get layout =>
      createFillExtrusionLayout(visible: visible);

  @override
  Map<String, Object?> get paint => createFillExtrusionPaint(
    opacity: opacity,
    color: color,
    pattern: pattern,
    height: height,
    base: base,
    verticalGradient: verticalGradient,
    translate: translate,
    translateAnchor: translateAnchor,
  );

  @override
  final String id;

  @override
  final String sourceId;

  @override
  bool visible;

  @override
  double minZoom;

  @override
  double maxZoom;

  @override
  Expression? filter;

  @override
  String? sourceLayerId;

  @override
  PropertyValue<double> opacity;

  @override
  PropertyValue<Color> color;

  @override
  PropertyValue<String>? pattern;

  @override
  PropertyValue<double> height;

  @override
  PropertyValue<double> base;

  @override
  PropertyValue<bool> verticalGradient;

  @override
  PropertyValue<Offset> translate;

  @override
  PropertyValue<ReferenceSpace> translateAnchor;
}
