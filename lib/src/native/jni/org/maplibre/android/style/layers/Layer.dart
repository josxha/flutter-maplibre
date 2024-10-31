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

import 'PropertyValue.dart' as propertyvalue_;

/// from: `org.maplibre.android.style.layers.Layer`
class Layer extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<Layer> $type;

  @_$jni.internal
  Layer.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      _$jni.JClass.forName(r'org/maplibre/android/style/layers/Layer');

  /// The type which includes information such as the signature of this class.
  static const type = $Layer$Type();
  static final _id_setProperties = _class.instanceMethodId(
    r'setProperties',
    r'([Lorg/maplibre/android/style/layers/PropertyValue;)V',
  );

  static final _setProperties = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void setProperties(java.lang.Object[] propertyValues)`
  void setProperties(
    _$jni.JArray<propertyvalue_.PropertyValue<_$jni.JObject>> propertyValues,
  ) {
    _setProperties(reference.pointer, _id_setProperties as _$jni.JMethodIDPtr,
            propertyValues.reference.pointer)
        .check();
  }

  static final _id_getId = _class.instanceMethodId(
    r'getId',
    r'()Ljava/lang/String;',
  );

  static final _getId = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public java.lang.String getId()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JString getId() {
    return _getId(reference.pointer, _id_getId as _$jni.JMethodIDPtr)
        .object(const _$jni.JStringType());
  }

  static final _id_getVisibility = _class.instanceMethodId(
    r'getVisibility',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getVisibility = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public org.maplibre.android.style.layers.PropertyValue getVisibility()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JString> getVisibility() {
    return _getVisibility(
            reference.pointer, _id_getVisibility as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(_$jni.JStringType()));
  }

  static final _id_getMinZoom = _class.instanceMethodId(
    r'getMinZoom',
    r'()F',
  );

  static final _getMinZoom = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallFloatMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public float getMinZoom()`
  double getMinZoom() {
    return _getMinZoom(reference.pointer, _id_getMinZoom as _$jni.JMethodIDPtr)
        .float;
  }

  static final _id_getMaxZoom = _class.instanceMethodId(
    r'getMaxZoom',
    r'()F',
  );

  static final _getMaxZoom = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallFloatMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public float getMaxZoom()`
  double getMaxZoom() {
    return _getMaxZoom(reference.pointer, _id_getMaxZoom as _$jni.JMethodIDPtr)
        .float;
  }

  static final _id_setMinZoom = _class.instanceMethodId(
    r'setMinZoom',
    r'(F)V',
  );

  static final _setMinZoom = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JThrowablePtr Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<(_$jni.Double,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(
              _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, double)>();

  /// from: `public void setMinZoom(float f)`
  void setMinZoom(
    double f,
  ) {
    _setMinZoom(reference.pointer, _id_setMinZoom as _$jni.JMethodIDPtr, f)
        .check();
  }

  static final _id_setMaxZoom = _class.instanceMethodId(
    r'setMaxZoom',
    r'(F)V',
  );

  static final _setMaxZoom = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JThrowablePtr Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<(_$jni.Double,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(
              _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, double)>();

  /// from: `public void setMaxZoom(float f)`
  void setMaxZoom(
    double f,
  ) {
    _setMaxZoom(reference.pointer, _id_setMaxZoom as _$jni.JMethodIDPtr, f)
        .check();
  }

  static final _id_getNativePtr = _class.instanceMethodId(
    r'getNativePtr',
    r'()J',
  );

  static final _getNativePtr = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallLongMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public long getNativePtr()`
  int getNativePtr() {
    return _getNativePtr(
            reference.pointer, _id_getNativePtr as _$jni.JMethodIDPtr)
        .long;
  }

  static final _id_setDetached = _class.instanceMethodId(
    r'setDetached',
    r'()V',
  );

  static final _setDetached = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JThrowablePtr Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public void setDetached()`
  void setDetached() {
    _setDetached(reference.pointer, _id_setDetached as _$jni.JMethodIDPtr)
        .check();
  }

  static final _id_isDetached = _class.instanceMethodId(
    r'isDetached',
    r'()Z',
  );

  static final _isDetached = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallBooleanMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public boolean isDetached()`
  bool isDetached() {
    return _isDetached(reference.pointer, _id_isDetached as _$jni.JMethodIDPtr)
        .boolean;
  }
}

final class $Layer$Type extends _$jni.JObjType<Layer> {
  @_$jni.internal
  const $Layer$Type();

  @_$jni.internal
  @_$core.override
  String get signature => r'Lorg/maplibre/android/style/layers/Layer;';

  @_$jni.internal
  @_$core.override
  Layer fromReference(_$jni.JReference reference) =>
      Layer.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode => ($Layer$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Layer$Type) && other is $Layer$Type;
  }
}
