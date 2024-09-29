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

/// from: `org.maplibre.android.location.LocationComponentConstants`
class LocationComponentConstants extends jni.JObject {
  @override
  late final jni.JObjType<LocationComponentConstants> $type = type;

  LocationComponentConstants.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/location/LocationComponentConstants');

  /// The type which includes information such as the signature of this class.
  static const type = $LocationComponentConstantsType();
  static final _id_LOCATION_SOURCE = _class.staticFieldId(
    r'LOCATION_SOURCE',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String LOCATION_SOURCE`
  /// The returned object must be released after use, by calling the [release] method.
  static jni.JString get LOCATION_SOURCE =>
      _id_LOCATION_SOURCE.get(_class, const jni.JStringType());

  static final _id_SHADOW_LAYER = _class.staticFieldId(
    r'SHADOW_LAYER',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String SHADOW_LAYER`
  /// The returned object must be released after use, by calling the [release] method.
  static jni.JString get SHADOW_LAYER =>
      _id_SHADOW_LAYER.get(_class, const jni.JStringType());

  static final _id_FOREGROUND_LAYER = _class.staticFieldId(
    r'FOREGROUND_LAYER',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String FOREGROUND_LAYER`
  /// The returned object must be released after use, by calling the [release] method.
  static jni.JString get FOREGROUND_LAYER =>
      _id_FOREGROUND_LAYER.get(_class, const jni.JStringType());

  static final _id_BACKGROUND_LAYER = _class.staticFieldId(
    r'BACKGROUND_LAYER',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String BACKGROUND_LAYER`
  /// The returned object must be released after use, by calling the [release] method.
  static jni.JString get BACKGROUND_LAYER =>
      _id_BACKGROUND_LAYER.get(_class, const jni.JStringType());

  static final _id_ACCURACY_LAYER = _class.staticFieldId(
    r'ACCURACY_LAYER',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String ACCURACY_LAYER`
  /// The returned object must be released after use, by calling the [release] method.
  static jni.JString get ACCURACY_LAYER =>
      _id_ACCURACY_LAYER.get(_class, const jni.JStringType());

  static final _id_BEARING_LAYER = _class.staticFieldId(
    r'BEARING_LAYER',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String BEARING_LAYER`
  /// The returned object must be released after use, by calling the [release] method.
  static jni.JString get BEARING_LAYER =>
      _id_BEARING_LAYER.get(_class, const jni.JStringType());

  static final _id_PULSING_CIRCLE_LAYER = _class.staticFieldId(
    r'PULSING_CIRCLE_LAYER',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String PULSING_CIRCLE_LAYER`
  /// The returned object must be released after use, by calling the [release] method.
  static jni.JString get PULSING_CIRCLE_LAYER =>
      _id_PULSING_CIRCLE_LAYER.get(_class, const jni.JStringType());
}

final class $LocationComponentConstantsType
    extends jni.JObjType<LocationComponentConstants> {
  const $LocationComponentConstantsType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/location/LocationComponentConstants;';

  @override
  LocationComponentConstants fromReference(jni.JReference reference) =>
      LocationComponentConstants.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($LocationComponentConstantsType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($LocationComponentConstantsType) &&
        other is $LocationComponentConstantsType;
  }
}