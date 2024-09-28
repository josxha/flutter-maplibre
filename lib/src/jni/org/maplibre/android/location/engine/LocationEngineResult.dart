// Autogenerated by jnigen. DO NOT EDIT!

// ignore_for_file: annotate_overrides
// ignore_for_file: argument_type_not_assignable
// ignore_for_file: camel_case_extensions
// ignore_for_file: camel_case_types
// ignore_for_file: constant_identifier_names
// ignore_for_file: doc_directive_unknown
// ignore_for_file: file_names
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: only_throw_errors
// ignore_for_file: overridden_fields
// ignore_for_file: prefer_double_quotes
// ignore_for_file: unnecessary_cast
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable
// ignore_for_file: unused_shown_name
// ignore_for_file: use_super_parameters

import 'dart:ffi' as ffi;
import 'dart:isolate' show ReceivePort;

import 'package:jni/internal_helpers_for_jnigen.dart';
import 'package:jni/jni.dart' as jni;

/// from: `org.maplibre.android.location.engine.LocationEngineResult`
class LocationEngineResult extends jni.JObject {
  @override
  late final jni.JObjType<LocationEngineResult> $type = type;

  LocationEngineResult.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/location/engine/LocationEngineResult');

  /// The type which includes information such as the signature of this class.
  static const type = $LocationEngineResultType();
  static final _id_create = _class.staticMethodId(
    r'create',
    r'(Landroid/location/Location;)Lorg/maplibre/android/location/engine/LocationEngineResult;',
  );

  static final _create = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `static public org.maplibre.android.location.engine.LocationEngineResult create(android.location.Location location)`
  /// The returned object must be released after use, by calling the [release] method.
  static LocationEngineResult create(
    jni.JObject location,
  ) {
    return _create(_class.reference.pointer, _id_create as jni.JMethodIDPtr,
            location.reference.pointer)
        .object(const $LocationEngineResultType());
  }

  static final _id_create1 = _class.staticMethodId(
    r'create',
    r'(Ljava/util/List;)Lorg/maplibre/android/location/engine/LocationEngineResult;',
  );

  static final _create1 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `static public org.maplibre.android.location.engine.LocationEngineResult create(java.util.List list)`
  /// The returned object must be released after use, by calling the [release] method.
  static LocationEngineResult create1(
    jni.JList<jni.JObject> list,
  ) {
    return _create1(_class.reference.pointer, _id_create1 as jni.JMethodIDPtr,
            list.reference.pointer)
        .object(const $LocationEngineResultType());
  }

  static final _id_getLastLocation = _class.instanceMethodId(
    r'getLastLocation',
    r'()Landroid/location/Location;',
  );

  static final _getLastLocation = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public android.location.Location getLastLocation()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject getLastLocation() {
    return _getLastLocation(
            reference.pointer, _id_getLastLocation as jni.JMethodIDPtr)
        .object(const jni.JObjectType());
  }

  static final _id_getLocations = _class.instanceMethodId(
    r'getLocations',
    r'()Ljava/util/List;',
  );

  static final _getLocations = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public java.util.List getLocations()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JList<jni.JObject> getLocations() {
    return _getLocations(
            reference.pointer, _id_getLocations as jni.JMethodIDPtr)
        .object(const jni.JListType(jni.JObjectType()));
  }

  static final _id_extractResult = _class.staticMethodId(
    r'extractResult',
    r'(Landroid/content/Intent;)Lorg/maplibre/android/location/engine/LocationEngineResult;',
  );

  static final _extractResult = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `static public org.maplibre.android.location.engine.LocationEngineResult extractResult(android.content.Intent intent)`
  /// The returned object must be released after use, by calling the [release] method.
  static LocationEngineResult extractResult(
    jni.JObject intent,
  ) {
    return _extractResult(_class.reference.pointer,
            _id_extractResult as jni.JMethodIDPtr, intent.reference.pointer)
        .object(const $LocationEngineResultType());
  }
}

final class $LocationEngineResultType
    extends jni.JObjType<LocationEngineResult> {
  const $LocationEngineResultType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/location/engine/LocationEngineResult;';

  @override
  LocationEngineResult fromReference(jni.JReference reference) =>
      LocationEngineResult.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($LocationEngineResultType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($LocationEngineResultType) &&
        other is $LocationEngineResultType;
  }
}
