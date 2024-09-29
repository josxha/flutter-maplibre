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

/// from: `org.maplibre.android.constants.GeometryConstants`
class GeometryConstants extends jni.JObject {
  @override
  late final jni.JObjType<GeometryConstants> $type = type;

  GeometryConstants.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/constants/GeometryConstants');

  /// The type which includes information such as the signature of this class.
  static const type = $GeometryConstantsType();

  /// from: `static public final int RADIUS_EARTH_METERS`
  static const RADIUS_EARTH_METERS = 6378137;

  /// from: `static public final double MIN_WRAP_LONGITUDE`
  static const MIN_WRAP_LONGITUDE = -180.0;

  /// from: `static public final double MAX_WRAP_LONGITUDE`
  static const MAX_WRAP_LONGITUDE = 180.0;

  /// from: `static public final double MIN_LONGITUDE`
  static const MIN_LONGITUDE = -1.7976931348623157e+308;

  /// from: `static public final double MAX_LONGITUDE`
  static const MAX_LONGITUDE = 1.7976931348623157e+308;

  /// from: `static public final double MIN_LATITUDE`
  static const MIN_LATITUDE = -90.0;

  /// from: `static public final double LATITUDE_SPAN`
  static const LATITUDE_SPAN = 180.0;

  /// from: `static public final double LONGITUDE_SPAN`
  static const LONGITUDE_SPAN = 360.0;

  /// from: `static public final double MAX_LATITUDE`
  static const MAX_LATITUDE = 90.0;

  /// from: `static public final double MAX_MERCATOR_LATITUDE`
  static const MAX_MERCATOR_LATITUDE = 85.05112877980659;

  /// from: `static public final double MIN_MERCATOR_LATITUDE`
  static const MIN_MERCATOR_LATITUDE = -85.05112877980659;
}

final class $GeometryConstantsType extends jni.JObjType<GeometryConstants> {
  const $GeometryConstantsType();

  @override
  String get signature => r'Lorg/maplibre/android/constants/GeometryConstants;';

  @override
  GeometryConstants fromReference(jni.JReference reference) =>
      GeometryConstants.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($GeometryConstantsType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($GeometryConstantsType) &&
        other is $GeometryConstantsType;
  }
}
