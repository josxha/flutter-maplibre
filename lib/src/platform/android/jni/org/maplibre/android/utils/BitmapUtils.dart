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

/// from: `org.maplibre.android.utils.BitmapUtils`
class BitmapUtils extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<BitmapUtils> $type;

  @jni$_.internal
  BitmapUtils.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/utils/BitmapUtils');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $BitmapUtils$NullableType();
  static const type = $BitmapUtils$Type();
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
  factory BitmapUtils() {
    return BitmapUtils.fromReference(
        _new$(_class.reference.pointer, _id_new$ as jni$_.JMethodIDPtr)
            .reference);
  }

  static final _id_createBitmapFromView = _class.staticMethodId(
    r'createBitmapFromView',
    r'(Landroid/view/View;)Landroid/graphics/Bitmap;',
  );

  static final _createBitmapFromView = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public android.graphics.Bitmap createBitmapFromView(android.view.View view)`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JObject? createBitmapFromView(
    jni$_.JObject? view,
  ) {
    final _$view = view?.reference ?? jni$_.jNullReference;
    return _createBitmapFromView(_class.reference.pointer,
            _id_createBitmapFromView as jni$_.JMethodIDPtr, _$view.pointer)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_mergeBitmap = _class.staticMethodId(
    r'mergeBitmap',
    r'(Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;',
  );

  static final _mergeBitmap = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public android.graphics.Bitmap mergeBitmap(android.graphics.Bitmap bitmap, android.graphics.Bitmap bitmap1)`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JObject? mergeBitmap(
    jni$_.JObject? bitmap,
    jni$_.JObject? bitmap1,
  ) {
    final _$bitmap = bitmap?.reference ?? jni$_.jNullReference;
    final _$bitmap1 = bitmap1?.reference ?? jni$_.jNullReference;
    return _mergeBitmap(
            _class.reference.pointer,
            _id_mergeBitmap as jni$_.JMethodIDPtr,
            _$bitmap.pointer,
            _$bitmap1.pointer)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_mergeBitmaps = _class.staticMethodId(
    r'mergeBitmaps',
    r'(Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;',
  );

  static final _mergeBitmaps = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public android.graphics.Bitmap mergeBitmaps(android.graphics.Bitmap bitmap, android.graphics.Bitmap bitmap1)`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JObject? mergeBitmaps(
    jni$_.JObject? bitmap,
    jni$_.JObject? bitmap1,
  ) {
    final _$bitmap = bitmap?.reference ?? jni$_.jNullReference;
    final _$bitmap1 = bitmap1?.reference ?? jni$_.jNullReference;
    return _mergeBitmaps(
            _class.reference.pointer,
            _id_mergeBitmaps as jni$_.JMethodIDPtr,
            _$bitmap.pointer,
            _$bitmap1.pointer)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_mergeBitmap$1 = _class.staticMethodId(
    r'mergeBitmap',
    r'(Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;FF)Landroid/graphics/Bitmap;',
  );

  static final _mergeBitmap$1 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Double,
                        jni$_.Double
                      )>)>>('globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              double,
              double)>();

  /// from: `static public android.graphics.Bitmap mergeBitmap(android.graphics.Bitmap bitmap, android.graphics.Bitmap bitmap1, float f, float f1)`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JObject? mergeBitmap$1(
    jni$_.JObject? bitmap,
    jni$_.JObject? bitmap1,
    double f,
    double f1,
  ) {
    final _$bitmap = bitmap?.reference ?? jni$_.jNullReference;
    final _$bitmap1 = bitmap1?.reference ?? jni$_.jNullReference;
    return _mergeBitmap$1(
            _class.reference.pointer,
            _id_mergeBitmap$1 as jni$_.JMethodIDPtr,
            _$bitmap.pointer,
            _$bitmap1.pointer,
            f,
            f1)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_getBitmapFromDrawable = _class.staticMethodId(
    r'getBitmapFromDrawable',
    r'(Landroid/graphics/drawable/Drawable;)Landroid/graphics/Bitmap;',
  );

  static final _getBitmapFromDrawable = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public android.graphics.Bitmap getBitmapFromDrawable(android.graphics.drawable.Drawable drawable)`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JObject? getBitmapFromDrawable(
    jni$_.JObject? drawable,
  ) {
    final _$drawable = drawable?.reference ?? jni$_.jNullReference;
    return _getBitmapFromDrawable(_class.reference.pointer,
            _id_getBitmapFromDrawable as jni$_.JMethodIDPtr, _$drawable.pointer)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_getByteArrayFromDrawable = _class.staticMethodId(
    r'getByteArrayFromDrawable',
    r'(Landroid/graphics/drawable/Drawable;)[B',
  );

  static final _getByteArrayFromDrawable = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public byte[] getByteArrayFromDrawable(android.graphics.drawable.Drawable drawable)`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JByteArray? getByteArrayFromDrawable(
    jni$_.JObject? drawable,
  ) {
    final _$drawable = drawable?.reference ?? jni$_.jNullReference;
    return _getByteArrayFromDrawable(
            _class.reference.pointer,
            _id_getByteArrayFromDrawable as jni$_.JMethodIDPtr,
            _$drawable.pointer)
        .object<jni$_.JByteArray?>(const jni$_.JByteArrayNullableType());
  }

  static final _id_getDrawableFromByteArray = _class.staticMethodId(
    r'getDrawableFromByteArray',
    r'(Landroid/content/Context;[B)Landroid/graphics/drawable/Drawable;',
  );

  static final _getDrawableFromByteArray = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public android.graphics.drawable.Drawable getDrawableFromByteArray(android.content.Context context, byte[] bs)`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JObject? getDrawableFromByteArray(
    jni$_.JObject? context,
    jni$_.JByteArray? bs,
  ) {
    final _$context = context?.reference ?? jni$_.jNullReference;
    final _$bs = bs?.reference ?? jni$_.jNullReference;
    return _getDrawableFromByteArray(
            _class.reference.pointer,
            _id_getDrawableFromByteArray as jni$_.JMethodIDPtr,
            _$context.pointer,
            _$bs.pointer)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_getDrawableFromRes = _class.staticMethodId(
    r'getDrawableFromRes',
    r'(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;',
  );

  static final _getDrawableFromRes = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_
                          .VarArgs<(jni$_.Pointer<jni$_.Void>, jni$_.Int32)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>, int)>();

  /// from: `static public android.graphics.drawable.Drawable getDrawableFromRes(android.content.Context context, int i)`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JObject? getDrawableFromRes(
    jni$_.JObject? context,
    int i,
  ) {
    final _$context = context?.reference ?? jni$_.jNullReference;
    return _getDrawableFromRes(_class.reference.pointer,
            _id_getDrawableFromRes as jni$_.JMethodIDPtr, _$context.pointer, i)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_getDrawableFromRes$1 = _class.staticMethodId(
    r'getDrawableFromRes',
    r'(Landroid/content/Context;ILjava/lang/Integer;)Landroid/graphics/drawable/Drawable;',
  );

  static final _getDrawableFromRes$1 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Int32,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              int,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public android.graphics.drawable.Drawable getDrawableFromRes(android.content.Context context, int i, java.lang.Integer integer)`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JObject? getDrawableFromRes$1(
    jni$_.JObject? context,
    int i,
    jni$_.JInteger? integer,
  ) {
    final _$context = context?.reference ?? jni$_.jNullReference;
    final _$integer = integer?.reference ?? jni$_.jNullReference;
    return _getDrawableFromRes$1(
            _class.reference.pointer,
            _id_getDrawableFromRes$1 as jni$_.JMethodIDPtr,
            _$context.pointer,
            i,
            _$integer.pointer)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_equals = _class.staticMethodId(
    r'equals',
    r'(Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;)Z',
  );

  static final _equals = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallStaticBooleanMethod')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public boolean equals(android.graphics.Bitmap bitmap, android.graphics.Bitmap bitmap1)`
  static bool equals(
    jni$_.JObject? bitmap,
    jni$_.JObject? bitmap1,
  ) {
    final _$bitmap = bitmap?.reference ?? jni$_.jNullReference;
    final _$bitmap1 = bitmap1?.reference ?? jni$_.jNullReference;
    return _equals(_class.reference.pointer, _id_equals as jni$_.JMethodIDPtr,
            _$bitmap.pointer, _$bitmap1.pointer)
        .boolean;
  }
}

final class $BitmapUtils$NullableType extends jni$_.JObjType<BitmapUtils?> {
  @jni$_.internal
  const $BitmapUtils$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/utils/BitmapUtils;';

  @jni$_.internal
  @core$_.override
  BitmapUtils? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : BitmapUtils.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<BitmapUtils?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($BitmapUtils$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($BitmapUtils$NullableType) &&
        other is $BitmapUtils$NullableType;
  }
}

final class $BitmapUtils$Type extends jni$_.JObjType<BitmapUtils> {
  @jni$_.internal
  const $BitmapUtils$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/utils/BitmapUtils;';

  @jni$_.internal
  @core$_.override
  BitmapUtils fromReference(jni$_.JReference reference) =>
      BitmapUtils.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<BitmapUtils?> get nullableType =>
      const $BitmapUtils$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($BitmapUtils$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($BitmapUtils$Type) &&
        other is $BitmapUtils$Type;
  }
}