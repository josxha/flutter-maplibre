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

/// from: `org.maplibre.android.location.MapLibreAnimator`
class MapLibreAnimator<$K extends _$jni.JObject> extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<MapLibreAnimator<$K>> $type;

  @_$jni.internal
  final _$jni.JObjType<$K> K;

  @_$jni.internal
  MapLibreAnimator.fromReference(
    this.K,
    _$jni.JReference reference,
  )   : $type = type(K),
        super.fromReference(reference);

  static final _class =
      _$jni.JClass.forName(r'org/maplibre/android/location/MapLibreAnimator');

  /// The type which includes information such as the signature of this class.
  static $MapLibreAnimator$Type<$K> type<$K extends _$jni.JObject>(
    _$jni.JObjType<$K> K,
  ) {
    return $MapLibreAnimator$Type(
      K,
    );
  }

  static final _id_onAnimationUpdate = _class.instanceMethodId(
    r'onAnimationUpdate',
    r'(Landroid/animation/ValueAnimator;)V',
  );

  static final _onAnimationUpdate = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void onAnimationUpdate(android.animation.ValueAnimator valueAnimator)`
  void onAnimationUpdate(
    _$jni.JObject valueAnimator,
  ) {
    _onAnimationUpdate(
            reference.pointer,
            _id_onAnimationUpdate as _$jni.JMethodIDPtr,
            valueAnimator.reference.pointer)
        .check();
  }

  static final _id_makeInvalid = _class.instanceMethodId(
    r'makeInvalid',
    r'()V',
  );

  static final _makeInvalid = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JThrowablePtr Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public void makeInvalid()`
  void makeInvalid() {
    _makeInvalid(reference.pointer, _id_makeInvalid as _$jni.JMethodIDPtr)
        .check();
  }
}

final class $MapLibreAnimator$Type<$K extends _$jni.JObject>
    extends _$jni.JObjType<MapLibreAnimator<$K>> {
  @_$jni.internal
  final _$jni.JObjType<$K> K;

  @_$jni.internal
  const $MapLibreAnimator$Type(
    this.K,
  );

  @_$jni.internal
  @_$core.override
  String get signature => r'Lorg/maplibre/android/location/MapLibreAnimator;';

  @_$jni.internal
  @_$core.override
  MapLibreAnimator<$K> fromReference(_$jni.JReference reference) =>
      MapLibreAnimator.fromReference(K, reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode => Object.hash($MapLibreAnimator$Type, K);

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapLibreAnimator$Type<$K>) &&
        other is $MapLibreAnimator$Type<$K> &&
        K == other.K;
  }
}
