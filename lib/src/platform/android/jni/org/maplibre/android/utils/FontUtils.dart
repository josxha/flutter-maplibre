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

/// from: `org.maplibre.android.utils.FontUtils`
class FontUtils extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<FontUtils> $type;

  @jni$_.internal
  FontUtils.fromReference(jni$_.JReference reference)
    : $type = type,
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
    r'org/maplibre/android/utils/FontUtils',
  );

  /// The type which includes information such as the signature of this class.
  static const nullableType = $FontUtils$NullableType();
  static const type = $FontUtils$Type();
  static final _id_extractValidFont = _class.staticMethodId(
    r'extractValidFont',
    r'([Ljava/lang/String;)Ljava/lang/String;',
  );

  static final _extractValidFont =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_CallStaticObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `static public java.lang.String extractValidFont(java.lang.String[] strings)`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? extractValidFont(
    jni$_.JArray<jni$_.JString?>? strings,
  ) {
    final _$strings = strings?.reference ?? jni$_.jNullReference;
    return _extractValidFont(
      _class.reference.pointer,
      _id_extractValidFont as jni$_.JMethodIDPtr,
      _$strings.pointer,
    ).object<jni$_.JString?>(const jni$_.JStringNullableType());
  }
}

final class $FontUtils$NullableType extends jni$_.JObjType<FontUtils?> {
  @jni$_.internal
  const $FontUtils$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/utils/FontUtils;';

  @jni$_.internal
  @core$_.override
  FontUtils? fromReference(jni$_.JReference reference) =>
      reference.isNull ? null : FontUtils.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<FontUtils?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($FontUtils$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($FontUtils$NullableType) &&
        other is $FontUtils$NullableType;
  }
}

final class $FontUtils$Type extends jni$_.JObjType<FontUtils> {
  @jni$_.internal
  const $FontUtils$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/utils/FontUtils;';

  @jni$_.internal
  @core$_.override
  FontUtils fromReference(jni$_.JReference reference) =>
      FontUtils.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<FontUtils?> get nullableType =>
      const $FontUtils$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($FontUtils$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($FontUtils$Type) && other is $FontUtils$Type;
  }
}
