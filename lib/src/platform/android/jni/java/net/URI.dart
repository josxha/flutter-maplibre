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

import 'URL.dart' as url$_;

/// from: `java.net.URI`
class URI extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<URI> $type;

  @jni$_.internal
  URI.fromReference(jni$_.JReference reference)
    : $type = type,
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(r'java/net/URI');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $URI$NullableType();
  static const type = $URI$Type();
  static final _id_new$ = _class.constructorId(r'(Ljava/lang/String;)V');

  static final _new$ =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_NewObject')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public void <init>(java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  factory URI(jni$_.JString? string) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    return URI.fromReference(
      _new$(
        _class.reference.pointer,
        _id_new$ as jni$_.JMethodIDPtr,
        _$string.pointer,
      ).reference,
    );
  }

  static final _id_new$1 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _new$1 =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<
                  (
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Int32,
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Pointer<jni$_.Void>,
                  )
                >,
              )
            >
          >('globalEnv_NewObject')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              int,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public void <init>(java.lang.String string, java.lang.String string1, java.lang.String string2, int i, java.lang.String string3, java.lang.String string4, java.lang.String string5)`
  /// The returned object must be released after use, by calling the [release] method.
  factory URI.new$1(
    jni$_.JString? string,
    jni$_.JString? string1,
    jni$_.JString? string2,
    int i,
    jni$_.JString? string3,
    jni$_.JString? string4,
    jni$_.JString? string5,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    final _$string2 = string2?.reference ?? jni$_.jNullReference;
    final _$string3 = string3?.reference ?? jni$_.jNullReference;
    final _$string4 = string4?.reference ?? jni$_.jNullReference;
    final _$string5 = string5?.reference ?? jni$_.jNullReference;
    return URI.fromReference(
      _new$1(
        _class.reference.pointer,
        _id_new$1 as jni$_.JMethodIDPtr,
        _$string.pointer,
        _$string1.pointer,
        _$string2.pointer,
        i,
        _$string3.pointer,
        _$string4.pointer,
        _$string5.pointer,
      ).reference,
    );
  }

  static final _id_new$2 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _new$2 =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<
                  (
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Pointer<jni$_.Void>,
                  )
                >,
              )
            >
          >('globalEnv_NewObject')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public void <init>(java.lang.String string, java.lang.String string1, java.lang.String string2, java.lang.String string3, java.lang.String string4)`
  /// The returned object must be released after use, by calling the [release] method.
  factory URI.new$2(
    jni$_.JString? string,
    jni$_.JString? string1,
    jni$_.JString? string2,
    jni$_.JString? string3,
    jni$_.JString? string4,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    final _$string2 = string2?.reference ?? jni$_.jNullReference;
    final _$string3 = string3?.reference ?? jni$_.jNullReference;
    final _$string4 = string4?.reference ?? jni$_.jNullReference;
    return URI.fromReference(
      _new$2(
        _class.reference.pointer,
        _id_new$2 as jni$_.JMethodIDPtr,
        _$string.pointer,
        _$string1.pointer,
        _$string2.pointer,
        _$string3.pointer,
        _$string4.pointer,
      ).reference,
    );
  }

  static final _id_new$3 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _new$3 =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<
                  (
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Pointer<jni$_.Void>,
                  )
                >,
              )
            >
          >('globalEnv_NewObject')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public void <init>(java.lang.String string, java.lang.String string1, java.lang.String string2, java.lang.String string3)`
  /// The returned object must be released after use, by calling the [release] method.
  factory URI.new$3(
    jni$_.JString? string,
    jni$_.JString? string1,
    jni$_.JString? string2,
    jni$_.JString? string3,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    final _$string2 = string2?.reference ?? jni$_.jNullReference;
    final _$string3 = string3?.reference ?? jni$_.jNullReference;
    return URI.fromReference(
      _new$3(
        _class.reference.pointer,
        _id_new$3 as jni$_.JMethodIDPtr,
        _$string.pointer,
        _$string1.pointer,
        _$string2.pointer,
        _$string3.pointer,
      ).reference,
    );
  }

  static final _id_new$4 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _new$4 =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<
                  (
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Pointer<jni$_.Void>,
                  )
                >,
              )
            >
          >('globalEnv_NewObject')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public void <init>(java.lang.String string, java.lang.String string1, java.lang.String string2)`
  /// The returned object must be released after use, by calling the [release] method.
  factory URI.new$4(
    jni$_.JString? string,
    jni$_.JString? string1,
    jni$_.JString? string2,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    final _$string2 = string2?.reference ?? jni$_.jNullReference;
    return URI.fromReference(
      _new$4(
        _class.reference.pointer,
        _id_new$4 as jni$_.JMethodIDPtr,
        _$string.pointer,
        _$string1.pointer,
        _$string2.pointer,
      ).reference,
    );
  }

  static final _id_create = _class.staticMethodId(
    r'create',
    r'(Ljava/lang/String;)Ljava/net/URI;',
  );

  static final _create =
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

  /// from: `static public java.net.URI create(java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  static URI? create(jni$_.JString? string) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    return _create(
      _class.reference.pointer,
      _id_create as jni$_.JMethodIDPtr,
      _$string.pointer,
    ).object<URI?>(const $URI$NullableType());
  }

  static final _id_parseServerAuthority = _class.instanceMethodId(
    r'parseServerAuthority',
    r'()Ljava/net/URI;',
  );

  static final _parseServerAuthority =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.net.URI parseServerAuthority()`
  /// The returned object must be released after use, by calling the [release] method.
  URI? parseServerAuthority() {
    return _parseServerAuthority(
      reference.pointer,
      _id_parseServerAuthority as jni$_.JMethodIDPtr,
    ).object<URI?>(const $URI$NullableType());
  }

  static final _id_normalize = _class.instanceMethodId(
    r'normalize',
    r'()Ljava/net/URI;',
  );

  static final _normalize =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.net.URI normalize()`
  /// The returned object must be released after use, by calling the [release] method.
  URI? normalize() {
    return _normalize(
      reference.pointer,
      _id_normalize as jni$_.JMethodIDPtr,
    ).object<URI?>(const $URI$NullableType());
  }

  static final _id_resolve = _class.instanceMethodId(
    r'resolve',
    r'(Ljava/net/URI;)Ljava/net/URI;',
  );

  static final _resolve =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public java.net.URI resolve(java.net.URI uRI)`
  /// The returned object must be released after use, by calling the [release] method.
  URI? resolve(URI? uRI) {
    final _$uRI = uRI?.reference ?? jni$_.jNullReference;
    return _resolve(
      reference.pointer,
      _id_resolve as jni$_.JMethodIDPtr,
      _$uRI.pointer,
    ).object<URI?>(const $URI$NullableType());
  }

  static final _id_resolve$1 = _class.instanceMethodId(
    r'resolve',
    r'(Ljava/lang/String;)Ljava/net/URI;',
  );

  static final _resolve$1 =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public java.net.URI resolve(java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  URI? resolve$1(jni$_.JString? string) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    return _resolve$1(
      reference.pointer,
      _id_resolve$1 as jni$_.JMethodIDPtr,
      _$string.pointer,
    ).object<URI?>(const $URI$NullableType());
  }

  static final _id_relativize = _class.instanceMethodId(
    r'relativize',
    r'(Ljava/net/URI;)Ljava/net/URI;',
  );

  static final _relativize =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public java.net.URI relativize(java.net.URI uRI)`
  /// The returned object must be released after use, by calling the [release] method.
  URI? relativize(URI? uRI) {
    final _$uRI = uRI?.reference ?? jni$_.jNullReference;
    return _relativize(
      reference.pointer,
      _id_relativize as jni$_.JMethodIDPtr,
      _$uRI.pointer,
    ).object<URI?>(const $URI$NullableType());
  }

  static final _id_toURL = _class.instanceMethodId(
    r'toURL',
    r'()Ljava/net/URL;',
  );

  static final _toURL =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.net.URL toURL()`
  /// The returned object must be released after use, by calling the [release] method.
  url$_.URL? toURL() {
    return _toURL(
      reference.pointer,
      _id_toURL as jni$_.JMethodIDPtr,
    ).object<url$_.URL?>(const url$_.$URL$NullableType());
  }

  static final _id_getScheme = _class.instanceMethodId(
    r'getScheme',
    r'()Ljava/lang/String;',
  );

  static final _getScheme =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.lang.String getScheme()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getScheme() {
    return _getScheme(
      reference.pointer,
      _id_getScheme as jni$_.JMethodIDPtr,
    ).object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_isAbsolute = _class.instanceMethodId(r'isAbsolute', r'()Z');

  static final _isAbsolute =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallBooleanMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public boolean isAbsolute()`
  bool isAbsolute() {
    return _isAbsolute(
      reference.pointer,
      _id_isAbsolute as jni$_.JMethodIDPtr,
    ).boolean;
  }

  static final _id_isOpaque = _class.instanceMethodId(r'isOpaque', r'()Z');

  static final _isOpaque =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallBooleanMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public boolean isOpaque()`
  bool isOpaque() {
    return _isOpaque(
      reference.pointer,
      _id_isOpaque as jni$_.JMethodIDPtr,
    ).boolean;
  }

  static final _id_getRawSchemeSpecificPart = _class.instanceMethodId(
    r'getRawSchemeSpecificPart',
    r'()Ljava/lang/String;',
  );

  static final _getRawSchemeSpecificPart =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.lang.String getRawSchemeSpecificPart()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getRawSchemeSpecificPart() {
    return _getRawSchemeSpecificPart(
      reference.pointer,
      _id_getRawSchemeSpecificPart as jni$_.JMethodIDPtr,
    ).object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getSchemeSpecificPart = _class.instanceMethodId(
    r'getSchemeSpecificPart',
    r'()Ljava/lang/String;',
  );

  static final _getSchemeSpecificPart =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.lang.String getSchemeSpecificPart()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getSchemeSpecificPart() {
    return _getSchemeSpecificPart(
      reference.pointer,
      _id_getSchemeSpecificPart as jni$_.JMethodIDPtr,
    ).object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getRawAuthority = _class.instanceMethodId(
    r'getRawAuthority',
    r'()Ljava/lang/String;',
  );

  static final _getRawAuthority =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.lang.String getRawAuthority()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getRawAuthority() {
    return _getRawAuthority(
      reference.pointer,
      _id_getRawAuthority as jni$_.JMethodIDPtr,
    ).object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getAuthority = _class.instanceMethodId(
    r'getAuthority',
    r'()Ljava/lang/String;',
  );

  static final _getAuthority =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.lang.String getAuthority()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getAuthority() {
    return _getAuthority(
      reference.pointer,
      _id_getAuthority as jni$_.JMethodIDPtr,
    ).object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getRawUserInfo = _class.instanceMethodId(
    r'getRawUserInfo',
    r'()Ljava/lang/String;',
  );

  static final _getRawUserInfo =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.lang.String getRawUserInfo()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getRawUserInfo() {
    return _getRawUserInfo(
      reference.pointer,
      _id_getRawUserInfo as jni$_.JMethodIDPtr,
    ).object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getUserInfo = _class.instanceMethodId(
    r'getUserInfo',
    r'()Ljava/lang/String;',
  );

  static final _getUserInfo =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.lang.String getUserInfo()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getUserInfo() {
    return _getUserInfo(
      reference.pointer,
      _id_getUserInfo as jni$_.JMethodIDPtr,
    ).object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getHost = _class.instanceMethodId(
    r'getHost',
    r'()Ljava/lang/String;',
  );

  static final _getHost =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.lang.String getHost()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getHost() {
    return _getHost(
      reference.pointer,
      _id_getHost as jni$_.JMethodIDPtr,
    ).object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getPort = _class.instanceMethodId(r'getPort', r'()I');

  static final _getPort =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallIntMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public int getPort()`
  int getPort() {
    return _getPort(
      reference.pointer,
      _id_getPort as jni$_.JMethodIDPtr,
    ).integer;
  }

  static final _id_getRawPath = _class.instanceMethodId(
    r'getRawPath',
    r'()Ljava/lang/String;',
  );

  static final _getRawPath =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.lang.String getRawPath()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getRawPath() {
    return _getRawPath(
      reference.pointer,
      _id_getRawPath as jni$_.JMethodIDPtr,
    ).object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getPath = _class.instanceMethodId(
    r'getPath',
    r'()Ljava/lang/String;',
  );

  static final _getPath =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.lang.String getPath()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getPath() {
    return _getPath(
      reference.pointer,
      _id_getPath as jni$_.JMethodIDPtr,
    ).object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getRawQuery = _class.instanceMethodId(
    r'getRawQuery',
    r'()Ljava/lang/String;',
  );

  static final _getRawQuery =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.lang.String getRawQuery()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getRawQuery() {
    return _getRawQuery(
      reference.pointer,
      _id_getRawQuery as jni$_.JMethodIDPtr,
    ).object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getQuery = _class.instanceMethodId(
    r'getQuery',
    r'()Ljava/lang/String;',
  );

  static final _getQuery =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.lang.String getQuery()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getQuery() {
    return _getQuery(
      reference.pointer,
      _id_getQuery as jni$_.JMethodIDPtr,
    ).object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getRawFragment = _class.instanceMethodId(
    r'getRawFragment',
    r'()Ljava/lang/String;',
  );

  static final _getRawFragment =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.lang.String getRawFragment()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getRawFragment() {
    return _getRawFragment(
      reference.pointer,
      _id_getRawFragment as jni$_.JMethodIDPtr,
    ).object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getFragment = _class.instanceMethodId(
    r'getFragment',
    r'()Ljava/lang/String;',
  );

  static final _getFragment =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.lang.String getFragment()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getFragment() {
    return _getFragment(
      reference.pointer,
      _id_getFragment as jni$_.JMethodIDPtr,
    ).object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_equals = _class.instanceMethodId(
    r'equals',
    r'(Ljava/lang/Object;)Z',
  );

  static final _equals =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_CallBooleanMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public boolean equals(java.lang.Object object)`
  bool equals(jni$_.JObject? object) {
    final _$object = object?.reference ?? jni$_.jNullReference;
    return _equals(
      reference.pointer,
      _id_equals as jni$_.JMethodIDPtr,
      _$object.pointer,
    ).boolean;
  }

  static final _id_hashCode$1 = _class.instanceMethodId(r'hashCode', r'()I');

  static final _hashCode$1 =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallIntMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public int hashCode()`
  int hashCode$1() {
    return _hashCode$1(
      reference.pointer,
      _id_hashCode$1 as jni$_.JMethodIDPtr,
    ).integer;
  }

  static final _id_compareTo = _class.instanceMethodId(
    r'compareTo',
    r'(Ljava/net/URI;)I',
  );

  static final _compareTo =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_CallIntMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public int compareTo(java.net.URI uRI)`
  int compareTo(URI? uRI) {
    final _$uRI = uRI?.reference ?? jni$_.jNullReference;
    return _compareTo(
      reference.pointer,
      _id_compareTo as jni$_.JMethodIDPtr,
      _$uRI.pointer,
    ).integer;
  }

  static final _id_toString$1 = _class.instanceMethodId(
    r'toString',
    r'()Ljava/lang/String;',
  );

  static final _toString$1 =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.lang.String toString()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? toString$1() {
    return _toString$1(
      reference.pointer,
      _id_toString$1 as jni$_.JMethodIDPtr,
    ).object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_toASCIIString = _class.instanceMethodId(
    r'toASCIIString',
    r'()Ljava/lang/String;',
  );

  static final _toASCIIString =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.lang.String toASCIIString()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? toASCIIString() {
    return _toASCIIString(
      reference.pointer,
      _id_toASCIIString as jni$_.JMethodIDPtr,
    ).object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  bool operator <(URI? uRI) {
    return compareTo(uRI) < 0;
  }

  bool operator <=(URI? uRI) {
    return compareTo(uRI) <= 0;
  }

  bool operator >(URI? uRI) {
    return compareTo(uRI) > 0;
  }

  bool operator >=(URI? uRI) {
    return compareTo(uRI) >= 0;
  }
}

final class $URI$NullableType extends jni$_.JObjType<URI?> {
  @jni$_.internal
  const $URI$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Ljava/net/URI;';

  @jni$_.internal
  @core$_.override
  URI? fromReference(jni$_.JReference reference) =>
      reference.isNull ? null : URI.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<URI?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($URI$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($URI$NullableType) &&
        other is $URI$NullableType;
  }
}

final class $URI$Type extends jni$_.JObjType<URI> {
  @jni$_.internal
  const $URI$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Ljava/net/URI;';

  @jni$_.internal
  @core$_.override
  URI fromReference(jni$_.JReference reference) => URI.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<URI?> get nullableType => const $URI$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($URI$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($URI$Type) && other is $URI$Type;
  }
}
