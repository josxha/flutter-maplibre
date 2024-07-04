// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MapLibreMapOptions _$MapLibreMapOptionsFromJson(Map<String, dynamic> json) {
  return _MapLibreMapOptions.fromJson(json);
}

/// @nodoc
mixin _$MapLibreMapOptions {
  String get style => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MapLibreMapOptionsCopyWith<MapLibreMapOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapLibreMapOptionsCopyWith<$Res> {
  factory $MapLibreMapOptionsCopyWith(
          MapLibreMapOptions value, $Res Function(MapLibreMapOptions) then) =
      _$MapLibreMapOptionsCopyWithImpl<$Res, MapLibreMapOptions>;
  @useResult
  $Res call({String style});
}

/// @nodoc
class _$MapLibreMapOptionsCopyWithImpl<$Res, $Val extends MapLibreMapOptions>
    implements $MapLibreMapOptionsCopyWith<$Res> {
  _$MapLibreMapOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? style = null,
  }) {
    return _then(_value.copyWith(
      style: null == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MapLibreMapOptionsImplCopyWith<$Res>
    implements $MapLibreMapOptionsCopyWith<$Res> {
  factory _$$MapLibreMapOptionsImplCopyWith(_$MapLibreMapOptionsImpl value,
          $Res Function(_$MapLibreMapOptionsImpl) then) =
      __$$MapLibreMapOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String style});
}

/// @nodoc
class __$$MapLibreMapOptionsImplCopyWithImpl<$Res>
    extends _$MapLibreMapOptionsCopyWithImpl<$Res, _$MapLibreMapOptionsImpl>
    implements _$$MapLibreMapOptionsImplCopyWith<$Res> {
  __$$MapLibreMapOptionsImplCopyWithImpl(_$MapLibreMapOptionsImpl _value,
      $Res Function(_$MapLibreMapOptionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? style = null,
  }) {
    return _then(_$MapLibreMapOptionsImpl(
      style: null == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MapLibreMapOptionsImpl implements _MapLibreMapOptions {
  const _$MapLibreMapOptionsImpl(
      {this.style = 'https://demotiles.maplibre.org/style.json'});

  factory _$MapLibreMapOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MapLibreMapOptionsImplFromJson(json);

  @override
  @JsonKey()
  final String style;

  @override
  String toString() {
    return 'MapLibreMapOptions(style: $style)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapLibreMapOptionsImpl &&
            (identical(other.style, style) || other.style == style));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, style);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MapLibreMapOptionsImplCopyWith<_$MapLibreMapOptionsImpl> get copyWith =>
      __$$MapLibreMapOptionsImplCopyWithImpl<_$MapLibreMapOptionsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MapLibreMapOptionsImplToJson(
      this,
    );
  }
}

abstract class _MapLibreMapOptions implements MapLibreMapOptions {
  const factory _MapLibreMapOptions({final String style}) =
      _$MapLibreMapOptionsImpl;

  factory _MapLibreMapOptions.fromJson(Map<String, dynamic> json) =
      _$MapLibreMapOptionsImpl.fromJson;

  @override
  String get style;
  @override
  @JsonKey(ignore: true)
  _$$MapLibreMapOptionsImplCopyWith<_$MapLibreMapOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
