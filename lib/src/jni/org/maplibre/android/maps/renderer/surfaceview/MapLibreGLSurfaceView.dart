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

import 'MapLibreSurfaceView.dart' as maplibresurfaceview_;

import 'SurfaceViewMapRenderer.dart' as surfaceviewmaprenderer_;

/// from: `org.maplibre.android.maps.renderer.surfaceview.MapLibreGLSurfaceView`
class MapLibreGLSurfaceView extends maplibresurfaceview_.MapLibreSurfaceView {
  @override
  late final jni.JObjType<MapLibreGLSurfaceView> $type = type;

  MapLibreGLSurfaceView.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/maps/renderer/surfaceview/MapLibreGLSurfaceView');

  /// The type which includes information such as the signature of this class.
  static const type = $MapLibreGLSurfaceViewType();
  static final _id_viewWeakReference = _class.instanceFieldId(
    r'viewWeakReference',
    r'Ljava/lang/ref/WeakReference;',
  );

  /// from: `protected final java.lang.ref.WeakReference viewWeakReference`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject get viewWeakReference =>
      _id_viewWeakReference.get(this, const jni.JObjectType());

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
  factory MapLibreGLSurfaceView(
    jni.JObject context,
  ) {
    return MapLibreGLSurfaceView.fromReference(_new0(_class.reference.pointer,
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
  factory MapLibreGLSurfaceView.new1(
    jni.JObject context,
    jni.JObject attributeSet,
  ) {
    return MapLibreGLSurfaceView.fromReference(_new1(
            _class.reference.pointer,
            _id_new1 as jni.JMethodIDPtr,
            context.reference.pointer,
            attributeSet.reference.pointer)
        .reference);
  }

  static final _id_setPreserveEGLContextOnPause = _class.instanceMethodId(
    r'setPreserveEGLContextOnPause',
    r'(Z)V',
  );

  static final _setPreserveEGLContextOnPause = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<($Int32,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int)>();

  /// from: `public void setPreserveEGLContextOnPause(boolean z)`
  void setPreserveEGLContextOnPause(
    bool z,
  ) {
    _setPreserveEGLContextOnPause(reference.pointer,
            _id_setPreserveEGLContextOnPause as jni.JMethodIDPtr, z ? 1 : 0)
        .check();
  }

  static final _id_getPreserveEGLContextOnPause = _class.instanceMethodId(
    r'getPreserveEGLContextOnPause',
    r'()Z',
  );

  static final _getPreserveEGLContextOnPause = ProtectedJniExtensions.lookup<
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

  /// from: `public boolean getPreserveEGLContextOnPause()`
  bool getPreserveEGLContextOnPause() {
    return _getPreserveEGLContextOnPause(reference.pointer,
            _id_getPreserveEGLContextOnPause as jni.JMethodIDPtr)
        .boolean;
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

  static final _id_setEGLContextFactory = _class.instanceMethodId(
    r'setEGLContextFactory',
    r'(Landroid/opengl/GLSurfaceView$EGLContextFactory;)V',
  );

  static final _setEGLContextFactory = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void setEGLContextFactory(android.opengl.GLSurfaceView$EGLContextFactory eGLContextFactory)`
  void setEGLContextFactory(
    jni.JObject eGLContextFactory,
  ) {
    _setEGLContextFactory(
            reference.pointer,
            _id_setEGLContextFactory as jni.JMethodIDPtr,
            eGLContextFactory.reference.pointer)
        .check();
  }

  static final _id_setEGLWindowSurfaceFactory = _class.instanceMethodId(
    r'setEGLWindowSurfaceFactory',
    r'(Landroid/opengl/GLSurfaceView$EGLWindowSurfaceFactory;)V',
  );

  static final _setEGLWindowSurfaceFactory = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void setEGLWindowSurfaceFactory(android.opengl.GLSurfaceView$EGLWindowSurfaceFactory eGLWindowSurfaceFactory)`
  void setEGLWindowSurfaceFactory(
    jni.JObject eGLWindowSurfaceFactory,
  ) {
    _setEGLWindowSurfaceFactory(
            reference.pointer,
            _id_setEGLWindowSurfaceFactory as jni.JMethodIDPtr,
            eGLWindowSurfaceFactory.reference.pointer)
        .check();
  }

  static final _id_setEGLConfigChooser = _class.instanceMethodId(
    r'setEGLConfigChooser',
    r'(Landroid/opengl/GLSurfaceView$EGLConfigChooser;)V',
  );

  static final _setEGLConfigChooser = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void setEGLConfigChooser(android.opengl.GLSurfaceView$EGLConfigChooser eGLConfigChooser)`
  void setEGLConfigChooser(
    jni.JObject eGLConfigChooser,
  ) {
    _setEGLConfigChooser(
            reference.pointer,
            _id_setEGLConfigChooser as jni.JMethodIDPtr,
            eGLConfigChooser.reference.pointer)
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

  /// from: `protected void createRenderThread()`
  void createRenderThread() {
    _createRenderThread(
            reference.pointer, _id_createRenderThread as jni.JMethodIDPtr)
        .check();
  }
}

final class $MapLibreGLSurfaceViewType
    extends jni.JObjType<MapLibreGLSurfaceView> {
  const $MapLibreGLSurfaceViewType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/maps/renderer/surfaceview/MapLibreGLSurfaceView;';

  @override
  MapLibreGLSurfaceView fromReference(jni.JReference reference) =>
      MapLibreGLSurfaceView.fromReference(reference);

  @override
  jni.JObjType get superType =>
      const maplibresurfaceview_.$MapLibreSurfaceViewType();

  @override
  final superCount = 2;

  @override
  int get hashCode => ($MapLibreGLSurfaceViewType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapLibreGLSurfaceViewType) &&
        other is $MapLibreGLSurfaceViewType;
  }
}