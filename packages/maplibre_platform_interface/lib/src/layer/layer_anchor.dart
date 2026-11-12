import 'package:flutter/foundation.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Where a [Layer] of [MapLibreMap.layers] goes among the layers of the
/// style, see [Layer.anchor].
///
/// Layers with the same anchor draw in the order of [MapLibreMap.layers],
/// the first at the bottom.
///
/// {@category Layers}
@immutable
sealed class LayerAnchor {
  const LayerAnchor._();

  /// On top of every layer of the style. The default.
  const factory LayerAnchor.top() = LayerAnchorTop;

  /// Below every layer of the style, even its background.
  const factory LayerAnchor.bottom() = LayerAnchorBottom;

  /// Right below the style layer [layerId], for example below the labels of
  /// the style.
  const factory LayerAnchor.below(String layerId) = LayerAnchorBelow;

  /// Right above the style layer [layerId].
  const factory LayerAnchor.above(String layerId) = LayerAnchorAbove;
}

/// See [LayerAnchor.top].
///
/// {@category Layers}
final class LayerAnchorTop extends LayerAnchor {
  /// See [LayerAnchor.top].
  const LayerAnchorTop() : super._();

  @override
  bool operator ==(Object other) => other is LayerAnchorTop;

  @override
  int get hashCode => (LayerAnchorTop).hashCode;

  @override
  String toString() => 'LayerAnchor.top()';
}

/// See [LayerAnchor.bottom].
///
/// {@category Layers}
final class LayerAnchorBottom extends LayerAnchor {
  /// See [LayerAnchor.bottom].
  const LayerAnchorBottom() : super._();

  @override
  bool operator ==(Object other) => other is LayerAnchorBottom;

  @override
  int get hashCode => (LayerAnchorBottom).hashCode;

  @override
  String toString() => 'LayerAnchor.bottom()';
}

/// See [LayerAnchor.below].
///
/// {@category Layers}
final class LayerAnchorBelow extends LayerAnchor {
  /// See [LayerAnchor.below].
  const LayerAnchorBelow(this.layerId) : super._();

  /// The id of the style layer to go below.
  final String layerId;

  @override
  bool operator ==(Object other) =>
      other is LayerAnchorBelow && layerId == other.layerId;

  @override
  int get hashCode => Object.hash(LayerAnchorBelow, layerId);

  @override
  String toString() => 'LayerAnchor.below($layerId)';
}

/// See [LayerAnchor.above].
///
/// {@category Layers}
final class LayerAnchorAbove extends LayerAnchor {
  /// See [LayerAnchor.above].
  const LayerAnchorAbove(this.layerId) : super._();

  /// The id of the style layer to go above.
  final String layerId;

  @override
  bool operator ==(Object other) =>
      other is LayerAnchorAbove && layerId == other.layerId;

  @override
  int get hashCode => Object.hash(LayerAnchorAbove, layerId);

  @override
  String toString() => 'LayerAnchor.above($layerId)';
}
