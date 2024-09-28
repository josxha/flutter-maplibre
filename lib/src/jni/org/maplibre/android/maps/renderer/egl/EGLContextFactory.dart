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

/// from: `org.maplibre.android.maps.renderer.egl.EGLContextFactory`
class EGLContextFactory extends jni.JObject {
  @override
  late final jni.JObjType<EGLContextFactory> $type = type;

  EGLContextFactory.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/maps/renderer/egl/EGLContextFactory');

  /// The type which includes information such as the signature of this class.
  static const type = $EGLContextFactoryType();
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
  factory EGLContextFactory() {
    return EGLContextFactory.fromReference(
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr)
            .reference);
  }

  static final _id_createContext = _class.instanceMethodId(
    r'createContext',
    r'(Ljavax/microedition/khronos/egl/EGL10;Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;)Ljavax/microedition/khronos/egl/EGLContext;',
  );

  static final _createContext = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
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
              ffi.Pointer<ffi.Void>)>();

  /// from: `public javax.microedition.khronos.egl.EGLContext createContext(javax.microedition.khronos.egl.EGL10 eGL10, javax.microedition.khronos.egl.EGLDisplay eGLDisplay, javax.microedition.khronos.egl.EGLConfig eGLConfig)`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject createContext(
    jni.JObject eGL10,
    jni.JObject eGLDisplay,
    jni.JObject eGLConfig,
  ) {
    return _createContext(
            reference.pointer,
            _id_createContext as jni.JMethodIDPtr,
            eGL10.reference.pointer,
            eGLDisplay.reference.pointer,
            eGLConfig.reference.pointer)
        .object(const jni.JObjectType());
  }

  static final _id_destroyContext = _class.instanceMethodId(
    r'destroyContext',
    r'(Ljavax/microedition/khronos/egl/EGL10;Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLContext;)V',
  );

  static final _destroyContext = ProtectedJniExtensions.lookup<
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

  /// from: `public void destroyContext(javax.microedition.khronos.egl.EGL10 eGL10, javax.microedition.khronos.egl.EGLDisplay eGLDisplay, javax.microedition.khronos.egl.EGLContext eGLContext)`
  void destroyContext(
    jni.JObject eGL10,
    jni.JObject eGLDisplay,
    jni.JObject eGLContext,
  ) {
    _destroyContext(
            reference.pointer,
            _id_destroyContext as jni.JMethodIDPtr,
            eGL10.reference.pointer,
            eGLDisplay.reference.pointer,
            eGLContext.reference.pointer)
        .check();
  }
}

final class $EGLContextFactoryType extends jni.JObjType<EGLContextFactory> {
  const $EGLContextFactoryType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/maps/renderer/egl/EGLContextFactory;';

  @override
  EGLContextFactory fromReference(jni.JReference reference) =>
      EGLContextFactory.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($EGLContextFactoryType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($EGLContextFactoryType) &&
        other is $EGLContextFactoryType;
  }
}
