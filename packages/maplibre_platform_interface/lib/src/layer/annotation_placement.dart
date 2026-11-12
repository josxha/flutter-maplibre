import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// A layer of [MapLibreMap.layers] for [placeLayers].
///
/// `anchor` must name a layer of the style that is not one of the layers;
/// the map passes [LayerAnchor.top] for the others. `added` is whether the
/// layer's style layer was added to the style before.
typedef PlacedLayer = ({String id, LayerAnchor anchor, bool added});

/// What a [PlacementStep] does.
enum PlacementKind {
  /// Adds the style layer.
  add,

  /// Moves the style layer, which is on the style.
  move,
}

/// A step of [placeLayers]: adds or moves the style layer `id` below the
/// layer `belowLayerId`, or on top if it is null.
typedef PlacementStep = ({PlacementKind kind, String id, String? belowLayerId});

/// The overlay of a drag for [placeLayers], which goes right above the layer
/// `aboveId`.
typedef PlacedOverlay = ({String id, String aboveId});

/// The steps that bring [layers], in the order of [MapLibreMap.layers], to
/// their places among [styleIds], the ids of the style's layers from bottom
/// to top, with as few moves as it takes.
///
/// Layers with the same anchor are in the order of the list, right next to
/// each other at the place of their anchor, with only the layers of that
/// anchor in between. A layer that was not `added` is added, and
/// so is one that is no longer among [styleIds], which the map rejected. A
/// layer that was not added but whose id [styleIds] has is left alone: a
/// layer of the app took the id. [overlay] goes right above its layer.
List<PlacementStep> placeLayers(
  List<String> styleIds,
  List<PlacedLayer> layers, {
  PlacedOverlay? overlay,
}) {
  final ids = List.of(styleIds);
  final steps = <PlacementStep>[];
  final groups = <LayerAnchor, List<PlacedLayer>>{};
  for (final layer in layers) {
    groups.putIfAbsent(layer.anchor, () => []).add(layer);
  }
  // On top first, then at the bottom, then next to the layers of the style.
  for (final rank in const [0, 1, 2]) {
    for (final MapEntry(key: anchor, value: group) in groups.entries) {
      if (_rankOf(anchor) != rank) continue;
      _placeGroup(ids, steps, anchor, group, overlay?.id);
    }
  }
  if (overlay != null) _placeOverlay(ids, steps, overlay);
  return steps;
}

int _rankOf(LayerAnchor anchor) => switch (anchor) {
  LayerAnchorTop() => 0,
  LayerAnchorBottom() => 1,
  LayerAnchorBelow() || LayerAnchorAbove() => 2,
};

/// Places the layers of [group], which share [anchor], from the top down.
/// [ids] are the ids of the style's layers, which this keeps up to date.
void _placeGroup(
  List<String> ids,
  List<PlacementStep> steps,
  LayerAnchor anchor,
  List<PlacedLayer> group,
  String? overlayId,
) {
  final members = {for (final layer in group) layer.id};
  bool other(String id) => !members.contains(id) && id != overlayId;

  // Whether [index] is where the group goes, among the other layers.
  bool inRegion(int index) {
    switch (anchor) {
      case LayerAnchorTop():
        for (var i = index + 1; i < ids.length; i++) {
          if (other(ids[i])) return false;
        }
        return true;
      case LayerAnchorBottom():
        for (var i = 0; i < index; i++) {
          if (other(ids[i])) return false;
        }
        return true;
      case LayerAnchorBelow(:final layerId):
        // Right below the layer, with only the group in between.
        final anchorIndex = ids.indexOf(layerId);
        if (index > anchorIndex) return false;
        for (var i = index + 1; i < anchorIndex; i++) {
          if (other(ids[i])) return false;
        }
        return true;
      case LayerAnchorAbove(:final layerId):
        // Right above the layer, with only the group in between.
        final anchorIndex = ids.indexOf(layerId);
        if (index < anchorIndex) return false;
        for (var i = anchorIndex + 1; i < index; i++) {
          if (other(ids[i])) return false;
        }
        return true;
    }
  }

  // The layer that the top of the group goes below, or null for the top.
  String? groupBelow() {
    switch (anchor) {
      case LayerAnchorTop():
        return null;
      case LayerAnchorBottom():
        for (final id in ids) {
          if (other(id)) return id;
        }
        return null;
      case LayerAnchorBelow(:final layerId):
        return layerId;
      case LayerAnchorAbove(:final layerId):
        final index = ids.indexOf(layerId);
        for (var i = index + 1; i < ids.length; i++) {
          if (other(ids[i])) return ids[i];
        }
        return null;
    }
  }

  for (var i = group.length - 1; i >= 0; i--) {
    final layer = group[i];
    final index = ids.indexOf(layer.id);
    // A layer of the app took the id after the map rejected this one.
    if (!layer.added && index != -1) continue;
    // The map can reject a style layer, which takes it out of the style
    // again. Such a layer is added again.
    final missing = index == -1;
    final above = i + 1 < group.length ? group[i + 1].id : null;
    if (!missing &&
        inRegion(index) &&
        (above == null || index < ids.indexOf(above))) {
      continue;
    }
    final belowLayerId = above ?? groupBelow();
    final kind = missing ? PlacementKind.add : PlacementKind.move;
    steps.add(_step(kind, layer.id, belowLayerId));
    if (!missing) ids.removeAt(index);
    ids.insert(
      belowLayerId == null ? ids.length : ids.indexOf(belowLayerId),
      layer.id,
    );
  }
}

/// Keeps [overlay] right above its layer.
void _placeOverlay(
  List<String> ids,
  List<PlacementStep> steps,
  PlacedOverlay overlay,
) {
  final layerIndex = ids.indexOf(overlay.aboveId);
  final index = ids.indexOf(overlay.id);
  if (layerIndex == -1 || index == -1 || index == layerIndex + 1) return;
  ids.removeAt(index);
  final above = ids.indexOf(overlay.aboveId) + 1;
  final belowLayerId = above < ids.length ? ids[above] : null;
  steps.add(_step(PlacementKind.move, overlay.id, belowLayerId));
  ids.insert(above, overlay.id);
}

PlacementStep _step(PlacementKind kind, String id, String? belowLayerId) =>
    (kind: kind, id: id, belowLayerId: belowLayerId);
