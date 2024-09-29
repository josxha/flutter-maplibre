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

import '../../../../android/graphics/PointF.dart' as pointf_;

import '../geometry/LatLng.dart' as latlng_;

import '../geometry/ProjectedMeters.dart' as projectedmeters_;

import '../geometry/VisibleRegion.dart' as visibleregion_;

/// from: `org.maplibre.android.maps.Projection`
class Projection extends jni.JObject {
  @override
  late final jni.JObjType<Projection> $type = type;

  Projection.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/maps/Projection');

  /// The type which includes information such as the signature of this class.
  static const type = $ProjectionType();
  static final _id_invalidateContentPadding = _class.instanceMethodId(
    r'invalidateContentPadding',
    r'()V',
  );

  static final _invalidateContentPadding = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public void invalidateContentPadding()`
  void invalidateContentPadding() {
    _invalidateContentPadding(
            reference.pointer, _id_invalidateContentPadding as jni.JMethodIDPtr)
        .check();
  }

  static final _id_getProjectedMetersForLatLng = _class.instanceMethodId(
    r'getProjectedMetersForLatLng',
    r'(Lorg/maplibre/android/geometry/LatLng;)Lorg/maplibre/android/geometry/ProjectedMeters;',
  );

  static final _getProjectedMetersForLatLng = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public org.maplibre.android.geometry.ProjectedMeters getProjectedMetersForLatLng(org.maplibre.android.geometry.LatLng latLng)`
  /// The returned object must be released after use, by calling the [release] method.
  projectedmeters_.ProjectedMeters getProjectedMetersForLatLng(
    latlng_.LatLng latLng,
  ) {
    return _getProjectedMetersForLatLng(
            reference.pointer,
            _id_getProjectedMetersForLatLng as jni.JMethodIDPtr,
            latLng.reference.pointer)
        .object(const projectedmeters_.$ProjectedMetersType());
  }

  static final _id_getLatLngForProjectedMeters = _class.instanceMethodId(
    r'getLatLngForProjectedMeters',
    r'(Lorg/maplibre/android/geometry/ProjectedMeters;)Lorg/maplibre/android/geometry/LatLng;',
  );

  static final _getLatLngForProjectedMeters = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public org.maplibre.android.geometry.LatLng getLatLngForProjectedMeters(org.maplibre.android.geometry.ProjectedMeters projectedMeters)`
  /// The returned object must be released after use, by calling the [release] method.
  latlng_.LatLng getLatLngForProjectedMeters(
    projectedmeters_.ProjectedMeters projectedMeters,
  ) {
    return _getLatLngForProjectedMeters(
            reference.pointer,
            _id_getLatLngForProjectedMeters as jni.JMethodIDPtr,
            projectedMeters.reference.pointer)
        .object(const latlng_.$LatLngType());
  }

  static final _id_getMetersPerPixelAtLatitude = _class.instanceMethodId(
    r'getMetersPerPixelAtLatitude',
    r'(D)D',
  );

  static final _getMetersPerPixelAtLatitude = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
                  ffi.VarArgs<(ffi.Double,)>)>>('globalEnv_CallDoubleMethod')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, double)>();

  /// from: `public double getMetersPerPixelAtLatitude(double d)`
  double getMetersPerPixelAtLatitude(
    double d,
  ) {
    return _getMetersPerPixelAtLatitude(reference.pointer,
            _id_getMetersPerPixelAtLatitude as jni.JMethodIDPtr, d)
        .doubleFloat;
  }

  static final _id_fromScreenLocation = _class.instanceMethodId(
    r'fromScreenLocation',
    r'(Landroid/graphics/PointF;)Lorg/maplibre/android/geometry/LatLng;',
  );

  static final _fromScreenLocation = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public org.maplibre.android.geometry.LatLng fromScreenLocation(android.graphics.PointF pointF)`
  /// The returned object must be released after use, by calling the [release] method.
  latlng_.LatLng fromScreenLocation(
    pointf_.PointF pointF,
  ) {
    return _fromScreenLocation(
            reference.pointer,
            _id_fromScreenLocation as jni.JMethodIDPtr,
            pointF.reference.pointer)
        .object(const latlng_.$LatLngType());
  }

  static final _id_fromScreenLocations = _class.instanceMethodId(
    r'fromScreenLocations',
    r'([D[D)V',
  );

  static final _fromScreenLocations = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `public void fromScreenLocations(double[] ds, double[] ds1)`
  void fromScreenLocations(
    jni.JArray<jni.jdouble> ds,
    jni.JArray<jni.jdouble> ds1,
  ) {
    _fromScreenLocations(
            reference.pointer,
            _id_fromScreenLocations as jni.JMethodIDPtr,
            ds.reference.pointer,
            ds1.reference.pointer)
        .check();
  }

  static final _id_getVisibleRegion = _class.instanceMethodId(
    r'getVisibleRegion',
    r'()Lorg/maplibre/android/geometry/VisibleRegion;',
  );

  static final _getVisibleRegion = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public org.maplibre.android.geometry.VisibleRegion getVisibleRegion()`
  /// The returned object must be released after use, by calling the [release] method.
  visibleregion_.VisibleRegion getVisibleRegion() {
    return _getVisibleRegion(
            reference.pointer, _id_getVisibleRegion as jni.JMethodIDPtr)
        .object(const visibleregion_.$VisibleRegionType());
  }

  static final _id_getVisibleRegion1 = _class.instanceMethodId(
    r'getVisibleRegion',
    r'(Z)Lorg/maplibre/android/geometry/VisibleRegion;',
  );

  static final _getVisibleRegion1 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
                  ffi.VarArgs<($Int32,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int)>();

  /// from: `public org.maplibre.android.geometry.VisibleRegion getVisibleRegion(boolean z)`
  /// The returned object must be released after use, by calling the [release] method.
  visibleregion_.VisibleRegion getVisibleRegion1(
    bool z,
  ) {
    return _getVisibleRegion1(reference.pointer,
            _id_getVisibleRegion1 as jni.JMethodIDPtr, z ? 1 : 0)
        .object(const visibleregion_.$VisibleRegionType());
  }

  static final _id_getVisibleCoordinateBounds = _class.instanceMethodId(
    r'getVisibleCoordinateBounds',
    r'([D)V',
  );

  static final _getVisibleCoordinateBounds = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void getVisibleCoordinateBounds(double[] ds)`
  void getVisibleCoordinateBounds(
    jni.JArray<jni.jdouble> ds,
  ) {
    _getVisibleCoordinateBounds(
            reference.pointer,
            _id_getVisibleCoordinateBounds as jni.JMethodIDPtr,
            ds.reference.pointer)
        .check();
  }

  static final _id_toScreenLocation = _class.instanceMethodId(
    r'toScreenLocation',
    r'(Lorg/maplibre/android/geometry/LatLng;)Landroid/graphics/PointF;',
  );

  static final _toScreenLocation = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public android.graphics.PointF toScreenLocation(org.maplibre.android.geometry.LatLng latLng)`
  /// The returned object must be released after use, by calling the [release] method.
  pointf_.PointF toScreenLocation(
    latlng_.LatLng latLng,
  ) {
    return _toScreenLocation(reference.pointer,
            _id_toScreenLocation as jni.JMethodIDPtr, latLng.reference.pointer)
        .object(const pointf_.$PointFType());
  }

  static final _id_toScreenLocations = _class.instanceMethodId(
    r'toScreenLocations',
    r'([D[D)V',
  );

  static final _toScreenLocations = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `public void toScreenLocations(double[] ds, double[] ds1)`
  void toScreenLocations(
    jni.JArray<jni.jdouble> ds,
    jni.JArray<jni.jdouble> ds1,
  ) {
    _toScreenLocations(
            reference.pointer,
            _id_toScreenLocations as jni.JMethodIDPtr,
            ds.reference.pointer,
            ds1.reference.pointer)
        .check();
  }

  static final _id_calculateZoom = _class.instanceMethodId(
    r'calculateZoom',
    r'(F)D',
  );

  static final _calculateZoom = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
                  ffi.VarArgs<(ffi.Double,)>)>>('globalEnv_CallDoubleMethod')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, double)>();

  /// from: `public double calculateZoom(float f)`
  double calculateZoom(
    double f,
  ) {
    return _calculateZoom(
            reference.pointer, _id_calculateZoom as jni.JMethodIDPtr, f)
        .doubleFloat;
  }
}

final class $ProjectionType extends jni.JObjType<Projection> {
  const $ProjectionType();

  @override
  String get signature => r'Lorg/maplibre/android/maps/Projection;';

  @override
  Projection fromReference(jni.JReference reference) =>
      Projection.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($ProjectionType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($ProjectionType) && other is $ProjectionType;
  }
}