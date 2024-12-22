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

import 'Layer.dart' as layer$_;

import 'PropertyValue.dart' as propertyvalue$_;

import 'TransitionOptions.dart' as transitionoptions$_;

/// from: `org.maplibre.android.style.layers.HillshadeLayer`
class HillshadeLayer extends layer$_.Layer {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<HillshadeLayer> $type;

  @jni$_.internal
  HillshadeLayer.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/style/layers/HillshadeLayer');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $HillshadeLayer$NullableType();
  static const type = $HillshadeLayer$Type();
  static final _id_new$ = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _new$ = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void <init>(java.lang.String string, java.lang.String string1)`
  /// The returned object must be released after use, by calling the [release] method.
  factory HillshadeLayer(
    jni$_.JString? string,
    jni$_.JString? string1,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    return HillshadeLayer.fromReference(_new$(_class.reference.pointer,
            _id_new$ as jni$_.JMethodIDPtr, _$string.pointer, _$string1.pointer)
        .reference);
  }

  static final _id_setSourceLayer = _class.instanceMethodId(
    r'setSourceLayer',
    r'(Ljava/lang/String;)V',
  );

  static final _setSourceLayer = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void setSourceLayer(java.lang.String string)`
  void setSourceLayer(
    jni$_.JString? string,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    _setSourceLayer(reference.pointer, _id_setSourceLayer as jni$_.JMethodIDPtr,
            _$string.pointer)
        .check();
  }

  static final _id_withSourceLayer = _class.instanceMethodId(
    r'withSourceLayer',
    r'(Ljava/lang/String;)Lorg/maplibre/android/style/layers/HillshadeLayer;',
  );

  static final _withSourceLayer = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public org.maplibre.android.style.layers.HillshadeLayer withSourceLayer(java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  HillshadeLayer? withSourceLayer(
    jni$_.JString? string,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    return _withSourceLayer(reference.pointer,
            _id_withSourceLayer as jni$_.JMethodIDPtr, _$string.pointer)
        .object<HillshadeLayer?>(const $HillshadeLayer$NullableType());
  }

  static final _id_getSourceId = _class.instanceMethodId(
    r'getSourceId',
    r'()Ljava/lang/String;',
  );

  static final _getSourceId = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getSourceId()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getSourceId() {
    return _getSourceId(
            reference.pointer, _id_getSourceId as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_withProperties = _class.instanceMethodId(
    r'withProperties',
    r'([Lorg/maplibre/android/style/layers/PropertyValue;)Lorg/maplibre/android/style/layers/HillshadeLayer;',
  );

  static final _withProperties = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public org.maplibre.android.style.layers.HillshadeLayer withProperties(java.lang.Object[] propertyValues)`
  /// The returned object must be released after use, by calling the [release] method.
  HillshadeLayer? withProperties(
    jni$_.JArray<propertyvalue$_.PropertyValue<jni$_.JObject?>?>?
        propertyValues,
  ) {
    final _$propertyValues = propertyValues?.reference ?? jni$_.jNullReference;
    return _withProperties(reference.pointer,
            _id_withProperties as jni$_.JMethodIDPtr, _$propertyValues.pointer)
        .object<HillshadeLayer?>(const $HillshadeLayer$NullableType());
  }

  static final _id_getHillshadeIlluminationDirection = _class.instanceMethodId(
    r'getHillshadeIlluminationDirection',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHillshadeIlluminationDirection =
      jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHillshadeIlluminationDirection()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue$_.PropertyValue<jni$_.JFloat?>?
      getHillshadeIlluminationDirection() {
    return _getHillshadeIlluminationDirection(reference.pointer,
            _id_getHillshadeIlluminationDirection as jni$_.JMethodIDPtr)
        .object<propertyvalue$_.PropertyValue<jni$_.JFloat?>?>(
            const propertyvalue$_.$PropertyValue$NullableType<jni$_.JFloat?>(
                jni$_.JFloatNullableType()));
  }

  static final _id_getHillshadeIlluminationAnchor = _class.instanceMethodId(
    r'getHillshadeIlluminationAnchor',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHillshadeIlluminationAnchor =
      jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHillshadeIlluminationAnchor()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue$_.PropertyValue<jni$_.JString?>?
      getHillshadeIlluminationAnchor() {
    return _getHillshadeIlluminationAnchor(reference.pointer,
            _id_getHillshadeIlluminationAnchor as jni$_.JMethodIDPtr)
        .object<propertyvalue$_.PropertyValue<jni$_.JString?>?>(
            const propertyvalue$_.$PropertyValue$NullableType<jni$_.JString?>(
                jni$_.JStringNullableType()));
  }

  static final _id_getHillshadeExaggeration = _class.instanceMethodId(
    r'getHillshadeExaggeration',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHillshadeExaggeration = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHillshadeExaggeration()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue$_.PropertyValue<jni$_.JFloat?>? getHillshadeExaggeration() {
    return _getHillshadeExaggeration(reference.pointer,
            _id_getHillshadeExaggeration as jni$_.JMethodIDPtr)
        .object<propertyvalue$_.PropertyValue<jni$_.JFloat?>?>(
            const propertyvalue$_.$PropertyValue$NullableType<jni$_.JFloat?>(
                jni$_.JFloatNullableType()));
  }

  static final _id_getHillshadeExaggerationTransition = _class.instanceMethodId(
    r'getHillshadeExaggerationTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getHillshadeExaggerationTransition =
      jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getHillshadeExaggerationTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions$_.TransitionOptions? getHillshadeExaggerationTransition() {
    return _getHillshadeExaggerationTransition(reference.pointer,
            _id_getHillshadeExaggerationTransition as jni$_.JMethodIDPtr)
        .object<transitionoptions$_.TransitionOptions?>(
            const transitionoptions$_.$TransitionOptions$NullableType());
  }

  static final _id_setHillshadeExaggerationTransition = _class.instanceMethodId(
    r'setHillshadeExaggerationTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setHillshadeExaggerationTransition =
      jni$_.ProtectedJniExtensions.lookup<
                  jni$_.NativeFunction<
                      jni$_.JThrowablePtr Function(
                          jni$_.Pointer<jni$_.Void>,
                          jni$_.JMethodIDPtr,
                          jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
              'globalEnv_CallVoidMethod')
          .asFunction<
              jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void setHillshadeExaggerationTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setHillshadeExaggerationTransition(
    transitionoptions$_.TransitionOptions? transitionOptions,
  ) {
    final _$transitionOptions =
        transitionOptions?.reference ?? jni$_.jNullReference;
    _setHillshadeExaggerationTransition(
            reference.pointer,
            _id_setHillshadeExaggerationTransition as jni$_.JMethodIDPtr,
            _$transitionOptions.pointer)
        .check();
  }

  static final _id_getHillshadeShadowColor = _class.instanceMethodId(
    r'getHillshadeShadowColor',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHillshadeShadowColor = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHillshadeShadowColor()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue$_.PropertyValue<jni$_.JString?>? getHillshadeShadowColor() {
    return _getHillshadeShadowColor(reference.pointer,
            _id_getHillshadeShadowColor as jni$_.JMethodIDPtr)
        .object<propertyvalue$_.PropertyValue<jni$_.JString?>?>(
            const propertyvalue$_.$PropertyValue$NullableType<jni$_.JString?>(
                jni$_.JStringNullableType()));
  }

  static final _id_getHillshadeShadowColorAsInt = _class.instanceMethodId(
    r'getHillshadeShadowColorAsInt',
    r'()I',
  );

  static final _getHillshadeShadowColorAsInt =
      jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.JMethodIDPtr,
                  )>>('globalEnv_CallIntMethod')
          .asFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>();

  /// from: `public int getHillshadeShadowColorAsInt()`
  int getHillshadeShadowColorAsInt() {
    return _getHillshadeShadowColorAsInt(reference.pointer,
            _id_getHillshadeShadowColorAsInt as jni$_.JMethodIDPtr)
        .integer;
  }

  static final _id_getHillshadeShadowColorTransition = _class.instanceMethodId(
    r'getHillshadeShadowColorTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getHillshadeShadowColorTransition =
      jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getHillshadeShadowColorTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions$_.TransitionOptions? getHillshadeShadowColorTransition() {
    return _getHillshadeShadowColorTransition(reference.pointer,
            _id_getHillshadeShadowColorTransition as jni$_.JMethodIDPtr)
        .object<transitionoptions$_.TransitionOptions?>(
            const transitionoptions$_.$TransitionOptions$NullableType());
  }

  static final _id_setHillshadeShadowColorTransition = _class.instanceMethodId(
    r'setHillshadeShadowColorTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setHillshadeShadowColorTransition =
      jni$_.ProtectedJniExtensions.lookup<
                  jni$_.NativeFunction<
                      jni$_.JThrowablePtr Function(
                          jni$_.Pointer<jni$_.Void>,
                          jni$_.JMethodIDPtr,
                          jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
              'globalEnv_CallVoidMethod')
          .asFunction<
              jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void setHillshadeShadowColorTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setHillshadeShadowColorTransition(
    transitionoptions$_.TransitionOptions? transitionOptions,
  ) {
    final _$transitionOptions =
        transitionOptions?.reference ?? jni$_.jNullReference;
    _setHillshadeShadowColorTransition(
            reference.pointer,
            _id_setHillshadeShadowColorTransition as jni$_.JMethodIDPtr,
            _$transitionOptions.pointer)
        .check();
  }

  static final _id_getHillshadeHighlightColor = _class.instanceMethodId(
    r'getHillshadeHighlightColor',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHillshadeHighlightColor =
      jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHillshadeHighlightColor()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue$_.PropertyValue<jni$_.JString?>? getHillshadeHighlightColor() {
    return _getHillshadeHighlightColor(reference.pointer,
            _id_getHillshadeHighlightColor as jni$_.JMethodIDPtr)
        .object<propertyvalue$_.PropertyValue<jni$_.JString?>?>(
            const propertyvalue$_.$PropertyValue$NullableType<jni$_.JString?>(
                jni$_.JStringNullableType()));
  }

  static final _id_getHillshadeHighlightColorAsInt = _class.instanceMethodId(
    r'getHillshadeHighlightColorAsInt',
    r'()I',
  );

  static final _getHillshadeHighlightColorAsInt =
      jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.JMethodIDPtr,
                  )>>('globalEnv_CallIntMethod')
          .asFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>();

  /// from: `public int getHillshadeHighlightColorAsInt()`
  int getHillshadeHighlightColorAsInt() {
    return _getHillshadeHighlightColorAsInt(reference.pointer,
            _id_getHillshadeHighlightColorAsInt as jni$_.JMethodIDPtr)
        .integer;
  }

  static final _id_getHillshadeHighlightColorTransition =
      _class.instanceMethodId(
    r'getHillshadeHighlightColorTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getHillshadeHighlightColorTransition =
      jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getHillshadeHighlightColorTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions$_.TransitionOptions?
      getHillshadeHighlightColorTransition() {
    return _getHillshadeHighlightColorTransition(reference.pointer,
            _id_getHillshadeHighlightColorTransition as jni$_.JMethodIDPtr)
        .object<transitionoptions$_.TransitionOptions?>(
            const transitionoptions$_.$TransitionOptions$NullableType());
  }

  static final _id_setHillshadeHighlightColorTransition =
      _class.instanceMethodId(
    r'setHillshadeHighlightColorTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setHillshadeHighlightColorTransition =
      jni$_.ProtectedJniExtensions.lookup<
                  jni$_.NativeFunction<
                      jni$_.JThrowablePtr Function(
                          jni$_.Pointer<jni$_.Void>,
                          jni$_.JMethodIDPtr,
                          jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
              'globalEnv_CallVoidMethod')
          .asFunction<
              jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void setHillshadeHighlightColorTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setHillshadeHighlightColorTransition(
    transitionoptions$_.TransitionOptions? transitionOptions,
  ) {
    final _$transitionOptions =
        transitionOptions?.reference ?? jni$_.jNullReference;
    _setHillshadeHighlightColorTransition(
            reference.pointer,
            _id_setHillshadeHighlightColorTransition as jni$_.JMethodIDPtr,
            _$transitionOptions.pointer)
        .check();
  }

  static final _id_getHillshadeAccentColor = _class.instanceMethodId(
    r'getHillshadeAccentColor',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getHillshadeAccentColor = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getHillshadeAccentColor()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue$_.PropertyValue<jni$_.JString?>? getHillshadeAccentColor() {
    return _getHillshadeAccentColor(reference.pointer,
            _id_getHillshadeAccentColor as jni$_.JMethodIDPtr)
        .object<propertyvalue$_.PropertyValue<jni$_.JString?>?>(
            const propertyvalue$_.$PropertyValue$NullableType<jni$_.JString?>(
                jni$_.JStringNullableType()));
  }

  static final _id_getHillshadeAccentColorAsInt = _class.instanceMethodId(
    r'getHillshadeAccentColorAsInt',
    r'()I',
  );

  static final _getHillshadeAccentColorAsInt =
      jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.JMethodIDPtr,
                  )>>('globalEnv_CallIntMethod')
          .asFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>();

  /// from: `public int getHillshadeAccentColorAsInt()`
  int getHillshadeAccentColorAsInt() {
    return _getHillshadeAccentColorAsInt(reference.pointer,
            _id_getHillshadeAccentColorAsInt as jni$_.JMethodIDPtr)
        .integer;
  }

  static final _id_getHillshadeAccentColorTransition = _class.instanceMethodId(
    r'getHillshadeAccentColorTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getHillshadeAccentColorTransition =
      jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getHillshadeAccentColorTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions$_.TransitionOptions? getHillshadeAccentColorTransition() {
    return _getHillshadeAccentColorTransition(reference.pointer,
            _id_getHillshadeAccentColorTransition as jni$_.JMethodIDPtr)
        .object<transitionoptions$_.TransitionOptions?>(
            const transitionoptions$_.$TransitionOptions$NullableType());
  }

  static final _id_setHillshadeAccentColorTransition = _class.instanceMethodId(
    r'setHillshadeAccentColorTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setHillshadeAccentColorTransition =
      jni$_.ProtectedJniExtensions.lookup<
                  jni$_.NativeFunction<
                      jni$_.JThrowablePtr Function(
                          jni$_.Pointer<jni$_.Void>,
                          jni$_.JMethodIDPtr,
                          jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
              'globalEnv_CallVoidMethod')
          .asFunction<
              jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void setHillshadeAccentColorTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setHillshadeAccentColorTransition(
    transitionoptions$_.TransitionOptions? transitionOptions,
  ) {
    final _$transitionOptions =
        transitionOptions?.reference ?? jni$_.jNullReference;
    _setHillshadeAccentColorTransition(
            reference.pointer,
            _id_setHillshadeAccentColorTransition as jni$_.JMethodIDPtr,
            _$transitionOptions.pointer)
        .check();
  }
}

final class $HillshadeLayer$NullableType
    extends jni$_.JObjType<HillshadeLayer?> {
  @jni$_.internal
  const $HillshadeLayer$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/style/layers/HillshadeLayer;';

  @jni$_.internal
  @core$_.override
  HillshadeLayer? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : HillshadeLayer.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const layer$_.$Layer$NullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<HillshadeLayer?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 2;

  @core$_.override
  int get hashCode => ($HillshadeLayer$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($HillshadeLayer$NullableType) &&
        other is $HillshadeLayer$NullableType;
  }
}

final class $HillshadeLayer$Type extends jni$_.JObjType<HillshadeLayer> {
  @jni$_.internal
  const $HillshadeLayer$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/style/layers/HillshadeLayer;';

  @jni$_.internal
  @core$_.override
  HillshadeLayer fromReference(jni$_.JReference reference) =>
      HillshadeLayer.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const layer$_.$Layer$NullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<HillshadeLayer?> get nullableType =>
      const $HillshadeLayer$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 2;

  @core$_.override
  int get hashCode => ($HillshadeLayer$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($HillshadeLayer$Type) &&
        other is $HillshadeLayer$Type;
  }
}
