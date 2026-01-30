import 'dart:ui';

import 'package:maplibre/maplibre.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:mocktail/mocktail.dart';

class MockMapController extends Mock implements MapController {}

class MockStyleController extends Mock implements StyleController {}

class MockMapCamera extends Mock implements MapCamera {}

class MockMapOptions extends Mock implements MapOptions {}

class MockDuration extends Mock implements Duration {}

class MockGeographic extends Mock implements Geographic {}

class MockOffset extends Mock implements Offset {}
