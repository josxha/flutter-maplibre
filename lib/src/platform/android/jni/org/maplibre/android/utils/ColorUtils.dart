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

/// from: `org.maplibre.android.utils.ColorUtils`
class ColorUtils extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<ColorUtils> $type;

  @jni$_.internal
  ColorUtils.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/utils/ColorUtils');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $ColorUtils$NullableType();
  static const type = $ColorUtils$Type();
  static final _id_new$ = _class.constructorId(
    r'()V',
  );

  static final _new$ = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public void <init>()`
  /// The returned object must be released after use, by calling the [release] method.
  factory ColorUtils() {
    return ColorUtils.fromReference(
        _new$(_class.reference.pointer, _id_new$ as jni$_.JMethodIDPtr)
            .reference);
  }

  static final _id_getPrimaryColor = _class.staticMethodId(
    r'getPrimaryColor',
    r'(Landroid/content/Context;)I',
  );

  static final _getPrimaryColor = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallStaticIntMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public int getPrimaryColor(android.content.Context context)`
  static int getPrimaryColor(
    jni$_.JObject? context,
  ) {
    final _$context = context?.reference ?? jni$_.jNullReference;
    return _getPrimaryColor(_class.reference.pointer,
            _id_getPrimaryColor as jni$_.JMethodIDPtr, _$context.pointer)
        .integer;
  }

  static final _id_getPrimaryDarkColor = _class.staticMethodId(
    r'getPrimaryDarkColor',
    r'(Landroid/content/Context;)I',
  );

  static final _getPrimaryDarkColor = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallStaticIntMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public int getPrimaryDarkColor(android.content.Context context)`
  static int getPrimaryDarkColor(
    jni$_.JObject? context,
  ) {
    final _$context = context?.reference ?? jni$_.jNullReference;
    return _getPrimaryDarkColor(_class.reference.pointer,
            _id_getPrimaryDarkColor as jni$_.JMethodIDPtr, _$context.pointer)
        .integer;
  }

  static final _id_getAccentColor = _class.staticMethodId(
    r'getAccentColor',
    r'(Landroid/content/Context;)I',
  );

  static final _getAccentColor = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallStaticIntMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public int getAccentColor(android.content.Context context)`
  static int getAccentColor(
    jni$_.JObject? context,
  ) {
    final _$context = context?.reference ?? jni$_.jNullReference;
    return _getAccentColor(_class.reference.pointer,
            _id_getAccentColor as jni$_.JMethodIDPtr, _$context.pointer)
        .integer;
  }

  static final _id_getSelector = _class.staticMethodId(
    r'getSelector',
    r'(I)Landroid/content/res/ColorStateList;',
  );

  static final _getSelector = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr, jni$_.VarArgs<(jni$_.Int32,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, int)>();

  /// from: `static public android.content.res.ColorStateList getSelector(int i)`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JObject? getSelector(
    int i,
  ) {
    return _getSelector(
            _class.reference.pointer, _id_getSelector as jni$_.JMethodIDPtr, i)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_setTintList = _class.staticMethodId(
    r'setTintList',
    r'(Landroid/widget/ImageView;I)V',
  );

  static final _setTintList = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_
                          .VarArgs<(jni$_.Pointer<jni$_.Void>, jni$_.Int32)>)>>(
          'globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>, int)>();

  /// from: `static public void setTintList(android.widget.ImageView imageView, int i)`
  static void setTintList(
    jni$_.JObject? imageView,
    int i,
  ) {
    final _$imageView = imageView?.reference ?? jni$_.jNullReference;
    _setTintList(_class.reference.pointer,
            _id_setTintList as jni$_.JMethodIDPtr, _$imageView.pointer, i)
        .check();
  }

  static final _id_rgbaToColor = _class.staticMethodId(
    r'rgbaToColor',
    r'(Ljava/lang/String;)I',
  );

  static final _rgbaToColor = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallStaticIntMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public int rgbaToColor(java.lang.String string)`
  static int rgbaToColor(
    jni$_.JString? string,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    return _rgbaToColor(_class.reference.pointer,
            _id_rgbaToColor as jni$_.JMethodIDPtr, _$string.pointer)
        .integer;
  }

  static final _id_colorToRgbaString = _class.staticMethodId(
    r'colorToRgbaString',
    r'(I)Ljava/lang/String;',
  );

  static final _colorToRgbaString = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr, jni$_.VarArgs<(jni$_.Int32,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, int)>();

  /// from: `static public java.lang.String colorToRgbaString(int i)`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? colorToRgbaString(
    int i,
  ) {
    return _colorToRgbaString(_class.reference.pointer,
            _id_colorToRgbaString as jni$_.JMethodIDPtr, i)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_colorToRgbaArray = _class.staticMethodId(
    r'colorToRgbaArray',
    r'(I)[F',
  );

  static final _colorToRgbaArray = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr, jni$_.VarArgs<(jni$_.Int32,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, int)>();

  /// from: `static public float[] colorToRgbaArray(int i)`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JFloatArray? colorToRgbaArray(
    int i,
  ) {
    return _colorToRgbaArray(_class.reference.pointer,
            _id_colorToRgbaArray as jni$_.JMethodIDPtr, i)
        .object<jni$_.JFloatArray?>(const jni$_.JFloatArrayNullableType());
  }

  static final _id_colorToGlRgbaArray = _class.staticMethodId(
    r'colorToGlRgbaArray',
    r'(I)[F',
  );

  static final _colorToGlRgbaArray = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr, jni$_.VarArgs<(jni$_.Int32,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, int)>();

  /// from: `static public float[] colorToGlRgbaArray(int i)`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JFloatArray? colorToGlRgbaArray(
    int i,
  ) {
    return _colorToGlRgbaArray(_class.reference.pointer,
            _id_colorToGlRgbaArray as jni$_.JMethodIDPtr, i)
        .object<jni$_.JFloatArray?>(const jni$_.JFloatArrayNullableType());
  }
}

final class $ColorUtils$NullableType extends jni$_.JObjType<ColorUtils?> {
  @jni$_.internal
  const $ColorUtils$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/utils/ColorUtils;';

  @jni$_.internal
  @core$_.override
  ColorUtils? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : ColorUtils.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<ColorUtils?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($ColorUtils$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($ColorUtils$NullableType) &&
        other is $ColorUtils$NullableType;
  }
}

final class $ColorUtils$Type extends jni$_.JObjType<ColorUtils> {
  @jni$_.internal
  const $ColorUtils$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/utils/ColorUtils;';

  @jni$_.internal
  @core$_.override
  ColorUtils fromReference(jni$_.JReference reference) =>
      ColorUtils.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<ColorUtils?> get nullableType =>
      const $ColorUtils$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($ColorUtils$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($ColorUtils$Type) && other is $ColorUtils$Type;
  }
}
