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

/// from: `org.maplibre.android.http.HttpRequestUrl`
class HttpRequestUrl extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<HttpRequestUrl> $type;

  @jni$_.internal
  HttpRequestUrl.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/http/HttpRequestUrl');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $HttpRequestUrl$NullableType();
  static const type = $HttpRequestUrl$Type();
  static final _id_buildResourceUrl = _class.staticMethodId(
    r'buildResourceUrl',
    r'(Ljava/lang/String;Ljava/lang/String;IZ)Ljava/lang/String;',
  );

  static final _buildResourceUrl = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Int32,
                        jni$_.Int32
                      )>)>>('globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              int,
              int)>();

  /// from: `static public java.lang.String buildResourceUrl(java.lang.String string, java.lang.String string1, int i, boolean z)`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? buildResourceUrl(
    jni$_.JString? string,
    jni$_.JString? string1,
    int i,
    bool z,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    return _buildResourceUrl(
            _class.reference.pointer,
            _id_buildResourceUrl as jni$_.JMethodIDPtr,
            _$string.pointer,
            _$string1.pointer,
            i,
            z ? 1 : 0)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }
}

final class $HttpRequestUrl$NullableType
    extends jni$_.JObjType<HttpRequestUrl?> {
  @jni$_.internal
  const $HttpRequestUrl$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/http/HttpRequestUrl;';

  @jni$_.internal
  @core$_.override
  HttpRequestUrl? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : HttpRequestUrl.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<HttpRequestUrl?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($HttpRequestUrl$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($HttpRequestUrl$NullableType) &&
        other is $HttpRequestUrl$NullableType;
  }
}

final class $HttpRequestUrl$Type extends jni$_.JObjType<HttpRequestUrl> {
  @jni$_.internal
  const $HttpRequestUrl$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/http/HttpRequestUrl;';

  @jni$_.internal
  @core$_.override
  HttpRequestUrl fromReference(jni$_.JReference reference) =>
      HttpRequestUrl.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<HttpRequestUrl?> get nullableType =>
      const $HttpRequestUrl$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($HttpRequestUrl$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($HttpRequestUrl$Type) &&
        other is $HttpRequestUrl$Type;
  }
}