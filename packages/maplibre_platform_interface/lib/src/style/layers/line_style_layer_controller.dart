import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Reads and updates the properties of a line layer in the map's style.
///
/// Get one with [StyleController.getLineLayer]. A getter returns the value
/// the layer had when it was looked up, or the value a setter gave it since.
/// A setter updates the map without waiting for it, so an animation can call
/// it every frame.
///
/// {@category Style}
/// {@subCategory Style Layers}
final class LineStyleLayerController {
  /// Creates a controller of the line layer [id], whose properties start as
  /// `paint` and whose setters call `setPaintProperty`. Platforms create it.
  LineStyleLayerController({
    required this.id,
    required this._paint,
    required this._setPaintProperty,
  });

  /// The paint properties a [LineStyleLayerController] reads and updates.
  static const paintProperties = ['line-gradient'];

  /// The id of the layer.
  final String id;

  final Map<String, Object?> _paint;
  final void Function(String name, Object? value) _setPaintProperty;

  /// The gradient that colors the line, as an expression on
  /// `['line-progress']`, or null when the line has no gradient.
  ///
  /// `line-progress` runs from 0 at the start of the line to 1 at its end, so
  /// a `step` at a growing progress draws a growing line. Needs a
  /// [GeoJsonSource] with [GeoJsonSource.lineMetrics].
  ///
  /// https://maplibre.org/maplibre-style-spec/layers/#line-gradient
  List<Object>? get lineGradient =>
      (_paint['line-gradient'] as List<Object?>?)?.cast<Object>();

  set lineGradient(List<Object>? value) => _setPaint('line-gradient', value);

  void _setPaint(String name, Object? value) {
    _paint[name] = value;
    _setPaintProperty(name, value);
  }
}
