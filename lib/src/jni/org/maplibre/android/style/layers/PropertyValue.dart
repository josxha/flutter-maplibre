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

/// from: `org.maplibre.android.style.layers.PropertyValue`
class PropertyValue<$T extends _$jni.JObject> extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<PropertyValue<$T>> $type;

  @_$jni.internal
  final _$jni.JObjType<$T> T;

  @_$jni.internal
  PropertyValue.fromReference(
    this.T,
    _$jni.JReference reference,
  )   : $type = type(T),
        super.fromReference(reference);

  static final _class =
      _$jni.JClass.forName(r'org/maplibre/android/style/layers/PropertyValue');

  /// The type which includes information such as the signature of this class.
  static $PropertyValue$Type<$T> type<$T extends _$jni.JObject>(
    _$jni.JObjType<$T> T,
  ) {
    return $PropertyValue$Type(
      T,
    );
  }

  static final _id_name = _class.instanceFieldId(
    r'name',
    r'Ljava/lang/String;',
  );

  /// from: `public final java.lang.String name`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JString get name => _id_name.get(this, const _$jni.JStringType());

  static final _id_value = _class.instanceFieldId(
    r'value',
    r'Ljava/lang/Object;',
  );

  /// from: `public final T value`
  /// The returned object must be released after use, by calling the [release] method.
  $T get value => _id_value.get(this, T);

  static final _id_new$ = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/Object;)V',
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

  /// from: `public void <init>(java.lang.String string, T object)`
  /// The returned object must be released after use, by calling the [release] method.
  factory PropertyValue(
    _$jni.JString string,
    $T object, {
    _$jni.JObjType<$T>? T,
  }) {
    T ??= _$jni.lowestCommonSuperType([
      object.$type,
    ]) as _$jni.JObjType<$T>;
    return PropertyValue.fromReference(
        T,
        _new$(_class.reference.pointer, _id_new$ as _$jni.JMethodIDPtr,
                string.reference.pointer, object.reference.pointer)
            .reference);
  }

  static final _id_isNull$1 = _class.instanceMethodId(
    r'isNull',
    r'()Z',
  );

  static final _isNull$1 = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallBooleanMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public boolean isNull()`
  bool isNull$1() {
    return _isNull$1(reference.pointer, _id_isNull$1 as _$jni.JMethodIDPtr)
        .boolean;
  }

  static final _id_isExpression = _class.instanceMethodId(
    r'isExpression',
    r'()Z',
  );

  static final _isExpression = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallBooleanMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public boolean isExpression()`
  bool isExpression() {
    return _isExpression(
            reference.pointer, _id_isExpression as _$jni.JMethodIDPtr)
        .boolean;
  }

  static final _id_getExpression = _class.instanceMethodId(
    r'getExpression',
    r'()Lorg/maplibre/android/style/expressions/Expression;',
  );

  static final _getExpression = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.style.expressions.Expression getExpression()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JObject getExpression() {
    return _getExpression(
            reference.pointer, _id_getExpression as _$jni.JMethodIDPtr)
        .object(const _$jni.JObjectType());
  }

  static final _id_isValue = _class.instanceMethodId(
    r'isValue',
    r'()Z',
  );

  static final _isValue = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallBooleanMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public boolean isValue()`
  bool isValue() {
    return _isValue(reference.pointer, _id_isValue as _$jni.JMethodIDPtr)
        .boolean;
  }

  static final _id_getValue = _class.instanceMethodId(
    r'getValue',
    r'()Ljava/lang/Object;',
  );

  static final _getValue = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public T getValue()`
  /// The returned object must be released after use, by calling the [release] method.
  $T getValue() {
    return _getValue(reference.pointer, _id_getValue as _$jni.JMethodIDPtr)
        .object(T);
  }

  static final _id_getColorInt = _class.instanceMethodId(
    r'getColorInt',
    r'()Ljava/lang/Integer;',
  );

  static final _getColorInt = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.Integer getColorInt()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JInteger getColorInt() {
    return _getColorInt(
            reference.pointer, _id_getColorInt as _$jni.JMethodIDPtr)
        .object(const _$jni.JIntegerType());
  }

  static final _id_toString$1 = _class.instanceMethodId(
    r'toString',
    r'()Ljava/lang/String;',
  );

  static final _toString$1 = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String toString()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JString toString$1() {
    return _toString$1(reference.pointer, _id_toString$1 as _$jni.JMethodIDPtr)
        .object(const _$jni.JStringType());
  }

  static final _id_equals = _class.instanceMethodId(
    r'equals',
    r'(Ljava/lang/Object;)Z',
  );

  static final _equals = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallBooleanMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public boolean equals(java.lang.Object object)`
  bool equals(
    _$jni.JObject object,
  ) {
    return _equals(reference.pointer, _id_equals as _$jni.JMethodIDPtr,
            object.reference.pointer)
        .boolean;
  }

  static final _id_hashCode$1 = _class.instanceMethodId(
    r'hashCode',
    r'()I',
  );

  static final _hashCode$1 = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public int hashCode()`
  int hashCode$1() {
    return _hashCode$1(reference.pointer, _id_hashCode$1 as _$jni.JMethodIDPtr)
        .integer;
  }
}

final class $PropertyValue$Type<$T extends _$jni.JObject>
    extends _$jni.JObjType<PropertyValue<$T>> {
  @_$jni.internal
  final _$jni.JObjType<$T> T;

  @_$jni.internal
  const $PropertyValue$Type(
    this.T,
  );

  @_$jni.internal
  @_$core.override
  String get signature => r'Lorg/maplibre/android/style/layers/PropertyValue;';

  @_$jni.internal
  @_$core.override
  PropertyValue<$T> fromReference(_$jni.JReference reference) =>
      PropertyValue.fromReference(T, reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode => Object.hash($PropertyValue$Type, T);

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($PropertyValue$Type<$T>) &&
        other is $PropertyValue$Type<$T> &&
        T == other.T;
  }
}
