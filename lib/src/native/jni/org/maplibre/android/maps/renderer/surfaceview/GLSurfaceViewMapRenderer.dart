// Autogenerated by jnigen. DO NOT EDIT!

// coverage:ignore-file
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
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable
// ignore_for_file: unused_shown_name
// ignore_for_file: use_super_parameters

import 'dart:core' show Object, String, bool, double, int;
import 'dart:core' as _$core;

import 'package:jni/_internal.dart' as _$jni;
import 'package:jni/jni.dart' as _$jni;

import 'MapLibreGLSurfaceView.dart' as maplibreglsurfaceview_;

import 'SurfaceViewMapRenderer.dart' as surfaceviewmaprenderer_;

/// from: `org.maplibre.android.maps.renderer.surfaceview.GLSurfaceViewMapRenderer`
class GLSurfaceViewMapRenderer
    extends surfaceviewmaprenderer_.SurfaceViewMapRenderer {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<GLSurfaceViewMapRenderer> $type;

  @_$jni.internal
  GLSurfaceViewMapRenderer.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = _$jni.JClass.forName(
      r'org/maplibre/android/maps/renderer/surfaceview/GLSurfaceViewMapRenderer');

  /// The type which includes information such as the signature of this class.
  static const type = $GLSurfaceViewMapRenderer$Type();
  static final _id_new$1 = _class.constructorId(
    r'(Landroid/content/Context;Lorg/maplibre/android/maps/renderer/surfaceview/MapLibreGLSurfaceView;Ljava/lang/String;)V',
  );

  static final _new$1 = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void <init>(android.content.Context context, org.maplibre.android.maps.renderer.surfaceview.MapLibreGLSurfaceView mapLibreGLSurfaceView, java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  factory GLSurfaceViewMapRenderer.new$1(
    _$jni.JObject context,
    maplibreglsurfaceview_.MapLibreGLSurfaceView mapLibreGLSurfaceView,
    _$jni.JString string,
  ) {
    return GLSurfaceViewMapRenderer.fromReference(_new$1(
            _class.reference.pointer,
            _id_new$1 as _$jni.JMethodIDPtr,
            context.reference.pointer,
            mapLibreGLSurfaceView.reference.pointer,
            string.reference.pointer)
        .reference);
  }
}

final class $GLSurfaceViewMapRenderer$Type
    extends _$jni.JObjType<GLSurfaceViewMapRenderer> {
  @_$jni.internal
  const $GLSurfaceViewMapRenderer$Type();

  @_$jni.internal
  @_$core.override
  String get signature =>
      r'Lorg/maplibre/android/maps/renderer/surfaceview/GLSurfaceViewMapRenderer;';

  @_$jni.internal
  @_$core.override
  GLSurfaceViewMapRenderer fromReference(_$jni.JReference reference) =>
      GLSurfaceViewMapRenderer.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType =>
      const surfaceviewmaprenderer_.$SurfaceViewMapRenderer$Type();

  @_$jni.internal
  @_$core.override
  final superCount = 3;

  @_$core.override
  int get hashCode => ($GLSurfaceViewMapRenderer$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($GLSurfaceViewMapRenderer$Type) &&
        other is $GLSurfaceViewMapRenderer$Type;
  }
}
