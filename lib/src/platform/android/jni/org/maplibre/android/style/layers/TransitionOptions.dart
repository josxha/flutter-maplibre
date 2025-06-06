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

/// from: `org.maplibre.android.style.layers.TransitionOptions`
class TransitionOptions extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<TransitionOptions> $type;

  @jni$_.internal
  TransitionOptions.fromReference(jni$_.JReference reference)
    : $type = type,
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
    r'org/maplibre/android/style/layers/TransitionOptions',
  );

  /// The type which includes information such as the signature of this class.
  static const nullableType = $TransitionOptions$NullableType();
  static const type = $TransitionOptions$Type();
  static final _id_new$ = _class.constructorId(r'(JJ)V');

  static final _new$ =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Int64, jni$_.Int64)>,
              )
            >
          >('globalEnv_NewObject')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              int,
              int,
            )
          >();

  /// from: `public void <init>(long j, long j1)`
  /// The returned object must be released after use, by calling the [release] method.
  factory TransitionOptions(int j, int j1) {
    return TransitionOptions.fromReference(
      _new$(
        _class.reference.pointer,
        _id_new$ as jni$_.JMethodIDPtr,
        j,
        j1,
      ).reference,
    );
  }

  static final _id_new$1 = _class.constructorId(r'(JJZ)V');

  static final _new$1 =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Int64, jni$_.Int64, jni$_.Int32)>,
              )
            >
          >('globalEnv_NewObject')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              int,
              int,
              int,
            )
          >();

  /// from: `public void <init>(long j, long j1, boolean z)`
  /// The returned object must be released after use, by calling the [release] method.
  factory TransitionOptions.new$1(int j, int j1, bool z) {
    return TransitionOptions.fromReference(
      _new$1(
        _class.reference.pointer,
        _id_new$1 as jni$_.JMethodIDPtr,
        j,
        j1,
        z ? 1 : 0,
      ).reference,
    );
  }

  static final _id_fromTransitionOptions = _class.staticMethodId(
    r'fromTransitionOptions',
    r'(JJ)Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _fromTransitionOptions =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Int64, jni$_.Int64)>,
              )
            >
          >('globalEnv_CallStaticObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              int,
              int,
            )
          >();

  /// from: `static public org.maplibre.android.style.layers.TransitionOptions fromTransitionOptions(long j, long j1)`
  /// The returned object must be released after use, by calling the [release] method.
  static TransitionOptions? fromTransitionOptions(int j, int j1) {
    return _fromTransitionOptions(
      _class.reference.pointer,
      _id_fromTransitionOptions as jni$_.JMethodIDPtr,
      j,
      j1,
    ).object<TransitionOptions?>(const $TransitionOptions$NullableType());
  }

  static final _id_getDuration = _class.instanceMethodId(
    r'getDuration',
    r'()J',
  );

  static final _getDuration =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallLongMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public long getDuration()`
  int getDuration() {
    return _getDuration(
      reference.pointer,
      _id_getDuration as jni$_.JMethodIDPtr,
    ).long;
  }

  static final _id_getDelay = _class.instanceMethodId(r'getDelay', r'()J');

  static final _getDelay =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallLongMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public long getDelay()`
  int getDelay() {
    return _getDelay(
      reference.pointer,
      _id_getDelay as jni$_.JMethodIDPtr,
    ).long;
  }

  static final _id_isEnablePlacementTransitions = _class.instanceMethodId(
    r'isEnablePlacementTransitions',
    r'()Z',
  );

  static final _isEnablePlacementTransitions =
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

  /// from: `public boolean isEnablePlacementTransitions()`
  bool isEnablePlacementTransitions() {
    return _isEnablePlacementTransitions(
      reference.pointer,
      _id_isEnablePlacementTransitions as jni$_.JMethodIDPtr,
    ).boolean;
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
}

final class $TransitionOptions$NullableType
    extends jni$_.JObjType<TransitionOptions?> {
  @jni$_.internal
  const $TransitionOptions$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/style/layers/TransitionOptions;';

  @jni$_.internal
  @core$_.override
  TransitionOptions? fromReference(jni$_.JReference reference) =>
      reference.isNull ? null : TransitionOptions.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<TransitionOptions?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($TransitionOptions$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($TransitionOptions$NullableType) &&
        other is $TransitionOptions$NullableType;
  }
}

final class $TransitionOptions$Type extends jni$_.JObjType<TransitionOptions> {
  @jni$_.internal
  const $TransitionOptions$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/style/layers/TransitionOptions;';

  @jni$_.internal
  @core$_.override
  TransitionOptions fromReference(jni$_.JReference reference) =>
      TransitionOptions.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<TransitionOptions?> get nullableType =>
      const $TransitionOptions$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($TransitionOptions$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($TransitionOptions$Type) &&
        other is $TransitionOptions$Type;
  }
}
