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

import 'surfaceview/SurfaceViewMapRenderer.dart' as surfaceviewmaprenderer_;

import 'textureview/TextureViewMapRenderer.dart' as textureviewmaprenderer_;

/// from: `org.maplibre.android.maps.renderer.MapRendererFactory`
class MapRendererFactory extends jni.JObject {
  @override
  late final jni.JObjType<MapRendererFactory> $type = type;

  MapRendererFactory.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/maps/renderer/MapRendererFactory');

  /// The type which includes information such as the signature of this class.
  static const type = $MapRendererFactoryType();
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

  /// from: `public void <init>()`
  /// The returned object must be released after use, by calling the [release] method.
  factory MapRendererFactory() {
    return MapRendererFactory.fromReference(
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr)
            .reference);
  }

  static final _id_newTextureViewMapRenderer = _class.staticMethodId(
    r'newTextureViewMapRenderer',
    r'(Landroid/content/Context;Landroid/view/TextureView;Ljava/lang/String;ZLjava/lang/Runnable;)Lorg/maplibre/android/maps/renderer/textureview/TextureViewMapRenderer;',
  );

  static final _newTextureViewMapRenderer = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        $Int32,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>,
              jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              int,
              ffi.Pointer<ffi.Void>)>();

  /// from: `static public org.maplibre.android.maps.renderer.textureview.TextureViewMapRenderer newTextureViewMapRenderer(android.content.Context context, android.view.TextureView textureView, java.lang.String string, boolean z, java.lang.Runnable runnable)`
  /// The returned object must be released after use, by calling the [release] method.
  static textureviewmaprenderer_.TextureViewMapRenderer
      newTextureViewMapRenderer(
    jni.JObject context,
    jni.JObject textureView,
    jni.JString string,
    bool z,
    jni.JObject runnable,
  ) {
    return _newTextureViewMapRenderer(
            _class.reference.pointer,
            _id_newTextureViewMapRenderer as jni.JMethodIDPtr,
            context.reference.pointer,
            textureView.reference.pointer,
            string.reference.pointer,
            z ? 1 : 0,
            runnable.reference.pointer)
        .object(const textureviewmaprenderer_.$TextureViewMapRendererType());
  }

  static final _id_newSurfaceViewMapRenderer = _class.staticMethodId(
    r'newSurfaceViewMapRenderer',
    r'(Landroid/content/Context;Ljava/lang/String;ZLjava/lang/Runnable;)Lorg/maplibre/android/maps/renderer/surfaceview/SurfaceViewMapRenderer;',
  );

  static final _newSurfaceViewMapRenderer = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        $Int32,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>,
              jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              int,
              ffi.Pointer<ffi.Void>)>();

  /// from: `static public org.maplibre.android.maps.renderer.surfaceview.SurfaceViewMapRenderer newSurfaceViewMapRenderer(android.content.Context context, java.lang.String string, boolean z, java.lang.Runnable runnable)`
  /// The returned object must be released after use, by calling the [release] method.
  static surfaceviewmaprenderer_.SurfaceViewMapRenderer
      newSurfaceViewMapRenderer(
    jni.JObject context,
    jni.JString string,
    bool z,
    jni.JObject runnable,
  ) {
    return _newSurfaceViewMapRenderer(
            _class.reference.pointer,
            _id_newSurfaceViewMapRenderer as jni.JMethodIDPtr,
            context.reference.pointer,
            string.reference.pointer,
            z ? 1 : 0,
            runnable.reference.pointer)
        .object(const surfaceviewmaprenderer_.$SurfaceViewMapRendererType());
  }
}

final class $MapRendererFactoryType extends jni.JObjType<MapRendererFactory> {
  const $MapRendererFactoryType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/maps/renderer/MapRendererFactory;';

  @override
  MapRendererFactory fromReference(jni.JReference reference) =>
      MapRendererFactory.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($MapRendererFactoryType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapRendererFactoryType) &&
        other is $MapRendererFactoryType;
  }
}
