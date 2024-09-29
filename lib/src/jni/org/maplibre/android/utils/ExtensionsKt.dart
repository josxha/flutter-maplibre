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

final _ExtensionsKtClass =
    jni.JClass.forName(r'org/maplibre/android/utils/ExtensionsKt');

final _id_isNaN = _ExtensionsKtClass.staticMethodId(
  r'isNaN',
  r'(Lkotlin/jvm/internal/DoubleCompanionObject;D)Z',
);

final _isNaN = ProtectedJniExtensions.lookup<
            ffi.NativeFunction<
                jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
                    ffi.VarArgs<(ffi.Pointer<ffi.Void>, ffi.Double)>)>>(
        'globalEnv_CallStaticBooleanMethod')
    .asFunction<
        jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
            ffi.Pointer<ffi.Void>, double)>();

/// from: `static public final boolean isNaN(kotlin.jvm.internal.DoubleCompanionObject doubleCompanionObject, double d)`
bool isNaN(
  jni.JObject doubleCompanionObject,
  double d,
) {
  return _isNaN(
          _ExtensionsKtClass.reference.pointer,
          _id_isNaN as jni.JMethodIDPtr,
          doubleCompanionObject.reference.pointer,
          d)
      .boolean;
}

final _id_isNaN1 = _ExtensionsKtClass.staticMethodId(
  r'isNaN',
  r'(Lkotlin/jvm/internal/FloatCompanionObject;F)Z',
);

final _isNaN1 = ProtectedJniExtensions.lookup<
            ffi.NativeFunction<
                jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
                    ffi.VarArgs<(ffi.Pointer<ffi.Void>, ffi.Double)>)>>(
        'globalEnv_CallStaticBooleanMethod')
    .asFunction<
        jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
            ffi.Pointer<ffi.Void>, double)>();

/// from: `static public final boolean isNaN(kotlin.jvm.internal.FloatCompanionObject floatCompanionObject, float f)`
bool isNaN1(
  jni.JObject floatCompanionObject,
  double f,
) {
  return _isNaN1(
          _ExtensionsKtClass.reference.pointer,
          _id_isNaN1 as jni.JMethodIDPtr,
          floatCompanionObject.reference.pointer,
          f)
      .boolean;
}

final _id_isInfinite = _ExtensionsKtClass.staticMethodId(
  r'isInfinite',
  r'(Lkotlin/jvm/internal/DoubleCompanionObject;D)Z',
);

final _isInfinite = ProtectedJniExtensions.lookup<
            ffi.NativeFunction<
                jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
                    ffi.VarArgs<(ffi.Pointer<ffi.Void>, ffi.Double)>)>>(
        'globalEnv_CallStaticBooleanMethod')
    .asFunction<
        jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
            ffi.Pointer<ffi.Void>, double)>();

/// from: `static public final boolean isInfinite(kotlin.jvm.internal.DoubleCompanionObject doubleCompanionObject, double d)`
bool isInfinite(
  jni.JObject doubleCompanionObject,
  double d,
) {
  return _isInfinite(
          _ExtensionsKtClass.reference.pointer,
          _id_isInfinite as jni.JMethodIDPtr,
          doubleCompanionObject.reference.pointer,
          d)
      .boolean;
}

final _id_isInfinite1 = _ExtensionsKtClass.staticMethodId(
  r'isInfinite',
  r'(Lkotlin/jvm/internal/FloatCompanionObject;D)Z',
);

final _isInfinite1 = ProtectedJniExtensions.lookup<
            ffi.NativeFunction<
                jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
                    ffi.VarArgs<(ffi.Pointer<ffi.Void>, ffi.Double)>)>>(
        'globalEnv_CallStaticBooleanMethod')
    .asFunction<
        jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
            ffi.Pointer<ffi.Void>, double)>();

/// from: `static public final boolean isInfinite(kotlin.jvm.internal.FloatCompanionObject floatCompanionObject, double d)`
bool isInfinite1(
  jni.JObject floatCompanionObject,
  double d,
) {
  return _isInfinite1(
          _ExtensionsKtClass.reference.pointer,
          _id_isInfinite1 as jni.JMethodIDPtr,
          floatCompanionObject.reference.pointer,
          d)
      .boolean;
}
