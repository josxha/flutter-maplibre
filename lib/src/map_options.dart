import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geotypes/geotypes.dart';

@immutable
class MapOptions {
  const MapOptions({
    this.style = 'https://demotiles.maplibre.org/style.json',
    this.zoom = 0,
    this.center,
    this.controls = const [],
  });

  final String style;
  final double zoom;
  final Position? center;
  final List<MapControl> controls;

  Map<String, Object?> toJson() => <String, Object?>{
        'style': style,
        'zoom': zoom,
        'center':
            center == null ? null : {'lng': center!.lng, 'lat': center!.lat},
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

@immutable
class GeolocateControl extends MapControl {
  const GeolocateControl({
    this.positionOptions = const PositionOptions(),
    this.fitBoundsOptions,
    this.trackUserLocation = false,
    this.showAccuracyCircle = true,
    this.showUserLocation = true,
  });

  final PositionOptions positionOptions;
  final FitBoundsOptions? fitBoundsOptions;
  final bool trackUserLocation;
  final bool showAccuracyCircle;
  final bool showUserLocation;
}

@immutable
class PositionOptions {
  const PositionOptions({
    this.enableHighAccuracy = false,
    this.timeout = const Duration(seconds: 6),
    this.maximumAge = Duration.zero,
  });

  final bool enableHighAccuracy;
  final Duration timeout;
  final Duration maximumAge;
}

@immutable
class FitBoundsOptions {
  const FitBoundsOptions();
}

@immutable
class AttributionControl extends MapControl {
  const AttributionControl({
    this.compact = true,
    this.customAttribution =
        '<a href="https://maplibre.org/" target="_blank">MapLibre</a>',
  });

  final bool compact;
  final String customAttribution;
}

@immutable
class FullscreenControl extends MapControl {
  const FullscreenControl();
}
