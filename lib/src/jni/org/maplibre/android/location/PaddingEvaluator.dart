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

/// from: `org.maplibre.android.location.PaddingEvaluator`
class PaddingEvaluator extends jni.JObject {
  @override
  late final jni.JObjType<PaddingEvaluator> $type = type;

  PaddingEvaluator.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/location/PaddingEvaluator');

  /// The type which includes information such as the signature of this class.
  static const type = $PaddingEvaluatorType();
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
  factory PaddingEvaluator() {
    return PaddingEvaluator.fromReference(
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr)
            .reference);
  }

  static final _id_evaluate = _class.instanceMethodId(
    r'evaluate',
    r'(F[D[D)[D',
  );

  static final _evaluate = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Double,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              double, ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `public double[] evaluate(float f, double[] ds, double[] ds1)`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JArray<jni.jdouble> evaluate(
    double f,
    jni.JArray<jni.jdouble> ds,
    jni.JArray<jni.jdouble> ds1,
  ) {
    return _evaluate(reference.pointer, _id_evaluate as jni.JMethodIDPtr, f,
            ds.reference.pointer, ds1.reference.pointer)
        .object(const jni.JArrayType(jni.jdoubleType()));
  }

  static final _id_evaluate1 = _class.instanceMethodId(
    r'evaluate',
    r'(FLjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;',
  );

  static final _evaluate1 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Double,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              double, ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `public java.lang.Object evaluate(float f, java.lang.Object object, java.lang.Object object1)`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject evaluate1(
    double f,
    jni.JObject object,
    jni.JObject object1,
  ) {
    return _evaluate1(reference.pointer, _id_evaluate1 as jni.JMethodIDPtr, f,
            object.reference.pointer, object1.reference.pointer)
        .object(const jni.JObjectType());
  }
}

final class $PaddingEvaluatorType extends jni.JObjType<PaddingEvaluator> {
  const $PaddingEvaluatorType();

  @override
  String get signature => r'Lorg/maplibre/android/location/PaddingEvaluator;';

  @override
  PaddingEvaluator fromReference(jni.JReference reference) =>
      PaddingEvaluator.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($PaddingEvaluatorType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($PaddingEvaluatorType) &&
        other is $PaddingEvaluatorType;
  }
}