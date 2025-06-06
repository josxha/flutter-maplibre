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

import '../MapLibreMap.dart' as maplibremap$_;

import '../MapLibreMapOptions.dart' as maplibremapoptions$_;

/// from: `org.maplibre.android.maps.renderer.MapRenderer$RenderingRefreshMode`
class MapRenderer$RenderingRefreshMode extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<MapRenderer$RenderingRefreshMode> $type;

  @jni$_.internal
  MapRenderer$RenderingRefreshMode.fromReference(jni$_.JReference reference)
    : $type = type,
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
    r'org/maplibre/android/maps/renderer/MapRenderer$RenderingRefreshMode',
  );

  /// The type which includes information such as the signature of this class.
  static const nullableType = $MapRenderer$RenderingRefreshMode$NullableType();
  static const type = $MapRenderer$RenderingRefreshMode$Type();
  static final _id_WHEN_DIRTY = _class.staticFieldId(
    r'WHEN_DIRTY',
    r'Lorg/maplibre/android/maps/renderer/MapRenderer$RenderingRefreshMode;',
  );

  /// from: `static public final org.maplibre.android.maps.renderer.MapRenderer$RenderingRefreshMode WHEN_DIRTY`
  /// The returned object must be released after use, by calling the [release] method.
  static MapRenderer$RenderingRefreshMode get WHEN_DIRTY => _id_WHEN_DIRTY.get(
    _class,
    const $MapRenderer$RenderingRefreshMode$Type(),
  );

  static final _id_CONTINUOUS = _class.staticFieldId(
    r'CONTINUOUS',
    r'Lorg/maplibre/android/maps/renderer/MapRenderer$RenderingRefreshMode;',
  );

  /// from: `static public final org.maplibre.android.maps.renderer.MapRenderer$RenderingRefreshMode CONTINUOUS`
  /// The returned object must be released after use, by calling the [release] method.
  static MapRenderer$RenderingRefreshMode get CONTINUOUS => _id_CONTINUOUS.get(
    _class,
    const $MapRenderer$RenderingRefreshMode$Type(),
  );

  static final _id_values = _class.staticMethodId(
    r'values',
    r'()[Lorg/maplibre/android/maps/renderer/MapRenderer$RenderingRefreshMode;',
  );

  static final _values =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallStaticObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `static public org.maplibre.android.maps.renderer.MapRenderer$RenderingRefreshMode[] values()`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JArray<MapRenderer$RenderingRefreshMode?>? values() {
    return _values(
      _class.reference.pointer,
      _id_values as jni$_.JMethodIDPtr,
    ).object<jni$_.JArray<MapRenderer$RenderingRefreshMode?>?>(
      const jni$_.JArrayNullableType<MapRenderer$RenderingRefreshMode?>(
        $MapRenderer$RenderingRefreshMode$NullableType(),
      ),
    );
  }

  static final _id_valueOf = _class.staticMethodId(
    r'valueOf',
    r'(Ljava/lang/String;)Lorg/maplibre/android/maps/renderer/MapRenderer$RenderingRefreshMode;',
  );

  static final _valueOf =
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

  /// from: `static public org.maplibre.android.maps.renderer.MapRenderer$RenderingRefreshMode valueOf(java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  static MapRenderer$RenderingRefreshMode? valueOf(jni$_.JString? string) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    return _valueOf(
      _class.reference.pointer,
      _id_valueOf as jni$_.JMethodIDPtr,
      _$string.pointer,
    ).object<MapRenderer$RenderingRefreshMode?>(
      const $MapRenderer$RenderingRefreshMode$NullableType(),
    );
  }
}

final class $MapRenderer$RenderingRefreshMode$NullableType
    extends jni$_.JObjType<MapRenderer$RenderingRefreshMode?> {
  @jni$_.internal
  const $MapRenderer$RenderingRefreshMode$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/maps/renderer/MapRenderer$RenderingRefreshMode;';

  @jni$_.internal
  @core$_.override
  MapRenderer$RenderingRefreshMode? fromReference(jni$_.JReference reference) =>
      reference.isNull
      ? null
      : MapRenderer$RenderingRefreshMode.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MapRenderer$RenderingRefreshMode?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($MapRenderer$RenderingRefreshMode$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($MapRenderer$RenderingRefreshMode$NullableType) &&
        other is $MapRenderer$RenderingRefreshMode$NullableType;
  }
}

final class $MapRenderer$RenderingRefreshMode$Type
    extends jni$_.JObjType<MapRenderer$RenderingRefreshMode> {
  @jni$_.internal
  const $MapRenderer$RenderingRefreshMode$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/maps/renderer/MapRenderer$RenderingRefreshMode;';

  @jni$_.internal
  @core$_.override
  MapRenderer$RenderingRefreshMode fromReference(jni$_.JReference reference) =>
      MapRenderer$RenderingRefreshMode.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MapRenderer$RenderingRefreshMode?> get nullableType =>
      const $MapRenderer$RenderingRefreshMode$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($MapRenderer$RenderingRefreshMode$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapRenderer$RenderingRefreshMode$Type) &&
        other is $MapRenderer$RenderingRefreshMode$Type;
  }
}

/// from: `org.maplibre.android.maps.renderer.MapRenderer`
class MapRenderer extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<MapRenderer> $type;

  @jni$_.internal
  MapRenderer.fromReference(jni$_.JReference reference)
    : $type = type,
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
    r'org/maplibre/android/maps/renderer/MapRenderer',
  );

  /// The type which includes information such as the signature of this class.
  static const nullableType = $MapRenderer$NullableType();
  static const type = $MapRenderer$Type();
  static final _id_create = _class.staticMethodId(
    r'create',
    r'(Lorg/maplibre/android/maps/MapLibreMapOptions;Landroid/content/Context;Ljava/lang/Runnable;)Lorg/maplibre/android/maps/renderer/MapRenderer;',
  );

  static final _create =
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
          >('globalEnv_CallStaticObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `static public org.maplibre.android.maps.renderer.MapRenderer create(org.maplibre.android.maps.MapLibreMapOptions mapLibreMapOptions, android.content.Context context, java.lang.Runnable runnable)`
  /// The returned object must be released after use, by calling the [release] method.
  static MapRenderer? create(
    maplibremapoptions$_.MapLibreMapOptions? mapLibreMapOptions,
    jni$_.JObject context,
    jni$_.JObject? runnable,
  ) {
    final _$mapLibreMapOptions =
        mapLibreMapOptions?.reference ?? jni$_.jNullReference;
    final _$context = context.reference;
    final _$runnable = runnable?.reference ?? jni$_.jNullReference;
    return _create(
      _class.reference.pointer,
      _id_create as jni$_.JMethodIDPtr,
      _$mapLibreMapOptions.pointer,
      _$context.pointer,
      _$runnable.pointer,
    ).object<MapRenderer?>(const $MapRenderer$NullableType());
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

  /// from: `public abstract android.view.View getView()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JObject? getView() {
    return _getView(
      reference.pointer,
      _id_getView as jni$_.JMethodIDPtr,
    ).object<jni$_.JObject?>(const jni$_.JObjectNullableType());
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

  /// from: `public abstract void setRenderingRefreshMode(org.maplibre.android.maps.renderer.MapRenderer$RenderingRefreshMode renderingRefreshMode)`
  void setRenderingRefreshMode(
    MapRenderer$RenderingRefreshMode? renderingRefreshMode,
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

  /// from: `public abstract org.maplibre.android.maps.renderer.MapRenderer$RenderingRefreshMode getRenderingRefreshMode()`
  /// The returned object must be released after use, by calling the [release] method.
  MapRenderer$RenderingRefreshMode? getRenderingRefreshMode() {
    return _getRenderingRefreshMode(
      reference.pointer,
      _id_getRenderingRefreshMode as jni$_.JMethodIDPtr,
    ).object<MapRenderer$RenderingRefreshMode?>(
      const $MapRenderer$RenderingRefreshMode$NullableType(),
    );
  }

  static final _id_setOnFpsChangedListener = _class.instanceMethodId(
    r'setOnFpsChangedListener',
    r'(Lorg/maplibre/android/maps/MapLibreMap$OnFpsChangedListener;)V',
  );

  static final _setOnFpsChangedListener =
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

  /// from: `public void setOnFpsChangedListener(org.maplibre.android.maps.MapLibreMap$OnFpsChangedListener onFpsChangedListener)`
  void setOnFpsChangedListener(
    maplibremap$_.MapLibreMap$OnFpsChangedListener? onFpsChangedListener,
  ) {
    final _$onFpsChangedListener =
        onFpsChangedListener?.reference ?? jni$_.jNullReference;
    _setOnFpsChangedListener(
      reference.pointer,
      _id_setOnFpsChangedListener as jni$_.JMethodIDPtr,
      _$onFpsChangedListener.pointer,
    ).check();
  }

  static final _id_setSwapBehaviorFlush = _class.instanceMethodId(
    r'setSwapBehaviorFlush',
    r'(Z)V',
  );

  static final _setSwapBehaviorFlush =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Int32,)>,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              int,
            )
          >();

  /// from: `public void setSwapBehaviorFlush(boolean z)`
  void setSwapBehaviorFlush(bool z) {
    _setSwapBehaviorFlush(
      reference.pointer,
      _id_setSwapBehaviorFlush as jni$_.JMethodIDPtr,
      z ? 1 : 0,
    ).check();
  }

  static final _id_setMaximumFps = _class.instanceMethodId(
    r'setMaximumFps',
    r'(I)V',
  );

  static final _setMaximumFps =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Int32,)>,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              int,
            )
          >();

  /// from: `public void setMaximumFps(int i)`
  void setMaximumFps(int i) {
    _setMaximumFps(
      reference.pointer,
      _id_setMaximumFps as jni$_.JMethodIDPtr,
      i,
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

  /// from: `public abstract void requestRender()`
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

  /// from: `public abstract void queueEvent(java.lang.Runnable runnable)`
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

  /// from: `public abstract void waitForEmpty()`
  void waitForEmpty() {
    _waitForEmpty(
      reference.pointer,
      _id_waitForEmpty as jni$_.JMethodIDPtr,
    ).check();
  }
}

final class $MapRenderer$NullableType extends jni$_.JObjType<MapRenderer?> {
  @jni$_.internal
  const $MapRenderer$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/maps/renderer/MapRenderer;';

  @jni$_.internal
  @core$_.override
  MapRenderer? fromReference(jni$_.JReference reference) =>
      reference.isNull ? null : MapRenderer.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MapRenderer?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($MapRenderer$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapRenderer$NullableType) &&
        other is $MapRenderer$NullableType;
  }
}

final class $MapRenderer$Type extends jni$_.JObjType<MapRenderer> {
  @jni$_.internal
  const $MapRenderer$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/maps/renderer/MapRenderer;';

  @jni$_.internal
  @core$_.override
  MapRenderer fromReference(jni$_.JReference reference) =>
      MapRenderer.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MapRenderer?> get nullableType =>
      const $MapRenderer$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($MapRenderer$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapRenderer$Type) &&
        other is $MapRenderer$Type;
  }
}
