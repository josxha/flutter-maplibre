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

    late StyleController style;
    setUp(() {
      style = MockStyleController();
      when(() => style.addSource(any())).thenAnswer((_) async {});
      when(() => style.removeSource(any())).thenAnswer((_) async {});
      when(
        () => style.updateGeoJsonSource(
          id: any(named: 'id'),
          data: any(named: 'data'),
        ),
      ).thenAnswer((_) async {});
      when(() => style.addLayer(any())).thenAnswer((_) async {});
      when(() => style.removeLayer(any())).thenAnswer((_) async {});
    });

    testWidgets('add and remove layers', (tester) async {
      final manager = LayerManager(style, []);
      final layer1 = CircleLayer(
        circles: Layer.generateFeatureList(
          [
            Point(coordinates: Position(0, 0)),
          ],
        ),
      );

      manager.updateLayers([layer1]);
      verify(() => style.addSource(any(that: isA<GeoJsonSource>()))).called(1);
      verify(() => style.addLayer(any(that: isA<CircleStyleLayer>())))
          .called(1);
      verifyNoMoreInteractions(style);

      manager.updateLayers([layer1]);
      verify(
        () => style.updateGeoJsonSource(
          id: any(named: 'id'),
          data: any(named: 'data'),
        ),
      ).called(1);
      verifyNoMoreInteractions(style);

      manager.updateLayers([]);
      verify(() => style.removeLayer(any())).called(1);
      verify(() => style.removeSource(any())).called(1);
      verifyNoMoreInteractions(style);
    });
  });
}
