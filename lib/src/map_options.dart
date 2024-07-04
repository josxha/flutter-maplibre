import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_options.freezed.dart';

part 'map_options.g.dart';

@immutable
@freezed
class MapLibreMapOptions with _$MapLibreMapOptions {
  const factory MapLibreMapOptions({
    @Default('https://demotiles.maplibre.org/style.json') String style,
  }) = _MapLibreMapOptions;

  factory MapLibreMapOptions.fromJson(Map<String, Object?> json) =>
      _$MapLibreMapOptionsFromJson(json);
}
