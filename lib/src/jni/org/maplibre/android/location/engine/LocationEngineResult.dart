// Autogenerated by jnigen. DO NOT EDIT!

// ignore_for_file: public_member_api_docs
// ignore_for_file: require_trailing_commas
// ignore_for_file: unnecessary_raw_strings
// ignore_for_file: avoid_field_initializers_in_const_classes
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
// ignore_for_file: sort_constructors_first
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: sort_unnamed_constructors_first
// ignore_for_file: always_use_package_imports
// ignore_for_file: use_late_for_private_fields_and_variables
// ignore_for_file: one_member_abstracts
// ignore_for_file: always_put_required_named_parameters_first

// Autogenerated by jnigen. DO NOT EDIT!

// ignore_for_file: annotate_overrides
// ignore_for_file: argument_type_not_assignable
// ignore_for_file: camel_case_extensions
// ignore_for_file: camel_case_types
// ignore_for_file: constant_identifier_names
// ignore_for_file: doc_directive_unknown
// ignore_for_file: file_names
// ignore_for_file: inference_failure_on_untyped_parameter
// ignore_for_file: invalid_internal_annotation
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: library_prefixes
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: no_leading_underscores_for_library_prefixes
// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: only_throw_errors
// ignore_for_file: overridden_fields
// ignore_for_file: prefer_double_quotes
// ignore_for_file: unintended_html_in_doc_comment
// ignore_for_file: unnecessary_cast
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable
// ignore_for_file: unused_shown_name
// ignore_for_file: use_super_parameters

import 'dart:core' show Object, String, bool, double, int;
import 'dart:core' as _$core;

import 'package:jni/_internal.dart' as _$jni;
import 'package:jni/jni.dart' as _$jni;

import '../../../../../android/location/Location.dart' as location_;

/// from: `org.maplibre.android.location.engine.LocationEngineResult`
class LocationEngineResult extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<LocationEngineResult> $type;

  @_$jni.internal
  LocationEngineResult.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = _$jni.JClass.forName(
      r'org/maplibre/android/location/engine/LocationEngineResult');

  /// The type which includes information such as the signature of this class.
  static const type = $LocationEngineResult$Type();
  static final _id_create = _class.staticMethodId(
    r'create',
    r'(Landroid/location/Location;)Lorg/maplibre/android/location/engine/LocationEngineResult;',
  );

  static final _create = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `static public org.maplibre.android.location.engine.LocationEngineResult create(android.location.Location location)`
  /// The returned object must be released after use, by calling the [release] method.
  static LocationEngineResult create(
    location_.Location location,
  ) {
    return _create(_class.reference.pointer, _id_create as _$jni.JMethodIDPtr,
            location.reference.pointer)
        .object(const $LocationEngineResult$Type());
  }

  static final _id_create$1 = _class.staticMethodId(
    r'create',
    r'(Ljava/util/List;)Lorg/maplibre/android/location/engine/LocationEngineResult;',
  );

  static final _create$1 = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `static public org.maplibre.android.location.engine.LocationEngineResult create(java.util.List list)`
  /// The returned object must be released after use, by calling the [release] method.
  static LocationEngineResult create$1(
    _$jni.JList<location_.Location> list,
  ) {
    return _create$1(_class.reference.pointer,
            _id_create$1 as _$jni.JMethodIDPtr, list.reference.pointer)
        .object(const $LocationEngineResult$Type());
  }

  static final _id_getLastLocation = _class.instanceMethodId(
    r'getLastLocation',
    r'()Landroid/location/Location;',
  );

  static final _getLastLocation = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public android.location.Location getLastLocation()`
  /// The returned object must be released after use, by calling the [release] method.
  location_.Location getLastLocation() {
    return _getLastLocation(
            reference.pointer, _id_getLastLocation as _$jni.JMethodIDPtr)
        .object(const location_.$Location$Type());
  }

  static final _id_getLocations = _class.instanceMethodId(
    r'getLocations',
    r'()Ljava/util/List;',
  );

  static final _getLocations = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public java.util.List getLocations()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JList<location_.Location> getLocations() {
    return _getLocations(
            reference.pointer, _id_getLocations as _$jni.JMethodIDPtr)
        .object(const _$jni.JListType(location_.$Location$Type()));
  }

  static final _id_extractResult = _class.staticMethodId(
    r'extractResult',
    r'(Landroid/content/Intent;)Lorg/maplibre/android/location/engine/LocationEngineResult;',
  );

  static final _extractResult = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `static public org.maplibre.android.location.engine.LocationEngineResult extractResult(android.content.Intent intent)`
  /// The returned object must be released after use, by calling the [release] method.
  static LocationEngineResult extractResult(
    _$jni.JObject intent,
  ) {
    return _extractResult(_class.reference.pointer,
            _id_extractResult as _$jni.JMethodIDPtr, intent.reference.pointer)
        .object(const $LocationEngineResult$Type());
  }
}

final class $LocationEngineResult$Type
    extends _$jni.JObjType<LocationEngineResult> {
  @_$jni.internal
  const $LocationEngineResult$Type();

  @_$jni.internal
  @_$core.override
  String get signature =>
      r'Lorg/maplibre/android/location/engine/LocationEngineResult;';

  @_$jni.internal
  @_$core.override
  LocationEngineResult fromReference(_$jni.JReference reference) =>
      LocationEngineResult.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode => ($LocationEngineResult$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LocationEngineResult$Type) &&
        other is $LocationEngineResult$Type;
  }
}
