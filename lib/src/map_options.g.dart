// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MapLibreMapOptionsImpl _$$MapLibreMapOptionsImplFromJson(
        Map<String, dynamic> json) =>
    _$MapLibreMapOptionsImpl(
      style: json['style'] as String? ??
          'https://demotiles.maplibre.org/style.json',
      zoom: (json['zoom'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$MapLibreMapOptionsImplToJson(
        _$MapLibreMapOptionsImpl instance) =>
    <String, dynamic>{
      'style': instance.style,
      'zoom': instance.zoom,
    };
