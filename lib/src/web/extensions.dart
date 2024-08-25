import 'package:geotypes/geotypes.dart';
import 'package:maplibre/src/web/interop/interop.dart' as interop;

extension PositionExt on Position {
  interop.LngLat toLngLat() => interop.LngLat.fromPosition(this);
}
