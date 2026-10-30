import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
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
  Future<void> setGeoJsonData(String id, String data) async =>
      calls.add('setGeoJsonData $data');

  @override
  Future<void> addLayer(
    Map<String, Object?> json, {
    String? belowLayerId,
  }) async => calls.add('addLayer ${json['type']}');

  @override
  Future<void> removeLayer(String id) async => calls.add('removeLayer');
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
      final manager = LayerManager(style, []);
      const layer1 = CircleLayer(
        points: [Feature(geometry: Point(Geographic(lon: 0, lat: 0)))],
      );
      const layer2 = CircleLayer(
        points: [Feature(geometry: Point(Geographic(lon: 1, lat: 1)))],
      );

      manager.updateLayers([layer1]);
      expect(backend.calls, ['addSource', 'addLayer circle']);
      backend.calls.clear();

      // An unchanged layer keeps its source: `Layer.==` compares `list` by
      // identity, so passing the same instance back must not re-serialise it.
      manager.updateLayers([layer1]);
      expect(backend.calls, isEmpty);

      // A layer that did change still updates, so nothing real is skipped.
      // Its style is the same, so the style layer stays.
      manager.updateLayers([layer2]);
      expect(backend.calls.single, startsWith('setGeoJsonData'));
      backend.calls.clear();

      manager.updateLayers([]);
      expect(backend.calls, ['removeLayer', 'removeSource']);
    });

    testWidgets('updates a source whose list grew in place', (tester) async {
      final points = [
        const Feature(geometry: Point(Geographic(lon: 0, lat: 0))),
      ];
      final manager = LayerManager(style, [CircleLayer(points: points)]);
      backend.calls.clear();

      // The example pages add a tapped point to the same list and rebuild,
      // so the new layer equals the old one by `Layer.==`.
      points.add(const Feature(geometry: Point(Geographic(lon: 1, lat: 1))));
      manager.updateLayers([CircleLayer(points: points)]);
      // Only the data changed, so the style layer stays.
      expect(backend.calls.single, contains('[1,1]'));
      backend.calls.clear();

      manager.updateLayers([CircleLayer(points: points)]);
      expect(backend.calls, isEmpty);
    });
  });
}
