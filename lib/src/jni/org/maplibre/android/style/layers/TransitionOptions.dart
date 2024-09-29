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

/// from: `org.maplibre.android.style.layers.TransitionOptions`
class TransitionOptions extends jni.JObject {
  @override
  late final jni.JObjType<TransitionOptions> $type = type;

  TransitionOptions.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/style/layers/TransitionOptions');

  /// The type which includes information such as the signature of this class.
  static const type = $TransitionOptionsType();
  static final _id_new0 = _class.constructorId(
    r'(JJ)V',
  );

  static final _new0 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
                  ffi.VarArgs<(ffi.Int64, ffi.Int64)>)>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int, int)>();

  /// from: `public void <init>(long j, long j1)`
  /// The returned object must be released after use, by calling the [release] method.
  factory TransitionOptions(
    int j,
    int j1,
  ) {
    return TransitionOptions.fromReference(
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr, j, j1)
            .reference);
  }

  static final _id_new1 = _class.constructorId(
    r'(JJZ)V',
  );

  static final _new1 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Int64, ffi.Int64, $Int32)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int, int, int)>();

  /// from: `public void <init>(long j, long j1, boolean z)`
  /// The returned object must be released after use, by calling the [release] method.
  factory TransitionOptions.new1(
    int j,
    int j1,
    bool z,
  ) {
    return TransitionOptions.fromReference(_new1(_class.reference.pointer,
            _id_new1 as jni.JMethodIDPtr, j, j1, z ? 1 : 0)
        .reference);
  }

  static final _id_fromTransitionOptions = _class.staticMethodId(
    r'fromTransitionOptions',
    r'(JJ)Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _fromTransitionOptions = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr, ffi.VarArgs<(ffi.Int64, ffi.Int64)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int, int)>();

  /// from: `static public org.maplibre.android.style.layers.TransitionOptions fromTransitionOptions(long j, long j1)`
  /// The returned object must be released after use, by calling the [release] method.
  static TransitionOptions fromTransitionOptions(
    int j,
    int j1,
  ) {
    return _fromTransitionOptions(_class.reference.pointer,
            _id_fromTransitionOptions as jni.JMethodIDPtr, j, j1)
        .object(const $TransitionOptionsType());
  }

  static final _id_getDuration = _class.instanceMethodId(
    r'getDuration',
    r'()J',
  );

  static final _getDuration = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallLongMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public long getDuration()`
  int getDuration() {
    return _getDuration(reference.pointer, _id_getDuration as jni.JMethodIDPtr)
        .long;
  }

  static final _id_getDelay = _class.instanceMethodId(
    r'getDelay',
    r'()J',
  );

  static final _getDelay = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallLongMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public long getDelay()`
  int getDelay() {
    return _getDelay(reference.pointer, _id_getDelay as jni.JMethodIDPtr).long;
  }

  static final _id_isEnablePlacementTransitions = _class.instanceMethodId(
    r'isEnablePlacementTransitions',
    r'()Z',
  );

  static final _isEnablePlacementTransitions = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallBooleanMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public boolean isEnablePlacementTransitions()`
  bool isEnablePlacementTransitions() {
    return _isEnablePlacementTransitions(reference.pointer,
            _id_isEnablePlacementTransitions as jni.JMethodIDPtr)
        .boolean;
  }

  static final _id_equals = _class.instanceMethodId(
    r'equals',
    r'(Ljava/lang/Object;)Z',
  );

  static final _equals = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallBooleanMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public boolean equals(java.lang.Object object)`
  bool equals(
    jni.JObject object,
  ) {
    return _equals(reference.pointer, _id_equals as jni.JMethodIDPtr,
            object.reference.pointer)
        .boolean;
  }

  static final _id_hashCode1 = _class.instanceMethodId(
    r'hashCode',
    r'()I',
  );

  static final _hashCode1 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallIntMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public int hashCode()`
  int hashCode1() {
    return _hashCode1(reference.pointer, _id_hashCode1 as jni.JMethodIDPtr)
        .integer;
  }

  static final _id_toString1 = _class.instanceMethodId(
    r'toString',
    r'()Ljava/lang/String;',
  );

  static final _toString1 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public java.lang.String toString()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString toString1() {
    return _toString1(reference.pointer, _id_toString1 as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }
}

final class $TransitionOptionsType extends jni.JObjType<TransitionOptions> {
  const $TransitionOptionsType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/style/layers/TransitionOptions;';

  @override
  TransitionOptions fromReference(jni.JReference reference) =>
      TransitionOptions.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($TransitionOptionsType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($TransitionOptionsType) &&
        other is $TransitionOptionsType;
  }
}
