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
// ignore_for_file: unnecessary_non_null_assertion
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable
// ignore_for_file: unused_shown_name
// ignore_for_file: use_super_parameters

import 'dart:core' show Object, String, bool, double, int;
import 'dart:core' as core$_;

import 'package:jni/_internal.dart' as jni$_;
import 'package:jni/jni.dart' as jni$_;

/// from: `org.maplibre.android.utils.MathUtils`
class MathUtils extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<MathUtils> $type;

  @jni$_.internal
  MathUtils.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/utils/MathUtils');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $MathUtils$NullableType();
  static const type = $MathUtils$Type();
  static final _id_new$ = _class.constructorId(
    r'()V',
  );

  static final _new$ = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public void <init>()`
  /// The returned object must be released after use, by calling the [release] method.
  factory MathUtils() {
    return MathUtils.fromReference(
        _new$(_class.reference.pointer, _id_new$ as jni$_.JMethodIDPtr)
            .reference);
  }

  static final _id_clamp = _class.staticMethodId(
    r'clamp',
    r'(DDD)D',
  );

  static final _clamp = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Double,
                        jni$_.Double,
                        jni$_.Double
                      )>)>>('globalEnv_CallStaticDoubleMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, double, double, double)>();

  /// from: `static public double clamp(double d, double d1, double d2)`
  static double clamp(
    double d,
    double d1,
    double d2,
  ) {
    return _clamp(_class.reference.pointer, _id_clamp as jni$_.JMethodIDPtr, d,
            d1, d2)
        .doubleFloat;
  }

  static final _id_clamp$1 = _class.staticMethodId(
    r'clamp',
    r'(FFF)F',
  );

  static final _clamp$1 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Double,
                        jni$_.Double,
                        jni$_.Double
                      )>)>>('globalEnv_CallStaticFloatMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, double, double, double)>();

  /// from: `static public float clamp(float f, float f1, float f2)`
  static double clamp$1(
    double f,
    double f1,
    double f2,
  ) {
    return _clamp$1(_class.reference.pointer, _id_clamp$1 as jni$_.JMethodIDPtr,
            f, f1, f2)
        .float;
  }

  static final _id_wrap = _class.staticMethodId(
    r'wrap',
    r'(DDD)D',
  );

  static final _wrap = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Double,
                        jni$_.Double,
                        jni$_.Double
                      )>)>>('globalEnv_CallStaticDoubleMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, double, double, double)>();

  /// from: `static public double wrap(double d, double d1, double d2)`
  static double wrap(
    double d,
    double d1,
    double d2,
  ) {
    return _wrap(
            _class.reference.pointer, _id_wrap as jni$_.JMethodIDPtr, d, d1, d2)
        .doubleFloat;
  }

  static final _id_normalize = _class.staticMethodId(
    r'normalize',
    r'(DDDDD)D',
  );

  static final _normalize = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Double,
                        jni$_.Double,
                        jni$_.Double,
                        jni$_.Double,
                        jni$_.Double
                      )>)>>('globalEnv_CallStaticDoubleMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, double, double, double, double, double)>();

  /// from: `static public double normalize(double d, double d1, double d2, double d3, double d4)`
  static double normalize(
    double d,
    double d1,
    double d2,
    double d3,
    double d4,
  ) {
    return _normalize(_class.reference.pointer,
            _id_normalize as jni$_.JMethodIDPtr, d, d1, d2, d3, d4)
        .doubleFloat;
  }
}

final class $MathUtils$NullableType extends jni$_.JObjType<MathUtils?> {
  @jni$_.internal
  const $MathUtils$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/utils/MathUtils;';

  @jni$_.internal
  @core$_.override
  MathUtils? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : MathUtils.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MathUtils?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($MathUtils$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($MathUtils$NullableType) &&
        other is $MathUtils$NullableType;
  }
}

final class $MathUtils$Type extends jni$_.JObjType<MathUtils> {
  @jni$_.internal
  const $MathUtils$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/utils/MathUtils;';

  @jni$_.internal
  @core$_.override
  MathUtils fromReference(jni$_.JReference reference) =>
      MathUtils.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MathUtils?> get nullableType =>
      const $MathUtils$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($MathUtils$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($MathUtils$Type) && other is $MathUtils$Type;
  }
}