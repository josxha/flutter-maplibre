import 'package:geotypes/geotypes.dart';
import 'package:maplibre/src/native/pigeon.g.dart';

extension PositionExt on Position {
    LngLat toLngLat() => LngLat(lng: lng.toDouble(), lat: lat.toDouble());
}
