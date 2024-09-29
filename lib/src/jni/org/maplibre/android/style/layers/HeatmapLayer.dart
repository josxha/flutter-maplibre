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

import 'Layer.dart' as layer_;

import 'PropertyValue.dart' as propertyvalue_;

import 'TransitionOptions.dart' as transitionoptions_;

/// from: `org.maplibre.android.style.layers.HeatmapLayer`
class HeatmapLayer extends layer_.Layer {
  @override
  late final jni.JObjType<HeatmapLayer> $type = type;

  HeatmapLayer.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/style/layers/HeatmapLayer');

  /// The type which includes information such as the signature of this class.
  static const type = $HeatmapLayerType();
  static final _id_new2 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _new2 = ProtectedJniExtensions.lookup<
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

  /// from: `public void <init>(java.lang.String string, java.lang.String string1)`
  /// The returned object must be released after use, by calling the [release] method.
  factory HeatmapLayer.new2(
    jni.JString string,
    jni.JString string1,
  ) {
    return HeatmapLayer.fromReference(_new2(
            _class.reference.pointer,
            _id_new2 as jni.JMethodIDPtr,
            string.reference.pointer,
            string1.reference.pointer)
        .reference);
  }

  static final _id_initialize = _class.instanceMethodId(
    r'initialize',
    r'(Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _initialize = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `protected native void initialize(java.lang.String string, java.lang.String string1)`
  void initialize(
    jni.JString string,
    jni.JString string1,
  ) {
    _initialize(reference.pointer, _id_initialize as jni.JMethodIDPtr,
            string.reference.pointer, string1.reference.pointer)
        .check();
  }

  static final _id_setSourceLayer = _class.instanceMethodId(
    r'setSourceLayer',
    r'(Ljava/lang/String;)V',
  );

  static final _setSourceLayer = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void setSourceLayer(java.lang.String string)`
  void setSourceLayer(
    jni.JString string,
  ) {
    _setSourceLayer(reference.pointer, _id_setSourceLayer as jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_withSourceLayer = _class.instanceMethodId(
    r'withSourceLayer',
    r'(Ljava/lang/String;)Lorg/maplibre/android/style/layers/HeatmapLayer;',
  );

  static final _withSourceLayer = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public org.maplibre.android.style.layers.HeatmapLayer withSourceLayer(java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  HeatmapLayer withSourceLayer(
    jni.JString string,
  ) {
    return _withSourceLayer(reference.pointer,
            _id_withSourceLayer as jni.JMethodIDPtr, string.reference.pointer)
        .object(const $HeatmapLayerType());
  }

  static final _id_getSourceId = _class.instanceMethodId(
    r'getSourceId',
    r'()Ljava/lang/String;',
  );

  static final _getSourceId = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public java.lang.String getSourceId()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString getSourceId() {
    return _getSourceId(reference.pointer, _id_getSourceId as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_getSourceLayer = _class.instanceMethodId(
    r'getSourceLayer',
    r'()Ljava/lang/String;',
  );

  static final _getSourceLayer = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public java.lang.String getSourceLayer()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString getSourceLayer() {
    return _getSourceLayer(
            reference.pointer, _id_getSourceLayer as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_setFilter = _class.instanceMethodId(
    r'setFilter',
    r'(Lorg/maplibre/android/style/expressions/Expression;)V',
  );

  static final _setFilter = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void setFilter(org.maplibre.android.style.expressions.Expression expression)`
  void setFilter(
    jni.JObject expression,
  ) {
    _setFilter(reference.pointer, _id_setFilter as jni.JMethodIDPtr,
            expression.reference.pointer)
        .check();
  }

  static final _id_withFilter = _class.instanceMethodId(
    r'withFilter',
    r'(Lorg/maplibre/android/style/expressions/Expression;)Lorg/maplibre/android/style/layers/HeatmapLayer;',
  );

  static final _withFilter = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public org.maplibre.android.style.layers.HeatmapLayer withFilter(org.maplibre.android.style.expressions.Expression expression)`
  /// The returned object must be released after use, by calling the [release] method.
  HeatmapLayer withFilter(
    jni.JObject expression,
  ) {
    return _withFilter(reference.pointer, _id_withFilter as jni.JMethodIDPtr,
            expression.reference.pointer)
        .object(const $HeatmapLayerType());
  }

  static final _id_getFilter = _class.instanceMethodId(
    r'getFilter',
    r'()Lorg/maplibre/android/style/expressions/Expression;',
  );

  static final _getFilter = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public org.maplibre.android.style.expressions.Expression getFilter()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject getFilter() {
    return _getFilter(reference.pointer, _id_getFilter as jni.JMethodIDPtr)
        .object(const jni.JObjectType());
  }

  static final _id_withProperties = _class.instanceMethodId(
    r'withProperties',
    r'([Lorg/maplibre/android/style/layers/PropertyValue;)Lorg/maplibre/android/style/layers/HeatmapLayer;',
  );

  static final _withProperties = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public org.maplibre.android.style.layers.HeatmapLayer withProperties(java.lang.Object[] propertyValues)`
  /// The returned object must be released after use, by calling the [release] method.
  HeatmapLayer withProperties(
    jni.JArray<propertyvalue_.PropertyValue<jni.JObject>> propertyValues,
  ) {
    return _withProperties(
            reference.pointer,
            _id_withProperties as jni.JMethodIDPtr,
            propertyValues.reference.pointer)
        .object(const $HeatmapLayerType());
  }

  static final _id_getHeatmapRadius = _class.instanceMethodId(
    r'getHeatmapRadius',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHeatmapRadius = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHeatmapRadius()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<jni.JFloat> getHeatmapRadius() {
    return _getHeatmapRadius(
            reference.pointer, _id_getHeatmapRadius as jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValueType(jni.JFloatType()));
  }

  static final _id_getHeatmapRadiusTransition = _class.instanceMethodId(
    r'getHeatmapRadiusTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getHeatmapRadiusTransition = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getHeatmapRadiusTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions_.TransitionOptions getHeatmapRadiusTransition() {
    return _getHeatmapRadiusTransition(reference.pointer,
            _id_getHeatmapRadiusTransition as jni.JMethodIDPtr)
        .object(const transitionoptions_.$TransitionOptionsType());
  }

  static final _id_setHeatmapRadiusTransition = _class.instanceMethodId(
    r'setHeatmapRadiusTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setHeatmapRadiusTransition = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void setHeatmapRadiusTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setHeatmapRadiusTransition(
    transitionoptions_.TransitionOptions transitionOptions,
  ) {
    _setHeatmapRadiusTransition(
            reference.pointer,
            _id_setHeatmapRadiusTransition as jni.JMethodIDPtr,
            transitionOptions.reference.pointer)
        .check();
  }

  static final _id_getHeatmapWeight = _class.instanceMethodId(
    r'getHeatmapWeight',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHeatmapWeight = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHeatmapWeight()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<jni.JFloat> getHeatmapWeight() {
    return _getHeatmapWeight(
            reference.pointer, _id_getHeatmapWeight as jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValueType(jni.JFloatType()));
  }

  static final _id_getHeatmapIntensity = _class.instanceMethodId(
    r'getHeatmapIntensity',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHeatmapIntensity = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHeatmapIntensity()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<jni.JFloat> getHeatmapIntensity() {
    return _getHeatmapIntensity(
            reference.pointer, _id_getHeatmapIntensity as jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValueType(jni.JFloatType()));
  }

  static final _id_getHeatmapIntensityTransition = _class.instanceMethodId(
    r'getHeatmapIntensityTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getHeatmapIntensityTransition = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getHeatmapIntensityTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions_.TransitionOptions getHeatmapIntensityTransition() {
    return _getHeatmapIntensityTransition(reference.pointer,
            _id_getHeatmapIntensityTransition as jni.JMethodIDPtr)
        .object(const transitionoptions_.$TransitionOptionsType());
  }

  static final _id_setHeatmapIntensityTransition = _class.instanceMethodId(
    r'setHeatmapIntensityTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setHeatmapIntensityTransition = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void setHeatmapIntensityTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setHeatmapIntensityTransition(
    transitionoptions_.TransitionOptions transitionOptions,
  ) {
    _setHeatmapIntensityTransition(
            reference.pointer,
            _id_setHeatmapIntensityTransition as jni.JMethodIDPtr,
            transitionOptions.reference.pointer)
        .check();
  }

  static final _id_getHeatmapColor = _class.instanceMethodId(
    r'getHeatmapColor',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHeatmapColor = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHeatmapColor()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<jni.JString> getHeatmapColor() {
    return _getHeatmapColor(
            reference.pointer, _id_getHeatmapColor as jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValueType(jni.JStringType()));
  }

  static final _id_getHeatmapColorAsInt = _class.instanceMethodId(
    r'getHeatmapColorAsInt',
    r'()I',
  );

  static final _getHeatmapColorAsInt = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallIntMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public int getHeatmapColorAsInt()`
  int getHeatmapColorAsInt() {
    return _getHeatmapColorAsInt(
            reference.pointer, _id_getHeatmapColorAsInt as jni.JMethodIDPtr)
        .integer;
  }

  static final _id_getHeatmapOpacity = _class.instanceMethodId(
    r'getHeatmapOpacity',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHeatmapOpacity = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHeatmapOpacity()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<jni.JFloat> getHeatmapOpacity() {
    return _getHeatmapOpacity(
            reference.pointer, _id_getHeatmapOpacity as jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValueType(jni.JFloatType()));
  }

  static final _id_getHeatmapOpacityTransition = _class.instanceMethodId(
    r'getHeatmapOpacityTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getHeatmapOpacityTransition = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getHeatmapOpacityTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions_.TransitionOptions getHeatmapOpacityTransition() {
    return _getHeatmapOpacityTransition(reference.pointer,
            _id_getHeatmapOpacityTransition as jni.JMethodIDPtr)
        .object(const transitionoptions_.$TransitionOptionsType());
  }

  static final _id_setHeatmapOpacityTransition = _class.instanceMethodId(
    r'setHeatmapOpacityTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setHeatmapOpacityTransition = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void setHeatmapOpacityTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setHeatmapOpacityTransition(
    transitionoptions_.TransitionOptions transitionOptions,
  ) {
    _setHeatmapOpacityTransition(
            reference.pointer,
            _id_setHeatmapOpacityTransition as jni.JMethodIDPtr,
            transitionOptions.reference.pointer)
        .check();
  }

  static final _id_finalize = _class.instanceMethodId(
    r'finalize',
    r'()V',
  );

  static final _finalize = ProtectedJniExtensions.lookup<
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

  /// from: `protected native void finalize()`
  void finalize() {
    _finalize(reference.pointer, _id_finalize as jni.JMethodIDPtr).check();
  }
}

final class $HeatmapLayerType extends jni.JObjType<HeatmapLayer> {
  const $HeatmapLayerType();

  @override
  String get signature => r'Lorg/maplibre/android/style/layers/HeatmapLayer;';

  @override
  HeatmapLayer fromReference(jni.JReference reference) =>
      HeatmapLayer.fromReference(reference);

  @override
  jni.JObjType get superType => const layer_.$LayerType();

  @override
  final superCount = 2;

  @override
  int get hashCode => ($HeatmapLayerType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($HeatmapLayerType) &&
        other is $HeatmapLayerType;
  }
}
