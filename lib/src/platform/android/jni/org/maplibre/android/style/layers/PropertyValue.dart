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

/// from: `org.maplibre.android.style.layers.PropertyValue`
class PropertyValue<$T extends jni$_.JObject?> extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<PropertyValue<$T>> $type;

  @jni$_.internal
  final jni$_.JObjType<$T> T;

  @jni$_.internal
  PropertyValue.fromReference(
    this.T,
    jni$_.JReference reference,
  )   : $type = type<$T>(T),
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/style/layers/PropertyValue');

  /// The type which includes information such as the signature of this class.
  static $PropertyValue$NullableType<$T>
      nullableType<$T extends jni$_.JObject?>(
    jni$_.JObjType<$T> T,
  ) {
    return $PropertyValue$NullableType<$T>(
      T,
    );
  }

  static $PropertyValue$Type<$T> type<$T extends jni$_.JObject?>(
    jni$_.JObjType<$T> T,
  ) {
    return $PropertyValue$Type<$T>(
      T,
    );
  }

  static final _id_name = _class.instanceFieldId(
    r'name',
    r'Ljava/lang/String;',
  );

  /// from: `public final java.lang.String name`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? get name =>
      _id_name.get(this, const jni$_.JStringNullableType());

  static final _id_value = _class.instanceFieldId(
    r'value',
    r'Ljava/lang/Object;',
  );

  /// from: `public final T value`
  /// The returned object must be released after use, by calling the [release] method.
  $T? get value => _id_value.get(this, T.nullableType);

  static final _id_new$ = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/Object;)V',
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

  /// from: `public void <init>(java.lang.String string, T object)`
  /// The returned object must be released after use, by calling the [release] method.
  factory PropertyValue(
    jni$_.JString? string,
    $T? object, {
    required jni$_.JObjType<$T> T,
  }) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$object = object?.reference ?? jni$_.jNullReference;
    return PropertyValue<$T>.fromReference(
        T,
        _new$(_class.reference.pointer, _id_new$ as jni$_.JMethodIDPtr,
                _$string.pointer, _$object.pointer)
            .reference);
  }

  static final _id_isNull$1 = _class.instanceMethodId(
    r'isNull',
    r'()Z',
  );

  static final _isNull$1 = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public boolean isNull()`
  bool isNull$1() {
    return _isNull$1(reference.pointer, _id_isNull$1 as jni$_.JMethodIDPtr)
        .boolean;
  }

  static final _id_isExpression = _class.instanceMethodId(
    r'isExpression',
    r'()Z',
  );

  static final _isExpression = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public boolean isExpression()`
  bool isExpression() {
    return _isExpression(
            reference.pointer, _id_isExpression as jni$_.JMethodIDPtr)
        .boolean;
  }

  static final _id_getExpression = _class.instanceMethodId(
    r'getExpression',
    r'()Lorg/maplibre/android/style/expressions/Expression;',
  );

  static final _getExpression = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.expressions.Expression getExpression()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JObject? getExpression() {
    return _getExpression(
            reference.pointer, _id_getExpression as jni$_.JMethodIDPtr)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_isValue = _class.instanceMethodId(
    r'isValue',
    r'()Z',
  );

  static final _isValue = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public boolean isValue()`
  bool isValue() {
    return _isValue(reference.pointer, _id_isValue as jni$_.JMethodIDPtr)
        .boolean;
  }

  static final _id_getValue = _class.instanceMethodId(
    r'getValue',
    r'()Ljava/lang/Object;',
  );

  static final _getValue = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public T getValue()`
  /// The returned object must be released after use, by calling the [release] method.
  $T? getValue() {
    return _getValue(reference.pointer, _id_getValue as jni$_.JMethodIDPtr)
        .object<$T?>(T.nullableType);
  }

  static final _id_getColorInt = _class.instanceMethodId(
    r'getColorInt',
    r'()Ljava/lang/Integer;',
  );

  static final _getColorInt = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.Integer getColorInt()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JInteger? getColorInt() {
    return _getColorInt(
            reference.pointer, _id_getColorInt as jni$_.JMethodIDPtr)
        .object<jni$_.JInteger?>(const jni$_.JIntegerNullableType());
  }

  static final _id_toString$1 = _class.instanceMethodId(
    r'toString',
    r'()Ljava/lang/String;',
  );

  static final _toString$1 = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String toString()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? toString$1() {
    return _toString$1(reference.pointer, _id_toString$1 as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_equals = _class.instanceMethodId(
    r'equals',
    r'(Ljava/lang/Object;)Z',
  );

  static final _equals = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallBooleanMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public boolean equals(java.lang.Object object)`
  bool equals(
    jni$_.JObject? object,
  ) {
    final _$object = object?.reference ?? jni$_.jNullReference;
    return _equals(reference.pointer, _id_equals as jni$_.JMethodIDPtr,
            _$object.pointer)
        .boolean;
  }

  static final _id_hashCode$1 = _class.instanceMethodId(
    r'hashCode',
    r'()I',
  );

  static final _hashCode$1 = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public int hashCode()`
  int hashCode$1() {
    return _hashCode$1(reference.pointer, _id_hashCode$1 as jni$_.JMethodIDPtr)
        .integer;
  }
}

final class $PropertyValue$NullableType<$T extends jni$_.JObject?>
    extends jni$_.JObjType<PropertyValue<$T>?> {
  @jni$_.internal
  final jni$_.JObjType<$T> T;

  @jni$_.internal
  const $PropertyValue$NullableType(
    this.T,
  );

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/style/layers/PropertyValue;';

  @jni$_.internal
  @core$_.override
  PropertyValue<$T>? fromReference(jni$_.JReference reference) =>
      reference.isNull
          ? null
          : PropertyValue<$T>.fromReference(
              T,
              reference,
            );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<PropertyValue<$T>?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => Object.hash($PropertyValue$NullableType, T);

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($PropertyValue$NullableType<$T>) &&
        other is $PropertyValue$NullableType<$T> &&
        T == other.T;
  }
}

final class $PropertyValue$Type<$T extends jni$_.JObject?>
    extends jni$_.JObjType<PropertyValue<$T>> {
  @jni$_.internal
  final jni$_.JObjType<$T> T;

  @jni$_.internal
  const $PropertyValue$Type(
    this.T,
  );

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/style/layers/PropertyValue;';

  @jni$_.internal
  @core$_.override
  PropertyValue<$T> fromReference(jni$_.JReference reference) =>
      PropertyValue<$T>.fromReference(
        T,
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<PropertyValue<$T>?> get nullableType =>
      $PropertyValue$NullableType<$T>(T);

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => Object.hash($PropertyValue$Type, T);

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($PropertyValue$Type<$T>) &&
        other is $PropertyValue$Type<$T> &&
        T == other.T;
  }
}
