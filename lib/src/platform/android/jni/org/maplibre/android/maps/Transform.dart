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

import '../camera/CameraPosition.dart' as cameraposition$_;

import '../camera/CameraUpdate.dart' as cameraupdate$_;

import 'MapLibreMap.dart' as maplibremap$_;

/// from: `org.maplibre.android.maps.Transform`
class Transform extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<Transform> $type;

  @jni$_.internal
  Transform.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/maps/Transform');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $Transform$NullableType();
  static const type = $Transform$Type();
  static final _id_getCameraPosition = _class.instanceMethodId(
    r'getCameraPosition',
    r'()Lorg/maplibre/android/camera/CameraPosition;',
  );

  static final _getCameraPosition = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public final org.maplibre.android.camera.CameraPosition getCameraPosition()`
  /// The returned object must be released after use, by calling the [release] method.
  cameraposition$_.CameraPosition? getCameraPosition() {
    return _getCameraPosition(
            reference.pointer, _id_getCameraPosition as jni$_.JMethodIDPtr)
        .object<cameraposition$_.CameraPosition?>(
            const cameraposition$_.$CameraPosition$NullableType());
  }

  static final _id_onCameraDidChange = _class.instanceMethodId(
    r'onCameraDidChange',
    r'(Z)V',
  );

  static final _onCameraDidChange = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<(jni$_.Int32,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, int)>();

  /// from: `public void onCameraDidChange(boolean z)`
  void onCameraDidChange(
    bool z,
  ) {
    _onCameraDidChange(reference.pointer,
            _id_onCameraDidChange as jni$_.JMethodIDPtr, z ? 1 : 0)
        .check();
  }

  static final _id_moveCamera = _class.instanceMethodId(
    r'moveCamera',
    r'(Lorg/maplibre/android/maps/MapLibreMap;Lorg/maplibre/android/camera/CameraUpdate;Lorg/maplibre/android/maps/MapLibreMap$CancelableCallback;)V',
  );

  static final _moveCamera = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `public final void moveCamera(org.maplibre.android.maps.MapLibreMap mapLibreMap, org.maplibre.android.camera.CameraUpdate cameraUpdate, org.maplibre.android.maps.MapLibreMap$CancelableCallback cancelableCallback)`
  void moveCamera(
    maplibremap$_.MapLibreMap? mapLibreMap,
    cameraupdate$_.CameraUpdate? cameraUpdate,
    maplibremap$_.MapLibreMap$CancelableCallback? cancelableCallback,
  ) {
    final _$mapLibreMap = mapLibreMap?.reference ?? jni$_.jNullReference;
    final _$cameraUpdate = cameraUpdate?.reference ?? jni$_.jNullReference;
    final _$cancelableCallback =
        cancelableCallback?.reference ?? jni$_.jNullReference;
    _moveCamera(
            reference.pointer,
            _id_moveCamera as jni$_.JMethodIDPtr,
            _$mapLibreMap.pointer,
            _$cameraUpdate.pointer,
            _$cancelableCallback.pointer)
        .check();
  }

  static final _id_animateCamera = _class.instanceMethodId(
    r'animateCamera',
    r'(Lorg/maplibre/android/maps/MapLibreMap;Lorg/maplibre/android/camera/CameraUpdate;ILorg/maplibre/android/maps/MapLibreMap$CancelableCallback;)V',
  );

  static final _animateCamera = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Int32,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              int,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `public final void animateCamera(org.maplibre.android.maps.MapLibreMap mapLibreMap, org.maplibre.android.camera.CameraUpdate cameraUpdate, int i, org.maplibre.android.maps.MapLibreMap$CancelableCallback cancelableCallback)`
  void animateCamera(
    maplibremap$_.MapLibreMap? mapLibreMap,
    cameraupdate$_.CameraUpdate? cameraUpdate,
    int i,
    maplibremap$_.MapLibreMap$CancelableCallback? cancelableCallback,
  ) {
    final _$mapLibreMap = mapLibreMap?.reference ?? jni$_.jNullReference;
    final _$cameraUpdate = cameraUpdate?.reference ?? jni$_.jNullReference;
    final _$cancelableCallback =
        cancelableCallback?.reference ?? jni$_.jNullReference;
    _animateCamera(
            reference.pointer,
            _id_animateCamera as jni$_.JMethodIDPtr,
            _$mapLibreMap.pointer,
            _$cameraUpdate.pointer,
            i,
            _$cancelableCallback.pointer)
        .check();
  }
}

final class $Transform$NullableType extends jni$_.JObjType<Transform?> {
  @jni$_.internal
  const $Transform$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/maps/Transform;';

  @jni$_.internal
  @core$_.override
  Transform? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : Transform.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Transform?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Transform$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Transform$NullableType) &&
        other is $Transform$NullableType;
  }
}

final class $Transform$Type extends jni$_.JObjType<Transform> {
  @jni$_.internal
  const $Transform$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/maps/Transform;';

  @jni$_.internal
  @core$_.override
  Transform fromReference(jni$_.JReference reference) =>
      Transform.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Transform?> get nullableType =>
      const $Transform$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Transform$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Transform$Type) && other is $Transform$Type;
  }
}
