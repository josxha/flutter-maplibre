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

import '../maps/MapLibreMap.dart' as maplibremap$_;

/// from: `org.maplibre.android.location.MapLibreAnimatorListener`
class MapLibreAnimatorListener extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<MapLibreAnimatorListener> $type;

  @jni$_.internal
  MapLibreAnimatorListener.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
      r'org/maplibre/android/location/MapLibreAnimatorListener');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $MapLibreAnimatorListener$NullableType();
  static const type = $MapLibreAnimatorListener$Type();
  static final _id_new$ = _class.constructorId(
    r'(Lorg/maplibre/android/maps/MapLibreMap$CancelableCallback;)V',
  );

  static final _new$ = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void <init>(org.maplibre.android.maps.MapLibreMap$CancelableCallback cancelableCallback)`
  /// The returned object must be released after use, by calling the [release] method.
  factory MapLibreAnimatorListener(
    maplibremap$_.MapLibreMap$CancelableCallback? cancelableCallback,
  ) {
    final _$cancelableCallback =
        cancelableCallback?.reference ?? jni$_.jNullReference;
    return MapLibreAnimatorListener.fromReference(_new$(
            _class.reference.pointer,
            _id_new$ as jni$_.JMethodIDPtr,
            _$cancelableCallback.pointer)
        .reference);
  }

  static final _id_onAnimationCancel = _class.instanceMethodId(
    r'onAnimationCancel',
    r'(Landroid/animation/Animator;)V',
  );

  static final _onAnimationCancel = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void onAnimationCancel(android.animation.Animator animator)`
  void onAnimationCancel(
    jni$_.JObject animator,
  ) {
    final _$animator = animator.reference;
    _onAnimationCancel(reference.pointer,
            _id_onAnimationCancel as jni$_.JMethodIDPtr, _$animator.pointer)
        .check();
  }

  static final _id_onAnimationEnd = _class.instanceMethodId(
    r'onAnimationEnd',
    r'(Landroid/animation/Animator;)V',
  );

  static final _onAnimationEnd = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void onAnimationEnd(android.animation.Animator animator)`
  void onAnimationEnd(
    jni$_.JObject animator,
  ) {
    final _$animator = animator.reference;
    _onAnimationEnd(reference.pointer, _id_onAnimationEnd as jni$_.JMethodIDPtr,
            _$animator.pointer)
        .check();
  }
}

final class $MapLibreAnimatorListener$NullableType
    extends jni$_.JObjType<MapLibreAnimatorListener?> {
  @jni$_.internal
  const $MapLibreAnimatorListener$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/location/MapLibreAnimatorListener;';

  @jni$_.internal
  @core$_.override
  MapLibreAnimatorListener? fromReference(jni$_.JReference reference) =>
      reference.isNull
          ? null
          : MapLibreAnimatorListener.fromReference(
              reference,
            );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MapLibreAnimatorListener?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($MapLibreAnimatorListener$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapLibreAnimatorListener$NullableType) &&
        other is $MapLibreAnimatorListener$NullableType;
  }
}

final class $MapLibreAnimatorListener$Type
    extends jni$_.JObjType<MapLibreAnimatorListener> {
  @jni$_.internal
  const $MapLibreAnimatorListener$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/location/MapLibreAnimatorListener;';

  @jni$_.internal
  @core$_.override
  MapLibreAnimatorListener fromReference(jni$_.JReference reference) =>
      MapLibreAnimatorListener.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MapLibreAnimatorListener?> get nullableType =>
      const $MapLibreAnimatorListener$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($MapLibreAnimatorListener$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapLibreAnimatorListener$Type) &&
        other is $MapLibreAnimatorListener$Type;
  }
}
