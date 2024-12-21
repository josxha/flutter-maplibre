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

import 'SurfaceViewMapRenderer.dart' as surfaceviewmaprenderer$_;

/// from: `org.maplibre.android.maps.renderer.surfaceview.MapLibreSurfaceView$OnSurfaceViewDetachedListener`
class MapLibreSurfaceView$OnSurfaceViewDetachedListener extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<MapLibreSurfaceView$OnSurfaceViewDetachedListener> $type;

  @jni$_.internal
  MapLibreSurfaceView$OnSurfaceViewDetachedListener.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
      r'org/maplibre/android/maps/renderer/surfaceview/MapLibreSurfaceView$OnSurfaceViewDetachedListener');

  /// The type which includes information such as the signature of this class.
  static const nullableType =
      $MapLibreSurfaceView$OnSurfaceViewDetachedListener$NullableType();
  static const type = $MapLibreSurfaceView$OnSurfaceViewDetachedListener$Type();
  static final _id_onSurfaceViewDetached = _class.instanceMethodId(
    r'onSurfaceViewDetached',
    r'()V',
  );

  static final _onSurfaceViewDetached = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public abstract void onSurfaceViewDetached()`
  void onSurfaceViewDetached() {
    _onSurfaceViewDetached(
            reference.pointer, _id_onSurfaceViewDetached as jni$_.JMethodIDPtr)
        .check();
  }

  /// Maps a specific port to the implemented interface.
  static final core$_
      .Map<int, $MapLibreSurfaceView$OnSurfaceViewDetachedListener>
      _$impls = {};
  static jni$_.JObjectPtr _$invoke(
    int port,
    jni$_.JObjectPtr descriptor,
    jni$_.JObjectPtr args,
  ) {
    return _$invokeMethod(
      port,
      jni$_.MethodInvocation.fromAddresses(
        0,
        descriptor.address,
        args.address,
      ),
    );
  }

  static final jni$_.Pointer<
          jni$_.NativeFunction<
              jni$_.JObjectPtr Function(
                  jni$_.Int64, jni$_.JObjectPtr, jni$_.JObjectPtr)>>
      _$invokePointer = jni$_.Pointer.fromFunction(_$invoke);

  static jni$_.Pointer<jni$_.Void> _$invokeMethod(
    int $p,
    jni$_.MethodInvocation $i,
  ) {
    try {
      final $d = $i.methodDescriptor.toDartString(releaseOriginal: true);
      final $a = $i.args;
      if ($d == r'onSurfaceViewDetached()V') {
        _$impls[$p]!.onSurfaceViewDetached();
        return jni$_.nullptr;
      }
    } catch (e) {
      return jni$_.ProtectedJniExtensions.newDartException(e);
    }
    return jni$_.nullptr;
  }

  static void implementIn(
    jni$_.JImplementer implementer,
    $MapLibreSurfaceView$OnSurfaceViewDetachedListener $impl,
  ) {
    late final jni$_.RawReceivePort $p;
    $p = jni$_.RawReceivePort(($m) {
      if ($m == null) {
        _$impls.remove($p.sendPort.nativePort);
        $p.close();
        return;
      }
      final $i = jni$_.MethodInvocation.fromMessage($m);
      final $r = _$invokeMethod($p.sendPort.nativePort, $i);
      jni$_.ProtectedJniExtensions.returnResult($i.result, $r);
    });
    implementer.add(
      r'org.maplibre.android.maps.renderer.surfaceview.MapLibreSurfaceView$OnSurfaceViewDetachedListener',
      $p,
      _$invokePointer,
      [
        if ($impl.onSurfaceViewDetached$async) r'onSurfaceViewDetached()V',
      ],
    );
    final $a = $p.sendPort.nativePort;
    _$impls[$a] = $impl;
  }

  factory MapLibreSurfaceView$OnSurfaceViewDetachedListener.implement(
    $MapLibreSurfaceView$OnSurfaceViewDetachedListener $impl,
  ) {
    final $i = jni$_.JImplementer();
    implementIn($i, $impl);
    return MapLibreSurfaceView$OnSurfaceViewDetachedListener.fromReference(
      $i.implementReference(),
    );
  }
}

abstract base mixin class $MapLibreSurfaceView$OnSurfaceViewDetachedListener {
  factory $MapLibreSurfaceView$OnSurfaceViewDetachedListener({
    required void Function() onSurfaceViewDetached,
    bool onSurfaceViewDetached$async,
  }) = _$MapLibreSurfaceView$OnSurfaceViewDetachedListener;

  void onSurfaceViewDetached();
  bool get onSurfaceViewDetached$async => false;
}

final class _$MapLibreSurfaceView$OnSurfaceViewDetachedListener
    with $MapLibreSurfaceView$OnSurfaceViewDetachedListener {
  _$MapLibreSurfaceView$OnSurfaceViewDetachedListener({
    required void Function() onSurfaceViewDetached,
    this.onSurfaceViewDetached$async = false,
  }) : _onSurfaceViewDetached = onSurfaceViewDetached;

  final void Function() _onSurfaceViewDetached;
  final bool onSurfaceViewDetached$async;

  void onSurfaceViewDetached() {
    return _onSurfaceViewDetached();
  }
}

final class $MapLibreSurfaceView$OnSurfaceViewDetachedListener$NullableType
    extends jni$_.JObjType<MapLibreSurfaceView$OnSurfaceViewDetachedListener?> {
  @jni$_.internal
  const $MapLibreSurfaceView$OnSurfaceViewDetachedListener$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/maps/renderer/surfaceview/MapLibreSurfaceView$OnSurfaceViewDetachedListener;';

  @jni$_.internal
  @core$_.override
  MapLibreSurfaceView$OnSurfaceViewDetachedListener? fromReference(
          jni$_.JReference reference) =>
      reference.isNull
          ? null
          : MapLibreSurfaceView$OnSurfaceViewDetachedListener.fromReference(
              reference,
            );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MapLibreSurfaceView$OnSurfaceViewDetachedListener?>
      get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode =>
      ($MapLibreSurfaceView$OnSurfaceViewDetachedListener$NullableType)
          .hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($MapLibreSurfaceView$OnSurfaceViewDetachedListener$NullableType) &&
        other
            is $MapLibreSurfaceView$OnSurfaceViewDetachedListener$NullableType;
  }
}

final class $MapLibreSurfaceView$OnSurfaceViewDetachedListener$Type
    extends jni$_.JObjType<MapLibreSurfaceView$OnSurfaceViewDetachedListener> {
  @jni$_.internal
  const $MapLibreSurfaceView$OnSurfaceViewDetachedListener$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/maps/renderer/surfaceview/MapLibreSurfaceView$OnSurfaceViewDetachedListener;';

  @jni$_.internal
  @core$_.override
  MapLibreSurfaceView$OnSurfaceViewDetachedListener fromReference(
          jni$_.JReference reference) =>
      MapLibreSurfaceView$OnSurfaceViewDetachedListener.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MapLibreSurfaceView$OnSurfaceViewDetachedListener?>
      get nullableType =>
          const $MapLibreSurfaceView$OnSurfaceViewDetachedListener$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode =>
      ($MapLibreSurfaceView$OnSurfaceViewDetachedListener$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($MapLibreSurfaceView$OnSurfaceViewDetachedListener$Type) &&
        other is $MapLibreSurfaceView$OnSurfaceViewDetachedListener$Type;
  }
}

/// from: `org.maplibre.android.maps.renderer.surfaceview.MapLibreSurfaceView`
class MapLibreSurfaceView extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<MapLibreSurfaceView> $type;

  @jni$_.internal
  MapLibreSurfaceView.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
      r'org/maplibre/android/maps/renderer/surfaceview/MapLibreSurfaceView');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $MapLibreSurfaceView$NullableType();
  static const type = $MapLibreSurfaceView$Type();
  static final _id_setDetachedListener = _class.instanceMethodId(
    r'setDetachedListener',
    r'(Lorg/maplibre/android/maps/renderer/surfaceview/MapLibreSurfaceView$OnSurfaceViewDetachedListener;)V',
  );

  static final _setDetachedListener = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void setDetachedListener(org.maplibre.android.maps.renderer.surfaceview.MapLibreSurfaceView$OnSurfaceViewDetachedListener onSurfaceViewDetachedListener)`
  void setDetachedListener(
    MapLibreSurfaceView$OnSurfaceViewDetachedListener?
        onSurfaceViewDetachedListener,
  ) {
    final _$onSurfaceViewDetachedListener =
        onSurfaceViewDetachedListener?.reference ?? jni$_.jNullReference;
    _setDetachedListener(
            reference.pointer,
            _id_setDetachedListener as jni$_.JMethodIDPtr,
            _$onSurfaceViewDetachedListener.pointer)
        .check();
  }

  static final _id_setRenderer = _class.instanceMethodId(
    r'setRenderer',
    r'(Lorg/maplibre/android/maps/renderer/surfaceview/SurfaceViewMapRenderer;)V',
  );

  static final _setRenderer = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void setRenderer(org.maplibre.android.maps.renderer.surfaceview.SurfaceViewMapRenderer surfaceViewMapRenderer)`
  void setRenderer(
    surfaceviewmaprenderer$_.SurfaceViewMapRenderer? surfaceViewMapRenderer,
  ) {
    final _$surfaceViewMapRenderer =
        surfaceViewMapRenderer?.reference ?? jni$_.jNullReference;
    _setRenderer(reference.pointer, _id_setRenderer as jni$_.JMethodIDPtr,
            _$surfaceViewMapRenderer.pointer)
        .check();
  }

  static final _id_setRenderingRefreshMode = _class.instanceMethodId(
    r'setRenderingRefreshMode',
    r'(Lorg/maplibre/android/maps/renderer/MapRenderer$RenderingRefreshMode;)V',
  );

  static final _setRenderingRefreshMode = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void setRenderingRefreshMode(org.maplibre.android.maps.renderer.MapRenderer$RenderingRefreshMode renderingRefreshMode)`
  void setRenderingRefreshMode(
    maprenderer$_.MapRenderer$RenderingRefreshMode? renderingRefreshMode,
  ) {
    final _$renderingRefreshMode =
        renderingRefreshMode?.reference ?? jni$_.jNullReference;
    _setRenderingRefreshMode(
            reference.pointer,
            _id_setRenderingRefreshMode as jni$_.JMethodIDPtr,
            _$renderingRefreshMode.pointer)
        .check();
  }

  static final _id_getRenderingRefreshMode = _class.instanceMethodId(
    r'getRenderingRefreshMode',
    r'()Lorg/maplibre/android/maps/renderer/MapRenderer$RenderingRefreshMode;',
  );

  static final _getRenderingRefreshMode = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.maps.renderer.MapRenderer$RenderingRefreshMode getRenderingRefreshMode()`
  /// The returned object must be released after use, by calling the [release] method.
  maprenderer$_.MapRenderer$RenderingRefreshMode? getRenderingRefreshMode() {
    return _getRenderingRefreshMode(reference.pointer,
            _id_getRenderingRefreshMode as jni$_.JMethodIDPtr)
        .object<maprenderer$_.MapRenderer$RenderingRefreshMode?>(
            const maprenderer$_
                .$MapRenderer$RenderingRefreshMode$NullableType());
  }

  static final _id_requestRender = _class.instanceMethodId(
    r'requestRender',
    r'()V',
  );

  static final _requestRender = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public void requestRender()`
  void requestRender() {
    _requestRender(reference.pointer, _id_requestRender as jni$_.JMethodIDPtr)
        .check();
  }

  static final _id_surfaceCreated = _class.instanceMethodId(
    r'surfaceCreated',
    r'(Landroid/view/SurfaceHolder;)V',
  );

  static final _surfaceCreated = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void surfaceCreated(android.view.SurfaceHolder surfaceHolder)`
  void surfaceCreated(
    jni$_.JObject? surfaceHolder,
  ) {
    final _$surfaceHolder = surfaceHolder?.reference ?? jni$_.jNullReference;
    _surfaceCreated(reference.pointer, _id_surfaceCreated as jni$_.JMethodIDPtr,
            _$surfaceHolder.pointer)
        .check();
  }

  static final _id_surfaceDestroyed = _class.instanceMethodId(
    r'surfaceDestroyed',
    r'(Landroid/view/SurfaceHolder;)V',
  );

  static final _surfaceDestroyed = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void surfaceDestroyed(android.view.SurfaceHolder surfaceHolder)`
  void surfaceDestroyed(
    jni$_.JObject? surfaceHolder,
  ) {
    final _$surfaceHolder = surfaceHolder?.reference ?? jni$_.jNullReference;
    _surfaceDestroyed(reference.pointer,
            _id_surfaceDestroyed as jni$_.JMethodIDPtr, _$surfaceHolder.pointer)
        .check();
  }

  static final _id_surfaceChanged = _class.instanceMethodId(
    r'surfaceChanged',
    r'(Landroid/view/SurfaceHolder;III)V',
  );

  static final _surfaceChanged = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Int32,
                        jni$_.Int32,
                        jni$_.Int32
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>, int, int, int)>();

  /// from: `public void surfaceChanged(android.view.SurfaceHolder surfaceHolder, int i, int i1, int i2)`
  void surfaceChanged(
    jni$_.JObject? surfaceHolder,
    int i,
    int i1,
    int i2,
  ) {
    final _$surfaceHolder = surfaceHolder?.reference ?? jni$_.jNullReference;
    _surfaceChanged(reference.pointer, _id_surfaceChanged as jni$_.JMethodIDPtr,
            _$surfaceHolder.pointer, i, i1, i2)
        .check();
  }

  static final _id_surfaceRedrawNeededAsync = _class.instanceMethodId(
    r'surfaceRedrawNeededAsync',
    r'(Landroid/view/SurfaceHolder;Ljava/lang/Runnable;)V',
  );

  static final _surfaceRedrawNeededAsync = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void surfaceRedrawNeededAsync(android.view.SurfaceHolder surfaceHolder, java.lang.Runnable runnable)`
  void surfaceRedrawNeededAsync(
    jni$_.JObject? surfaceHolder,
    jni$_.JObject? runnable,
  ) {
    final _$surfaceHolder = surfaceHolder?.reference ?? jni$_.jNullReference;
    final _$runnable = runnable?.reference ?? jni$_.jNullReference;
    _surfaceRedrawNeededAsync(
            reference.pointer,
            _id_surfaceRedrawNeededAsync as jni$_.JMethodIDPtr,
            _$surfaceHolder.pointer,
            _$runnable.pointer)
        .check();
  }

  static final _id_surfaceRedrawNeeded = _class.instanceMethodId(
    r'surfaceRedrawNeeded',
    r'(Landroid/view/SurfaceHolder;)V',
  );

  static final _surfaceRedrawNeeded = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void surfaceRedrawNeeded(android.view.SurfaceHolder surfaceHolder)`
  void surfaceRedrawNeeded(
    jni$_.JObject? surfaceHolder,
  ) {
    final _$surfaceHolder = surfaceHolder?.reference ?? jni$_.jNullReference;
    _surfaceRedrawNeeded(
            reference.pointer,
            _id_surfaceRedrawNeeded as jni$_.JMethodIDPtr,
            _$surfaceHolder.pointer)
        .check();
  }

  static final _id_onPause = _class.instanceMethodId(
    r'onPause',
    r'()V',
  );

  static final _onPause = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public void onPause()`
  void onPause() {
    _onPause(reference.pointer, _id_onPause as jni$_.JMethodIDPtr).check();
  }

  static final _id_onResume = _class.instanceMethodId(
    r'onResume',
    r'()V',
  );

  static final _onResume = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public void onResume()`
  void onResume() {
    _onResume(reference.pointer, _id_onResume as jni$_.JMethodIDPtr).check();
  }

  static final _id_queueEvent = _class.instanceMethodId(
    r'queueEvent',
    r'(Ljava/lang/Runnable;)V',
  );

  static final _queueEvent = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void queueEvent(java.lang.Runnable runnable)`
  void queueEvent(
    jni$_.JObject? runnable,
  ) {
    final _$runnable = runnable?.reference ?? jni$_.jNullReference;
    _queueEvent(reference.pointer, _id_queueEvent as jni$_.JMethodIDPtr,
            _$runnable.pointer)
        .check();
  }

  static final _id_waitForEmpty = _class.instanceMethodId(
    r'waitForEmpty',
    r'()V',
  );

  static final _waitForEmpty = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public void waitForEmpty()`
  void waitForEmpty() {
    _waitForEmpty(reference.pointer, _id_waitForEmpty as jni$_.JMethodIDPtr)
        .check();
  }
}

final class $MapLibreSurfaceView$NullableType
    extends jni$_.JObjType<MapLibreSurfaceView?> {
  @jni$_.internal
  const $MapLibreSurfaceView$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/maps/renderer/surfaceview/MapLibreSurfaceView;';

  @jni$_.internal
  @core$_.override
  MapLibreSurfaceView? fromReference(jni$_.JReference reference) =>
      reference.isNull
          ? null
          : MapLibreSurfaceView.fromReference(
              reference,
            );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MapLibreSurfaceView?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($MapLibreSurfaceView$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapLibreSurfaceView$NullableType) &&
        other is $MapLibreSurfaceView$NullableType;
  }
}

final class $MapLibreSurfaceView$Type
    extends jni$_.JObjType<MapLibreSurfaceView> {
  @jni$_.internal
  const $MapLibreSurfaceView$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/maps/renderer/surfaceview/MapLibreSurfaceView;';

  @jni$_.internal
  @core$_.override
  MapLibreSurfaceView fromReference(jni$_.JReference reference) =>
      MapLibreSurfaceView.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MapLibreSurfaceView?> get nullableType =>
      const $MapLibreSurfaceView$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($MapLibreSurfaceView$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapLibreSurfaceView$Type) &&
        other is $MapLibreSurfaceView$Type;
  }
}
