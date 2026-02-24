part of 'style_layer.dart';

class BackgroundStyleLayerWebView extends StyleLayerWebView
    implements BackgroundStyleLayer {
  BackgroundStyleLayerWebView({
    required this.id,
    required this.color,
    required this.maxZoom,
    required this.minZoom,
    required this.opacity,
    required this.pattern,
    required this.visible,
  });

  @override
  Map<String, Object?> get layout => createBackgroundLayout(visible: visible);

  @override
  Map<String, Object?> get paint =>
      createBackgroundPaint(color: color, opacity: opacity, pattern: pattern);

  @override
  PropertyValue<Color> color;

  @override
  double maxZoom;

  @override
  double minZoom;

  @override
  PropertyValue<double> opacity;

  @override
  PropertyValue<String>? pattern;

  @override
  bool visible;

  @override
  final String id;
}
