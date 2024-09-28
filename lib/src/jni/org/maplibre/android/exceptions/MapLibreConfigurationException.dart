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

/// from: `org.maplibre.android.exceptions.MapLibreConfigurationException`
class MapLibreConfigurationException extends jni.JObject {
  @override
  late final jni.JObjType<MapLibreConfigurationException> $type = type;

  MapLibreConfigurationException.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/exceptions/MapLibreConfigurationException');

  /// The type which includes information such as the signature of this class.
  static const type = $MapLibreConfigurationExceptionType();
  static final _id_new0 = _class.constructorId(
    r'()V',
  );

  static final _new0 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public void <init>()`
  /// The returned object must be released after use, by calling the [release] method.
  factory MapLibreConfigurationException() {
    return MapLibreConfigurationException.fromReference(
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr)
            .reference);
  }

  static final _id_new1 = _class.constructorId(
    r'(Ljava/lang/String;)V',
  );

  static final _new1 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  factory MapLibreConfigurationException.new1(
    jni.JString string,
  ) {
    return MapLibreConfigurationException.fromReference(_new1(
            _class.reference.pointer,
            _id_new1 as jni.JMethodIDPtr,
            string.reference.pointer)
        .reference);
  }
}

final class $MapLibreConfigurationExceptionType
    extends jni.JObjType<MapLibreConfigurationException> {
  const $MapLibreConfigurationExceptionType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/exceptions/MapLibreConfigurationException;';

  @override
  MapLibreConfigurationException fromReference(jni.JReference reference) =>
      MapLibreConfigurationException.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($MapLibreConfigurationExceptionType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapLibreConfigurationExceptionType) &&
        other is $MapLibreConfigurationExceptionType;
  }
}
