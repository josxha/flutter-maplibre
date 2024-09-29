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

/// from: `org.maplibre.android.exceptions.CalledFromWorkerThreadException`
class CalledFromWorkerThreadException extends jni.JObject {
  @override
  late final jni.JObjType<CalledFromWorkerThreadException> $type = type;

  CalledFromWorkerThreadException.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/exceptions/CalledFromWorkerThreadException');

  /// The type which includes information such as the signature of this class.
  static const type = $CalledFromWorkerThreadExceptionType();
  static final _id_new0 = _class.constructorId(
    r'(Ljava/lang/String;)V',
  );

  static final _new0 = ProtectedJniExtensions.lookup<
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
  factory CalledFromWorkerThreadException(
    jni.JString string,
  ) {
    return CalledFromWorkerThreadException.fromReference(_new0(
            _class.reference.pointer,
            _id_new0 as jni.JMethodIDPtr,
            string.reference.pointer)
        .reference);
  }
}

final class $CalledFromWorkerThreadExceptionType
    extends jni.JObjType<CalledFromWorkerThreadException> {
  const $CalledFromWorkerThreadExceptionType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/exceptions/CalledFromWorkerThreadException;';

  @override
  CalledFromWorkerThreadException fromReference(jni.JReference reference) =>
      CalledFromWorkerThreadException.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($CalledFromWorkerThreadExceptionType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($CalledFromWorkerThreadExceptionType) &&
        other is $CalledFromWorkerThreadExceptionType;
  }
}
