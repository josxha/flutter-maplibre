import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

void main() {
  group('LineStyleLayerController', () {
    const gradient = [
      'step',
      ['line-progress'],
      '#F00',
      0.5,
      'rgba(0, 0, 0, 0)',
    ];

    test('reads the properties it was looked up with', () {
      final line = LineStyleLayerController(
        id: 'line',
        paint: {'line-gradient': List<Object?>.of(gradient)},
        setPaintProperty: (_, _) => fail('nothing was set'),
      );
      expect(line.lineGradient, gradient);
    });

    test('reads null for a property the layer lacks', () {
      final line = LineStyleLayerController(
        id: 'line',
        paint: {'line-gradient': null},
        setPaintProperty: (_, _) => fail('nothing was set'),
      );
      expect(line.lineGradient, isNull);
    });

    test('updates the map and reads back what it set', () {
      final updates = <(String, Object?)>[];
      final line = LineStyleLayerController(
        id: 'line',
        paint: {'line-gradient': null},
        setPaintProperty: (name, value) => updates.add((name, value)),
      )..lineGradient = gradient;
      expect(updates, [('line-gradient', gradient)]);
      expect(line.lineGradient, gradient);

      line.lineGradient = null;
      expect(updates.last, ('line-gradient', null));
      expect(line.lineGradient, isNull);
    });
  });
}
