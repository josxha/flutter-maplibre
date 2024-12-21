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

import '../layers/TransitionOptions.dart' as transitionoptions$_;

import 'Position.dart' as position$_;

/// from: `org.maplibre.android.style.light.Light`
class Light extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<Light> $type;

  @jni$_.internal
  Light.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/style/light/Light');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $Light$NullableType();
  static const type = $Light$Type();
  static final _id_setAnchor = _class.instanceMethodId(
    r'setAnchor',
    r'(Ljava/lang/String;)V',
  );

  static final _setAnchor = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void setAnchor(java.lang.String string)`
  void setAnchor(
    jni$_.JString? string,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    _setAnchor(reference.pointer, _id_setAnchor as jni$_.JMethodIDPtr,
            _$string.pointer)
        .check();
  }

  static final _id_getAnchor = _class.instanceMethodId(
    r'getAnchor',
    r'()Ljava/lang/String;',
  );

  static final _getAnchor = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getAnchor()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getAnchor() {
    return _getAnchor(reference.pointer, _id_getAnchor as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_setPosition = _class.instanceMethodId(
    r'setPosition',
    r'(Lorg/maplibre/android/style/light/Position;)V',
  );

  static final _setPosition = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void setPosition(org.maplibre.android.style.light.Position position)`
  void setPosition(
    position$_.Position? position,
  ) {
    final _$position = position?.reference ?? jni$_.jNullReference;
    _setPosition(reference.pointer, _id_setPosition as jni$_.JMethodIDPtr,
            _$position.pointer)
        .check();
  }

  static final _id_getPosition = _class.instanceMethodId(
    r'getPosition',
    r'()Lorg/maplibre/android/style/light/Position;',
  );

  static final _getPosition = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.light.Position getPosition()`
  /// The returned object must be released after use, by calling the [release] method.
  position$_.Position? getPosition() {
    return _getPosition(
            reference.pointer, _id_getPosition as jni$_.JMethodIDPtr)
        .object<position$_.Position?>(
            const position$_.$Position$NullableType());
  }

  static final _id_getPositionTransition = _class.instanceMethodId(
    r'getPositionTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getPositionTransition = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getPositionTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions$_.TransitionOptions? getPositionTransition() {
    return _getPositionTransition(
            reference.pointer, _id_getPositionTransition as jni$_.JMethodIDPtr)
        .object<transitionoptions$_.TransitionOptions?>(
            const transitionoptions$_.$TransitionOptions$NullableType());
  }

  static final _id_setPositionTransition = _class.instanceMethodId(
    r'setPositionTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setPositionTransition = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void setPositionTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setPositionTransition(
    transitionoptions$_.TransitionOptions? transitionOptions,
  ) {
    final _$transitionOptions =
        transitionOptions?.reference ?? jni$_.jNullReference;
    _setPositionTransition(
            reference.pointer,
            _id_setPositionTransition as jni$_.JMethodIDPtr,
            _$transitionOptions.pointer)
        .check();
  }

  static final _id_setColor = _class.instanceMethodId(
    r'setColor',
    r'(I)V',
  );

  static final _setColor = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<(jni$_.Int32,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, int)>();

  /// from: `public void setColor(int i)`
  void setColor(
    int i,
  ) {
    _setColor(reference.pointer, _id_setColor as jni$_.JMethodIDPtr, i).check();
  }

  static final _id_setColor$1 = _class.instanceMethodId(
    r'setColor',
    r'(Ljava/lang/String;)V',
  );

  static final _setColor$1 = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void setColor(java.lang.String string)`
  void setColor$1(
    jni$_.JString? string,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    _setColor$1(reference.pointer, _id_setColor$1 as jni$_.JMethodIDPtr,
            _$string.pointer)
        .check();
  }

  static final _id_getColor = _class.instanceMethodId(
    r'getColor',
    r'()Ljava/lang/String;',
  );

  static final _getColor = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getColor()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getColor() {
    return _getColor(reference.pointer, _id_getColor as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getColorTransition = _class.instanceMethodId(
    r'getColorTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getColorTransition = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getColorTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions$_.TransitionOptions? getColorTransition() {
    return _getColorTransition(
            reference.pointer, _id_getColorTransition as jni$_.JMethodIDPtr)
        .object<transitionoptions$_.TransitionOptions?>(
            const transitionoptions$_.$TransitionOptions$NullableType());
  }

  static final _id_setColorTransition = _class.instanceMethodId(
    r'setColorTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setColorTransition = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void setColorTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setColorTransition(
    transitionoptions$_.TransitionOptions? transitionOptions,
  ) {
    final _$transitionOptions =
        transitionOptions?.reference ?? jni$_.jNullReference;
    _setColorTransition(
            reference.pointer,
            _id_setColorTransition as jni$_.JMethodIDPtr,
            _$transitionOptions.pointer)
        .check();
  }

  static final _id_setIntensity = _class.instanceMethodId(
    r'setIntensity',
    r'(F)V',
  );

  static final _setIntensity = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<(jni$_.Double,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, double)>();

  /// from: `public void setIntensity(float f)`
  void setIntensity(
    double f,
  ) {
    _setIntensity(reference.pointer, _id_setIntensity as jni$_.JMethodIDPtr, f)
        .check();
  }

  static final _id_getIntensity = _class.instanceMethodId(
    r'getIntensity',
    r'()F',
  );

  static final _getIntensity = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public float getIntensity()`
  double getIntensity() {
    return _getIntensity(
            reference.pointer, _id_getIntensity as jni$_.JMethodIDPtr)
        .float;
  }

  static final _id_getIntensityTransition = _class.instanceMethodId(
    r'getIntensityTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getIntensityTransition = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getIntensityTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions$_.TransitionOptions? getIntensityTransition() {
    return _getIntensityTransition(
            reference.pointer, _id_getIntensityTransition as jni$_.JMethodIDPtr)
        .object<transitionoptions$_.TransitionOptions?>(
            const transitionoptions$_.$TransitionOptions$NullableType());
  }

  static final _id_setIntensityTransition = _class.instanceMethodId(
    r'setIntensityTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setIntensityTransition = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void setIntensityTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setIntensityTransition(
    transitionoptions$_.TransitionOptions? transitionOptions,
  ) {
    final _$transitionOptions =
        transitionOptions?.reference ?? jni$_.jNullReference;
    _setIntensityTransition(
            reference.pointer,
            _id_setIntensityTransition as jni$_.JMethodIDPtr,
            _$transitionOptions.pointer)
        .check();
  }
}

final class $Light$NullableType extends jni$_.JObjType<Light?> {
  @jni$_.internal
  const $Light$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/style/light/Light;';

  @jni$_.internal
  @core$_.override
  Light? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : Light.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Light?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Light$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Light$NullableType) &&
        other is $Light$NullableType;
  }
}

final class $Light$Type extends jni$_.JObjType<Light> {
  @jni$_.internal
  const $Light$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/style/light/Light;';

  @jni$_.internal
  @core$_.override
  Light fromReference(jni$_.JReference reference) => Light.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Light?> get nullableType => const $Light$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Light$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Light$Type) && other is $Light$Type;
  }
}