import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_platform_interface/src/layer/annotation_placement.dart';

PlacedLayer _layer(
  String id, {
  LayerAnchor anchor = const LayerAnchor.top(),
  bool added = true,
}) => (id: id, anchor: anchor, added: added);

PlacementStep _add(String id, [String? belowLayerId]) =>
    (kind: PlacementKind.add, id: id, belowLayerId: belowLayerId);

PlacementStep _move(String id, [String? belowLayerId]) =>
    (kind: PlacementKind.move, id: id, belowLayerId: belowLayerId);

typedef _Case = ({
  String name,
  List<String> style,
  List<PlacedLayer> layers,
  PlacedOverlay? overlay,
  List<PlacementStep> steps,
});

void main() {
  final cases = <_Case>[
    (
      name: 'adds new layers on top, in the order of the list',
      style: ['x'],
      layers: [_layer('a', added: false), _layer('b', added: false)],
      overlay: null,
      steps: [_add('b'), _add('a', 'b')],
    ),
    (
      name: 'leaves layers in order alone',
      style: ['x', 'a', 'b'],
      layers: [_layer('a'), _layer('b')],
      overlay: null,
      steps: [],
    ),
    (
      name: 'moves a reordered layer only',
      style: ['x', 'a', 'b', 'c'],
      layers: [_layer('a'), _layer('c'), _layer('b')],
      overlay: null,
      steps: [_move('c', 'b')],
    ),
    (
      name: 'moves a layer back on top after the app added one above',
      style: ['x', 'a', 'y'],
      layers: [_layer('a')],
      overlay: null,
      steps: [_move('a')],
    ),
    (
      name: 'adds at the bottom below every other layer',
      style: ['x', 'y'],
      layers: [_layer('a', anchor: const .bottom(), added: false)],
      overlay: null,
      steps: [_add('a', 'x')],
    ),
    (
      name: 'adds right below the anchor layer',
      style: ['bg', 'road', 'label'],
      layers: [_layer('a', anchor: const .below('road'), added: false)],
      overlay: null,
      steps: [_add('a', 'road')],
    ),
    (
      name: 'adds right above the anchor layer',
      style: ['bg', 'road', 'label'],
      layers: [_layer('a', anchor: const .above('road'), added: false)],
      overlay: null,
      steps: [_add('a', 'label')],
    ),
    (
      name: 'adds on top above the top layer',
      style: ['bg', 'road'],
      layers: [_layer('a', anchor: const .above('road'), added: false)],
      overlay: null,
      steps: [_add('a')],
    ),
    (
      name: 'moves a layer back next to its anchor',
      style: ['bg', 'a', 'z', 'road'],
      layers: [_layer('a', anchor: const .below('road'))],
      overlay: null,
      steps: [_move('a', 'road')],
    ),
    (
      name: 'keeps a group next to its anchor with only the group between',
      style: ['bg', 'a', 'b', 'road'],
      layers: [
        _layer('a', anchor: const .below('road')),
        _layer('b', anchor: const .below('road')),
      ],
      overlay: null,
      steps: [],
    ),
    (
      name: 'places the top group first, then the bottom group',
      style: ['x'],
      layers: [
        _layer('a', added: false),
        _layer('b', anchor: const .bottom(), added: false),
      ],
      overlay: null,
      steps: [_add('a'), _add('b', 'x')],
    ),
    (
      name: 'adds a layer that the map rejected again',
      style: ['x'],
      layers: [_layer('a')],
      overlay: null,
      steps: [_add('a')],
    ),
    (
      name: 'leaves an id alone that a layer of the app took',
      style: ['a'],
      layers: [_layer('a', added: false)],
      overlay: null,
      steps: [],
    ),
    (
      name: 'keeps the overlay right above its layer',
      style: ['a', 'b', 'drag'],
      layers: [_layer('a'), _layer('b')],
      overlay: (id: 'drag', aboveId: 'a'),
      steps: [_move('drag', 'b')],
    ),
    (
      name: 'does not count the overlay as a layer of the style',
      style: ['a', 'drag'],
      layers: [_layer('a')],
      overlay: (id: 'drag', aboveId: 'a'),
      steps: [],
    ),
  ];

  group('placeLayers', () {
    for (final placement in cases) {
      test(placement.name, () {
        expect(
          placeLayers(
            placement.style,
            placement.layers,
            overlay: placement.overlay,
          ),
          placement.steps,
        );
      });
    }
  });
}
