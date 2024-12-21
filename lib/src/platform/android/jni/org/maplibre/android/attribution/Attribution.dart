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

/// from: `org.maplibre.android.attribution.Attribution`
class Attribution extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<Attribution> $type;

  @jni$_.internal
  Attribution.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/attribution/Attribution');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $Attribution$NullableType();
  static const type = $Attribution$Type();
  static final _id_getTitle = _class.instanceMethodId(
    r'getTitle',
    r'()Ljava/lang/String;',
  );

  static final _getTitle = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public java.lang.String getTitle()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getTitle() {
    return _getTitle(reference.pointer, _id_getTitle as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getTitleAbbreviated = _class.instanceMethodId(
    r'getTitleAbbreviated',
    r'()Ljava/lang/String;',
  );

  static final _getTitleAbbreviated = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public java.lang.String getTitleAbbreviated()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getTitleAbbreviated() {
    return _getTitleAbbreviated(
            reference.pointer, _id_getTitleAbbreviated as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getUrl = _class.instanceMethodId(
    r'getUrl',
    r'()Ljava/lang/String;',
  );

  static final _getUrl = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public java.lang.String getUrl()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getUrl() {
    return _getUrl(reference.pointer, _id_getUrl as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_equals = _class.instanceMethodId(
    r'equals',
    r'(Ljava/lang/Object;)Z',
  );

  static final _equals = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallBooleanMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public boolean equals(java.lang.Object object)`
  bool equals(
    jni$_.JObject? object,
  ) {
    final _$object = object?.reference ?? jni$_.jNullReference;
    return _equals(reference.pointer, _id_equals as jni$_.JMethodIDPtr,
            _$object.pointer)
        .boolean;
  }

  static final _id_hashCode$1 = _class.instanceMethodId(
    r'hashCode',
    r'()I',
  );

  static final _hashCode$1 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallIntMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public int hashCode()`
  int hashCode$1() {
    return _hashCode$1(reference.pointer, _id_hashCode$1 as jni$_.JMethodIDPtr)
        .integer;
  }
}

final class $Attribution$NullableType extends jni$_.JObjType<Attribution?> {
  @jni$_.internal
  const $Attribution$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/attribution/Attribution;';

  @jni$_.internal
  @core$_.override
  Attribution? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : Attribution.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Attribution?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Attribution$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Attribution$NullableType) &&
        other is $Attribution$NullableType;
  }
}

final class $Attribution$Type extends jni$_.JObjType<Attribution> {
  @jni$_.internal
  const $Attribution$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/attribution/Attribution;';

  @jni$_.internal
  @core$_.override
  Attribution fromReference(jni$_.JReference reference) =>
      Attribution.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Attribution?> get nullableType =>
      const $Attribution$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Attribution$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Attribution$Type) &&
        other is $Attribution$Type;
  }
}
