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

/// from: `org.maplibre.android.style.sources.Source`
class Source extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<Source> $type;

  @jni$_.internal
  Source.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/style/sources/Source');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $Source$NullableType();
  static const type = $Source$Type();
  static final _id_getId = _class.instanceMethodId(
    r'getId',
    r'()Ljava/lang/String;',
  );

  static final _getId = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getId()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getId() {
    return _getId(reference.pointer, _id_getId as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getAttribution = _class.instanceMethodId(
    r'getAttribution',
    r'()Ljava/lang/String;',
  );

  static final _getAttribution = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getAttribution()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getAttribution() {
    return _getAttribution(
            reference.pointer, _id_getAttribution as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getPrefetchZoomDelta = _class.instanceMethodId(
    r'getPrefetchZoomDelta',
    r'()Ljava/lang/Integer;',
  );

  static final _getPrefetchZoomDelta = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.Integer getPrefetchZoomDelta()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JInteger? getPrefetchZoomDelta() {
    return _getPrefetchZoomDelta(
            reference.pointer, _id_getPrefetchZoomDelta as jni$_.JMethodIDPtr)
        .object<jni$_.JInteger?>(const jni$_.JIntegerNullableType());
  }

  static final _id_setPrefetchZoomDelta = _class.instanceMethodId(
    r'setPrefetchZoomDelta',
    r'(Ljava/lang/Integer;)V',
  );

  static final _setPrefetchZoomDelta = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void setPrefetchZoomDelta(java.lang.Integer integer)`
  void setPrefetchZoomDelta(
    jni$_.JInteger? integer,
  ) {
    final _$integer = integer?.reference ?? jni$_.jNullReference;
    _setPrefetchZoomDelta(reference.pointer,
            _id_setPrefetchZoomDelta as jni$_.JMethodIDPtr, _$integer.pointer)
        .check();
  }

  static final _id_setMaxOverscaleFactorForParentTiles =
      _class.instanceMethodId(
    r'setMaxOverscaleFactorForParentTiles',
    r'(Ljava/lang/Integer;)V',
  );

  static final _setMaxOverscaleFactorForParentTiles =
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

  /// from: `public void setMaxOverscaleFactorForParentTiles(java.lang.Integer integer)`
  void setMaxOverscaleFactorForParentTiles(
    jni$_.JInteger? integer,
  ) {
    final _$integer = integer?.reference ?? jni$_.jNullReference;
    _setMaxOverscaleFactorForParentTiles(
            reference.pointer,
            _id_setMaxOverscaleFactorForParentTiles as jni$_.JMethodIDPtr,
            _$integer.pointer)
        .check();
  }

  static final _id_getMaxOverscaleFactorForParentTiles =
      _class.instanceMethodId(
    r'getMaxOverscaleFactorForParentTiles',
    r'()Ljava/lang/Integer;',
  );

  static final _getMaxOverscaleFactorForParentTiles =
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

  /// from: `public java.lang.Integer getMaxOverscaleFactorForParentTiles()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JInteger? getMaxOverscaleFactorForParentTiles() {
    return _getMaxOverscaleFactorForParentTiles(reference.pointer,
            _id_getMaxOverscaleFactorForParentTiles as jni$_.JMethodIDPtr)
        .object<jni$_.JInteger?>(const jni$_.JIntegerNullableType());
  }

  static final _id_isVolatile = _class.instanceMethodId(
    r'isVolatile',
    r'()Ljava/lang/Boolean;',
  );

  static final _isVolatile = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.Boolean isVolatile()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JBoolean? isVolatile() {
    return _isVolatile(reference.pointer, _id_isVolatile as jni$_.JMethodIDPtr)
        .object<jni$_.JBoolean?>(const jni$_.JBooleanNullableType());
  }

  static final _id_setVolatile = _class.instanceMethodId(
    r'setVolatile',
    r'(Ljava/lang/Boolean;)V',
  );

  static final _setVolatile = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void setVolatile(java.lang.Boolean boolean)`
  void setVolatile(
    jni$_.JBoolean? boolean,
  ) {
    final _$boolean = boolean?.reference ?? jni$_.jNullReference;
    _setVolatile(reference.pointer, _id_setVolatile as jni$_.JMethodIDPtr,
            _$boolean.pointer)
        .check();
  }

  static final _id_setMinimumTileUpdateInterval = _class.instanceMethodId(
    r'setMinimumTileUpdateInterval',
    r'(Ljava/lang/Long;)V',
  );

  static final _setMinimumTileUpdateInterval =
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

  /// from: `public void setMinimumTileUpdateInterval(java.lang.Long long)`
  void setMinimumTileUpdateInterval(
    jni$_.JLong? long,
  ) {
    final _$long = long?.reference ?? jni$_.jNullReference;
    _setMinimumTileUpdateInterval(
            reference.pointer,
            _id_setMinimumTileUpdateInterval as jni$_.JMethodIDPtr,
            _$long.pointer)
        .check();
  }

  static final _id_getMinimumTileUpdateInterval = _class.instanceMethodId(
    r'getMinimumTileUpdateInterval',
    r'()Ljava/lang/Long;',
  );

  static final _getMinimumTileUpdateInterval =
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

  /// from: `public java.lang.Long getMinimumTileUpdateInterval()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JLong? getMinimumTileUpdateInterval() {
    return _getMinimumTileUpdateInterval(reference.pointer,
            _id_getMinimumTileUpdateInterval as jni$_.JMethodIDPtr)
        .object<jni$_.JLong?>(const jni$_.JLongNullableType());
  }

  static final _id_getNativePtr = _class.instanceMethodId(
    r'getNativePtr',
    r'()J',
  );

  static final _getNativePtr = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallLongMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public long getNativePtr()`
  int getNativePtr() {
    return _getNativePtr(
            reference.pointer, _id_getNativePtr as jni$_.JMethodIDPtr)
        .long;
  }

  static final _id_setDetached = _class.instanceMethodId(
    r'setDetached',
    r'()V',
  );

  static final _setDetached = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public void setDetached()`
  void setDetached() {
    _setDetached(reference.pointer, _id_setDetached as jni$_.JMethodIDPtr)
        .check();
  }
}

final class $Source$NullableType extends jni$_.JObjType<Source?> {
  @jni$_.internal
  const $Source$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/style/sources/Source;';

  @jni$_.internal
  @core$_.override
  Source? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : Source.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Source?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Source$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Source$NullableType) &&
        other is $Source$NullableType;
  }
}

final class $Source$Type extends jni$_.JObjType<Source> {
  @jni$_.internal
  const $Source$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/style/sources/Source;';

  @jni$_.internal
  @core$_.override
  Source fromReference(jni$_.JReference reference) => Source.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Source?> get nullableType => const $Source$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Source$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Source$Type) && other is $Source$Type;
  }
}