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

import 'PropertyValue.dart' as propertyvalue$_;

/// from: `org.maplibre.android.style.layers.Layer`
class Layer extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<Layer> $type;

  @jni$_.internal
  Layer.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/style/layers/Layer');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $Layer$NullableType();
  static const type = $Layer$Type();
  static final _id_setProperties = _class.instanceMethodId(
    r'setProperties',
    r'([Lorg/maplibre/android/style/layers/PropertyValue;)V',
  );

  static final _setProperties = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void setProperties(java.lang.Object[] propertyValues)`
  void setProperties(
    jni$_.JArray<propertyvalue$_.PropertyValue<jni$_.JObject?>?>?
        propertyValues,
  ) {
    final _$propertyValues = propertyValues?.reference ?? jni$_.jNullReference;
    _setProperties(reference.pointer, _id_setProperties as jni$_.JMethodIDPtr,
            _$propertyValues.pointer)
        .check();
  }

  static final _id_getId = _class.instanceMethodId(
    r'getId',
    r'()Ljava/lang/String;',
  );

  static final _getId = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public java.lang.String getId()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getId() {
    return _getId(reference.pointer, _id_getId as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getVisibility = _class.instanceMethodId(
    r'getVisibility',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getVisibility = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public org.maplibre.android.style.layers.PropertyValue getVisibility()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue$_.PropertyValue<jni$_.JString?>? getVisibility() {
    return _getVisibility(
            reference.pointer, _id_getVisibility as jni$_.JMethodIDPtr)
        .object<propertyvalue$_.PropertyValue<jni$_.JString?>?>(
            const propertyvalue$_.$PropertyValue$NullableType<jni$_.JString?>(
                jni$_.JStringNullableType()));
  }

  static final _id_getMinZoom = _class.instanceMethodId(
    r'getMinZoom',
    r'()F',
  );

  static final _getMinZoom = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallFloatMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public float getMinZoom()`
  double getMinZoom() {
    return _getMinZoom(reference.pointer, _id_getMinZoom as jni$_.JMethodIDPtr)
        .float;
  }

  static final _id_getMaxZoom = _class.instanceMethodId(
    r'getMaxZoom',
    r'()F',
  );

  static final _getMaxZoom = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallFloatMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public float getMaxZoom()`
  double getMaxZoom() {
    return _getMaxZoom(reference.pointer, _id_getMaxZoom as jni$_.JMethodIDPtr)
        .float;
  }

  static final _id_setMinZoom = _class.instanceMethodId(
    r'setMinZoom',
    r'(F)V',
  );

  static final _setMinZoom = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<(jni$_.Double,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, double)>();

  /// from: `public void setMinZoom(float f)`
  void setMinZoom(
    double f,
  ) {
    _setMinZoom(reference.pointer, _id_setMinZoom as jni$_.JMethodIDPtr, f)
        .check();
  }

  static final _id_setMaxZoom = _class.instanceMethodId(
    r'setMaxZoom',
    r'(F)V',
  );

  static final _setMaxZoom = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<(jni$_.Double,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, double)>();

  /// from: `public void setMaxZoom(float f)`
  void setMaxZoom(
    double f,
  ) {
    _setMaxZoom(reference.pointer, _id_setMaxZoom as jni$_.JMethodIDPtr, f)
        .check();
  }

  static final _id_getNativePtr = _class.instanceMethodId(
    r'getNativePtr',
    r'()J',
  );

  static final _getNativePtr = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallLongMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public long getNativePtr()`
  int getNativePtr() {
    return _getNativePtr(
            reference.pointer, _id_getNativePtr as jni$_.JMethodIDPtr)
        .long;
  }

  static final _id_setDetached = _class.instanceMethodId(
    r'setDetached',
    r'()V',
  );

  static final _setDetached = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public void setDetached()`
  void setDetached() {
    _setDetached(reference.pointer, _id_setDetached as jni$_.JMethodIDPtr)
        .check();
  }

  static final _id_isDetached = _class.instanceMethodId(
    r'isDetached',
    r'()Z',
  );

  static final _isDetached = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallBooleanMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public boolean isDetached()`
  bool isDetached() {
    return _isDetached(reference.pointer, _id_isDetached as jni$_.JMethodIDPtr)
        .boolean;
  }
}

final class $Layer$NullableType extends jni$_.JObjType<Layer?> {
  @jni$_.internal
  const $Layer$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/style/layers/Layer;';

  @jni$_.internal
  @core$_.override
  Layer? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : Layer.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Layer?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Layer$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Layer$NullableType) &&
        other is $Layer$NullableType;
  }
}

final class $Layer$Type extends jni$_.JObjType<Layer> {
  @jni$_.internal
  const $Layer$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/style/layers/Layer;';

  @jni$_.internal
  @core$_.override
  Layer fromReference(jni$_.JReference reference) => Layer.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Layer?> get nullableType => const $Layer$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Layer$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Layer$Type) && other is $Layer$Type;
  }
}
