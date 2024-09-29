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

import 'CompassListener.dart' as compasslistener_;

/// from: `org.maplibre.android.location.CompassEngine`
class CompassEngine extends jni.JObject {
  @override
  late final jni.JObjType<CompassEngine> $type = type;

  CompassEngine.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/location/CompassEngine');

  /// The type which includes information such as the signature of this class.
  static const type = $CompassEngineType();
  static final _id_addCompassListener = _class.instanceMethodId(
    r'addCompassListener',
    r'(Lorg/maplibre/android/location/CompassListener;)V',
  );

  static final _addCompassListener = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public abstract void addCompassListener(org.maplibre.android.location.CompassListener compassListener)`
  void addCompassListener(
    compasslistener_.CompassListener compassListener,
  ) {
    _addCompassListener(
            reference.pointer,
            _id_addCompassListener as jni.JMethodIDPtr,
            compassListener.reference.pointer)
        .check();
  }

  static final _id_removeCompassListener = _class.instanceMethodId(
    r'removeCompassListener',
    r'(Lorg/maplibre/android/location/CompassListener;)V',
  );

  static final _removeCompassListener = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public abstract void removeCompassListener(org.maplibre.android.location.CompassListener compassListener)`
  void removeCompassListener(
    compasslistener_.CompassListener compassListener,
  ) {
    _removeCompassListener(
            reference.pointer,
            _id_removeCompassListener as jni.JMethodIDPtr,
            compassListener.reference.pointer)
        .check();
  }

  static final _id_getLastHeading = _class.instanceMethodId(
    r'getLastHeading',
    r'()F',
  );

  static final _getLastHeading = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallFloatMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public abstract float getLastHeading()`
  double getLastHeading() {
    return _getLastHeading(
            reference.pointer, _id_getLastHeading as jni.JMethodIDPtr)
        .float;
  }

  static final _id_getLastAccuracySensorStatus = _class.instanceMethodId(
    r'getLastAccuracySensorStatus',
    r'()I',
  );

  static final _getLastAccuracySensorStatus = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallIntMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public abstract int getLastAccuracySensorStatus()`
  int getLastAccuracySensorStatus() {
    return _getLastAccuracySensorStatus(reference.pointer,
            _id_getLastAccuracySensorStatus as jni.JMethodIDPtr)
        .integer;
  }
}

final class $CompassEngineType extends jni.JObjType<CompassEngine> {
  const $CompassEngineType();

  @override
  String get signature => r'Lorg/maplibre/android/location/CompassEngine;';

  @override
  CompassEngine fromReference(jni.JReference reference) =>
      CompassEngine.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($CompassEngineType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($CompassEngineType) &&
        other is $CompassEngineType;
  }
}
