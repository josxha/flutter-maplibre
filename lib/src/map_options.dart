import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geotypes/geotypes.dart';

@immutable
class MapOptions {
  MapOptions({
    this.style = 'https://demotiles.maplibre.org/style.json',
    this.zoom = 0,
    Position? center,
    this.controls = const [],
  }) : center = center ?? Position(9, 47);

  final String style;
  final double zoom;
  final Position center;
  final List<MapControl> controls;

  Map<String, Object?> toJson() => <String, Object?>{
        'style': style,
        'zoom': zoom,
        'center': {'lng': center.lng, 'lat': center.lat},
      };
}

@immutable
sealed class MapControl {
  const MapControl();
}

@immutable
class ScaleControl extends MapControl {
  const ScaleControl({
    this.maxWidth = 100,
    this.unit = Unit.metric,
  });

  /// The maximum length of the scale control in pixels.
  final num maxWidth;

  /// Unit of the distance (`'imperial'`, `'metric'` or `'nautical'`).
  final Unit unit;
}

enum Unit { imperial, metric, nautical }
