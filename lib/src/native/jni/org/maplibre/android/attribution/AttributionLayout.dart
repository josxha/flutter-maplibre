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

import '../../../../android/graphics/PointF.dart' as pointf_;

/// from: `org.maplibre.android.attribution.AttributionLayout`
class AttributionLayout extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<AttributionLayout> $type;

  @_$jni.internal
  AttributionLayout.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = _$jni.JClass.forName(
      r'org/maplibre/android/attribution/AttributionLayout');

  /// The type which includes information such as the signature of this class.
  static const type = $AttributionLayout$Type();
  static final _id_new$ = _class.constructorId(
    r'(Landroid/graphics/Bitmap;Landroid/graphics/PointF;Z)V',
  );

  static final _new$ = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Int32
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>,
              int)>();

  /// from: `public void <init>(android.graphics.Bitmap bitmap, android.graphics.PointF pointF, boolean z)`
  /// The returned object must be released after use, by calling the [release] method.
  factory AttributionLayout(
    _$jni.JObject bitmap,
    pointf_.PointF pointF,
    bool z,
  ) {
    return AttributionLayout.fromReference(_new$(
            _class.reference.pointer,
            _id_new$ as _$jni.JMethodIDPtr,
            bitmap.reference.pointer,
            pointF.reference.pointer,
            z ? 1 : 0)
        .reference);
  }

  static final _id_getLogo = _class.instanceMethodId(
    r'getLogo',
    r'()Landroid/graphics/Bitmap;',
  );

  static final _getLogo = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public android.graphics.Bitmap getLogo()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JObject getLogo() {
    return _getLogo(reference.pointer, _id_getLogo as _$jni.JMethodIDPtr)
        .object(const _$jni.JObjectType());
  }

  static final _id_getAnchorPoint = _class.instanceMethodId(
    r'getAnchorPoint',
    r'()Landroid/graphics/PointF;',
  );

  static final _getAnchorPoint = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public android.graphics.PointF getAnchorPoint()`
  /// The returned object must be released after use, by calling the [release] method.
  pointf_.PointF getAnchorPoint() {
    return _getAnchorPoint(
            reference.pointer, _id_getAnchorPoint as _$jni.JMethodIDPtr)
        .object(const pointf_.$PointF$Type());
  }

  static final _id_isShortText = _class.instanceMethodId(
    r'isShortText',
    r'()Z',
  );

  static final _isShortText = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public boolean isShortText()`
  bool isShortText() {
    return _isShortText(
            reference.pointer, _id_isShortText as _$jni.JMethodIDPtr)
        .boolean;
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
}

final class $AttributionLayout$Type extends _$jni.JObjType<AttributionLayout> {
  @_$jni.internal
  const $AttributionLayout$Type();

  @_$jni.internal
  @_$core.override
  String get signature =>
      r'Lorg/maplibre/android/attribution/AttributionLayout;';

  @_$jni.internal
  @_$core.override
  AttributionLayout fromReference(_$jni.JReference reference) =>
      AttributionLayout.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode => ($AttributionLayout$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($AttributionLayout$Type) &&
        other is $AttributionLayout$Type;
  }
}
