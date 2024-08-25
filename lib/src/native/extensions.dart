import 'dart:ui';

import 'package:geotypes/geotypes.dart';
import 'package:maplibre/src/native/pigeon.g.dart';

extension PositionExt on Position {
    LngLat toLngLat() => LngLat(lng: lng.toDouble(), lat: lat.toDouble());
}

extension LngLatExt on LngLat {
    Position toPosition() => Position(lng, lat);
}

extension OffsetExt on Offset {
    ScreenLocation toScreenLocation() => ScreenLocation(x: dx, y: dy);
}
