import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_platform_interface/src/layer/annotation_manager.dart';
import 'package:mocktail/mocktail.dart';

import '../shared/mocks.dart';

/// Records the map calls that the layer manager's changes end in.
class _Backend extends Mock implements StyleBackend {
  final calls = <String>[];

  @override
  Future<void> addSource(Source source) async => calls.add('addSource');

  @override
  Future<void> removeSource(String id) async => calls.add('removeSource');

  @override
  Future<void> setGeoJsonData(String id, GeoJsonData data) async =>
      calls.add('setGeoJsonData ${data.toText()}');

  @override
  Future<void> addLayer(
    Map<String, Object?> json, {
    String? belowLayerId,
  }) async => calls.add('addLayer ${json['type']}');

  @override
  Future<void> removeLayer(String id) async => calls.add('removeLayer');

  @override
  void moveLayer(String id, {String? belowLayerId}) =>
      calls.add('moveLayer $id');

  @override
  void setLayerProperty(
    String layerId,
    String name,
    Object? value, {
    required bool layout,
  }) => calls.add('set $layerId $name $value');

  @override
  void setFilter(String layerId, Object? filter) =>
      calls.add('setFilter $layerId $filter');
}

void main() {
  group('AnnotationManager', () {
    late StyleController style;
    late _Backend backend;
    setUp(() {
      backend = _Backend();
      final sources = StyleSources(backend);
      final layers = StyleLayers(backend, sources: sources);
      style = MockStyleController();
      when(() => style.sources).thenReturn(sources);
      when(() => style.layers).thenReturn(layers);
      when(() => style.batch(any())).thenAnswer(
        (invocation) =>
            (invocation.positionalArguments.single as void Function())(),
      );
    });

    testWidgets('add and remove layers', (tester) async {
      final manager = AnnotationManager([])..attach(style);
      const layer1 = CircleLayer(
        points: [Feature(geometry: Point(Geographic(lon: 0, lat: 0)))],
      );
      const layer2 = CircleLayer(
        points: [Feature(geometry: Point(Geographic(lon: 1, lat: 1)))],
      );

      manager.update([layer1]);
      expect(backend.calls, ['addSource', 'addLayer circle']);
      backend.calls.clear();

      // An unchanged layer keeps its source: `Layer.==` compares `list` by
      // identity, so passing the same instance back must not re-serialise it.
      manager.update([layer1]);
      expect(backend.calls, isEmpty);

      // A layer that did change still updates, so nothing real is skipped.
      // Its style is the same, so the style layer stays.
      manager.update([layer2]);
      expect(backend.calls.single, startsWith('setGeoJsonData'));
      backend.calls.clear();

      manager.update([]);
      expect(backend.calls, ['removeLayer', 'removeSource']);
    });

    testWidgets('a draggable layer numbers its features in its source', (
      tester,
    ) async {
      final points = [
        const Feature(geometry: Point(Geographic(lon: 0, lat: 0))),
        const Feature(geometry: Point(Geographic(lon: 1, lat: 1))),
      ];
      final manager = AnnotationManager([CircleLayer(points: points)])
        ..attach(style);
      backend.calls.clear();

      // Turning dragging on rewrites the unchanged features with an index.
      manager.update([CircleLayer(points: points, draggable: true)]);
      expect(backend.calls.single, contains('"maplibre:index":1'));
      backend.calls.clear();

      manager.update([CircleLayer(points: points, draggable: true)]);
      expect(backend.calls, isEmpty);

      manager.update([CircleLayer(points: points)]);
      expect(backend.calls.single, isNot(contains('maplibre:index')));
    });

    group('a dragged feature', () {
      final points = [
        const Feature(geometry: Point(Geographic(lon: 0, lat: 0))),
        const Feature(geometry: Point(Geographic(lon: 1, lat: 1))),
      ];
      const moved = Point(Geographic(lon: 5, lat: 5));

      Future<AnnotationManager> drag(WidgetTester tester) async {
        final manager = AnnotationManager([
          CircleLayer(points: points, draggable: true),
        ])..attach(style);
        manager.startDrag(manager.entries.single, 1);
        manager.moveDrag(moved);
        await tester.pump();
        return manager;
      }

      testWidgets('moves in an overlay, not in its layer', (tester) async {
        await drag(tester);
        expect(backend.calls.skip(2), [
          'addSource',
          'addLayer circle',
          'setFilter maplibre-circle-1 [!=, [get, maplibre:index], 1]',
          // Only the dragged feature moves.
          allOf(contains('[5,5]'), isNot(contains('[0,0]'))),
        ]);
      });

      testWidgets('goes back if the app does not save it', (tester) async {
        final manager = await drag(tester);
        backend.calls.clear();
        manager.endDrag();
        await tester.pump();
        expect(backend.calls, [
          'removeLayer',
          'removeSource',
          'setFilter maplibre-circle-1 null',
        ]);
      });

      testWidgets('stays in the overlay until the app saved it', (
        tester,
      ) async {
        final manager = await drag(tester);
        backend.calls.clear();
        manager
          ..endDrag()
          ..update([
            CircleLayer(
              points: [
                points[0],
                const Feature(geometry: moved),
              ],
              draggable: true,
            ),
          ]);
        await tester.pump();
        expect(backend.calls.first, startsWith('setGeoJsonData'));
        // The layer keeps hiding the feature while the source tiles again.
        expect(
          backend.calls.last,
          'setFilter maplibre-circle-1 [!=, [get, maplibre:index], 1]',
        );
        backend.calls.clear();
        await tester.pump(const Duration(milliseconds: 300));
        expect(backend.calls, [
          'removeLayer',
          'removeSource',
          'setFilter maplibre-circle-1 null',
        ]);
      });

      testWidgets('ends with its layer', (tester) async {
        final manager = await drag(tester);
        backend.calls.clear();
        manager.update([]);
        expect(backend.calls, [
          'removeLayer',
          'removeSource',
          'setFilter maplibre-circle-1 null',
          'removeLayer',
          'removeSource',
        ]);
      });
    });

    testWidgets('updates a source whose list grew in place', (tester) async {
      final points = [
        const Feature(geometry: Point(Geographic(lon: 0, lat: 0))),
      ];
      final manager = AnnotationManager([CircleLayer(points: points)])
        ..attach(style);
      backend.calls.clear();

      // The example pages add a tapped point to the same list and rebuild,
      // so the new layer equals the old one by `Layer.==`.
      points.add(const Feature(geometry: Point(Geographic(lon: 1, lat: 1))));
      manager.update([CircleLayer(points: points)]);
      // Only the data changed, so the style layer stays.
      expect(backend.calls.single, contains('[1,1]'));
      backend.calls.clear();

      manager.update([CircleLayer(points: points)]);
      expect(backend.calls, isEmpty);
    });
  });
}
