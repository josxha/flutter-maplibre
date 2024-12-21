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

import 'URI.dart' as uri$_;

/// from: `java.net.URL`
class URL extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<URL> $type;

  @jni$_.internal
  URL.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = jni$_.JClass.forName(r'java/net/URL');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $URL$NullableType();
  static const type = $URL$Type();
  static final _id_new$ = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V',
  );

  static final _new$ = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Int32,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              int,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void <init>(java.lang.String string, java.lang.String string1, int i, java.lang.String string2)`
  /// The returned object must be released after use, by calling the [release] method.
  factory URL(
    jni$_.JString? string,
    jni$_.JString? string1,
    int i,
    jni$_.JString? string2,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    final _$string2 = string2?.reference ?? jni$_.jNullReference;
    return URL.fromReference(_new$(
            _class.reference.pointer,
            _id_new$ as jni$_.JMethodIDPtr,
            _$string.pointer,
            _$string1.pointer,
            i,
            _$string2.pointer)
        .reference);
  }

  static final _id_new$1 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _new$1 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void <init>(java.lang.String string, java.lang.String string1, java.lang.String string2)`
  /// The returned object must be released after use, by calling the [release] method.
  factory URL.new$1(
    jni$_.JString? string,
    jni$_.JString? string1,
    jni$_.JString? string2,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    final _$string2 = string2?.reference ?? jni$_.jNullReference;
    return URL.fromReference(_new$1(
            _class.reference.pointer,
            _id_new$1 as jni$_.JMethodIDPtr,
            _$string.pointer,
            _$string1.pointer,
            _$string2.pointer)
        .reference);
  }

  static final _id_new$2 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/net/URLStreamHandler;)V',
  );

  static final _new$2 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Int32,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              int,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void <init>(java.lang.String string, java.lang.String string1, int i, java.lang.String string2, java.net.URLStreamHandler uRLStreamHandler)`
  /// The returned object must be released after use, by calling the [release] method.
  factory URL.new$2(
    jni$_.JString? string,
    jni$_.JString? string1,
    int i,
    jni$_.JString? string2,
    jni$_.JObject? uRLStreamHandler,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    final _$string2 = string2?.reference ?? jni$_.jNullReference;
    final _$uRLStreamHandler =
        uRLStreamHandler?.reference ?? jni$_.jNullReference;
    return URL.fromReference(_new$2(
            _class.reference.pointer,
            _id_new$2 as jni$_.JMethodIDPtr,
            _$string.pointer,
            _$string1.pointer,
            i,
            _$string2.pointer,
            _$uRLStreamHandler.pointer)
        .reference);
  }

  static final _id_new$3 = _class.constructorId(
    r'(Ljava/lang/String;)V',
  );

  static final _new$3 = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void <init>(java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  factory URL.new$3(
    jni$_.JString? string,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    return URL.fromReference(_new$3(_class.reference.pointer,
            _id_new$3 as jni$_.JMethodIDPtr, _$string.pointer)
        .reference);
  }

  static final _id_new$4 = _class.constructorId(
    r'(Ljava/net/URL;Ljava/lang/String;)V',
  );

  static final _new$4 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void <init>(java.net.URL uRL, java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  factory URL.new$4(
    URL? uRL,
    jni$_.JString? string,
  ) {
    final _$uRL = uRL?.reference ?? jni$_.jNullReference;
    final _$string = string?.reference ?? jni$_.jNullReference;
    return URL.fromReference(_new$4(_class.reference.pointer,
            _id_new$4 as jni$_.JMethodIDPtr, _$uRL.pointer, _$string.pointer)
        .reference);
  }

  static final _id_new$5 = _class.constructorId(
    r'(Ljava/net/URL;Ljava/lang/String;Ljava/net/URLStreamHandler;)V',
  );

  static final _new$5 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void <init>(java.net.URL uRL, java.lang.String string, java.net.URLStreamHandler uRLStreamHandler)`
  /// The returned object must be released after use, by calling the [release] method.
  factory URL.new$5(
    URL? uRL,
    jni$_.JString? string,
    jni$_.JObject? uRLStreamHandler,
  ) {
    final _$uRL = uRL?.reference ?? jni$_.jNullReference;
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$uRLStreamHandler =
        uRLStreamHandler?.reference ?? jni$_.jNullReference;
    return URL.fromReference(_new$5(
            _class.reference.pointer,
            _id_new$5 as jni$_.JMethodIDPtr,
            _$uRL.pointer,
            _$string.pointer,
            _$uRLStreamHandler.pointer)
        .reference);
  }

  static final _id_getQuery = _class.instanceMethodId(
    r'getQuery',
    r'()Ljava/lang/String;',
  );

  static final _getQuery = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getQuery()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getQuery() {
    return _getQuery(reference.pointer, _id_getQuery as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getPath = _class.instanceMethodId(
    r'getPath',
    r'()Ljava/lang/String;',
  );

  static final _getPath = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getPath()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getPath() {
    return _getPath(reference.pointer, _id_getPath as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getUserInfo = _class.instanceMethodId(
    r'getUserInfo',
    r'()Ljava/lang/String;',
  );

  static final _getUserInfo = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getUserInfo()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getUserInfo() {
    return _getUserInfo(
            reference.pointer, _id_getUserInfo as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getAuthority = _class.instanceMethodId(
    r'getAuthority',
    r'()Ljava/lang/String;',
  );

  static final _getAuthority = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getAuthority()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getAuthority() {
    return _getAuthority(
            reference.pointer, _id_getAuthority as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getPort = _class.instanceMethodId(
    r'getPort',
    r'()I',
  );

  static final _getPort = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public int getPort()`
  int getPort() {
    return _getPort(reference.pointer, _id_getPort as jni$_.JMethodIDPtr)
        .integer;
  }

  static final _id_getDefaultPort = _class.instanceMethodId(
    r'getDefaultPort',
    r'()I',
  );

  static final _getDefaultPort = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public int getDefaultPort()`
  int getDefaultPort() {
    return _getDefaultPort(
            reference.pointer, _id_getDefaultPort as jni$_.JMethodIDPtr)
        .integer;
  }

  static final _id_getProtocol = _class.instanceMethodId(
    r'getProtocol',
    r'()Ljava/lang/String;',
  );

  static final _getProtocol = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getProtocol()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getProtocol() {
    return _getProtocol(
            reference.pointer, _id_getProtocol as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getHost = _class.instanceMethodId(
    r'getHost',
    r'()Ljava/lang/String;',
  );

  static final _getHost = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getHost()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getHost() {
    return _getHost(reference.pointer, _id_getHost as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getFile = _class.instanceMethodId(
    r'getFile',
    r'()Ljava/lang/String;',
  );

  static final _getFile = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getFile()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getFile() {
    return _getFile(reference.pointer, _id_getFile as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getRef = _class.instanceMethodId(
    r'getRef',
    r'()Ljava/lang/String;',
  );

  static final _getRef = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getRef()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getRef() {
    return _getRef(reference.pointer, _id_getRef as jni$_.JMethodIDPtr)
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

  static final _id_sameFile = _class.instanceMethodId(
    r'sameFile',
    r'(Ljava/net/URL;)Z',
  );

  static final _sameFile = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallBooleanMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public boolean sameFile(java.net.URL uRL)`
  bool sameFile(
    URL? uRL,
  ) {
    final _$uRL = uRL?.reference ?? jni$_.jNullReference;
    return _sameFile(reference.pointer, _id_sameFile as jni$_.JMethodIDPtr,
            _$uRL.pointer)
        .boolean;
  }

  static final _id_toString$1 = _class.instanceMethodId(
    r'toString',
    r'()Ljava/lang/String;',
  );

  static final _toString$1 = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String toString()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? toString$1() {
    return _toString$1(reference.pointer, _id_toString$1 as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_toExternalForm = _class.instanceMethodId(
    r'toExternalForm',
    r'()Ljava/lang/String;',
  );

  static final _toExternalForm = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String toExternalForm()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? toExternalForm() {
    return _toExternalForm(
            reference.pointer, _id_toExternalForm as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_toURI = _class.instanceMethodId(
    r'toURI',
    r'()Ljava/net/URI;',
  );

  static final _toURI = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.net.URI toURI()`
  /// The returned object must be released after use, by calling the [release] method.
  uri$_.URI? toURI() {
    return _toURI(reference.pointer, _id_toURI as jni$_.JMethodIDPtr)
        .object<uri$_.URI?>(const uri$_.$URI$NullableType());
  }

  static final _id_openConnection = _class.instanceMethodId(
    r'openConnection',
    r'()Ljava/net/URLConnection;',
  );

  static final _openConnection = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.net.URLConnection openConnection()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JObject? openConnection() {
    return _openConnection(
            reference.pointer, _id_openConnection as jni$_.JMethodIDPtr)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_openConnection$1 = _class.instanceMethodId(
    r'openConnection',
    r'(Ljava/net/Proxy;)Ljava/net/URLConnection;',
  );

  static final _openConnection$1 = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public java.net.URLConnection openConnection(java.net.Proxy proxy)`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JObject? openConnection$1(
    jni$_.JObject? proxy,
  ) {
    final _$proxy = proxy?.reference ?? jni$_.jNullReference;
    return _openConnection$1(reference.pointer,
            _id_openConnection$1 as jni$_.JMethodIDPtr, _$proxy.pointer)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_openStream = _class.instanceMethodId(
    r'openStream',
    r'()Ljava/io/InputStream;',
  );

  static final _openStream = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.io.InputStream openStream()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JObject? openStream() {
    return _openStream(reference.pointer, _id_openStream as jni$_.JMethodIDPtr)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_getContent = _class.instanceMethodId(
    r'getContent',
    r'()Ljava/lang/Object;',
  );

  static final _getContent = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.Object getContent()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JObject? getContent() {
    return _getContent(reference.pointer, _id_getContent as jni$_.JMethodIDPtr)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_getContent$1 = _class.instanceMethodId(
    r'getContent',
    r'([Ljava/lang/Class;)Ljava/lang/Object;',
  );

  static final _getContent$1 = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public java.lang.Object getContent(java.lang.Class[] classs)`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JObject? getContent$1(
    jni$_.JArray<jni$_.JObject?>? classs,
  ) {
    final _$classs = classs?.reference ?? jni$_.jNullReference;
    return _getContent$1(reference.pointer,
            _id_getContent$1 as jni$_.JMethodIDPtr, _$classs.pointer)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_setURLStreamHandlerFactory = _class.staticMethodId(
    r'setURLStreamHandlerFactory',
    r'(Ljava/net/URLStreamHandlerFactory;)V',
  );

  static final _setURLStreamHandlerFactory =
      jni$_.ProtectedJniExtensions.lookup<
                  jni$_.NativeFunction<
                      jni$_.JThrowablePtr Function(
                          jni$_.Pointer<jni$_.Void>,
                          jni$_.JMethodIDPtr,
                          jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
              'globalEnv_CallStaticVoidMethod')
          .asFunction<
              jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public void setURLStreamHandlerFactory(java.net.URLStreamHandlerFactory uRLStreamHandlerFactory)`
  static void setURLStreamHandlerFactory(
    jni$_.JObject? uRLStreamHandlerFactory,
  ) {
    final _$uRLStreamHandlerFactory =
        uRLStreamHandlerFactory?.reference ?? jni$_.jNullReference;
    _setURLStreamHandlerFactory(
            _class.reference.pointer,
            _id_setURLStreamHandlerFactory as jni$_.JMethodIDPtr,
            _$uRLStreamHandlerFactory.pointer)
        .check();
  }
}

final class $URL$NullableType extends jni$_.JObjType<URL?> {
  @jni$_.internal
  const $URL$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Ljava/net/URL;';

  @jni$_.internal
  @core$_.override
  URL? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : URL.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<URL?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($URL$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($URL$NullableType) &&
        other is $URL$NullableType;
  }
}

final class $URL$Type extends jni$_.JObjType<URL> {
  @jni$_.internal
  const $URL$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Ljava/net/URL;';

  @jni$_.internal
  @core$_.override
  URL fromReference(jni$_.JReference reference) => URL.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<URL?> get nullableType => const $URL$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($URL$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($URL$Type) && other is $URL$Type;
  }
}