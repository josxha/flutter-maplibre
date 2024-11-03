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

/// from: `org.maplibre.android.utils.ColorUtils`
class ColorUtils extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<ColorUtils> $type;

  @_$jni.internal
  ColorUtils.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      _$jni.JClass.forName(r'org/maplibre/android/utils/ColorUtils');

  /// The type which includes information such as the signature of this class.
  static const type = $ColorUtils$Type();
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
  factory ColorUtils() {
    return ColorUtils.fromReference(
        _new$(_class.reference.pointer, _id_new$ as _$jni.JMethodIDPtr)
            .reference);
  }

  static final _id_getPrimaryColor = _class.staticMethodId(
    r'getPrimaryColor',
    r'(Landroid/content/Context;)I',
  );

  static final _getPrimaryColor = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallStaticIntMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `static public int getPrimaryColor(android.content.Context context)`
  static int getPrimaryColor(
    _$jni.JObject context,
  ) {
    return _getPrimaryColor(
            _class.reference.pointer,
            _id_getPrimaryColor as _$jni.JMethodIDPtr,
            context.reference.pointer)
        .integer;
  }

  static final _id_getPrimaryDarkColor = _class.staticMethodId(
    r'getPrimaryDarkColor',
    r'(Landroid/content/Context;)I',
  );

  static final _getPrimaryDarkColor = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallStaticIntMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `static public int getPrimaryDarkColor(android.content.Context context)`
  static int getPrimaryDarkColor(
    _$jni.JObject context,
  ) {
    return _getPrimaryDarkColor(
            _class.reference.pointer,
            _id_getPrimaryDarkColor as _$jni.JMethodIDPtr,
            context.reference.pointer)
        .integer;
  }

  static final _id_getAccentColor = _class.staticMethodId(
    r'getAccentColor',
    r'(Landroid/content/Context;)I',
  );

  static final _getAccentColor = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallStaticIntMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `static public int getAccentColor(android.content.Context context)`
  static int getAccentColor(
    _$jni.JObject context,
  ) {
    return _getAccentColor(_class.reference.pointer,
            _id_getAccentColor as _$jni.JMethodIDPtr, context.reference.pointer)
        .integer;
  }

  static final _id_getSelector = _class.staticMethodId(
    r'getSelector',
    r'(I)Landroid/content/res/ColorStateList;',
  );

  static final _getSelector = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr, _$jni.VarArgs<(_$jni.Int32,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, int)>();

  /// from: `static public android.content.res.ColorStateList getSelector(int i)`
  /// The returned object must be released after use, by calling the [release] method.
  static _$jni.JObject getSelector(
    int i,
  ) {
    return _getSelector(
            _class.reference.pointer, _id_getSelector as _$jni.JMethodIDPtr, i)
        .object(const _$jni.JObjectType());
  }

  static final _id_setTintList = _class.staticMethodId(
    r'setTintList',
    r'(Landroid/widget/ImageView;I)V',
  );

  static final _setTintList = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni
                          .VarArgs<(_$jni.Pointer<_$jni.Void>, _$jni.Int32)>)>>(
          'globalEnv_CallStaticVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>, int)>();

  /// from: `static public void setTintList(android.widget.ImageView imageView, int i)`
  static void setTintList(
    _$jni.JObject imageView,
    int i,
  ) {
    _setTintList(
            _class.reference.pointer,
            _id_setTintList as _$jni.JMethodIDPtr,
            imageView.reference.pointer,
            i)
        .check();
  }

  static final _id_rgbaToColor = _class.staticMethodId(
    r'rgbaToColor',
    r'(Ljava/lang/String;)I',
  );

  static final _rgbaToColor = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallStaticIntMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `static public int rgbaToColor(java.lang.String string)`
  static int rgbaToColor(
    _$jni.JString string,
  ) {
    return _rgbaToColor(_class.reference.pointer,
            _id_rgbaToColor as _$jni.JMethodIDPtr, string.reference.pointer)
        .integer;
  }

  static final _id_colorToRgbaString = _class.staticMethodId(
    r'colorToRgbaString',
    r'(I)Ljava/lang/String;',
  );

  static final _colorToRgbaString = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr, _$jni.VarArgs<(_$jni.Int32,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, int)>();

  /// from: `static public java.lang.String colorToRgbaString(int i)`
  /// The returned object must be released after use, by calling the [release] method.
  static _$jni.JString colorToRgbaString(
    int i,
  ) {
    return _colorToRgbaString(_class.reference.pointer,
            _id_colorToRgbaString as _$jni.JMethodIDPtr, i)
        .object(const _$jni.JStringType());
  }

  static final _id_colorToRgbaArray = _class.staticMethodId(
    r'colorToRgbaArray',
    r'(I)[F',
  );

  static final _colorToRgbaArray = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr, _$jni.VarArgs<(_$jni.Int32,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, int)>();

  /// from: `static public float[] colorToRgbaArray(int i)`
  /// The returned object must be released after use, by calling the [release] method.
  static _$jni.JArray<_$jni.jfloat> colorToRgbaArray(
    int i,
  ) {
    return _colorToRgbaArray(_class.reference.pointer,
            _id_colorToRgbaArray as _$jni.JMethodIDPtr, i)
        .object(const _$jni.JArrayType(_$jni.jfloatType()));
  }

  static final _id_colorToGlRgbaArray = _class.staticMethodId(
    r'colorToGlRgbaArray',
    r'(I)[F',
  );

  static final _colorToGlRgbaArray = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr, _$jni.VarArgs<(_$jni.Int32,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, int)>();

  /// from: `static public float[] colorToGlRgbaArray(int i)`
  /// The returned object must be released after use, by calling the [release] method.
  static _$jni.JArray<_$jni.jfloat> colorToGlRgbaArray(
    int i,
  ) {
    return _colorToGlRgbaArray(_class.reference.pointer,
            _id_colorToGlRgbaArray as _$jni.JMethodIDPtr, i)
        .object(const _$jni.JArrayType(_$jni.jfloatType()));
  }
}

final class $ColorUtils$Type extends _$jni.JObjType<ColorUtils> {
  @_$jni.internal
  const $ColorUtils$Type();

  @_$jni.internal
  @_$core.override
  String get signature => r'Lorg/maplibre/android/utils/ColorUtils;';

  @_$jni.internal
  @_$core.override
  ColorUtils fromReference(_$jni.JReference reference) =>
      ColorUtils.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode => ($ColorUtils$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($ColorUtils$Type) && other is $ColorUtils$Type;
  }
}
