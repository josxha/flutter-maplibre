import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mocktail/mocktail.dart';

import '../shared/mocks.dart';

class DraggableStyleLayer extends Mock implements StyleLayer {
  @override
  bool get draggable => true;
}

class NonDraggableStyleLayer extends Mock implements StyleLayer {
  @override
  bool get draggable => false;
}

void main() {
  group('StyleController', () {
    setUpAll(() {
      registerFallbackValue(DraggableStyleLayer());
      registerFallbackValue(NonDraggableStyleLayer());
      registerFallbackValue(MockStyleController());
    });

    late StyleController style;
    setUp(() {
      style = MockStyleController();
      when(() => style.getDraggableLayers()).thenReturn([]);
      when(() => style.addLayer(any(), belowLayerId: any(named: 'belowLayerId'))).thenAnswer((invocation) async {
        final layer = invocation.positionalArguments[0] as StyleLayer;
        if (layer.draggable) {
          style.getDraggableLayers().add(layer);
        }
      });
    });

    test('add and remove draggable layers', () async {
      final draggableLayer = DraggableStyleLayer();
      final nonDraggableLayer = NonDraggableStyleLayer();
      final layers = <StyleLayer>[];
      when(() => style.getDraggableLayers()).thenReturn(layers);

      await style.addLayer(draggableLayer);
      await style.addLayer(nonDraggableLayer);
      expect(style.getDraggableLayers(), contains(draggableLayer));
      expect(style.getDraggableLayers(), isNot(contains(nonDraggableLayer)));

      layers.remove(draggableLayer);
      expect(style.getDraggableLayers(), isNot(contains(draggableLayer)));
    });

    test('clear draggable layers', () async {
      final draggableLayer1 = DraggableStyleLayer();
      final draggableLayer2 = DraggableStyleLayer();
      final nonDraggableLayer = NonDraggableStyleLayer();
      final layers = <StyleLayer>[];
      when(() => style.getDraggableLayers()).thenReturn(layers);

      await style.addLayer(draggableLayer1);
      await style.addLayer(draggableLayer2);
      await style.addLayer(nonDraggableLayer);
      expect(style.getDraggableLayers().length, 2);
      expect(style.getDraggableLayers(), isNot(contains(nonDraggableLayer)));

      layers.clear();
      expect(style.getDraggableLayers(), isEmpty);
    });
  });
}
