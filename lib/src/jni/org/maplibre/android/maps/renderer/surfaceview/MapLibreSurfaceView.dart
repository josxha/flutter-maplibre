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

import '../MapRenderer.dart' as maprenderer_;

import 'SurfaceViewMapRenderer.dart' as surfaceviewmaprenderer_;

/// from: `org.maplibre.android.maps.renderer.surfaceview.MapLibreSurfaceView$OnSurfaceViewDetachedListener`
class MapLibreSurfaceView_OnSurfaceViewDetachedListener extends jni.JObject {
  @override
  late final jni.JObjType<MapLibreSurfaceView_OnSurfaceViewDetachedListener>
      $type = type;

  MapLibreSurfaceView_OnSurfaceViewDetachedListener.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/maps/renderer/surfaceview/MapLibreSurfaceView$OnSurfaceViewDetachedListener');

  /// The type which includes information such as the signature of this class.
  static const type = $MapLibreSurfaceView_OnSurfaceViewDetachedListenerType();
  static final _id_onSurfaceViewDetached = _class.instanceMethodId(
    r'onSurfaceViewDetached',
    r'()V',
  );

  static final _onSurfaceViewDetached = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public abstract void onSurfaceViewDetached()`
  void onSurfaceViewDetached() {
    _onSurfaceViewDetached(
            reference.pointer, _id_onSurfaceViewDetached as jni.JMethodIDPtr)
        .check();
  }

  /// Maps a specific port to the implemented interface.
  static final Map<int, $MapLibreSurfaceView_OnSurfaceViewDetachedListenerImpl>
      _$impls = {};
  ReceivePort? _$p;

  static jni.JObjectPtr _$invoke(
    int port,
    jni.JObjectPtr descriptor,
    jni.JObjectPtr args,
  ) {
    return _$invokeMethod(
      port,
      $MethodInvocation.fromAddresses(
        0,
        descriptor.address,
        args.address,
      ),
    );
  }

  static final ffi.Pointer<
          ffi.NativeFunction<
              jni.JObjectPtr Function(
                  ffi.Uint64, jni.JObjectPtr, jni.JObjectPtr)>>
      _$invokePointer = ffi.Pointer.fromFunction(_$invoke);

  static ffi.Pointer<ffi.Void> _$invokeMethod(
    int $p,
    $MethodInvocation $i,
  ) {
    try {
      final $d = $i.methodDescriptor.toDartString(releaseOriginal: true);
      final $a = $i.args;
      if ($d == r'onSurfaceViewDetached()V') {
        _$impls[$p]!.onSurfaceViewDetached();
        return jni.nullptr;
      }
    } catch (e) {
      return ProtectedJniExtensions.newDartException(e);
    }
    return jni.nullptr;
  }

  factory MapLibreSurfaceView_OnSurfaceViewDetachedListener.implement(
    $MapLibreSurfaceView_OnSurfaceViewDetachedListenerImpl $impl,
  ) {
    final $p = ReceivePort();
    final $x = MapLibreSurfaceView_OnSurfaceViewDetachedListener.fromReference(
      ProtectedJniExtensions.newPortProxy(
        r'org.maplibre.android.maps.renderer.surfaceview.MapLibreSurfaceView$OnSurfaceViewDetachedListener',
        $p,
        _$invokePointer,
      ),
    ).._$p = $p;
    final $a = $p.sendPort.nativePort;
    _$impls[$a] = $impl;
    $p.listen(($m) {
      if ($m == null) {
        _$impls.remove($p.sendPort.nativePort);
        $p.close();
        return;
      }
      final $i = $MethodInvocation.fromMessage($m as List<dynamic>);
      final $r = _$invokeMethod($p.sendPort.nativePort, $i);
      ProtectedJniExtensions.returnResult($i.result, $r);
    });
    return $x;
  }
}

abstract interface class $MapLibreSurfaceView_OnSurfaceViewDetachedListenerImpl {
  factory $MapLibreSurfaceView_OnSurfaceViewDetachedListenerImpl({
    required void Function() onSurfaceViewDetached,
  }) = _$MapLibreSurfaceView_OnSurfaceViewDetachedListenerImpl;

  void onSurfaceViewDetached();
}

class _$MapLibreSurfaceView_OnSurfaceViewDetachedListenerImpl
    implements $MapLibreSurfaceView_OnSurfaceViewDetachedListenerImpl {
  _$MapLibreSurfaceView_OnSurfaceViewDetachedListenerImpl({
    required void Function() onSurfaceViewDetached,
  }) : _onSurfaceViewDetached = onSurfaceViewDetached;

  final void Function() _onSurfaceViewDetached;

  void onSurfaceViewDetached() {
    return _onSurfaceViewDetached();
  }
}

final class $MapLibreSurfaceView_OnSurfaceViewDetachedListenerType
    extends jni.JObjType<MapLibreSurfaceView_OnSurfaceViewDetachedListener> {
  const $MapLibreSurfaceView_OnSurfaceViewDetachedListenerType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/maps/renderer/surfaceview/MapLibreSurfaceView$OnSurfaceViewDetachedListener;';

  @override
  MapLibreSurfaceView_OnSurfaceViewDetachedListener fromReference(
          jni.JReference reference) =>
      MapLibreSurfaceView_OnSurfaceViewDetachedListener.fromReference(
          reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode =>
      ($MapLibreSurfaceView_OnSurfaceViewDetachedListenerType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($MapLibreSurfaceView_OnSurfaceViewDetachedListenerType) &&
        other is $MapLibreSurfaceView_OnSurfaceViewDetachedListenerType;
  }
}

/// from: `org.maplibre.android.maps.renderer.surfaceview.MapLibreSurfaceView$RenderThreadManager`
class MapLibreSurfaceView_RenderThreadManager extends jni.JObject {
  @override
  late final jni.JObjType<MapLibreSurfaceView_RenderThreadManager> $type = type;

  MapLibreSurfaceView_RenderThreadManager.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/maps/renderer/surfaceview/MapLibreSurfaceView$RenderThreadManager');

  /// The type which includes information such as the signature of this class.
  static const type = $MapLibreSurfaceView_RenderThreadManagerType();
  static final _id_new0 = _class.constructorId(
    r'()V',
  );

  static final _new0 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `protected void <init>()`
  /// The returned object must be released after use, by calling the [release] method.
  factory MapLibreSurfaceView_RenderThreadManager() {
    return MapLibreSurfaceView_RenderThreadManager.fromReference(
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr)
            .reference);
  }
}

final class $MapLibreSurfaceView_RenderThreadManagerType
    extends jni.JObjType<MapLibreSurfaceView_RenderThreadManager> {
  const $MapLibreSurfaceView_RenderThreadManagerType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/maps/renderer/surfaceview/MapLibreSurfaceView$RenderThreadManager;';

  @override
  MapLibreSurfaceView_RenderThreadManager fromReference(
          jni.JReference reference) =>
      MapLibreSurfaceView_RenderThreadManager.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($MapLibreSurfaceView_RenderThreadManagerType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($MapLibreSurfaceView_RenderThreadManagerType) &&
        other is $MapLibreSurfaceView_RenderThreadManagerType;
  }
}

/// from: `org.maplibre.android.maps.renderer.surfaceview.MapLibreSurfaceView`
class MapLibreSurfaceView extends jni.JObject {
  @override
  late final jni.JObjType<MapLibreSurfaceView> $type = type;

  MapLibreSurfaceView.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/maps/renderer/surfaceview/MapLibreSurfaceView');

  /// The type which includes information such as the signature of this class.
  static const type = $MapLibreSurfaceViewType();
  static final _id_TAG = _class.staticFieldId(
    r'TAG',
    r'Ljava/lang/String;',
  );

  /// from: `static protected final java.lang.String TAG`
  /// The returned object must be released after use, by calling the [release] method.
  static jni.JString get TAG => _id_TAG.get(_class, const jni.JStringType());

  static final _id_renderThreadManager = _class.staticFieldId(
    r'renderThreadManager',
    r'Lorg/maplibre/android/maps/renderer/surfaceview/MapLibreSurfaceView$RenderThreadManager;',
  );

  /// from: `static protected final org.maplibre.android.maps.renderer.surfaceview.MapLibreSurfaceView$RenderThreadManager renderThreadManager`
  /// The returned object must be released after use, by calling the [release] method.
  static MapLibreSurfaceView_RenderThreadManager get renderThreadManager =>
      _id_renderThreadManager.get(
          _class, const $MapLibreSurfaceView_RenderThreadManagerType());

  static final _id_renderer = _class.instanceFieldId(
    r'renderer',
    r'Lorg/maplibre/android/maps/renderer/surfaceview/SurfaceViewMapRenderer;',
  );

  /// from: `protected org.maplibre.android.maps.renderer.surfaceview.SurfaceViewMapRenderer renderer`
  /// The returned object must be released after use, by calling the [release] method.
  surfaceviewmaprenderer_.SurfaceViewMapRenderer get renderer => _id_renderer
      .get(this, const surfaceviewmaprenderer_.$SurfaceViewMapRendererType());

  /// from: `protected org.maplibre.android.maps.renderer.surfaceview.SurfaceViewMapRenderer renderer`
  /// The returned object must be released after use, by calling the [release] method.
  set renderer(surfaceviewmaprenderer_.SurfaceViewMapRenderer value) =>
      _id_renderer.set(this,
          const surfaceviewmaprenderer_.$SurfaceViewMapRendererType(), value);

  static final _id_renderThread = _class.instanceFieldId(
    r'renderThread',
    r'Lorg/maplibre/android/maps/renderer/surfaceview/MapLibreSurfaceView$RenderThread;',
  );

  /// from: `protected org.maplibre.android.maps.renderer.surfaceview.MapLibreSurfaceView$RenderThread renderThread`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject get renderThread =>
      _id_renderThread.get(this, const jni.JObjectType());

  /// from: `protected org.maplibre.android.maps.renderer.surfaceview.MapLibreSurfaceView$RenderThread renderThread`
  /// The returned object must be released after use, by calling the [release] method.
  set renderThread(jni.JObject value) =>
      _id_renderThread.set(this, const jni.JObjectType(), value);

  static final _id_detachedListener = _class.instanceFieldId(
    r'detachedListener',
    r'Lorg/maplibre/android/maps/renderer/surfaceview/MapLibreSurfaceView$OnSurfaceViewDetachedListener;',
  );

  /// from: `protected org.maplibre.android.maps.renderer.surfaceview.MapLibreSurfaceView$OnSurfaceViewDetachedListener detachedListener`
  /// The returned object must be released after use, by calling the [release] method.
  MapLibreSurfaceView_OnSurfaceViewDetachedListener get detachedListener =>
      _id_detachedListener.get(
          this, const $MapLibreSurfaceView_OnSurfaceViewDetachedListenerType());

  /// from: `protected org.maplibre.android.maps.renderer.surfaceview.MapLibreSurfaceView$OnSurfaceViewDetachedListener detachedListener`
  /// The returned object must be released after use, by calling the [release] method.
  set detachedListener(
          MapLibreSurfaceView_OnSurfaceViewDetachedListener value) =>
      _id_detachedListener.set(
          this,
          const $MapLibreSurfaceView_OnSurfaceViewDetachedListenerType(),
          value);

  static final _id_detached = _class.instanceFieldId(
    r'detached',
    r'Z',
  );

  /// from: `protected boolean detached`
  bool get detached => _id_detached.get(this, const jni.jbooleanType());

  /// from: `protected boolean detached`
  set detached(bool value) =>
      _id_detached.set(this, const jni.jbooleanType(), value);

  static final _id_new0 = _class.constructorId(
    r'(Landroid/content/Context;)V',
  );

  static final _new0 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(android.content.Context context)`
  /// The returned object must be released after use, by calling the [release] method.
  factory MapLibreSurfaceView(
    jni.JObject context,
  ) {
    return MapLibreSurfaceView.fromReference(_new0(_class.reference.pointer,
            _id_new0 as jni.JMethodIDPtr, context.reference.pointer)
        .reference);
  }

  static final _id_new1 = _class.constructorId(
    r'(Landroid/content/Context;Landroid/util/AttributeSet;)V',
  );

  static final _new1 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(android.content.Context context, android.util.AttributeSet attributeSet)`
  /// The returned object must be released after use, by calling the [release] method.
  factory MapLibreSurfaceView.new1(
    jni.JObject context,
    jni.JObject attributeSet,
  ) {
    return MapLibreSurfaceView.fromReference(_new1(
            _class.reference.pointer,
            _id_new1 as jni.JMethodIDPtr,
            context.reference.pointer,
            attributeSet.reference.pointer)
        .reference);
  }

  static final _id_finalize = _class.instanceMethodId(
    r'finalize',
    r'()V',
  );

  static final _finalize = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `protected void finalize()`
  void finalize() {
    _finalize(reference.pointer, _id_finalize as jni.JMethodIDPtr).check();
  }

  static final _id_setDetachedListener = _class.instanceMethodId(
    r'setDetachedListener',
    r'(Lorg/maplibre/android/maps/renderer/surfaceview/MapLibreSurfaceView$OnSurfaceViewDetachedListener;)V',
  );

  static final _setDetachedListener = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void setDetachedListener(org.maplibre.android.maps.renderer.surfaceview.MapLibreSurfaceView$OnSurfaceViewDetachedListener onSurfaceViewDetachedListener)`
  void setDetachedListener(
    MapLibreSurfaceView_OnSurfaceViewDetachedListener
        onSurfaceViewDetachedListener,
  ) {
    _setDetachedListener(
            reference.pointer,
            _id_setDetachedListener as jni.JMethodIDPtr,
            onSurfaceViewDetachedListener.reference.pointer)
        .check();
  }

  static final _id_setRenderer = _class.instanceMethodId(
    r'setRenderer',
    r'(Lorg/maplibre/android/maps/renderer/surfaceview/SurfaceViewMapRenderer;)V',
  );

  static final _setRenderer = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void setRenderer(org.maplibre.android.maps.renderer.surfaceview.SurfaceViewMapRenderer surfaceViewMapRenderer)`
  void setRenderer(
    surfaceviewmaprenderer_.SurfaceViewMapRenderer surfaceViewMapRenderer,
  ) {
    _setRenderer(reference.pointer, _id_setRenderer as jni.JMethodIDPtr,
            surfaceViewMapRenderer.reference.pointer)
        .check();
  }

  static final _id_setRenderingRefreshMode = _class.instanceMethodId(
    r'setRenderingRefreshMode',
    r'(Lorg/maplibre/android/maps/renderer/MapRenderer$RenderingRefreshMode;)V',
  );

  static final _setRenderingRefreshMode = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void setRenderingRefreshMode(org.maplibre.android.maps.renderer.MapRenderer$RenderingRefreshMode renderingRefreshMode)`
  void setRenderingRefreshMode(
    maprenderer_.MapRenderer_RenderingRefreshMode renderingRefreshMode,
  ) {
    _setRenderingRefreshMode(
            reference.pointer,
            _id_setRenderingRefreshMode as jni.JMethodIDPtr,
            renderingRefreshMode.reference.pointer)
        .check();
  }

  static final _id_getRenderingRefreshMode = _class.instanceMethodId(
    r'getRenderingRefreshMode',
    r'()Lorg/maplibre/android/maps/renderer/MapRenderer$RenderingRefreshMode;',
  );

  static final _getRenderingRefreshMode = ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.maps.renderer.MapRenderer$RenderingRefreshMode getRenderingRefreshMode()`
  /// The returned object must be released after use, by calling the [release] method.
  maprenderer_.MapRenderer_RenderingRefreshMode getRenderingRefreshMode() {
    return _getRenderingRefreshMode(
            reference.pointer, _id_getRenderingRefreshMode as jni.JMethodIDPtr)
        .object(const maprenderer_.$MapRenderer_RenderingRefreshModeType());
  }

  static final _id_requestRender = _class.instanceMethodId(
    r'requestRender',
    r'()V',
  );

  static final _requestRender = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public void requestRender()`
  void requestRender() {
    _requestRender(reference.pointer, _id_requestRender as jni.JMethodIDPtr)
        .check();
  }

  static final _id_surfaceCreated = _class.instanceMethodId(
    r'surfaceCreated',
    r'(Landroid/view/SurfaceHolder;)V',
  );

  static final _surfaceCreated = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void surfaceCreated(android.view.SurfaceHolder surfaceHolder)`
  void surfaceCreated(
    jni.JObject surfaceHolder,
  ) {
    _surfaceCreated(reference.pointer, _id_surfaceCreated as jni.JMethodIDPtr,
            surfaceHolder.reference.pointer)
        .check();
  }

  static final _id_surfaceDestroyed = _class.instanceMethodId(
    r'surfaceDestroyed',
    r'(Landroid/view/SurfaceHolder;)V',
  );

  static final _surfaceDestroyed = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void surfaceDestroyed(android.view.SurfaceHolder surfaceHolder)`
  void surfaceDestroyed(
    jni.JObject surfaceHolder,
  ) {
    _surfaceDestroyed(
            reference.pointer,
            _id_surfaceDestroyed as jni.JMethodIDPtr,
            surfaceHolder.reference.pointer)
        .check();
  }

  static final _id_surfaceChanged = _class.instanceMethodId(
    r'surfaceChanged',
    r'(Landroid/view/SurfaceHolder;III)V',
  );

  static final _surfaceChanged = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        $Int32,
                        $Int32,
                        $Int32
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, int, int, int)>();

  /// from: `public void surfaceChanged(android.view.SurfaceHolder surfaceHolder, int i, int i1, int i2)`
  void surfaceChanged(
    jni.JObject surfaceHolder,
    int i,
    int i1,
    int i2,
  ) {
    _surfaceChanged(reference.pointer, _id_surfaceChanged as jni.JMethodIDPtr,
            surfaceHolder.reference.pointer, i, i1, i2)
        .check();
  }

  static final _id_surfaceRedrawNeededAsync = _class.instanceMethodId(
    r'surfaceRedrawNeededAsync',
    r'(Landroid/view/SurfaceHolder;Ljava/lang/Runnable;)V',
  );

  static final _surfaceRedrawNeededAsync = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `public void surfaceRedrawNeededAsync(android.view.SurfaceHolder surfaceHolder, java.lang.Runnable runnable)`
  void surfaceRedrawNeededAsync(
    jni.JObject surfaceHolder,
    jni.JObject runnable,
  ) {
    _surfaceRedrawNeededAsync(
            reference.pointer,
            _id_surfaceRedrawNeededAsync as jni.JMethodIDPtr,
            surfaceHolder.reference.pointer,
            runnable.reference.pointer)
        .check();
  }

  static final _id_surfaceRedrawNeeded = _class.instanceMethodId(
    r'surfaceRedrawNeeded',
    r'(Landroid/view/SurfaceHolder;)V',
  );

  static final _surfaceRedrawNeeded = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void surfaceRedrawNeeded(android.view.SurfaceHolder surfaceHolder)`
  void surfaceRedrawNeeded(
    jni.JObject surfaceHolder,
  ) {
    _surfaceRedrawNeeded(
            reference.pointer,
            _id_surfaceRedrawNeeded as jni.JMethodIDPtr,
            surfaceHolder.reference.pointer)
        .check();
  }

  static final _id_onPause = _class.instanceMethodId(
    r'onPause',
    r'()V',
  );

  static final _onPause = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public void onPause()`
  void onPause() {
    _onPause(reference.pointer, _id_onPause as jni.JMethodIDPtr).check();
  }

  static final _id_onResume = _class.instanceMethodId(
    r'onResume',
    r'()V',
  );

  static final _onResume = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public void onResume()`
  void onResume() {
    _onResume(reference.pointer, _id_onResume as jni.JMethodIDPtr).check();
  }

  static final _id_queueEvent = _class.instanceMethodId(
    r'queueEvent',
    r'(Ljava/lang/Runnable;)V',
  );

  static final _queueEvent = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void queueEvent(java.lang.Runnable runnable)`
  void queueEvent(
    jni.JObject runnable,
  ) {
    _queueEvent(reference.pointer, _id_queueEvent as jni.JMethodIDPtr,
            runnable.reference.pointer)
        .check();
  }

  static final _id_waitForEmpty = _class.instanceMethodId(
    r'waitForEmpty',
    r'()V',
  );

  static final _waitForEmpty = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public void waitForEmpty()`
  void waitForEmpty() {
    _waitForEmpty(reference.pointer, _id_waitForEmpty as jni.JMethodIDPtr)
        .check();
  }

  static final _id_onAttachedToWindow = _class.instanceMethodId(
    r'onAttachedToWindow',
    r'()V',
  );

  static final _onAttachedToWindow = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `protected void onAttachedToWindow()`
  void onAttachedToWindow() {
    _onAttachedToWindow(
            reference.pointer, _id_onAttachedToWindow as jni.JMethodIDPtr)
        .check();
  }

  static final _id_onDetachedFromWindow = _class.instanceMethodId(
    r'onDetachedFromWindow',
    r'()V',
  );

  static final _onDetachedFromWindow = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `protected void onDetachedFromWindow()`
  void onDetachedFromWindow() {
    _onDetachedFromWindow(
            reference.pointer, _id_onDetachedFromWindow as jni.JMethodIDPtr)
        .check();
  }

  static final _id_createRenderThread = _class.instanceMethodId(
    r'createRenderThread',
    r'()V',
  );

  static final _createRenderThread = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `protected abstract void createRenderThread()`
  void createRenderThread() {
    _createRenderThread(
            reference.pointer, _id_createRenderThread as jni.JMethodIDPtr)
        .check();
  }

  static final _id_checkRenderThreadState = _class.instanceMethodId(
    r'checkRenderThreadState',
    r'()V',
  );

  static final _checkRenderThreadState = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `protected void checkRenderThreadState()`
  void checkRenderThreadState() {
    _checkRenderThreadState(
            reference.pointer, _id_checkRenderThreadState as jni.JMethodIDPtr)
        .check();
  }
}

final class $MapLibreSurfaceViewType extends jni.JObjType<MapLibreSurfaceView> {
  const $MapLibreSurfaceViewType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/maps/renderer/surfaceview/MapLibreSurfaceView;';

  @override
  MapLibreSurfaceView fromReference(jni.JReference reference) =>
      MapLibreSurfaceView.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($MapLibreSurfaceViewType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapLibreSurfaceViewType) &&
        other is $MapLibreSurfaceViewType;
  }
}
