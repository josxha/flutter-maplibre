import 'dart:ui';

import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:mocktail/mocktail.dart';

class MockMapController extends Mock implements MapController {}

class MockStyleController extends Mock implements StyleController {}

class MockMapCamera extends Mock implements MapCamera {}

class MockMapOptions extends Mock implements MapOptions {}

class MockDuration extends Mock implements Duration {}

class MockGeographic extends Mock implements Geographic {}

class MockOffset extends Mock implements Offset {}

class MockCircleStyleLayer extends Mock implements CircleStyleLayer {}

class MockPlatformInterface extends MapLibrePlatform {
  @override
  CircleStyleLayer createCircleStyleLayer({
    required String id,
    required String sourceId,
    required String? sourceLayerId,
    required Expression? filter,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<Offset> translate,
    required PropertyValue<ReferenceSpace> translateAnchor,
    required PropertyValue<double>? sortKey,
    required PropertyValue<double> radius,
    required PropertyValue<Color> color,
    required PropertyValue<double> blur,
    required PropertyValue<double> opacity,
    required PropertyValue<ReferenceSpace> pitchScale,
    required PropertyValue<ReferenceSpace> pitchAlignment,
    required PropertyValue<double> strokeWidth,
    required PropertyValue<Color> strokeColor,
    required PropertyValue<double> strokeOpacity,
  }) => MockCircleStyleLayer();
}
