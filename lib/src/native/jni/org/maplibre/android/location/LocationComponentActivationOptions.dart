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

import '../maps/Style.dart' as style_;

import 'LocationComponentOptions.dart' as locationcomponentoptions_;

import 'engine/LocationEngine.dart' as locationengine_;

import 'engine/LocationEngineRequest.dart' as locationenginerequest_;

/// from: `org.maplibre.android.location.LocationComponentActivationOptions$Builder`
class LocationComponentActivationOptions_Builder extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<LocationComponentActivationOptions_Builder> $type;

  @_$jni.internal
  LocationComponentActivationOptions_Builder.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = _$jni.JClass.forName(
      r'org/maplibre/android/location/LocationComponentActivationOptions$Builder');

  /// The type which includes information such as the signature of this class.
  static const type = $LocationComponentActivationOptions_Builder$Type();
  static final _id_new$ = _class.constructorId(
    r'(Landroid/content/Context;Lorg/maplibre/android/maps/Style;)V',
  );

  static final _new$ = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void <init>(android.content.Context context, org.maplibre.android.maps.Style style)`
  /// The returned object must be released after use, by calling the [release] method.
  factory LocationComponentActivationOptions_Builder(
    _$jni.JObject context,
    style_.Style style,
  ) {
    return LocationComponentActivationOptions_Builder.fromReference(_new$(
            _class.reference.pointer,
            _id_new$ as _$jni.JMethodIDPtr,
            context.reference.pointer,
            style.reference.pointer)
        .reference);
  }

  static final _id_locationEngine = _class.instanceMethodId(
    r'locationEngine',
    r'(Lorg/maplibre/android/location/engine/LocationEngine;)Lorg/maplibre/android/location/LocationComponentActivationOptions$Builder;',
  );

  static final _locationEngine = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public org.maplibre.android.location.LocationComponentActivationOptions$Builder locationEngine(org.maplibre.android.location.engine.LocationEngine locationEngine)`
  /// The returned object must be released after use, by calling the [release] method.
  LocationComponentActivationOptions_Builder locationEngine(
    locationengine_.LocationEngine locationEngine,
  ) {
    return _locationEngine(
            reference.pointer,
            _id_locationEngine as _$jni.JMethodIDPtr,
            locationEngine.reference.pointer)
        .object(const $LocationComponentActivationOptions_Builder$Type());
  }

  static final _id_locationEngineRequest = _class.instanceMethodId(
    r'locationEngineRequest',
    r'(Lorg/maplibre/android/location/engine/LocationEngineRequest;)Lorg/maplibre/android/location/LocationComponentActivationOptions$Builder;',
  );

  static final _locationEngineRequest = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public org.maplibre.android.location.LocationComponentActivationOptions$Builder locationEngineRequest(org.maplibre.android.location.engine.LocationEngineRequest locationEngineRequest)`
  /// The returned object must be released after use, by calling the [release] method.
  LocationComponentActivationOptions_Builder locationEngineRequest(
    locationenginerequest_.LocationEngineRequest locationEngineRequest,
  ) {
    return _locationEngineRequest(
            reference.pointer,
            _id_locationEngineRequest as _$jni.JMethodIDPtr,
            locationEngineRequest.reference.pointer)
        .object(const $LocationComponentActivationOptions_Builder$Type());
  }

  static final _id_locationComponentOptions = _class.instanceMethodId(
    r'locationComponentOptions',
    r'(Lorg/maplibre/android/location/LocationComponentOptions;)Lorg/maplibre/android/location/LocationComponentActivationOptions$Builder;',
  );

  static final _locationComponentOptions = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public org.maplibre.android.location.LocationComponentActivationOptions$Builder locationComponentOptions(org.maplibre.android.location.LocationComponentOptions locationComponentOptions)`
  /// The returned object must be released after use, by calling the [release] method.
  LocationComponentActivationOptions_Builder locationComponentOptions(
    locationcomponentoptions_.LocationComponentOptions locationComponentOptions,
  ) {
    return _locationComponentOptions(
            reference.pointer,
            _id_locationComponentOptions as _$jni.JMethodIDPtr,
            locationComponentOptions.reference.pointer)
        .object(const $LocationComponentActivationOptions_Builder$Type());
  }

  static final _id_styleRes = _class.instanceMethodId(
    r'styleRes',
    r'(I)Lorg/maplibre/android/location/LocationComponentActivationOptions$Builder;',
  );

  static final _styleRes = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<(_$jni.Int32,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, int)>();

  /// from: `public org.maplibre.android.location.LocationComponentActivationOptions$Builder styleRes(int i)`
  /// The returned object must be released after use, by calling the [release] method.
  LocationComponentActivationOptions_Builder styleRes(
    int i,
  ) {
    return _styleRes(reference.pointer, _id_styleRes as _$jni.JMethodIDPtr, i)
        .object(const $LocationComponentActivationOptions_Builder$Type());
  }

  static final _id_useDefaultLocationEngine = _class.instanceMethodId(
    r'useDefaultLocationEngine',
    r'(Z)Lorg/maplibre/android/location/LocationComponentActivationOptions$Builder;',
  );

  static final _useDefaultLocationEngine = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<(_$jni.Int32,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, int)>();

  /// from: `public org.maplibre.android.location.LocationComponentActivationOptions$Builder useDefaultLocationEngine(boolean z)`
  /// The returned object must be released after use, by calling the [release] method.
  LocationComponentActivationOptions_Builder useDefaultLocationEngine(
    bool z,
  ) {
    return _useDefaultLocationEngine(reference.pointer,
            _id_useDefaultLocationEngine as _$jni.JMethodIDPtr, z ? 1 : 0)
        .object(const $LocationComponentActivationOptions_Builder$Type());
  }

  static final _id_useSpecializedLocationLayer = _class.instanceMethodId(
    r'useSpecializedLocationLayer',
    r'(Z)Lorg/maplibre/android/location/LocationComponentActivationOptions$Builder;',
  );

  static final _useSpecializedLocationLayer =
      _$jni.ProtectedJniExtensions.lookup<
                  _$jni.NativeFunction<
                      _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
                          _$jni.JMethodIDPtr, _$jni.VarArgs<(_$jni.Int32,)>)>>(
              'globalEnv_CallObjectMethod')
          .asFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, int)>();

  /// from: `public org.maplibre.android.location.LocationComponentActivationOptions$Builder useSpecializedLocationLayer(boolean z)`
  /// The returned object must be released after use, by calling the [release] method.
  LocationComponentActivationOptions_Builder useSpecializedLocationLayer(
    bool z,
  ) {
    return _useSpecializedLocationLayer(reference.pointer,
            _id_useSpecializedLocationLayer as _$jni.JMethodIDPtr, z ? 1 : 0)
        .object(const $LocationComponentActivationOptions_Builder$Type());
  }

  static final _id_build = _class.instanceMethodId(
    r'build',
    r'()Lorg/maplibre/android/location/LocationComponentActivationOptions;',
  );

  static final _build = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.location.LocationComponentActivationOptions build()`
  /// The returned object must be released after use, by calling the [release] method.
  LocationComponentActivationOptions build() {
    return _build(reference.pointer, _id_build as _$jni.JMethodIDPtr)
        .object(const $LocationComponentActivationOptions$Type());
  }
}

final class $LocationComponentActivationOptions_Builder$Type
    extends _$jni.JObjType<LocationComponentActivationOptions_Builder> {
  @_$jni.internal
  const $LocationComponentActivationOptions_Builder$Type();

  @_$jni.internal
  @_$core.override
  String get signature =>
      r'Lorg/maplibre/android/location/LocationComponentActivationOptions$Builder;';

  @_$jni.internal
  @_$core.override
  LocationComponentActivationOptions_Builder fromReference(
          _$jni.JReference reference) =>
      LocationComponentActivationOptions_Builder.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode =>
      ($LocationComponentActivationOptions_Builder$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($LocationComponentActivationOptions_Builder$Type) &&
        other is $LocationComponentActivationOptions_Builder$Type;
  }
}

/// from: `org.maplibre.android.location.LocationComponentActivationOptions`
class LocationComponentActivationOptions extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<LocationComponentActivationOptions> $type;

  @_$jni.internal
  LocationComponentActivationOptions.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = _$jni.JClass.forName(
      r'org/maplibre/android/location/LocationComponentActivationOptions');

  /// The type which includes information such as the signature of this class.
  static const type = $LocationComponentActivationOptions$Type();
  static final _id_builder = _class.staticMethodId(
    r'builder',
    r'(Landroid/content/Context;Lorg/maplibre/android/maps/Style;)Lorg/maplibre/android/location/LocationComponentActivationOptions$Builder;',
  );

  static final _builder = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_CallStaticObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `static public org.maplibre.android.location.LocationComponentActivationOptions$Builder builder(android.content.Context context, org.maplibre.android.maps.Style style)`
  /// The returned object must be released after use, by calling the [release] method.
  static LocationComponentActivationOptions_Builder builder(
    _$jni.JObject context,
    style_.Style style,
  ) {
    return _builder(_class.reference.pointer, _id_builder as _$jni.JMethodIDPtr,
            context.reference.pointer, style.reference.pointer)
        .object(const $LocationComponentActivationOptions_Builder$Type());
  }

  static final _id_context = _class.instanceMethodId(
    r'context',
    r'()Landroid/content/Context;',
  );

  static final _context = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public android.content.Context context()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JObject context() {
    return _context(reference.pointer, _id_context as _$jni.JMethodIDPtr)
        .object(const _$jni.JObjectType());
  }

  static final _id_style = _class.instanceMethodId(
    r'style',
    r'()Lorg/maplibre/android/maps/Style;',
  );

  static final _style = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.maps.Style style()`
  /// The returned object must be released after use, by calling the [release] method.
  style_.Style style() {
    return _style(reference.pointer, _id_style as _$jni.JMethodIDPtr)
        .object(const style_.$Style$Type());
  }

  static final _id_locationEngine = _class.instanceMethodId(
    r'locationEngine',
    r'()Lorg/maplibre/android/location/engine/LocationEngine;',
  );

  static final _locationEngine = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.location.engine.LocationEngine locationEngine()`
  /// The returned object must be released after use, by calling the [release] method.
  locationengine_.LocationEngine locationEngine() {
    return _locationEngine(
            reference.pointer, _id_locationEngine as _$jni.JMethodIDPtr)
        .object(const locationengine_.$LocationEngine$Type());
  }

  static final _id_locationEngineRequest = _class.instanceMethodId(
    r'locationEngineRequest',
    r'()Lorg/maplibre/android/location/engine/LocationEngineRequest;',
  );

  static final _locationEngineRequest = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.location.engine.LocationEngineRequest locationEngineRequest()`
  /// The returned object must be released after use, by calling the [release] method.
  locationenginerequest_.LocationEngineRequest locationEngineRequest() {
    return _locationEngineRequest(
            reference.pointer, _id_locationEngineRequest as _$jni.JMethodIDPtr)
        .object(const locationenginerequest_.$LocationEngineRequest$Type());
  }

  static final _id_locationComponentOptions = _class.instanceMethodId(
    r'locationComponentOptions',
    r'()Lorg/maplibre/android/location/LocationComponentOptions;',
  );

  static final _locationComponentOptions = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.location.LocationComponentOptions locationComponentOptions()`
  /// The returned object must be released after use, by calling the [release] method.
  locationcomponentoptions_.LocationComponentOptions
      locationComponentOptions() {
    return _locationComponentOptions(reference.pointer,
            _id_locationComponentOptions as _$jni.JMethodIDPtr)
        .object(
            const locationcomponentoptions_.$LocationComponentOptions$Type());
  }

  static final _id_styleRes = _class.instanceMethodId(
    r'styleRes',
    r'()I',
  );

  static final _styleRes = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallIntMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public int styleRes()`
  int styleRes() {
    return _styleRes(reference.pointer, _id_styleRes as _$jni.JMethodIDPtr)
        .integer;
  }

  static final _id_useDefaultLocationEngine = _class.instanceMethodId(
    r'useDefaultLocationEngine',
    r'()Z',
  );

  static final _useDefaultLocationEngine = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallBooleanMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public boolean useDefaultLocationEngine()`
  bool useDefaultLocationEngine() {
    return _useDefaultLocationEngine(reference.pointer,
            _id_useDefaultLocationEngine as _$jni.JMethodIDPtr)
        .boolean;
  }

  static final _id_useSpecializedLocationLayer = _class.instanceMethodId(
    r'useSpecializedLocationLayer',
    r'()Z',
  );

  static final _useSpecializedLocationLayer =
      _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                    _$jni.Pointer<_$jni.Void>,
                    _$jni.JMethodIDPtr,
                  )>>('globalEnv_CallBooleanMethod')
          .asFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>();

  /// from: `public boolean useSpecializedLocationLayer()`
  bool useSpecializedLocationLayer() {
    return _useSpecializedLocationLayer(reference.pointer,
            _id_useSpecializedLocationLayer as _$jni.JMethodIDPtr)
        .boolean;
  }
}

final class $LocationComponentActivationOptions$Type
    extends _$jni.JObjType<LocationComponentActivationOptions> {
  @_$jni.internal
  const $LocationComponentActivationOptions$Type();

  @_$jni.internal
  @_$core.override
  String get signature =>
      r'Lorg/maplibre/android/location/LocationComponentActivationOptions;';

  @_$jni.internal
  @_$core.override
  LocationComponentActivationOptions fromReference(
          _$jni.JReference reference) =>
      LocationComponentActivationOptions.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode => ($LocationComponentActivationOptions$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LocationComponentActivationOptions$Type) &&
        other is $LocationComponentActivationOptions$Type;
  }
}
