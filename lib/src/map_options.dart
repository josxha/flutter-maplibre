import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:turf/helpers.dart';

@immutable
class MapLibreMapOptions {
  MapLibreMapOptions({
    this.style = 'https://demotiles.maplibre.org/style.json',
    this.zoom = 0,
    Position? center,
  }) : center = center ?? Position(9, 47);

  final String style;
  final double zoom;
  final Position center;

  Map<String, Object?> toJson() => <String, Object?>{
        'style': style,
        'zoom': zoom,
        'center': {'lng': center.lng, 'lat': center.lat},
      };
}
