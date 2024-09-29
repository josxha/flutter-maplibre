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

/// from: `org.maplibre.android.utils.MathUtils`
class MathUtils extends jni.JObject {
  @override
  late final jni.JObjType<MathUtils> $type = type;

  MathUtils.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/utils/MathUtils');

  /// The type which includes information such as the signature of this class.
  static const type = $MathUtilsType();
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
  factory MathUtils() {
    return MathUtils.fromReference(
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr)
            .reference);
  }

  static final _id_clamp = _class.staticMethodId(
    r'clamp',
    r'(DDD)D',
  );

  static final _clamp = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Double, ffi.Double, ffi.Double)>)>>(
          'globalEnv_CallStaticDoubleMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              double, double, double)>();

  /// from: `static public double clamp(double d, double d1, double d2)`
  static double clamp(
    double d,
    double d1,
    double d2,
  ) {
    return _clamp(
            _class.reference.pointer, _id_clamp as jni.JMethodIDPtr, d, d1, d2)
        .doubleFloat;
  }

  static final _id_clamp1 = _class.staticMethodId(
    r'clamp',
    r'(FFF)F',
  );

  static final _clamp1 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Double, ffi.Double, ffi.Double)>)>>(
          'globalEnv_CallStaticFloatMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              double, double, double)>();

  /// from: `static public float clamp(float f, float f1, float f2)`
  static double clamp1(
    double f,
    double f1,
    double f2,
  ) {
    return _clamp1(
            _class.reference.pointer, _id_clamp1 as jni.JMethodIDPtr, f, f1, f2)
        .float;
  }

  static final _id_wrap = _class.staticMethodId(
    r'wrap',
    r'(DDD)D',
  );

  static final _wrap = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Double, ffi.Double, ffi.Double)>)>>(
          'globalEnv_CallStaticDoubleMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              double, double, double)>();

  /// from: `static public double wrap(double d, double d1, double d2)`
  static double wrap(
    double d,
    double d1,
    double d2,
  ) {
    return _wrap(
            _class.reference.pointer, _id_wrap as jni.JMethodIDPtr, d, d1, d2)
        .doubleFloat;
  }

  static final _id_normalize = _class.staticMethodId(
    r'normalize',
    r'(DDDDD)D',
  );

  static final _normalize = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Double,
                        ffi.Double,
                        ffi.Double,
                        ffi.Double,
                        ffi.Double
                      )>)>>('globalEnv_CallStaticDoubleMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              double, double, double, double, double)>();

  /// from: `static public double normalize(double d, double d1, double d2, double d3, double d4)`
  static double normalize(
    double d,
    double d1,
    double d2,
    double d3,
    double d4,
  ) {
    return _normalize(_class.reference.pointer,
            _id_normalize as jni.JMethodIDPtr, d, d1, d2, d3, d4)
        .doubleFloat;
  }
}

final class $MathUtilsType extends jni.JObjType<MathUtils> {
  const $MathUtilsType();

  @override
  String get signature => r'Lorg/maplibre/android/utils/MathUtils;';

  @override
  MathUtils fromReference(jni.JReference reference) =>
      MathUtils.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($MathUtilsType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($MathUtilsType) && other is $MathUtilsType;
  }
}
