part of 'style_layer.dart';

/// A simple background layer.
///
/// https://maplibre.org/maplibre-style-spec/layers/#background
///
/// {@category Style}
/// {@subCategory Style Layers}
interface class BackgroundStyleLayer extends StyleLayer {
  /// Create a new [BackgroundStyleLayer].
  BackgroundStyleLayer({
    required super.id,
    this.visible = true,
    this.color = const PropertyValue<Color>.value(Color(0x00000000)),
    this.opacity = const PropertyValue.value(1),
    super.minZoom = 0,
    super.maxZoom = 24,
  });

  /// Whether this layer is displayed.
  ///
  /// Defaults to visible.
  final bool visible;

  /// The color with which the background will be drawn.
  ///
  /// Defaults to #000000 (black).
  final PropertyValue<Color> color;

  /// The opacity at which the background will be drawn.
  ///
  /// Defaults to 1.0.
  final PropertyValue<double> opacity;
}
