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

/// from: `org.maplibre.android.maps.renderer.egl.EGLWindowSurfaceFactory`
class EGLWindowSurfaceFactory extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<EGLWindowSurfaceFactory> $type;

  @_$jni.internal
  EGLWindowSurfaceFactory.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = _$jni.JClass.forName(
      r'org/maplibre/android/maps/renderer/egl/EGLWindowSurfaceFactory');

  /// The type which includes information such as the signature of this class.
  static const type = $EGLWindowSurfaceFactory$Type();
  static final _id_new$ = _class.constructorId(
    r'()V',
  );

  static final _new$ = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public void <init>()`
  /// The returned object must be released after use, by calling the [release] method.
  factory EGLWindowSurfaceFactory() {
    return EGLWindowSurfaceFactory.fromReference(
        _new$(_class.reference.pointer, _id_new$ as _$jni.JMethodIDPtr)
            .reference);
  }

  static final _id_createWindowSurface = _class.instanceMethodId(
    r'createWindowSurface',
    r'(Ljavax/microedition/khronos/egl/EGL10;Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;Ljava/lang/Object;)Ljavax/microedition/khronos/egl/EGLSurface;',
  );

  static final _createWindowSurface = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `public javax.microedition.khronos.egl.EGLSurface createWindowSurface(javax.microedition.khronos.egl.EGL10 eGL10, javax.microedition.khronos.egl.EGLDisplay eGLDisplay, javax.microedition.khronos.egl.EGLConfig eGLConfig, java.lang.Object object)`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JObject createWindowSurface(
    _$jni.JObject eGL10,
    _$jni.JObject eGLDisplay,
    _$jni.JObject eGLConfig,
    _$jni.JObject object,
  ) {
    return _createWindowSurface(
            reference.pointer,
            _id_createWindowSurface as _$jni.JMethodIDPtr,
            eGL10.reference.pointer,
            eGLDisplay.reference.pointer,
            eGLConfig.reference.pointer,
            object.reference.pointer)
        .object(const _$jni.JObjectType());
  }

  static final _id_destroySurface = _class.instanceMethodId(
    r'destroySurface',
    r'(Ljavax/microedition/khronos/egl/EGL10;Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;)V',
  );

  static final _destroySurface = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JThrowablePtr Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void destroySurface(javax.microedition.khronos.egl.EGL10 eGL10, javax.microedition.khronos.egl.EGLDisplay eGLDisplay, javax.microedition.khronos.egl.EGLSurface eGLSurface)`
  void destroySurface(
    _$jni.JObject eGL10,
    _$jni.JObject eGLDisplay,
    _$jni.JObject eGLSurface,
  ) {
    _destroySurface(
            reference.pointer,
            _id_destroySurface as _$jni.JMethodIDPtr,
            eGL10.reference.pointer,
            eGLDisplay.reference.pointer,
            eGLSurface.reference.pointer)
        .check();
  }
}

final class $EGLWindowSurfaceFactory$Type
    extends _$jni.JObjType<EGLWindowSurfaceFactory> {
  @_$jni.internal
  const $EGLWindowSurfaceFactory$Type();

  @_$jni.internal
  @_$core.override
  String get signature =>
      r'Lorg/maplibre/android/maps/renderer/egl/EGLWindowSurfaceFactory;';

  @_$jni.internal
  @_$core.override
  EGLWindowSurfaceFactory fromReference(_$jni.JReference reference) =>
      EGLWindowSurfaceFactory.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode => ($EGLWindowSurfaceFactory$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($EGLWindowSurfaceFactory$Type) &&
        other is $EGLWindowSurfaceFactory$Type;
  }
}
