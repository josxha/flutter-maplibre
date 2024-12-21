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

/// from: `org.maplibre.android.location.LocationComponentConstants`
class LocationComponentConstants extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<LocationComponentConstants> $type;

  @jni$_.internal
  LocationComponentConstants.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
      r'org/maplibre/android/location/LocationComponentConstants');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $LocationComponentConstants$NullableType();
  static const type = $LocationComponentConstants$Type();
  static final _id_LOCATION_SOURCE = _class.staticFieldId(
    r'LOCATION_SOURCE',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String LOCATION_SOURCE`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get LOCATION_SOURCE =>
      _id_LOCATION_SOURCE.get(_class, const jni$_.JStringNullableType());

  static final _id_SHADOW_LAYER = _class.staticFieldId(
    r'SHADOW_LAYER',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String SHADOW_LAYER`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get SHADOW_LAYER =>
      _id_SHADOW_LAYER.get(_class, const jni$_.JStringNullableType());

  static final _id_FOREGROUND_LAYER = _class.staticFieldId(
    r'FOREGROUND_LAYER',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String FOREGROUND_LAYER`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get FOREGROUND_LAYER =>
      _id_FOREGROUND_LAYER.get(_class, const jni$_.JStringNullableType());

  static final _id_BACKGROUND_LAYER = _class.staticFieldId(
    r'BACKGROUND_LAYER',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String BACKGROUND_LAYER`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get BACKGROUND_LAYER =>
      _id_BACKGROUND_LAYER.get(_class, const jni$_.JStringNullableType());

  static final _id_ACCURACY_LAYER = _class.staticFieldId(
    r'ACCURACY_LAYER',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String ACCURACY_LAYER`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get ACCURACY_LAYER =>
      _id_ACCURACY_LAYER.get(_class, const jni$_.JStringNullableType());

  static final _id_BEARING_LAYER = _class.staticFieldId(
    r'BEARING_LAYER',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String BEARING_LAYER`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get BEARING_LAYER =>
      _id_BEARING_LAYER.get(_class, const jni$_.JStringNullableType());

  static final _id_PULSING_CIRCLE_LAYER = _class.staticFieldId(
    r'PULSING_CIRCLE_LAYER',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String PULSING_CIRCLE_LAYER`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get PULSING_CIRCLE_LAYER =>
      _id_PULSING_CIRCLE_LAYER.get(_class, const jni$_.JStringNullableType());
}

final class $LocationComponentConstants$NullableType
    extends jni$_.JObjType<LocationComponentConstants?> {
  @jni$_.internal
  const $LocationComponentConstants$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/location/LocationComponentConstants;';

  @jni$_.internal
  @core$_.override
  LocationComponentConstants? fromReference(jni$_.JReference reference) =>
      reference.isNull
          ? null
          : LocationComponentConstants.fromReference(
              reference,
            );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<LocationComponentConstants?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($LocationComponentConstants$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LocationComponentConstants$NullableType) &&
        other is $LocationComponentConstants$NullableType;
  }
}

final class $LocationComponentConstants$Type
    extends jni$_.JObjType<LocationComponentConstants> {
  @jni$_.internal
  const $LocationComponentConstants$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/location/LocationComponentConstants;';

  @jni$_.internal
  @core$_.override
  LocationComponentConstants fromReference(jni$_.JReference reference) =>
      LocationComponentConstants.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<LocationComponentConstants?> get nullableType =>
      const $LocationComponentConstants$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($LocationComponentConstants$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LocationComponentConstants$Type) &&
        other is $LocationComponentConstants$Type;
  }
}