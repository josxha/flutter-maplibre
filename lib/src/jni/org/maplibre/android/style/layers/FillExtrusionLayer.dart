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

/// from: `org.maplibre.android.style.layers.FillExtrusionLayer`
class FillExtrusionLayer extends layer_.Layer {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<FillExtrusionLayer> $type;

  @_$jni.internal
  FillExtrusionLayer.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = _$jni.JClass.forName(
      r'org/maplibre/android/style/layers/FillExtrusionLayer');

  /// The type which includes information such as the signature of this class.
  static const type = $FillExtrusionLayer$Type();
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
  factory FillExtrusionLayer(
    _$jni.JString string,
    _$jni.JString string1,
  ) {
    return FillExtrusionLayer.fromReference(_new$(
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
    r'(Ljava/lang/String;)Lorg/maplibre/android/style/layers/FillExtrusionLayer;',
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

  /// from: `public org.maplibre.android.style.layers.FillExtrusionLayer withSourceLayer(java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  FillExtrusionLayer withSourceLayer(
    _$jni.JString string,
  ) {
    return _withSourceLayer(reference.pointer,
            _id_withSourceLayer as _$jni.JMethodIDPtr, string.reference.pointer)
        .object(const $FillExtrusionLayer$Type());
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
    r'(Lorg/maplibre/android/style/expressions/Expression;)Lorg/maplibre/android/style/layers/FillExtrusionLayer;',
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

  /// from: `public org.maplibre.android.style.layers.FillExtrusionLayer withFilter(org.maplibre.android.style.expressions.Expression expression)`
  /// The returned object must be released after use, by calling the [release] method.
  FillExtrusionLayer withFilter(
    _$jni.JObject expression,
  ) {
    return _withFilter(reference.pointer, _id_withFilter as _$jni.JMethodIDPtr,
            expression.reference.pointer)
        .object(const $FillExtrusionLayer$Type());
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
    r'([Lorg/maplibre/android/style/layers/PropertyValue;)Lorg/maplibre/android/style/layers/FillExtrusionLayer;',
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

  /// from: `public org.maplibre.android.style.layers.FillExtrusionLayer withProperties(java.lang.Object[] propertyValues)`
  /// The returned object must be released after use, by calling the [release] method.
  FillExtrusionLayer withProperties(
    _$jni.JArray<propertyvalue_.PropertyValue<_$jni.JObject>> propertyValues,
  ) {
    return _withProperties(
            reference.pointer,
            _id_withProperties as _$jni.JMethodIDPtr,
            propertyValues.reference.pointer)
        .object(const $FillExtrusionLayer$Type());
  }

  static final _id_getFillExtrusionOpacity = _class.instanceMethodId(
    r'getFillExtrusionOpacity',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getFillExtrusionOpacity = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getFillExtrusionOpacity()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JFloat> getFillExtrusionOpacity() {
    return _getFillExtrusionOpacity(reference.pointer,
            _id_getFillExtrusionOpacity as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(_$jni.JFloatType()));
  }

  static final _id_getFillExtrusionOpacityTransition = _class.instanceMethodId(
    r'getFillExtrusionOpacityTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getFillExtrusionOpacityTransition =
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getFillExtrusionOpacityTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions_.TransitionOptions getFillExtrusionOpacityTransition() {
    return _getFillExtrusionOpacityTransition(reference.pointer,
            _id_getFillExtrusionOpacityTransition as _$jni.JMethodIDPtr)
        .object(const transitionoptions_.$TransitionOptions$Type());
  }

  static final _id_setFillExtrusionOpacityTransition = _class.instanceMethodId(
    r'setFillExtrusionOpacityTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setFillExtrusionOpacityTransition =
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

  /// from: `public void setFillExtrusionOpacityTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setFillExtrusionOpacityTransition(
    transitionoptions_.TransitionOptions transitionOptions,
  ) {
    _setFillExtrusionOpacityTransition(
            reference.pointer,
            _id_setFillExtrusionOpacityTransition as _$jni.JMethodIDPtr,
            transitionOptions.reference.pointer)
        .check();
  }

  static final _id_getFillExtrusionColor = _class.instanceMethodId(
    r'getFillExtrusionColor',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getFillExtrusionColor = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getFillExtrusionColor()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JString> getFillExtrusionColor() {
    return _getFillExtrusionColor(
            reference.pointer, _id_getFillExtrusionColor as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(_$jni.JStringType()));
  }

  static final _id_getFillExtrusionColorAsInt = _class.instanceMethodId(
    r'getFillExtrusionColorAsInt',
    r'()I',
  );

  static final _getFillExtrusionColorAsInt =
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

  /// from: `public int getFillExtrusionColorAsInt()`
  int getFillExtrusionColorAsInt() {
    return _getFillExtrusionColorAsInt(reference.pointer,
            _id_getFillExtrusionColorAsInt as _$jni.JMethodIDPtr)
        .integer;
  }

  static final _id_getFillExtrusionColorTransition = _class.instanceMethodId(
    r'getFillExtrusionColorTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getFillExtrusionColorTransition =
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getFillExtrusionColorTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions_.TransitionOptions getFillExtrusionColorTransition() {
    return _getFillExtrusionColorTransition(reference.pointer,
            _id_getFillExtrusionColorTransition as _$jni.JMethodIDPtr)
        .object(const transitionoptions_.$TransitionOptions$Type());
  }

  static final _id_setFillExtrusionColorTransition = _class.instanceMethodId(
    r'setFillExtrusionColorTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setFillExtrusionColorTransition =
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

  /// from: `public void setFillExtrusionColorTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setFillExtrusionColorTransition(
    transitionoptions_.TransitionOptions transitionOptions,
  ) {
    _setFillExtrusionColorTransition(
            reference.pointer,
            _id_setFillExtrusionColorTransition as _$jni.JMethodIDPtr,
            transitionOptions.reference.pointer)
        .check();
  }

  static final _id_getFillExtrusionTranslate = _class.instanceMethodId(
    r'getFillExtrusionTranslate',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getFillExtrusionTranslate = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getFillExtrusionTranslate()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JArray<_$jni.JFloat>>
      getFillExtrusionTranslate() {
    return _getFillExtrusionTranslate(reference.pointer,
            _id_getFillExtrusionTranslate as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(
            _$jni.JArrayType(_$jni.JFloatType())));
  }

  static final _id_getFillExtrusionTranslateTransition =
      _class.instanceMethodId(
    r'getFillExtrusionTranslateTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getFillExtrusionTranslateTransition =
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getFillExtrusionTranslateTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions_.TransitionOptions getFillExtrusionTranslateTransition() {
    return _getFillExtrusionTranslateTransition(reference.pointer,
            _id_getFillExtrusionTranslateTransition as _$jni.JMethodIDPtr)
        .object(const transitionoptions_.$TransitionOptions$Type());
  }

  static final _id_setFillExtrusionTranslateTransition =
      _class.instanceMethodId(
    r'setFillExtrusionTranslateTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setFillExtrusionTranslateTransition =
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

  /// from: `public void setFillExtrusionTranslateTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setFillExtrusionTranslateTransition(
    transitionoptions_.TransitionOptions transitionOptions,
  ) {
    _setFillExtrusionTranslateTransition(
            reference.pointer,
            _id_setFillExtrusionTranslateTransition as _$jni.JMethodIDPtr,
            transitionOptions.reference.pointer)
        .check();
  }

  static final _id_getFillExtrusionTranslateAnchor = _class.instanceMethodId(
    r'getFillExtrusionTranslateAnchor',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getFillExtrusionTranslateAnchor =
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getFillExtrusionTranslateAnchor()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JString>
      getFillExtrusionTranslateAnchor() {
    return _getFillExtrusionTranslateAnchor(reference.pointer,
            _id_getFillExtrusionTranslateAnchor as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(_$jni.JStringType()));
  }

  static final _id_getFillExtrusionPattern = _class.instanceMethodId(
    r'getFillExtrusionPattern',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getFillExtrusionPattern = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getFillExtrusionPattern()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JString> getFillExtrusionPattern() {
    return _getFillExtrusionPattern(reference.pointer,
            _id_getFillExtrusionPattern as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(_$jni.JStringType()));
  }

  static final _id_getFillExtrusionPatternTransition = _class.instanceMethodId(
    r'getFillExtrusionPatternTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getFillExtrusionPatternTransition =
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getFillExtrusionPatternTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions_.TransitionOptions getFillExtrusionPatternTransition() {
    return _getFillExtrusionPatternTransition(reference.pointer,
            _id_getFillExtrusionPatternTransition as _$jni.JMethodIDPtr)
        .object(const transitionoptions_.$TransitionOptions$Type());
  }

  static final _id_setFillExtrusionPatternTransition = _class.instanceMethodId(
    r'setFillExtrusionPatternTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setFillExtrusionPatternTransition =
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

  /// from: `public void setFillExtrusionPatternTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setFillExtrusionPatternTransition(
    transitionoptions_.TransitionOptions transitionOptions,
  ) {
    _setFillExtrusionPatternTransition(
            reference.pointer,
            _id_setFillExtrusionPatternTransition as _$jni.JMethodIDPtr,
            transitionOptions.reference.pointer)
        .check();
  }

  static final _id_getFillExtrusionHeight = _class.instanceMethodId(
    r'getFillExtrusionHeight',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getFillExtrusionHeight = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getFillExtrusionHeight()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JFloat> getFillExtrusionHeight() {
    return _getFillExtrusionHeight(
            reference.pointer, _id_getFillExtrusionHeight as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(_$jni.JFloatType()));
  }

  static final _id_getFillExtrusionHeightTransition = _class.instanceMethodId(
    r'getFillExtrusionHeightTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getFillExtrusionHeightTransition =
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getFillExtrusionHeightTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions_.TransitionOptions getFillExtrusionHeightTransition() {
    return _getFillExtrusionHeightTransition(reference.pointer,
            _id_getFillExtrusionHeightTransition as _$jni.JMethodIDPtr)
        .object(const transitionoptions_.$TransitionOptions$Type());
  }

  static final _id_setFillExtrusionHeightTransition = _class.instanceMethodId(
    r'setFillExtrusionHeightTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setFillExtrusionHeightTransition =
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

  /// from: `public void setFillExtrusionHeightTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setFillExtrusionHeightTransition(
    transitionoptions_.TransitionOptions transitionOptions,
  ) {
    _setFillExtrusionHeightTransition(
            reference.pointer,
            _id_setFillExtrusionHeightTransition as _$jni.JMethodIDPtr,
            transitionOptions.reference.pointer)
        .check();
  }

  static final _id_getFillExtrusionBase = _class.instanceMethodId(
    r'getFillExtrusionBase',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getFillExtrusionBase = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getFillExtrusionBase()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JFloat> getFillExtrusionBase() {
    return _getFillExtrusionBase(
            reference.pointer, _id_getFillExtrusionBase as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(_$jni.JFloatType()));
  }

  static final _id_getFillExtrusionBaseTransition = _class.instanceMethodId(
    r'getFillExtrusionBaseTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getFillExtrusionBaseTransition =
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getFillExtrusionBaseTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions_.TransitionOptions getFillExtrusionBaseTransition() {
    return _getFillExtrusionBaseTransition(reference.pointer,
            _id_getFillExtrusionBaseTransition as _$jni.JMethodIDPtr)
        .object(const transitionoptions_.$TransitionOptions$Type());
  }

  static final _id_setFillExtrusionBaseTransition = _class.instanceMethodId(
    r'setFillExtrusionBaseTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setFillExtrusionBaseTransition =
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

  /// from: `public void setFillExtrusionBaseTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setFillExtrusionBaseTransition(
    transitionoptions_.TransitionOptions transitionOptions,
  ) {
    _setFillExtrusionBaseTransition(
            reference.pointer,
            _id_setFillExtrusionBaseTransition as _$jni.JMethodIDPtr,
            transitionOptions.reference.pointer)
        .check();
  }

  static final _id_getFillExtrusionVerticalGradient = _class.instanceMethodId(
    r'getFillExtrusionVerticalGradient',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getFillExtrusionVerticalGradient =
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getFillExtrusionVerticalGradient()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<_$jni.JBoolean>
      getFillExtrusionVerticalGradient() {
    return _getFillExtrusionVerticalGradient(reference.pointer,
            _id_getFillExtrusionVerticalGradient as _$jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValue$Type(_$jni.JBooleanType()));
  }
}

final class $FillExtrusionLayer$Type
    extends _$jni.JObjType<FillExtrusionLayer> {
  @_$jni.internal
  const $FillExtrusionLayer$Type();

  @_$jni.internal
  @_$core.override
  String get signature =>
      r'Lorg/maplibre/android/style/layers/FillExtrusionLayer;';

  @_$jni.internal
  @_$core.override
  FillExtrusionLayer fromReference(_$jni.JReference reference) =>
      FillExtrusionLayer.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const layer_.$Layer$Type();

  @_$jni.internal
  @_$core.override
  final superCount = 2;

  @_$core.override
  int get hashCode => ($FillExtrusionLayer$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($FillExtrusionLayer$Type) &&
        other is $FillExtrusionLayer$Type;
  }
}
