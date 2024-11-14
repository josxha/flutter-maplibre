import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/layer/layer_manager.dart';
import 'package:mocktail/mocktail.dart';

import '../shared/mocks.dart';

class MockSource extends Mock implements Source {}

class MockStyleLayer extends Mock implements StyleLayer {}

void main() {
  group('AnnotationManager', () {
    setUpAll(() {
      registerFallbackValue(MockSource());
      registerFallbackValue(MockStyleLayer());
    });

    late MapController controller;
    setUp(() {
      controller = MockMapController();
      when(() => controller.addSource(any())).thenAnswer((_) async {});
      when(() => controller.removeSource(any())).thenAnswer((_) async {});
      when(
        () => controller.updateGeoJsonSource(
          id: any(named: 'id'),
          data: any(named: 'data'),
        ),
      ).thenAnswer((_) async {});
      when(() => controller.addLayer(any())).thenAnswer((_) async {});
      when(() => controller.removeLayer(any())).thenAnswer((_) async {});
    });

    testWidgets('add and remove layers', (tester) async {
      final manager = LayerManager(controller, []);
      final layer1 = CircleLayer(points: [Point(coordinates: Position(0, 0))]);

      manager.updateLayers([layer1]);
      verify(() => controller.addSource(any(that: isA<GeoJsonSource>())))
          .called(1);
      verify(() => controller.addLayer(any(that: isA<CircleStyleLayer>())))
          .called(1);
      verifyNoMoreInteractions(controller);

      manager.updateLayers([layer1]);
      verify(
        () => controller.updateGeoJsonSource(
          id: any(named: 'id'),
          data: any(named: 'data'),
        ),
      ).called(1);
      verifyNoMoreInteractions(controller);

      manager.updateLayers([]);
      verify(() => controller.removeLayer(any())).called(1);
      verify(() => controller.removeSource(any())).called(1);
      verifyNoMoreInteractions(controller);
    });
  });
}
