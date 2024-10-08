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

import 'Layer.dart' as layer_;

import 'PropertyValue.dart' as propertyvalue_;

import 'TransitionOptions.dart' as transitionoptions_;

/// from: `org.maplibre.android.style.layers.HeatmapLayer`
class HeatmapLayer extends layer_.Layer {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<HeatmapLayer> $type;

  @_$jni.internal
  HeatmapLayer.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      _$jni.JClass.forName(r'org/maplibre/android/style/layers/HeatmapLayer');

  /// The type which includes information such as the signature of this class.
  static const type = $HeatmapLayer$Type();
  static final _id_new$ = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _new$ = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void <init>(java.lang.String string, java.lang.String string1)`
  /// The returned object must be released after use, by calling the [release] method.
  factory HeatmapLayer(
    _$jni.JString string,
    _$jni.JString string1,
  ) {
    return HeatmapLayer.fromReference(_new$(
            _class.reference.pointer,
            _id_new$ as _$jni.JMethodIDPtr,
            string.reference.pointer,
            string1.reference.pointer)
        .reference);
  }

  static final _id_setSourceLayer = _class.instanceMethodId(
    r'setSourceLayer',
    r'(Ljava/lang/String;)V',
  );

  static final _setSourceLayer = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void setSourceLayer(java.lang.String string)`
  void setSourceLayer(
    _$jni.JString string,
  ) {
    _setSourceLayer(reference.pointer, _id_setSourceLayer as _$jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_withSourceLayer = _class.instanceMethodId(
    r'withSourceLayer',
    r'(Ljava/lang/String;)Lorg/maplibre/android/style/layers/HeatmapLayer;',
  );

  static final _withSourceLayer = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public org.maplibre.android.style.layers.HeatmapLayer withSourceLayer(java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  HeatmapLayer withSourceLayer(
    _$jni.JString string,
  ) {
    return _withSourceLayer(reference.pointer,
            _id_withSourceLayer as _$jni.JMethodIDPtr, string.reference.pointer)
        .object(const $HeatmapLayer$Type());
  }

  static final _id_getSourceId = _class.instanceMethodId(
    r'getSourceId',
    r'()Ljava/lang/String;',
  );

  static final _getSourceId = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getSourceId()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JString getSourceId() {
    return _getSourceId(
            reference.pointer, _id_getSourceId as _$jni.JMethodIDPtr)
        .object(const _$jni.JStringType());
  }

  static final _id_getSourceLayer = _class.instanceMethodId(
    r'getSourceLayer',
    r'()Ljava/lang/String;',
  );

  static final _getSourceLayer = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getSourceLayer()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JString getSourceLayer() {
    return _getSourceLayer(
            reference.pointer, _id_getSourceLayer as _$jni.JMethodIDPtr)
        .object(const _$jni.JStringType());
  }

  static final _id_setFilter = _class.instanceMethodId(
    r'setFilter',
    r'(Lorg/maplibre/android/style/expressions/Expression;)V',
  );

  static final _setFilter = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void setFilter(org.maplibre.android.style.expressions.Expression expression)`
  void setFilter(
    _$jni.JObject expression,
  ) {
    _setFilter(reference.pointer, _id_setFilter as _$jni.JMethodIDPtr,
            expression.reference.pointer)
        .check();
  }

  static final _id_withFilter = _class.instanceMethodId(
    r'withFilter',
    r'(Lorg/maplibre/android/style/expressions/Expression;)Lorg/maplibre/android/style/layers/HeatmapLayer;',
  );

  static final _withFilter = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public org.maplibre.android.style.layers.HeatmapLayer withFilter(org.maplibre.android.style.expressions.Expression expression)`
  /// The returned object must be released after use, by calling the [release] method.
  HeatmapLayer withFilter(
    _$jni.JObject expression,
  ) {
    return _withFilter(reference.pointer, _id_withFilter as _$jni.JMethodIDPtr,
            expression.reference.pointer)
        .object(const $HeatmapLayer$Type());
  }

  static final _id_getFilter = _class.instanceMethodId(
    r'getFilter',
    r'()Lorg/maplibre/android/style/expressions/Expression;',
  );

  static final _getFilter = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.expressions.Expression getFilter()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JObject getFilter() {
    return _getFilter(reference.pointer, _id_getFilter as _$jni.JMethodIDPtr)
        .object(const _$jni.JObjectType());
  }

  static final _id_withProperties = _class.instanceMethodId(
    r'withProperties',
    r'([Lorg/maplibre/android/style/layers/PropertyValue;)Lorg/maplibre/android/style/layers/HeatmapLayer;',
  );

  static final _withProperties = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public org.maplibre.android.style.layers.HeatmapLayer withProperties(java.lang.Object[] propertyValues)`
  /// The returned object must be released after use, by calling the [release] method.
  HeatmapLayer withProperties(
    _$jni.JArray<propertyvalue_.PropertyValue<_$jni.JObject>> propertyValues,
  ) {
    return _withProperties(
            reference.pointer,
            _id_withProperties as _$jni.JMethodIDPtr,
            propertyValues.reference.pointer)
        .object(const $HeatmapLayer$Type());
  }

  static final _id_getHeatmapRadius = _class.instanceMethodId(
    r'getHeatmapRadius',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHeatmapRadius = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHeatmapRadius()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JFloat> getHeatmapRadius() {
    return _getHeatmapRadius(
            reference.pointer, _id_getHeatmapRadius as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(_$jni.JFloatType()));
  }

  static final _id_getHeatmapRadiusTransition = _class.instanceMethodId(
    r'getHeatmapRadiusTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getHeatmapRadiusTransition =
      _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getHeatmapRadiusTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions_.TransitionOptions getHeatmapRadiusTransition() {
    return _getHeatmapRadiusTransition(reference.pointer,
            _id_getHeatmapRadiusTransition as _$jni.JMethodIDPtr)
        .object(const transitionoptions_.$TransitionOptions$Type());
  }

  static final _id_setHeatmapRadiusTransition = _class.instanceMethodId(
    r'setHeatmapRadiusTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setHeatmapRadiusTransition =
      _$jni.ProtectedJniExtensions.lookup<
                  _$jni.NativeFunction<
                      _$jni.JThrowablePtr Function(
                          _$jni.Pointer<_$jni.Void>,
                          _$jni.JMethodIDPtr,
                          _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
              'globalEnv_CallVoidMethod')
          .asFunction<
              _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void setHeatmapRadiusTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setHeatmapRadiusTransition(
    transitionoptions_.TransitionOptions transitionOptions,
  ) {
    _setHeatmapRadiusTransition(
            reference.pointer,
            _id_setHeatmapRadiusTransition as _$jni.JMethodIDPtr,
            transitionOptions.reference.pointer)
        .check();
  }

  static final _id_getHeatmapWeight = _class.instanceMethodId(
    r'getHeatmapWeight',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHeatmapWeight = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHeatmapWeight()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JFloat> getHeatmapWeight() {
    return _getHeatmapWeight(
            reference.pointer, _id_getHeatmapWeight as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(_$jni.JFloatType()));
  }

  static final _id_getHeatmapIntensity = _class.instanceMethodId(
    r'getHeatmapIntensity',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHeatmapIntensity = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHeatmapIntensity()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JFloat> getHeatmapIntensity() {
    return _getHeatmapIntensity(
            reference.pointer, _id_getHeatmapIntensity as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(_$jni.JFloatType()));
  }

  static final _id_getHeatmapIntensityTransition = _class.instanceMethodId(
    r'getHeatmapIntensityTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getHeatmapIntensityTransition =
      _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getHeatmapIntensityTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions_.TransitionOptions getHeatmapIntensityTransition() {
    return _getHeatmapIntensityTransition(reference.pointer,
            _id_getHeatmapIntensityTransition as _$jni.JMethodIDPtr)
        .object(const transitionoptions_.$TransitionOptions$Type());
  }

  static final _id_setHeatmapIntensityTransition = _class.instanceMethodId(
    r'setHeatmapIntensityTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setHeatmapIntensityTransition =
      _$jni.ProtectedJniExtensions.lookup<
                  _$jni.NativeFunction<
                      _$jni.JThrowablePtr Function(
                          _$jni.Pointer<_$jni.Void>,
                          _$jni.JMethodIDPtr,
                          _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
              'globalEnv_CallVoidMethod')
          .asFunction<
              _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void setHeatmapIntensityTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setHeatmapIntensityTransition(
    transitionoptions_.TransitionOptions transitionOptions,
  ) {
    _setHeatmapIntensityTransition(
            reference.pointer,
            _id_setHeatmapIntensityTransition as _$jni.JMethodIDPtr,
            transitionOptions.reference.pointer)
        .check();
  }

  static final _id_getHeatmapColor = _class.instanceMethodId(
    r'getHeatmapColor',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHeatmapColor = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHeatmapColor()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JString> getHeatmapColor() {
    return _getHeatmapColor(
            reference.pointer, _id_getHeatmapColor as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(_$jni.JStringType()));
  }

  static final _id_getHeatmapColorAsInt = _class.instanceMethodId(
    r'getHeatmapColorAsInt',
    r'()I',
  );

  static final _getHeatmapColorAsInt = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallIntMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public int getHeatmapColorAsInt()`
  int getHeatmapColorAsInt() {
    return _getHeatmapColorAsInt(
            reference.pointer, _id_getHeatmapColorAsInt as _$jni.JMethodIDPtr)
        .integer;
  }

  static final _id_getHeatmapOpacity = _class.instanceMethodId(
    r'getHeatmapOpacity',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHeatmapOpacity = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHeatmapOpacity()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JFloat> getHeatmapOpacity() {
    return _getHeatmapOpacity(
            reference.pointer, _id_getHeatmapOpacity as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(_$jni.JFloatType()));
  }

  static final _id_getHeatmapOpacityTransition = _class.instanceMethodId(
    r'getHeatmapOpacityTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getHeatmapOpacityTransition =
      _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getHeatmapOpacityTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions_.TransitionOptions getHeatmapOpacityTransition() {
    return _getHeatmapOpacityTransition(reference.pointer,
            _id_getHeatmapOpacityTransition as _$jni.JMethodIDPtr)
        .object(const transitionoptions_.$TransitionOptions$Type());
  }

  static final _id_setHeatmapOpacityTransition = _class.instanceMethodId(
    r'setHeatmapOpacityTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setHeatmapOpacityTransition =
      _$jni.ProtectedJniExtensions.lookup<
                  _$jni.NativeFunction<
                      _$jni.JThrowablePtr Function(
                          _$jni.Pointer<_$jni.Void>,
                          _$jni.JMethodIDPtr,
                          _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
              'globalEnv_CallVoidMethod')
          .asFunction<
              _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void setHeatmapOpacityTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setHeatmapOpacityTransition(
    transitionoptions_.TransitionOptions transitionOptions,
  ) {
    _setHeatmapOpacityTransition(
            reference.pointer,
            _id_setHeatmapOpacityTransition as _$jni.JMethodIDPtr,
            transitionOptions.reference.pointer)
        .check();
  }
}

final class $HeatmapLayer$Type extends _$jni.JObjType<HeatmapLayer> {
  @_$jni.internal
  const $HeatmapLayer$Type();

  @_$jni.internal
  @_$core.override
  String get signature => r'Lorg/maplibre/android/style/layers/HeatmapLayer;';

  @_$jni.internal
  @_$core.override
  HeatmapLayer fromReference(_$jni.JReference reference) =>
      HeatmapLayer.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const layer_.$Layer$Type();

  @_$jni.internal
  @_$core.override
  final superCount = 2;

  @_$core.override
  int get hashCode => ($HeatmapLayer$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($HeatmapLayer$Type) &&
        other is $HeatmapLayer$Type;
  }
}
