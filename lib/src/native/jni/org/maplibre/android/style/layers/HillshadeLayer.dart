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

import 'Layer.dart' as layer_;

import 'PropertyValue.dart' as propertyvalue_;

import 'TransitionOptions.dart' as transitionoptions_;

/// from: `org.maplibre.android.style.layers.HillshadeLayer`
class HillshadeLayer extends layer_.Layer {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<HillshadeLayer> $type;

  @_$jni.internal
  HillshadeLayer.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      _$jni.JClass.forName(r'org/maplibre/android/style/layers/HillshadeLayer');

  /// The type which includes information such as the signature of this class.
  static const type = $HillshadeLayer$Type();
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
  factory HillshadeLayer(
    _$jni.JString string,
    _$jni.JString string1,
  ) {
    return HillshadeLayer.fromReference(_new$(
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
    r'(Ljava/lang/String;)Lorg/maplibre/android/style/layers/HillshadeLayer;',
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

  /// from: `public org.maplibre.android.style.layers.HillshadeLayer withSourceLayer(java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  HillshadeLayer withSourceLayer(
    _$jni.JString string,
  ) {
    return _withSourceLayer(reference.pointer,
            _id_withSourceLayer as _$jni.JMethodIDPtr, string.reference.pointer)
        .object(const $HillshadeLayer$Type());
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

  static final _id_withProperties = _class.instanceMethodId(
    r'withProperties',
    r'([Lorg/maplibre/android/style/layers/PropertyValue;)Lorg/maplibre/android/style/layers/HillshadeLayer;',
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

  /// from: `public org.maplibre.android.style.layers.HillshadeLayer withProperties(java.lang.Object[] propertyValues)`
  /// The returned object must be released after use, by calling the [release] method.
  HillshadeLayer withProperties(
    _$jni.JArray<propertyvalue_.PropertyValue<_$jni.JObject>> propertyValues,
  ) {
    return _withProperties(
            reference.pointer,
            _id_withProperties as _$jni.JMethodIDPtr,
            propertyValues.reference.pointer)
        .object(const $HillshadeLayer$Type());
  }

  static final _id_getHillshadeIlluminationDirection = _class.instanceMethodId(
    r'getHillshadeIlluminationDirection',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHillshadeIlluminationDirection =
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHillshadeIlluminationDirection()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JFloat>
      getHillshadeIlluminationDirection() {
    return _getHillshadeIlluminationDirection(reference.pointer,
            _id_getHillshadeIlluminationDirection as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(_$jni.JFloatType()));
  }

  static final _id_getHillshadeIlluminationAnchor = _class.instanceMethodId(
    r'getHillshadeIlluminationAnchor',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHillshadeIlluminationAnchor =
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHillshadeIlluminationAnchor()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JString> getHillshadeIlluminationAnchor() {
    return _getHillshadeIlluminationAnchor(reference.pointer,
            _id_getHillshadeIlluminationAnchor as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(_$jni.JStringType()));
  }

  static final _id_getHillshadeExaggeration = _class.instanceMethodId(
    r'getHillshadeExaggeration',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHillshadeExaggeration = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHillshadeExaggeration()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JFloat> getHillshadeExaggeration() {
    return _getHillshadeExaggeration(reference.pointer,
            _id_getHillshadeExaggeration as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(_$jni.JFloatType()));
  }

  static final _id_getHillshadeExaggerationTransition = _class.instanceMethodId(
    r'getHillshadeExaggerationTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getHillshadeExaggerationTransition =
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getHillshadeExaggerationTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions_.TransitionOptions getHillshadeExaggerationTransition() {
    return _getHillshadeExaggerationTransition(reference.pointer,
            _id_getHillshadeExaggerationTransition as _$jni.JMethodIDPtr)
        .object(const transitionoptions_.$TransitionOptions$Type());
  }

  static final _id_setHillshadeExaggerationTransition = _class.instanceMethodId(
    r'setHillshadeExaggerationTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setHillshadeExaggerationTransition =
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

  /// from: `public void setHillshadeExaggerationTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setHillshadeExaggerationTransition(
    transitionoptions_.TransitionOptions transitionOptions,
  ) {
    _setHillshadeExaggerationTransition(
            reference.pointer,
            _id_setHillshadeExaggerationTransition as _$jni.JMethodIDPtr,
            transitionOptions.reference.pointer)
        .check();
  }

  static final _id_getHillshadeShadowColor = _class.instanceMethodId(
    r'getHillshadeShadowColor',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHillshadeShadowColor = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHillshadeShadowColor()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JString> getHillshadeShadowColor() {
    return _getHillshadeShadowColor(reference.pointer,
            _id_getHillshadeShadowColor as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(_$jni.JStringType()));
  }

  static final _id_getHillshadeShadowColorAsInt = _class.instanceMethodId(
    r'getHillshadeShadowColorAsInt',
    r'()I',
  );

  static final _getHillshadeShadowColorAsInt =
      _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public int getHillshadeShadowColorAsInt()`
  int getHillshadeShadowColorAsInt() {
    return _getHillshadeShadowColorAsInt(reference.pointer,
            _id_getHillshadeShadowColorAsInt as _$jni.JMethodIDPtr)
        .integer;
  }

  static final _id_getHillshadeShadowColorTransition = _class.instanceMethodId(
    r'getHillshadeShadowColorTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getHillshadeShadowColorTransition =
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getHillshadeShadowColorTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions_.TransitionOptions getHillshadeShadowColorTransition() {
    return _getHillshadeShadowColorTransition(reference.pointer,
            _id_getHillshadeShadowColorTransition as _$jni.JMethodIDPtr)
        .object(const transitionoptions_.$TransitionOptions$Type());
  }

  static final _id_setHillshadeShadowColorTransition = _class.instanceMethodId(
    r'setHillshadeShadowColorTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setHillshadeShadowColorTransition =
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

  /// from: `public void setHillshadeShadowColorTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setHillshadeShadowColorTransition(
    transitionoptions_.TransitionOptions transitionOptions,
  ) {
    _setHillshadeShadowColorTransition(
            reference.pointer,
            _id_setHillshadeShadowColorTransition as _$jni.JMethodIDPtr,
            transitionOptions.reference.pointer)
        .check();
  }

  static final _id_getHillshadeHighlightColor = _class.instanceMethodId(
    r'getHillshadeHighlightColor',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHillshadeHighlightColor =
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHillshadeHighlightColor()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JString> getHillshadeHighlightColor() {
    return _getHillshadeHighlightColor(reference.pointer,
            _id_getHillshadeHighlightColor as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(_$jni.JStringType()));
  }

  static final _id_getHillshadeHighlightColorAsInt = _class.instanceMethodId(
    r'getHillshadeHighlightColorAsInt',
    r'()I',
  );

  static final _getHillshadeHighlightColorAsInt =
      _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public int getHillshadeHighlightColorAsInt()`
  int getHillshadeHighlightColorAsInt() {
    return _getHillshadeHighlightColorAsInt(reference.pointer,
            _id_getHillshadeHighlightColorAsInt as _$jni.JMethodIDPtr)
        .integer;
  }

  static final _id_getHillshadeHighlightColorTransition =
      _class.instanceMethodId(
    r'getHillshadeHighlightColorTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getHillshadeHighlightColorTransition =
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getHillshadeHighlightColorTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions_.TransitionOptions getHillshadeHighlightColorTransition() {
    return _getHillshadeHighlightColorTransition(reference.pointer,
            _id_getHillshadeHighlightColorTransition as _$jni.JMethodIDPtr)
        .object(const transitionoptions_.$TransitionOptions$Type());
  }

  static final _id_setHillshadeHighlightColorTransition =
      _class.instanceMethodId(
    r'setHillshadeHighlightColorTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setHillshadeHighlightColorTransition =
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

  /// from: `public void setHillshadeHighlightColorTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setHillshadeHighlightColorTransition(
    transitionoptions_.TransitionOptions transitionOptions,
  ) {
    _setHillshadeHighlightColorTransition(
            reference.pointer,
            _id_setHillshadeHighlightColorTransition as _$jni.JMethodIDPtr,
            transitionOptions.reference.pointer)
        .check();
  }

  static final _id_getHillshadeAccentColor = _class.instanceMethodId(
    r'getHillshadeAccentColor',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHillshadeAccentColor = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHillshadeAccentColor()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JString> getHillshadeAccentColor() {
    return _getHillshadeAccentColor(reference.pointer,
            _id_getHillshadeAccentColor as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(_$jni.JStringType()));
  }

  static final _id_getHillshadeAccentColorAsInt = _class.instanceMethodId(
    r'getHillshadeAccentColorAsInt',
    r'()I',
  );

  static final _getHillshadeAccentColorAsInt =
      _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public int getHillshadeAccentColorAsInt()`
  int getHillshadeAccentColorAsInt() {
    return _getHillshadeAccentColorAsInt(reference.pointer,
            _id_getHillshadeAccentColorAsInt as _$jni.JMethodIDPtr)
        .integer;
  }

  static final _id_getHillshadeAccentColorTransition = _class.instanceMethodId(
    r'getHillshadeAccentColorTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getHillshadeAccentColorTransition =
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getHillshadeAccentColorTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions_.TransitionOptions getHillshadeAccentColorTransition() {
    return _getHillshadeAccentColorTransition(reference.pointer,
            _id_getHillshadeAccentColorTransition as _$jni.JMethodIDPtr)
        .object(const transitionoptions_.$TransitionOptions$Type());
  }

  static final _id_setHillshadeAccentColorTransition = _class.instanceMethodId(
    r'setHillshadeAccentColorTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setHillshadeAccentColorTransition =
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

  /// from: `public void setHillshadeAccentColorTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setHillshadeAccentColorTransition(
    transitionoptions_.TransitionOptions transitionOptions,
  ) {
    _setHillshadeAccentColorTransition(
            reference.pointer,
            _id_setHillshadeAccentColorTransition as _$jni.JMethodIDPtr,
            transitionOptions.reference.pointer)
        .check();
  }
}

final class $HillshadeLayer$Type extends _$jni.JObjType<HillshadeLayer> {
  @_$jni.internal
  const $HillshadeLayer$Type();

  @_$jni.internal
  @_$core.override
  String get signature => r'Lorg/maplibre/android/style/layers/HillshadeLayer;';

  @_$jni.internal
  @_$core.override
  HillshadeLayer fromReference(_$jni.JReference reference) =>
      HillshadeLayer.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const layer_.$Layer$Type();

  @_$jni.internal
  @_$core.override
  final superCount = 2;

  @_$core.override
  int get hashCode => ($HillshadeLayer$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($HillshadeLayer$Type) &&
        other is $HillshadeLayer$Type;
  }
}
