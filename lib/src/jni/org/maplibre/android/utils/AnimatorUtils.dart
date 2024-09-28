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

/// from: `org.maplibre.android.utils.AnimatorUtils$OnAnimationEndListener`
class AnimatorUtils_OnAnimationEndListener extends jni.JObject {
  @override
  late final jni.JObjType<AnimatorUtils_OnAnimationEndListener> $type = type;

  AnimatorUtils_OnAnimationEndListener.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/utils/AnimatorUtils$OnAnimationEndListener');

  /// The type which includes information such as the signature of this class.
  static const type = $AnimatorUtils_OnAnimationEndListenerType();
  static final _id_onAnimationEnd = _class.instanceMethodId(
    r'onAnimationEnd',
    r'()V',
  );

  static final _onAnimationEnd = ProtectedJniExtensions.lookup<
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

  /// from: `public abstract void onAnimationEnd()`
  void onAnimationEnd() {
    _onAnimationEnd(reference.pointer, _id_onAnimationEnd as jni.JMethodIDPtr)
        .check();
  }
}

final class $AnimatorUtils_OnAnimationEndListenerType
    extends jni.JObjType<AnimatorUtils_OnAnimationEndListener> {
  const $AnimatorUtils_OnAnimationEndListenerType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/utils/AnimatorUtils$OnAnimationEndListener;';

  @override
  AnimatorUtils_OnAnimationEndListener fromReference(
          jni.JReference reference) =>
      AnimatorUtils_OnAnimationEndListener.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($AnimatorUtils_OnAnimationEndListenerType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($AnimatorUtils_OnAnimationEndListenerType) &&
        other is $AnimatorUtils_OnAnimationEndListenerType;
  }
}

/// from: `org.maplibre.android.utils.AnimatorUtils`
class AnimatorUtils extends jni.JObject {
  @override
  late final jni.JObjType<AnimatorUtils> $type = type;

  AnimatorUtils.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/utils/AnimatorUtils');

  /// The type which includes information such as the signature of this class.
  static const type = $AnimatorUtilsType();
  static final _id_new0 = _class.constructorId(
    r'()V',
  );

  static final _new0 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public void <init>()`
  /// The returned object must be released after use, by calling the [release] method.
  factory AnimatorUtils() {
    return AnimatorUtils.fromReference(
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr)
            .reference);
  }

  static final _id_animate = _class.staticMethodId(
    r'animate',
    r'(Landroid/view/View;ILorg/maplibre/android/utils/AnimatorUtils$OnAnimationEndListener;)V',
  );

  static final _animate = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        $Int32,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, int, ffi.Pointer<ffi.Void>)>();

  /// from: `static public void animate(android.view.View view, int i, org.maplibre.android.utils.AnimatorUtils$OnAnimationEndListener onAnimationEndListener)`
  static void animate(
    jni.JObject view,
    int i,
    AnimatorUtils_OnAnimationEndListener onAnimationEndListener,
  ) {
    _animate(_class.reference.pointer, _id_animate as jni.JMethodIDPtr,
            view.reference.pointer, i, onAnimationEndListener.reference.pointer)
        .check();
  }

  static final _id_animate1 = _class.staticMethodId(
    r'animate',
    r'(Landroid/view/View;IILorg/maplibre/android/utils/AnimatorUtils$OnAnimationEndListener;)V',
  );

  static final _animate1 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        $Int32,
                        $Int32,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, int, int, ffi.Pointer<ffi.Void>)>();

  /// from: `static public void animate(android.view.View view, int i, int i1, org.maplibre.android.utils.AnimatorUtils$OnAnimationEndListener onAnimationEndListener)`
  static void animate1(
    jni.JObject view,
    int i,
    int i1,
    AnimatorUtils_OnAnimationEndListener onAnimationEndListener,
  ) {
    _animate1(
            _class.reference.pointer,
            _id_animate1 as jni.JMethodIDPtr,
            view.reference.pointer,
            i,
            i1,
            onAnimationEndListener.reference.pointer)
        .check();
  }

  static final _id_animate2 = _class.staticMethodId(
    r'animate',
    r'(Landroid/view/View;I)V',
  );

  static final _animate2 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>, $Int32)>)>>(
          'globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, int)>();

  /// from: `static public void animate(android.view.View view, int i)`
  static void animate2(
    jni.JObject view,
    int i,
  ) {
    _animate2(_class.reference.pointer, _id_animate2 as jni.JMethodIDPtr,
            view.reference.pointer, i)
        .check();
  }

  static final _id_animate3 = _class.staticMethodId(
    r'animate',
    r'(Landroid/view/View;II)V',
  );

  static final _animate3 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>, $Int32, $Int32)>)>>(
          'globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, int, int)>();

  /// from: `static public void animate(android.view.View view, int i, int i1)`
  static void animate3(
    jni.JObject view,
    int i,
    int i1,
  ) {
    _animate3(_class.reference.pointer, _id_animate3 as jni.JMethodIDPtr,
            view.reference.pointer, i, i1)
        .check();
  }

  static final _id_rotate = _class.staticMethodId(
    r'rotate',
    r'(Landroid/view/View;F)V',
  );

  static final _rotate = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>, ffi.Double)>)>>(
          'globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, double)>();

  /// from: `static public void rotate(android.view.View view, float f)`
  static void rotate(
    jni.JObject view,
    double f,
  ) {
    _rotate(_class.reference.pointer, _id_rotate as jni.JMethodIDPtr,
            view.reference.pointer, f)
        .check();
  }

  static final _id_rotateBy = _class.staticMethodId(
    r'rotateBy',
    r'(Landroid/view/View;F)V',
  );

  static final _rotateBy = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>, ffi.Double)>)>>(
          'globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, double)>();

  /// from: `static public void rotateBy(android.view.View view, float f)`
  static void rotateBy(
    jni.JObject view,
    double f,
  ) {
    _rotateBy(_class.reference.pointer, _id_rotateBy as jni.JMethodIDPtr,
            view.reference.pointer, f)
        .check();
  }

  static final _id_alpha = _class.staticMethodId(
    r'alpha',
    r'(Landroid/view/View;FLorg/maplibre/android/utils/AnimatorUtils$OnAnimationEndListener;)V',
  );

  static final _alpha = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Double,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, double, ffi.Pointer<ffi.Void>)>();

  /// from: `static public void alpha(android.view.View view, float f, org.maplibre.android.utils.AnimatorUtils$OnAnimationEndListener onAnimationEndListener)`
  static void alpha(
    jni.JObject view,
    double f,
    AnimatorUtils_OnAnimationEndListener onAnimationEndListener,
  ) {
    _alpha(_class.reference.pointer, _id_alpha as jni.JMethodIDPtr,
            view.reference.pointer, f, onAnimationEndListener.reference.pointer)
        .check();
  }

  static final _id_alpha1 = _class.staticMethodId(
    r'alpha',
    r'(Landroid/view/View;F)V',
  );

  static final _alpha1 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>, ffi.Double)>)>>(
          'globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, double)>();

  /// from: `static public void alpha(android.view.View view, float f)`
  static void alpha1(
    jni.JObject view,
    double f,
  ) {
    _alpha1(_class.reference.pointer, _id_alpha1 as jni.JMethodIDPtr,
            view.reference.pointer, f)
        .check();
  }
}

final class $AnimatorUtilsType extends jni.JObjType<AnimatorUtils> {
  const $AnimatorUtilsType();

  @override
  String get signature => r'Lorg/maplibre/android/utils/AnimatorUtils;';

  @override
  AnimatorUtils fromReference(jni.JReference reference) =>
      AnimatorUtils.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($AnimatorUtilsType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($AnimatorUtilsType) &&
        other is $AnimatorUtilsType;
  }
}
