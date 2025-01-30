// Autogenerated by jnigen. DO NOT EDIT!

// ignore_for_file: document_ignores
// ignore_for_file: avoid_catches_without_on_clauses
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

import '../MapLibreMap.dart' as maplibremap$_;

/// from: `org.maplibre.android.maps.widgets.CompassView`
class CompassView extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<CompassView> $type;

  @jni$_.internal
  CompassView.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/maps/widgets/CompassView');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $CompassView$NullableType();
  static const type = $CompassView$Type();

  /// from: `static public final long TIME_WAIT_IDLE`
  static const TIME_WAIT_IDLE = 500;

  /// from: `static public final long TIME_MAP_NORTH_ANIMATION`
  static const TIME_MAP_NORTH_ANIMATION = 150;
  static final _id_new$ = _class.constructorId(
    r'(Landroid/content/Context;)V',
  );

  static final _new$ = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void <init>(android.content.Context context)`
  /// The returned object must be released after use, by calling the [release] method.
  factory CompassView(
    jni$_.JObject context,
  ) {
    final _$context = context.reference;
    return CompassView.fromReference(_new$(_class.reference.pointer,
            _id_new$ as jni$_.JMethodIDPtr, _$context.pointer)
        .reference);
  }

  static final _id_new$1 = _class.constructorId(
    r'(Landroid/content/Context;Landroid/util/AttributeSet;)V',
  );

  static final _new$1 = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public void <init>(android.content.Context context, android.util.AttributeSet attributeSet)`
  /// The returned object must be released after use, by calling the [release] method.
  factory CompassView.new$1(
    jni$_.JObject context,
    jni$_.JObject? attributeSet,
  ) {
    final _$context = context.reference;
    final _$attributeSet = attributeSet?.reference ?? jni$_.jNullReference;
    return CompassView.fromReference(_new$1(
            _class.reference.pointer,
            _id_new$1 as jni$_.JMethodIDPtr,
            _$context.pointer,
            _$attributeSet.pointer)
        .reference);
  }

  static final _id_new$2 = _class.constructorId(
    r'(Landroid/content/Context;Landroid/util/AttributeSet;I)V',
  );

  static final _new$2 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Int32
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              int)>();

  /// from: `public void <init>(android.content.Context context, android.util.AttributeSet attributeSet, int i)`
  /// The returned object must be released after use, by calling the [release] method.
  factory CompassView.new$2(
    jni$_.JObject context,
    jni$_.JObject? attributeSet,
    int i,
  ) {
    final _$context = context.reference;
    final _$attributeSet = attributeSet?.reference ?? jni$_.jNullReference;
    return CompassView.fromReference(_new$2(
            _class.reference.pointer,
            _id_new$2 as jni$_.JMethodIDPtr,
            _$context.pointer,
            _$attributeSet.pointer,
            i)
        .reference);
  }

  static final _id_injectCompassAnimationListener = _class.instanceMethodId(
    r'injectCompassAnimationListener',
    r'(Lorg/maplibre/android/maps/MapLibreMap$OnCompassAnimationListener;)V',
  );

  static final _injectCompassAnimationListener =
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

  /// from: `public void injectCompassAnimationListener(org.maplibre.android.maps.MapLibreMap$OnCompassAnimationListener onCompassAnimationListener)`
  void injectCompassAnimationListener(
    maplibremap$_.MapLibreMap$OnCompassAnimationListener
        onCompassAnimationListener,
  ) {
    final _$onCompassAnimationListener = onCompassAnimationListener.reference;
    _injectCompassAnimationListener(
            reference.pointer,
            _id_injectCompassAnimationListener as jni$_.JMethodIDPtr,
            _$onCompassAnimationListener.pointer)
        .check();
  }

  static final _id_isAnimating = _class.instanceMethodId(
    r'isAnimating',
    r'(Z)V',
  );

  static final _isAnimating = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<(jni$_.Int32,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, int)>();

  /// from: `public void isAnimating(boolean z)`
  void isAnimating(
    bool z,
  ) {
    _isAnimating(
            reference.pointer, _id_isAnimating as jni$_.JMethodIDPtr, z ? 1 : 0)
        .check();
  }

  static final _id_resetAnimation = _class.instanceMethodId(
    r'resetAnimation',
    r'()V',
  );

  static final _resetAnimation = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public void resetAnimation()`
  void resetAnimation() {
    _resetAnimation(reference.pointer, _id_resetAnimation as jni$_.JMethodIDPtr)
        .check();
  }

  static final _id_isHidden = _class.instanceMethodId(
    r'isHidden',
    r'()Z',
  );

  static final _isHidden = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallBooleanMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public boolean isHidden()`
  bool isHidden() {
    return _isHidden(reference.pointer, _id_isHidden as jni$_.JMethodIDPtr)
        .boolean;
  }

  static final _id_isFacingNorth = _class.instanceMethodId(
    r'isFacingNorth',
    r'()Z',
  );

  static final _isFacingNorth = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallBooleanMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public boolean isFacingNorth()`
  bool isFacingNorth() {
    return _isFacingNorth(
            reference.pointer, _id_isFacingNorth as jni$_.JMethodIDPtr)
        .boolean;
  }

  static final _id_setEnabled = _class.instanceMethodId(
    r'setEnabled',
    r'(Z)V',
  );

  static final _setEnabled = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<(jni$_.Int32,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, int)>();

  /// from: `public void setEnabled(boolean z)`
  void setEnabled(
    bool z,
  ) {
    _setEnabled(
            reference.pointer, _id_setEnabled as jni$_.JMethodIDPtr, z ? 1 : 0)
        .check();
  }

  static final _id_update = _class.instanceMethodId(
    r'update',
    r'(D)V',
  );

  static final _update = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<(jni$_.Double,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, double)>();

  /// from: `public void update(double d)`
  void update(
    double d,
  ) {
    _update(reference.pointer, _id_update as jni$_.JMethodIDPtr, d).check();
  }

  static final _id_fadeCompassViewFacingNorth = _class.instanceMethodId(
    r'fadeCompassViewFacingNorth',
    r'(Z)V',
  );

  static final _fadeCompassViewFacingNorth =
      jni$_.ProtectedJniExtensions.lookup<
                  jni$_.NativeFunction<
                      jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
                          jni$_.JMethodIDPtr, jni$_.VarArgs<(jni$_.Int32,)>)>>(
              'globalEnv_CallVoidMethod')
          .asFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, int)>();

  /// from: `public void fadeCompassViewFacingNorth(boolean z)`
  void fadeCompassViewFacingNorth(
    bool z,
  ) {
    _fadeCompassViewFacingNorth(reference.pointer,
            _id_fadeCompassViewFacingNorth as jni$_.JMethodIDPtr, z ? 1 : 0)
        .check();
  }

  static final _id_isFadeCompassViewFacingNorth = _class.instanceMethodId(
    r'isFadeCompassViewFacingNorth',
    r'()Z',
  );

  static final _isFadeCompassViewFacingNorth =
      jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.JMethodIDPtr,
                  )>>('globalEnv_CallBooleanMethod')
          .asFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>();

  /// from: `public boolean isFadeCompassViewFacingNorth()`
  bool isFadeCompassViewFacingNorth() {
    return _isFadeCompassViewFacingNorth(reference.pointer,
            _id_isFadeCompassViewFacingNorth as jni$_.JMethodIDPtr)
        .boolean;
  }

  static final _id_setCompassImage = _class.instanceMethodId(
    r'setCompassImage',
    r'(Landroid/graphics/drawable/Drawable;)V',
  );

  static final _setCompassImage = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void setCompassImage(android.graphics.drawable.Drawable drawable)`
  void setCompassImage(
    jni$_.JObject? drawable,
  ) {
    final _$drawable = drawable?.reference ?? jni$_.jNullReference;
    _setCompassImage(reference.pointer,
            _id_setCompassImage as jni$_.JMethodIDPtr, _$drawable.pointer)
        .check();
  }

  static final _id_getCompassImage = _class.instanceMethodId(
    r'getCompassImage',
    r'()Landroid/graphics/drawable/Drawable;',
  );

  static final _getCompassImage = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public android.graphics.drawable.Drawable getCompassImage()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JObject? getCompassImage() {
    return _getCompassImage(
            reference.pointer, _id_getCompassImage as jni$_.JMethodIDPtr)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_run = _class.instanceMethodId(
    r'run',
    r'()V',
  );

  static final _run = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public void run()`
  void run() {
    _run(reference.pointer, _id_run as jni$_.JMethodIDPtr).check();
  }
}

final class $CompassView$NullableType extends jni$_.JObjType<CompassView?> {
  @jni$_.internal
  const $CompassView$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/maps/widgets/CompassView;';

  @jni$_.internal
  @core$_.override
  CompassView? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : CompassView.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<CompassView?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($CompassView$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($CompassView$NullableType) &&
        other is $CompassView$NullableType;
  }
}

final class $CompassView$Type extends jni$_.JObjType<CompassView> {
  @jni$_.internal
  const $CompassView$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/maps/widgets/CompassView;';

  @jni$_.internal
  @core$_.override
  CompassView fromReference(jni$_.JReference reference) =>
      CompassView.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<CompassView?> get nullableType =>
      const $CompassView$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($CompassView$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($CompassView$Type) &&
        other is $CompassView$Type;
  }
}
