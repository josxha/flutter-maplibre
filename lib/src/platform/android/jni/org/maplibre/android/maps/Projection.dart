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

import '../../../../android/graphics/PointF.dart' as pointf$_;

import '../geometry/LatLng.dart' as latlng$_;

import '../geometry/ProjectedMeters.dart' as projectedmeters$_;

import '../geometry/VisibleRegion.dart' as visibleregion$_;

/// from: `org.maplibre.android.maps.Projection`
class Projection extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<Projection> $type;

  @jni$_.internal
  Projection.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/maps/Projection');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $Projection$NullableType();
  static const type = $Projection$Type();
  static final _id_invalidateContentPadding = _class.instanceMethodId(
    r'invalidateContentPadding',
    r'()V',
  );

  static final _invalidateContentPadding = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public void invalidateContentPadding()`
  void invalidateContentPadding() {
    _invalidateContentPadding(reference.pointer,
            _id_invalidateContentPadding as jni$_.JMethodIDPtr)
        .check();
  }

  static final _id_getProjectedMetersForLatLng = _class.instanceMethodId(
    r'getProjectedMetersForLatLng',
    r'(Lorg/maplibre/android/geometry/LatLng;)Lorg/maplibre/android/geometry/ProjectedMeters;',
  );

  static final _getProjectedMetersForLatLng =
      jni$_.ProtectedJniExtensions.lookup<
                  jni$_.NativeFunction<
                      jni$_.JniResult Function(
                          jni$_.Pointer<jni$_.Void>,
                          jni$_.JMethodIDPtr,
                          jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
              'globalEnv_CallObjectMethod')
          .asFunction<
              jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public org.maplibre.android.geometry.ProjectedMeters getProjectedMetersForLatLng(org.maplibre.android.geometry.LatLng latLng)`
  /// The returned object must be released after use, by calling the [release] method.
  projectedmeters$_.ProjectedMeters? getProjectedMetersForLatLng(
    latlng$_.LatLng? latLng,
  ) {
    final _$latLng = latLng?.reference ?? jni$_.jNullReference;
    return _getProjectedMetersForLatLng(
            reference.pointer,
            _id_getProjectedMetersForLatLng as jni$_.JMethodIDPtr,
            _$latLng.pointer)
        .object<projectedmeters$_.ProjectedMeters?>(
            const projectedmeters$_.$ProjectedMeters$NullableType());
  }

  static final _id_getLatLngForProjectedMeters = _class.instanceMethodId(
    r'getLatLngForProjectedMeters',
    r'(Lorg/maplibre/android/geometry/ProjectedMeters;)Lorg/maplibre/android/geometry/LatLng;',
  );

  static final _getLatLngForProjectedMeters =
      jni$_.ProtectedJniExtensions.lookup<
                  jni$_.NativeFunction<
                      jni$_.JniResult Function(
                          jni$_.Pointer<jni$_.Void>,
                          jni$_.JMethodIDPtr,
                          jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
              'globalEnv_CallObjectMethod')
          .asFunction<
              jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public org.maplibre.android.geometry.LatLng getLatLngForProjectedMeters(org.maplibre.android.geometry.ProjectedMeters projectedMeters)`
  /// The returned object must be released after use, by calling the [release] method.
  latlng$_.LatLng? getLatLngForProjectedMeters(
    projectedmeters$_.ProjectedMeters? projectedMeters,
  ) {
    final _$projectedMeters =
        projectedMeters?.reference ?? jni$_.jNullReference;
    return _getLatLngForProjectedMeters(
            reference.pointer,
            _id_getLatLngForProjectedMeters as jni$_.JMethodIDPtr,
            _$projectedMeters.pointer)
        .object<latlng$_.LatLng?>(const latlng$_.$LatLng$NullableType());
  }

  static final _id_getMetersPerPixelAtLatitude = _class.instanceMethodId(
    r'getMetersPerPixelAtLatitude',
    r'(D)D',
  );

  static final _getMetersPerPixelAtLatitude =
      jni$_.ProtectedJniExtensions.lookup<
                  jni$_.NativeFunction<
                      jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
                          jni$_.JMethodIDPtr, jni$_.VarArgs<(jni$_.Double,)>)>>(
              'globalEnv_CallDoubleMethod')
          .asFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, double)>();

  /// from: `public double getMetersPerPixelAtLatitude(double d)`
  double getMetersPerPixelAtLatitude(
    double d,
  ) {
    return _getMetersPerPixelAtLatitude(reference.pointer,
            _id_getMetersPerPixelAtLatitude as jni$_.JMethodIDPtr, d)
        .doubleFloat;
  }

  static final _id_fromScreenLocation = _class.instanceMethodId(
    r'fromScreenLocation',
    r'(Landroid/graphics/PointF;)Lorg/maplibre/android/geometry/LatLng;',
  );

  static final _fromScreenLocation = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public org.maplibre.android.geometry.LatLng fromScreenLocation(android.graphics.PointF pointF)`
  /// The returned object must be released after use, by calling the [release] method.
  latlng$_.LatLng? fromScreenLocation(
    pointf$_.PointF? pointF,
  ) {
    final _$pointF = pointF?.reference ?? jni$_.jNullReference;
    return _fromScreenLocation(reference.pointer,
            _id_fromScreenLocation as jni$_.JMethodIDPtr, _$pointF.pointer)
        .object<latlng$_.LatLng?>(const latlng$_.$LatLng$NullableType());
  }

  static final _id_fromScreenLocations = _class.instanceMethodId(
    r'fromScreenLocations',
    r'([D[D)V',
  );

  static final _fromScreenLocations = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void fromScreenLocations(double[] ds, double[] ds1)`
  void fromScreenLocations(
    jni$_.JDoubleArray? ds,
    jni$_.JDoubleArray? ds1,
  ) {
    final _$ds = ds?.reference ?? jni$_.jNullReference;
    final _$ds1 = ds1?.reference ?? jni$_.jNullReference;
    _fromScreenLocations(
            reference.pointer,
            _id_fromScreenLocations as jni$_.JMethodIDPtr,
            _$ds.pointer,
            _$ds1.pointer)
        .check();
  }

  static final _id_getVisibleRegion = _class.instanceMethodId(
    r'getVisibleRegion',
    r'()Lorg/maplibre/android/geometry/VisibleRegion;',
  );

  static final _getVisibleRegion = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.geometry.VisibleRegion getVisibleRegion()`
  /// The returned object must be released after use, by calling the [release] method.
  visibleregion$_.VisibleRegion? getVisibleRegion() {
    return _getVisibleRegion(
            reference.pointer, _id_getVisibleRegion as jni$_.JMethodIDPtr)
        .object<visibleregion$_.VisibleRegion?>(
            const visibleregion$_.$VisibleRegion$NullableType());
  }

  static final _id_getVisibleRegion$1 = _class.instanceMethodId(
    r'getVisibleRegion',
    r'(Z)Lorg/maplibre/android/geometry/VisibleRegion;',
  );

  static final _getVisibleRegion$1 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<(jni$_.Int32,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, int)>();

  /// from: `public org.maplibre.android.geometry.VisibleRegion getVisibleRegion(boolean z)`
  /// The returned object must be released after use, by calling the [release] method.
  visibleregion$_.VisibleRegion? getVisibleRegion$1(
    bool z,
  ) {
    return _getVisibleRegion$1(reference.pointer,
            _id_getVisibleRegion$1 as jni$_.JMethodIDPtr, z ? 1 : 0)
        .object<visibleregion$_.VisibleRegion?>(
            const visibleregion$_.$VisibleRegion$NullableType());
  }

  static final _id_getVisibleCoordinateBounds = _class.instanceMethodId(
    r'getVisibleCoordinateBounds',
    r'([D)V',
  );

  static final _getVisibleCoordinateBounds =
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

  /// from: `public void getVisibleCoordinateBounds(double[] ds)`
  void getVisibleCoordinateBounds(
    jni$_.JDoubleArray? ds,
  ) {
    final _$ds = ds?.reference ?? jni$_.jNullReference;
    _getVisibleCoordinateBounds(reference.pointer,
            _id_getVisibleCoordinateBounds as jni$_.JMethodIDPtr, _$ds.pointer)
        .check();
  }

  static final _id_toScreenLocation = _class.instanceMethodId(
    r'toScreenLocation',
    r'(Lorg/maplibre/android/geometry/LatLng;)Landroid/graphics/PointF;',
  );

  static final _toScreenLocation = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public android.graphics.PointF toScreenLocation(org.maplibre.android.geometry.LatLng latLng)`
  /// The returned object must be released after use, by calling the [release] method.
  pointf$_.PointF? toScreenLocation(
    latlng$_.LatLng? latLng,
  ) {
    final _$latLng = latLng?.reference ?? jni$_.jNullReference;
    return _toScreenLocation(reference.pointer,
            _id_toScreenLocation as jni$_.JMethodIDPtr, _$latLng.pointer)
        .object<pointf$_.PointF?>(const pointf$_.$PointF$NullableType());
  }

  static final _id_toScreenLocations = _class.instanceMethodId(
    r'toScreenLocations',
    r'([D[D)V',
  );

  static final _toScreenLocations = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void toScreenLocations(double[] ds, double[] ds1)`
  void toScreenLocations(
    jni$_.JDoubleArray? ds,
    jni$_.JDoubleArray? ds1,
  ) {
    final _$ds = ds?.reference ?? jni$_.jNullReference;
    final _$ds1 = ds1?.reference ?? jni$_.jNullReference;
    _toScreenLocations(
            reference.pointer,
            _id_toScreenLocations as jni$_.JMethodIDPtr,
            _$ds.pointer,
            _$ds1.pointer)
        .check();
  }

  static final _id_calculateZoom = _class.instanceMethodId(
    r'calculateZoom',
    r'(F)D',
  );

  static final _calculateZoom = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_
                      .VarArgs<(jni$_.Double,)>)>>('globalEnv_CallDoubleMethod')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, double)>();

  /// from: `public double calculateZoom(float f)`
  double calculateZoom(
    double f,
  ) {
    return _calculateZoom(
            reference.pointer, _id_calculateZoom as jni$_.JMethodIDPtr, f)
        .doubleFloat;
  }
}

final class $Projection$NullableType extends jni$_.JObjType<Projection?> {
  @jni$_.internal
  const $Projection$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/maps/Projection;';

  @jni$_.internal
  @core$_.override
  Projection? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : Projection.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Projection?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Projection$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Projection$NullableType) &&
        other is $Projection$NullableType;
  }
}

final class $Projection$Type extends jni$_.JObjType<Projection> {
  @jni$_.internal
  const $Projection$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/maps/Projection;';

  @jni$_.internal
  @core$_.override
  Projection fromReference(jni$_.JReference reference) =>
      Projection.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Projection?> get nullableType =>
      const $Projection$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Projection$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Projection$Type) && other is $Projection$Type;
  }
}