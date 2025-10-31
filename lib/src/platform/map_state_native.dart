import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/map_state.dart';

/// The implementation that gets used for state of the [MapLibreMap] widget on
/// android using JNI and Pigeon as a fallback.
abstract class MapLibreMapStateNative extends MapLibreMapState {}
