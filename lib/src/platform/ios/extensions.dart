import 'package:geotypes/geotypes.dart';
import 'package:maplibre_ios/maplibre_ffi.dart';

/// Internal extensions on [CLLocationCoordinate2D].
extension CLLocationCoordinate2DExt on CLLocationCoordinate2D {
  /// Convert a [CLLocationCoordinate2D] to [Position].
  Position toPosition() => Position(longitude, latitude);
}
