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

/// from: `org.maplibre.android.style.layers.BackgroundLayer`
class BackgroundLayer extends layer_.Layer {
  @override
  late final jni.JObjType<BackgroundLayer> $type = type;

  BackgroundLayer.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/style/layers/BackgroundLayer');

  /// The type which includes information such as the signature of this class.
  static const type = $BackgroundLayerType();
  static final _id_new2 = _class.constructorId(
    r'(Ljava/lang/String;)V',
  );

  static final _new2 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  factory BackgroundLayer.new2(
    jni.JString string,
  ) {
    return BackgroundLayer.fromReference(_new2(_class.reference.pointer,
            _id_new2 as jni.JMethodIDPtr, string.reference.pointer)
        .reference);
  }

  static final _id_initialize = _class.instanceMethodId(
    r'initialize',
    r'(Ljava/lang/String;)V',
  );

  static final _initialize = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `protected native void initialize(java.lang.String string)`
  void initialize(
    jni.JString string,
  ) {
    _initialize(reference.pointer, _id_initialize as jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_withProperties = _class.instanceMethodId(
    r'withProperties',
    r'([Lorg/maplibre/android/style/layers/PropertyValue;)Lorg/maplibre/android/style/layers/BackgroundLayer;',
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

  /// from: `public org.maplibre.android.style.layers.BackgroundLayer withProperties(java.lang.Object[] propertyValues)`
  /// The returned object must be released after use, by calling the [release] method.
  BackgroundLayer withProperties(
    jni.JArray<propertyvalue_.PropertyValue<jni.JObject>> propertyValues,
  ) {
    return _withProperties(
            reference.pointer,
            _id_withProperties as jni.JMethodIDPtr,
            propertyValues.reference.pointer)
        .object(const $BackgroundLayerType());
  }

  static final _id_getBackgroundColor = _class.instanceMethodId(
    r'getBackgroundColor',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getBackgroundColor = ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getBackgroundColor()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<jni.JString> getBackgroundColor() {
    return _getBackgroundColor(
            reference.pointer, _id_getBackgroundColor as jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValueType(jni.JStringType()));
  }

  static final _id_getBackgroundColorAsInt = _class.instanceMethodId(
    r'getBackgroundColorAsInt',
    r'()I',
  );

  static final _getBackgroundColorAsInt = ProtectedJniExtensions.lookup<
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

  /// from: `public int getBackgroundColorAsInt()`
  int getBackgroundColorAsInt() {
    return _getBackgroundColorAsInt(
            reference.pointer, _id_getBackgroundColorAsInt as jni.JMethodIDPtr)
        .integer;
  }

  static final _id_getBackgroundColorTransition = _class.instanceMethodId(
    r'getBackgroundColorTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getBackgroundColorTransition = ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getBackgroundColorTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions_.TransitionOptions getBackgroundColorTransition() {
    return _getBackgroundColorTransition(reference.pointer,
            _id_getBackgroundColorTransition as jni.JMethodIDPtr)
        .object(const transitionoptions_.$TransitionOptionsType());
  }

  static final _id_setBackgroundColorTransition = _class.instanceMethodId(
    r'setBackgroundColorTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setBackgroundColorTransition = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void setBackgroundColorTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setBackgroundColorTransition(
    transitionoptions_.TransitionOptions transitionOptions,
  ) {
    _setBackgroundColorTransition(
            reference.pointer,
            _id_setBackgroundColorTransition as jni.JMethodIDPtr,
            transitionOptions.reference.pointer)
        .check();
  }

  static final _id_getBackgroundPattern = _class.instanceMethodId(
    r'getBackgroundPattern',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getBackgroundPattern = ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getBackgroundPattern()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<jni.JString> getBackgroundPattern() {
    return _getBackgroundPattern(
            reference.pointer, _id_getBackgroundPattern as jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValueType(jni.JStringType()));
  }

  static final _id_getBackgroundPatternTransition = _class.instanceMethodId(
    r'getBackgroundPatternTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getBackgroundPatternTransition = ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getBackgroundPatternTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions_.TransitionOptions getBackgroundPatternTransition() {
    return _getBackgroundPatternTransition(reference.pointer,
            _id_getBackgroundPatternTransition as jni.JMethodIDPtr)
        .object(const transitionoptions_.$TransitionOptionsType());
  }

  static final _id_setBackgroundPatternTransition = _class.instanceMethodId(
    r'setBackgroundPatternTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setBackgroundPatternTransition = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void setBackgroundPatternTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setBackgroundPatternTransition(
    transitionoptions_.TransitionOptions transitionOptions,
  ) {
    _setBackgroundPatternTransition(
            reference.pointer,
            _id_setBackgroundPatternTransition as jni.JMethodIDPtr,
            transitionOptions.reference.pointer)
        .check();
  }

  static final _id_getBackgroundOpacity = _class.instanceMethodId(
    r'getBackgroundOpacity',
    r'()Lorg/maplibre/android/style/layers/PropertyValue;',
  );

  static final _getBackgroundOpacity = ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.PropertyValue getBackgroundOpacity()`
  /// The returned object must be released after use, by calling the [release] method.
  propertyvalue_.PropertyValue<jni.JFloat> getBackgroundOpacity() {
    return _getBackgroundOpacity(
            reference.pointer, _id_getBackgroundOpacity as jni.JMethodIDPtr)
        .object(const propertyvalue_.$PropertyValueType(jni.JFloatType()));
  }

  static final _id_getBackgroundOpacityTransition = _class.instanceMethodId(
    r'getBackgroundOpacityTransition',
    r'()Lorg/maplibre/android/style/layers/TransitionOptions;',
  );

  static final _getBackgroundOpacityTransition = ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.layers.TransitionOptions getBackgroundOpacityTransition()`
  /// The returned object must be released after use, by calling the [release] method.
  transitionoptions_.TransitionOptions getBackgroundOpacityTransition() {
    return _getBackgroundOpacityTransition(reference.pointer,
            _id_getBackgroundOpacityTransition as jni.JMethodIDPtr)
        .object(const transitionoptions_.$TransitionOptionsType());
  }

  static final _id_setBackgroundOpacityTransition = _class.instanceMethodId(
    r'setBackgroundOpacityTransition',
    r'(Lorg/maplibre/android/style/layers/TransitionOptions;)V',
  );

  static final _setBackgroundOpacityTransition = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void setBackgroundOpacityTransition(org.maplibre.android.style.layers.TransitionOptions transitionOptions)`
  void setBackgroundOpacityTransition(
    transitionoptions_.TransitionOptions transitionOptions,
  ) {
    _setBackgroundOpacityTransition(
            reference.pointer,
            _id_setBackgroundOpacityTransition as jni.JMethodIDPtr,
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

final class $BackgroundLayerType extends jni.JObjType<BackgroundLayer> {
  const $BackgroundLayerType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/style/layers/BackgroundLayer;';

  @override
  BackgroundLayer fromReference(jni.JReference reference) =>
      BackgroundLayer.fromReference(reference);

  @override
  jni.JObjType get superType => const layer_.$LayerType();

  @override
  final superCount = 2;

  @override
  int get hashCode => ($BackgroundLayerType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($BackgroundLayerType) &&
        other is $BackgroundLayerType;
  }
}
