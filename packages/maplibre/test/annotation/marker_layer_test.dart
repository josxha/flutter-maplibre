import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  group('MarkerLayer clustering', () {
    const points = [
      Feature(geometry: Point(Geographic(lon: 0, lat: 0))),
      Feature(geometry: Point(Geographic(lon: 1, lat: 1))),
    ];

    test('createSource is not clustered by default', () {
      const layer = MarkerLayer(points: points);
      final source = layer.createSource(0);
      expect(source.cluster, isFalse);
    });

    test('createSource forwards cluster options when enabled', () {
      const layer = MarkerLayer(
        points: points,
        cluster: true,
        clusterRadius: 80,
        clusterMaxZoom: 12,
        clusterMinPoints: 3,
      );
      final source = layer.createSource(0);
      expect(source.cluster, isTrue);
      expect(source.clusterRadius, 80);
      expect(source.clusterMaxZoom, 12);
      expect(source.clusterMinPoints, 3);
    });

    test('createStyleLayers returns a single layer when not clustered', () {
      const layer = MarkerLayer(points: points);
      final layers = layer.createStyleLayers(0);
      expect(layers, hasLength(1));
      expect(layers.single, isA<SymbolStyleLayer>());
      expect(layers.single.id, layer.getLayerId(0));
      expect(layers.single.filter, isNull);
    });

    test('createStyleLayers returns marker, cluster and count layers when '
        'clustered', () {
      const layer = MarkerLayer(points: points, cluster: true);
      final layers = layer.createStyleLayers(0);
      expect(layers, hasLength(3));

      final markerLayer = layers[0];
      expect(markerLayer, isA<SymbolStyleLayer>());
      expect(markerLayer.id, layer.getLayerId(0));
      // unclustered markers only
      expect(markerLayer.filter, [
        '!',
        ['has', 'point_count'],
      ]);

      final clusterLayer = layers[1];
      expect(clusterLayer, isA<CircleStyleLayer>());
      expect(clusterLayer.id, '${layer.getLayerId(0)}-clusters');
      expect(clusterLayer.filter, ['has', 'point_count']);

      final countLayer = layers[2];
      expect(countLayer, isA<SymbolStyleLayer>());
      expect(countLayer.id, '${layer.getLayerId(0)}-cluster-count');
      expect(countLayer.filter, ['has', 'point_count']);
      expect(countLayer.layout['text-field'], [
        'get',
        'point_count_abbreviated',
      ]);
    });
  });
}
