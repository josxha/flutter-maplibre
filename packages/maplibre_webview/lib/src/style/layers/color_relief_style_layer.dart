part of 'style_layer.dart';

/// WebView implementation of [ColorReliefStyleLayer].
class ColorReliefStyleLayerWebView extends StyleLayerWebView
    implements ColorReliefStyleLayer {
  /// Creates a color relief style layer.
  ColorReliefStyleLayerWebView({
    required this.id,
    required this.sourceId,
    required this.visible,
    required this.color,
    required this.opacity,
    required this.minZoom,
    required this.maxZoom,
  });

  @override
  Map<String, Object?> get layout => createColorReliefLayout(visible: visible);

  @override
  Map<String, Object?> get paint =>
      createColorReliefPaint(color: color, opacity: opacity);

  @override
  bool visible;

  @override
  PropertyValue<Color>? color;

  @override
  PropertyValue<double> opacity;

  @override
  double minZoom;

  @override
  double maxZoom;

  @override
  final String id;

  @override
  final String sourceId;
}
