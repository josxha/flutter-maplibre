// Autogenerated by jnigen. DO NOT EDIT!

// ignore_for_file: document_ignores
// ignore_for_file: avoid_catches_without_on_clauses
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

import '../MapRenderer.dart' as maprenderer$_;

import 'MapLibreSurfaceView.dart' as maplibresurfaceview$_;

/// from: `org.maplibre.android.maps.renderer.surfaceview.SurfaceViewMapRenderer`
class SurfaceViewMapRenderer extends maprenderer$_.MapRenderer {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<SurfaceViewMapRenderer> $type;

  @jni$_.internal
  SurfaceViewMapRenderer.fromReference(jni$_.JReference reference)
    : $type = type,
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
    r'org/maplibre/android/maps/renderer/surfaceview/SurfaceViewMapRenderer',
  );

  /// The type which includes information such as the signature of this class.
  static const nullableType = $SurfaceViewMapRenderer$NullableType();
  static const type = $SurfaceViewMapRenderer$Type();
  static final _id_new$ = _class.constructorId(
    r'(Landroid/content/Context;Lorg/maplibre/android/maps/renderer/surfaceview/MapLibreSurfaceView;Ljava/lang/String;)V',
  );

  static final _new$ =
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

  /// from: `public void <init>(android.content.Context context, org.maplibre.android.maps.renderer.surfaceview.MapLibreSurfaceView mapLibreSurfaceView, java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  factory SurfaceViewMapRenderer(
    jni$_.JObject? context,
    maplibresurfaceview$_.MapLibreSurfaceView? mapLibreSurfaceView,
    jni$_.JString? string,
  ) {
    final _$context = context?.reference ?? jni$_.jNullReference;
    final _$mapLibreSurfaceView =
        mapLibreSurfaceView?.reference ?? jni$_.jNullReference;
    final _$string = string?.reference ?? jni$_.jNullReference;
    return SurfaceViewMapRenderer.fromReference(
      _new$(
        _class.reference.pointer,
        _id_new$ as jni$_.JMethodIDPtr,
        _$context.pointer,
        _$mapLibreSurfaceView.pointer,
        _$string.pointer,
      ).reference,
    );
  }

  static final _id_getView = _class.instanceMethodId(
    r'getView',
    r'()Landroid/view/View;',
  );

  static final _getView =
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

  /// from: `public android.view.View getView()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JObject? getView() {
    return _getView(
      reference.pointer,
      _id_getView as jni$_.JMethodIDPtr,
    ).object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_onStop = _class.instanceMethodId(r'onStop', r'()V');

  static final _onStop =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public void onStop()`
  void onStop() {
    _onStop(reference.pointer, _id_onStop as jni$_.JMethodIDPtr).check();
  }

  static final _id_onPause = _class.instanceMethodId(r'onPause', r'()V');

  static final _onPause =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public void onPause()`
  void onPause() {
    _onPause(reference.pointer, _id_onPause as jni$_.JMethodIDPtr).check();
  }

  static final _id_onDestroy = _class.instanceMethodId(r'onDestroy', r'()V');

  static final _onDestroy =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public void onDestroy()`
  void onDestroy() {
    _onDestroy(reference.pointer, _id_onDestroy as jni$_.JMethodIDPtr).check();
  }

  static final _id_onStart = _class.instanceMethodId(r'onStart', r'()V');

  static final _onStart =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public void onStart()`
  void onStart() {
    _onStart(reference.pointer, _id_onStart as jni$_.JMethodIDPtr).check();
  }

  static final _id_onResume = _class.instanceMethodId(r'onResume', r'()V');

  static final _onResume =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public void onResume()`
  void onResume() {
    _onResume(reference.pointer, _id_onResume as jni$_.JMethodIDPtr).check();
  }

  static final _id_onSurfaceCreated = _class.instanceMethodId(
    r'onSurfaceCreated',
    r'(Landroid/view/Surface;)V',
  );

  static final _onSurfaceCreated =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public void onSurfaceCreated(android.view.Surface surface)`
  void onSurfaceCreated(jni$_.JObject? surface) {
    final _$surface = surface?.reference ?? jni$_.jNullReference;
    _onSurfaceCreated(
      reference.pointer,
      _id_onSurfaceCreated as jni$_.JMethodIDPtr,
      _$surface.pointer,
    ).check();
  }

  static final _id_onSurfaceDestroyed = _class.instanceMethodId(
    r'onSurfaceDestroyed',
    r'()V',
  );

  static final _onSurfaceDestroyed =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public void onSurfaceDestroyed()`
  void onSurfaceDestroyed() {
    _onSurfaceDestroyed(
      reference.pointer,
      _id_onSurfaceDestroyed as jni$_.JMethodIDPtr,
    ).check();
  }

  static final _id_onSurfaceChanged = _class.instanceMethodId(
    r'onSurfaceChanged',
    r'(II)V',
  );

  static final _onSurfaceChanged =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Int32, jni$_.Int32)>,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              int,
              int,
            )
          >();

  /// from: `public void onSurfaceChanged(int i, int i1)`
  void onSurfaceChanged(int i, int i1) {
    _onSurfaceChanged(
      reference.pointer,
      _id_onSurfaceChanged as jni$_.JMethodIDPtr,
      i,
      i1,
    ).check();
  }

  static final _id_onDrawFrame = _class.instanceMethodId(
    r'onDrawFrame',
    r'()V',
  );

  static final _onDrawFrame =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public void onDrawFrame()`
  void onDrawFrame() {
    _onDrawFrame(
      reference.pointer,
      _id_onDrawFrame as jni$_.JMethodIDPtr,
    ).check();
  }

  static final _id_requestRender = _class.instanceMethodId(
    r'requestRender',
    r'()V',
  );

  static final _requestRender =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public void requestRender()`
  void requestRender() {
    _requestRender(
      reference.pointer,
      _id_requestRender as jni$_.JMethodIDPtr,
    ).check();
  }

  static final _id_queueEvent = _class.instanceMethodId(
    r'queueEvent',
    r'(Ljava/lang/Runnable;)V',
  );

  static final _queueEvent =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public void queueEvent(java.lang.Runnable runnable)`
  void queueEvent(jni$_.JObject? runnable) {
    final _$runnable = runnable?.reference ?? jni$_.jNullReference;
    _queueEvent(
      reference.pointer,
      _id_queueEvent as jni$_.JMethodIDPtr,
      _$runnable.pointer,
    ).check();
  }

  static final _id_waitForEmpty = _class.instanceMethodId(
    r'waitForEmpty',
    r'()V',
  );

  static final _waitForEmpty =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public void waitForEmpty()`
  void waitForEmpty() {
    _waitForEmpty(
      reference.pointer,
      _id_waitForEmpty as jni$_.JMethodIDPtr,
    ).check();
  }

  static final _id_setRenderingRefreshMode = _class.instanceMethodId(
    r'setRenderingRefreshMode',
    r'(Lorg/maplibre/android/maps/renderer/MapRenderer$RenderingRefreshMode;)V',
  );

  static final _setRenderingRefreshMode =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public void setRenderingRefreshMode(org.maplibre.android.maps.renderer.MapRenderer$RenderingRefreshMode renderingRefreshMode)`
  void setRenderingRefreshMode(
    maprenderer$_.MapRenderer$RenderingRefreshMode? renderingRefreshMode,
  ) {
    final _$renderingRefreshMode =
        renderingRefreshMode?.reference ?? jni$_.jNullReference;
    _setRenderingRefreshMode(
      reference.pointer,
      _id_setRenderingRefreshMode as jni$_.JMethodIDPtr,
      _$renderingRefreshMode.pointer,
    ).check();
  }

  static final _id_getRenderingRefreshMode = _class.instanceMethodId(
    r'getRenderingRefreshMode',
    r'()Lorg/maplibre/android/maps/renderer/MapRenderer$RenderingRefreshMode;',
  );

  static final _getRenderingRefreshMode =
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

  /// from: `public org.maplibre.android.maps.renderer.MapRenderer$RenderingRefreshMode getRenderingRefreshMode()`
  /// The returned object must be released after use, by calling the [release] method.
  maprenderer$_.MapRenderer$RenderingRefreshMode? getRenderingRefreshMode() {
    return _getRenderingRefreshMode(
      reference.pointer,
      _id_getRenderingRefreshMode as jni$_.JMethodIDPtr,
    ).object<maprenderer$_.MapRenderer$RenderingRefreshMode?>(
      const maprenderer$_.$MapRenderer$RenderingRefreshMode$NullableType(),
    );
  }
}

final class $SurfaceViewMapRenderer$NullableType
    extends jni$_.JObjType<SurfaceViewMapRenderer?> {
  @jni$_.internal
  const $SurfaceViewMapRenderer$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/maps/renderer/surfaceview/SurfaceViewMapRenderer;';

  @jni$_.internal
  @core$_.override
  SurfaceViewMapRenderer? fromReference(jni$_.JReference reference) =>
      reference.isNull ? null : SurfaceViewMapRenderer.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType =>
      const maprenderer$_.$MapRenderer$NullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<SurfaceViewMapRenderer?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 2;

  @core$_.override
  int get hashCode => ($SurfaceViewMapRenderer$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($SurfaceViewMapRenderer$NullableType) &&
        other is $SurfaceViewMapRenderer$NullableType;
  }
}

final class $SurfaceViewMapRenderer$Type
    extends jni$_.JObjType<SurfaceViewMapRenderer> {
  @jni$_.internal
  const $SurfaceViewMapRenderer$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/maps/renderer/surfaceview/SurfaceViewMapRenderer;';

  @jni$_.internal
  @core$_.override
  SurfaceViewMapRenderer fromReference(jni$_.JReference reference) =>
      SurfaceViewMapRenderer.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType =>
      const maprenderer$_.$MapRenderer$NullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<SurfaceViewMapRenderer?> get nullableType =>
      const $SurfaceViewMapRenderer$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 2;

  @core$_.override
  int get hashCode => ($SurfaceViewMapRenderer$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($SurfaceViewMapRenderer$Type) &&
        other is $SurfaceViewMapRenderer$Type;
  }
}
