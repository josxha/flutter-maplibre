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
      when(() => style.draggableLayers).thenReturn([]);
      when(() => style.addLayer(any())).thenAnswer((invocation) async {
        final layer = invocation.positionalArguments[0] as StyleLayer;
        if (layer.draggable) {
          style.draggableLayers.add(layer);
        }
      });
    });

    test('add and remove draggable layers', () {
      final draggableLayer = DraggableStyleLayer();
      final nonDraggableLayer = NonDraggableStyleLayer();
      final layers = <StyleLayer>[];
      when(() => style.draggableLayers).thenReturn(layers);

      style.addLayer(draggableLayer);
      style.addLayer(nonDraggableLayer);
      expect(style.draggableLayers, contains(draggableLayer));
      expect(style.draggableLayers, isNot(contains(nonDraggableLayer)));

      layers.remove(draggableLayer);
      expect(style.draggableLayers, isNot(contains(draggableLayer)));
    });

    test('clear draggable layers', () {
      final draggableLayer1 = DraggableStyleLayer();
      final draggableLayer2 = DraggableStyleLayer();
      final nonDraggableLayer = NonDraggableStyleLayer();
      final layers = <StyleLayer>[];
      when(() => style.draggableLayers).thenReturn(layers);

      style.addLayer(draggableLayer1);
      style.addLayer(draggableLayer2);
      style.addLayer(nonDraggableLayer);
      expect(style.draggableLayers.length, 2);
      expect(style.draggableLayers, isNot(contains(nonDraggableLayer)));

      layers.clear();
      expect(style.draggableLayers, isEmpty);
    });
  });
}
