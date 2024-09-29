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

/// from: `org.maplibre.android.maps.renderer.egl.EGLWindowSurfaceFactory`
class EGLWindowSurfaceFactory extends jni.JObject {
  @override
  late final jni.JObjType<EGLWindowSurfaceFactory> $type = type;

  EGLWindowSurfaceFactory.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/maps/renderer/egl/EGLWindowSurfaceFactory');

  /// The type which includes information such as the signature of this class.
  static const type = $EGLWindowSurfaceFactoryType();
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
  factory EGLWindowSurfaceFactory() {
    return EGLWindowSurfaceFactory.fromReference(
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr)
            .reference);
  }

  static final _id_createWindowSurface = _class.instanceMethodId(
    r'createWindowSurface',
    r'(Ljavax/microedition/khronos/egl/EGL10;Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;Ljava/lang/Object;)Ljavax/microedition/khronos/egl/EGLSurface;',
  );

  static final _createWindowSurface = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>,
              jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public javax.microedition.khronos.egl.EGLSurface createWindowSurface(javax.microedition.khronos.egl.EGL10 eGL10, javax.microedition.khronos.egl.EGLDisplay eGLDisplay, javax.microedition.khronos.egl.EGLConfig eGLConfig, java.lang.Object object)`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject createWindowSurface(
    jni.JObject eGL10,
    jni.JObject eGLDisplay,
    jni.JObject eGLConfig,
    jni.JObject object,
  ) {
    return _createWindowSurface(
            reference.pointer,
            _id_createWindowSurface as jni.JMethodIDPtr,
            eGL10.reference.pointer,
            eGLDisplay.reference.pointer,
            eGLConfig.reference.pointer,
            object.reference.pointer)
        .object(const jni.JObjectType());
  }

  static final _id_destroySurface = _class.instanceMethodId(
    r'destroySurface',
    r'(Ljavax/microedition/khronos/egl/EGL10;Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;)V',
  );

  static final _destroySurface = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>,
              jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void destroySurface(javax.microedition.khronos.egl.EGL10 eGL10, javax.microedition.khronos.egl.EGLDisplay eGLDisplay, javax.microedition.khronos.egl.EGLSurface eGLSurface)`
  void destroySurface(
    jni.JObject eGL10,
    jni.JObject eGLDisplay,
    jni.JObject eGLSurface,
  ) {
    _destroySurface(
            reference.pointer,
            _id_destroySurface as jni.JMethodIDPtr,
            eGL10.reference.pointer,
            eGLDisplay.reference.pointer,
            eGLSurface.reference.pointer)
        .check();
  }
}

final class $EGLWindowSurfaceFactoryType
    extends jni.JObjType<EGLWindowSurfaceFactory> {
  const $EGLWindowSurfaceFactoryType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/maps/renderer/egl/EGLWindowSurfaceFactory;';

  @override
  EGLWindowSurfaceFactory fromReference(jni.JReference reference) =>
      EGLWindowSurfaceFactory.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($EGLWindowSurfaceFactoryType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($EGLWindowSurfaceFactoryType) &&
        other is $EGLWindowSurfaceFactoryType;
  }
}
