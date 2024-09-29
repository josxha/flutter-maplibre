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

/// from: `org.maplibre.android.http.NativeHttpRequest`
class NativeHttpRequest extends jni.JObject {
  @override
  late final jni.JObjType<NativeHttpRequest> $type = type;

  NativeHttpRequest.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/http/NativeHttpRequest');

  /// The type which includes information such as the signature of this class.
  static const type = $NativeHttpRequestType();
  static final _id_cancel = _class.instanceMethodId(
    r'cancel',
    r'()V',
  );

  static final _cancel = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public void cancel()`
  void cancel() {
    _cancel(reference.pointer, _id_cancel as jni.JMethodIDPtr).check();
  }

  static final _id_onResponse = _class.instanceMethodId(
    r'onResponse',
    r'(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V',
  );

  static final _onResponse = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        $Int32,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>,
              jni.JMethodIDPtr,
              int,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void onResponse(int i, java.lang.String string, java.lang.String string1, java.lang.String string2, java.lang.String string3, java.lang.String string4, java.lang.String string5, byte[] bs)`
  void onResponse(
    int i,
    jni.JString string,
    jni.JString string1,
    jni.JString string2,
    jni.JString string3,
    jni.JString string4,
    jni.JString string5,
    jni.JArray<jni.jbyte> bs,
  ) {
    _onResponse(
            reference.pointer,
            _id_onResponse as jni.JMethodIDPtr,
            i,
            string.reference.pointer,
            string1.reference.pointer,
            string2.reference.pointer,
            string3.reference.pointer,
            string4.reference.pointer,
            string5.reference.pointer,
            bs.reference.pointer)
        .check();
  }

  static final _id_handleFailure = _class.instanceMethodId(
    r'handleFailure',
    r'(ILjava/lang/String;)V',
  );

  static final _handleFailure = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<($Int32, ffi.Pointer<ffi.Void>)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              int, ffi.Pointer<ffi.Void>)>();

  /// from: `public void handleFailure(int i, java.lang.String string)`
  void handleFailure(
    int i,
    jni.JString string,
  ) {
    _handleFailure(reference.pointer, _id_handleFailure as jni.JMethodIDPtr, i,
            string.reference.pointer)
        .check();
  }
}

final class $NativeHttpRequestType extends jni.JObjType<NativeHttpRequest> {
  const $NativeHttpRequestType();

  @override
  String get signature => r'Lorg/maplibre/android/http/NativeHttpRequest;';

  @override
  NativeHttpRequest fromReference(jni.JReference reference) =>
      NativeHttpRequest.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($NativeHttpRequestType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($NativeHttpRequestType) &&
        other is $NativeHttpRequestType;
  }
}
