import 'package:geotypes/geotypes.dart';
import 'package:maplibre/src/web/interop/interop.dart' as interop;

/// Extension methods for the [Position] class. Not exported publicly.
extension PositionExt on Position {
  /// Convert a [Position] to an internal [interop.LngLat].
  interop.LngLat toLngLat() => interop.LngLat.fromPosition(this);
}
