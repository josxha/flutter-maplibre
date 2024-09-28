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

import 'MapLibreGLSurfaceView.dart' as maplibreglsurfaceview_;

import 'SurfaceViewMapRenderer.dart' as surfaceviewmaprenderer_;

/// from: `org.maplibre.android.maps.renderer.surfaceview.GLSurfaceViewMapRenderer`
class GLSurfaceViewMapRenderer
    extends surfaceviewmaprenderer_.SurfaceViewMapRenderer {
  @override
  late final jni.JObjType<GLSurfaceViewMapRenderer> $type = type;

  GLSurfaceViewMapRenderer.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/maps/renderer/surfaceview/GLSurfaceViewMapRenderer');

  /// The type which includes information such as the signature of this class.
  static const type = $GLSurfaceViewMapRendererType();
  static final _id_new2 = _class.constructorId(
    r'(Landroid/content/Context;Lorg/maplibre/android/maps/renderer/surfaceview/MapLibreGLSurfaceView;Ljava/lang/String;)V',
  );

  static final _new2 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>,
              jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(android.content.Context context, org.maplibre.android.maps.renderer.surfaceview.MapLibreGLSurfaceView mapLibreGLSurfaceView, java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  factory GLSurfaceViewMapRenderer.new2(
    jni.JObject context,
    maplibreglsurfaceview_.MapLibreGLSurfaceView mapLibreGLSurfaceView,
    jni.JString string,
  ) {
    return GLSurfaceViewMapRenderer.fromReference(_new2(
            _class.reference.pointer,
            _id_new2 as jni.JMethodIDPtr,
            context.reference.pointer,
            mapLibreGLSurfaceView.reference.pointer,
            string.reference.pointer)
        .reference);
  }
}

final class $GLSurfaceViewMapRendererType
    extends jni.JObjType<GLSurfaceViewMapRenderer> {
  const $GLSurfaceViewMapRendererType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/maps/renderer/surfaceview/GLSurfaceViewMapRenderer;';

  @override
  GLSurfaceViewMapRenderer fromReference(jni.JReference reference) =>
      GLSurfaceViewMapRenderer.fromReference(reference);

  @override
  jni.JObjType get superType =>
      const surfaceviewmaprenderer_.$SurfaceViewMapRendererType();

  @override
  final superCount = 3;

  @override
  int get hashCode => ($GLSurfaceViewMapRendererType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($GLSurfaceViewMapRendererType) &&
        other is $GLSurfaceViewMapRendererType;
  }
}
