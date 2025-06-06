// AUTO GENERATED BY JNIGEN 0.14.2. DO NOT EDIT!

// ignore_for_file: type=lint

// ignore_for_file: annotate_overrides
// ignore_for_file: argument_type_not_assignable
// ignore_for_file: camel_case_extensions
// ignore_for_file: camel_case_types
// ignore_for_file: constant_identifier_names
// ignore_for_file: comment_references
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

/// from: `org.maplibre.android.location.Utils`
class Utils extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<Utils> $type;

  @jni$_.internal
  Utils.fromReference(jni$_.JReference reference)
    : $type = type,
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
    r'org/maplibre/android/location/Utils',
  );

  /// The type which includes information such as the signature of this class.
  static const nullableType = $Utils$NullableType();
  static const type = $Utils$Type();
  static final _id_shortestRotation = _class.staticMethodId(
    r'shortestRotation',
    r'(FF)F',
  );

  static final _shortestRotation =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Double, jni$_.Double)>,
              )
            >
          >('globalEnv_CallStaticFloatMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              double,
              double,
            )
          >();

  /// from: `static public float shortestRotation(float f, float f1)`
  static double shortestRotation(double f, double f1) {
    return _shortestRotation(
      _class.reference.pointer,
      _id_shortestRotation as jni$_.JMethodIDPtr,
      f,
      f1,
    ).float;
  }

  static final _id_normalize = _class.staticMethodId(r'normalize', r'(F)F');

  static final _normalize =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Double,)>,
              )
            >
          >('globalEnv_CallStaticFloatMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              double,
            )
          >();

  /// from: `static public float normalize(float f)`
  static double normalize(double f) {
    return _normalize(
      _class.reference.pointer,
      _id_normalize as jni$_.JMethodIDPtr,
      f,
    ).float;
  }
}

final class $Utils$NullableType extends jni$_.JObjType<Utils?> {
  @jni$_.internal
  const $Utils$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/location/Utils;';

  @jni$_.internal
  @core$_.override
  Utils? fromReference(jni$_.JReference reference) =>
      reference.isNull ? null : Utils.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Utils?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Utils$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Utils$NullableType) &&
        other is $Utils$NullableType;
  }
}

final class $Utils$Type extends jni$_.JObjType<Utils> {
  @jni$_.internal
  const $Utils$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/location/Utils;';

  @jni$_.internal
  @core$_.override
  Utils fromReference(jni$_.JReference reference) =>
      Utils.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Utils?> get nullableType => const $Utils$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Utils$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Utils$Type) && other is $Utils$Type;
  }
}
