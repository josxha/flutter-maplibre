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

import '../geometry/LatLngBounds.dart' as latlngbounds_;

/// from: `org.maplibre.android.offline.OfflineGeometryRegionDefinition$Companion`
class OfflineGeometryRegionDefinition_Companion extends jni.JObject {
  @override
  late final jni.JObjType<OfflineGeometryRegionDefinition_Companion> $type =
      type;

  OfflineGeometryRegionDefinition_Companion.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/offline/OfflineGeometryRegionDefinition$Companion');

  /// The type which includes information such as the signature of this class.
  static const type = $OfflineGeometryRegionDefinition_CompanionType();
  static final _id_new0 = _class.constructorId(
    r'(Lkotlin/jvm/internal/DefaultConstructorMarker;)V',
  );

  static final _new0 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(kotlin.jvm.internal.DefaultConstructorMarker defaultConstructorMarker)`
  /// The returned object must be released after use, by calling the [release] method.
  factory OfflineGeometryRegionDefinition_Companion(
    jni.JObject defaultConstructorMarker,
  ) {
    return OfflineGeometryRegionDefinition_Companion.fromReference(_new0(
            _class.reference.pointer,
            _id_new0 as jni.JMethodIDPtr,
            defaultConstructorMarker.reference.pointer)
        .reference);
  }
}

final class $OfflineGeometryRegionDefinition_CompanionType
    extends jni.JObjType<OfflineGeometryRegionDefinition_Companion> {
  const $OfflineGeometryRegionDefinition_CompanionType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/offline/OfflineGeometryRegionDefinition$Companion;';

  @override
  OfflineGeometryRegionDefinition_Companion fromReference(
          jni.JReference reference) =>
      OfflineGeometryRegionDefinition_Companion.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($OfflineGeometryRegionDefinition_CompanionType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($OfflineGeometryRegionDefinition_CompanionType) &&
        other is $OfflineGeometryRegionDefinition_CompanionType;
  }
}

/// from: `org.maplibre.android.offline.OfflineGeometryRegionDefinition`
class OfflineGeometryRegionDefinition extends jni.JObject {
  @override
  late final jni.JObjType<OfflineGeometryRegionDefinition> $type = type;

  OfflineGeometryRegionDefinition.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/offline/OfflineGeometryRegionDefinition');

  /// The type which includes information such as the signature of this class.
  static const type = $OfflineGeometryRegionDefinitionType();
  static final _id_Companion = _class.staticFieldId(
    r'Companion',
    r'Lorg/maplibre/android/offline/OfflineGeometryRegionDefinition$Companion;',
  );

  /// from: `static public final org.maplibre.android.offline.OfflineGeometryRegionDefinition$Companion Companion`
  /// The returned object must be released after use, by calling the [release] method.
  static OfflineGeometryRegionDefinition_Companion get Companion =>
      _id_Companion.get(
          _class, const $OfflineGeometryRegionDefinition_CompanionType());

  static final _id_CREATOR = _class.staticFieldId(
    r'CREATOR',
    r'Landroid/os/Parcelable$Creator;',
  );

  /// from: `static public final android.os.Parcelable$Creator CREATOR`
  /// The returned object must be released after use, by calling the [release] method.
  static jni.JObject get CREATOR =>
      _id_CREATOR.get(_class, const jni.JObjectType());

  static final _id_getStyleURL = _class.instanceMethodId(
    r'getStyleURL',
    r'()Ljava/lang/String;',
  );

  static final _getStyleURL = ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getStyleURL()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString getStyleURL() {
    return _getStyleURL(reference.pointer, _id_getStyleURL as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_getGeometry = _class.instanceMethodId(
    r'getGeometry',
    r'()Lorg/maplibre/geojson/Geometry;',
  );

  static final _getGeometry = ProtectedJniExtensions.lookup<
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

  /// from: `public final org.maplibre.geojson.Geometry getGeometry()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject getGeometry() {
    return _getGeometry(reference.pointer, _id_getGeometry as jni.JMethodIDPtr)
        .object(const jni.JObjectType());
  }

  static final _id_getMinZoom = _class.instanceMethodId(
    r'getMinZoom',
    r'()D',
  );

  static final _getMinZoom = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallDoubleMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public double getMinZoom()`
  double getMinZoom() {
    return _getMinZoom(reference.pointer, _id_getMinZoom as jni.JMethodIDPtr)
        .doubleFloat;
  }

  static final _id_getMaxZoom = _class.instanceMethodId(
    r'getMaxZoom',
    r'()D',
  );

  static final _getMaxZoom = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallDoubleMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public double getMaxZoom()`
  double getMaxZoom() {
    return _getMaxZoom(reference.pointer, _id_getMaxZoom as jni.JMethodIDPtr)
        .doubleFloat;
  }

  static final _id_getPixelRatio = _class.instanceMethodId(
    r'getPixelRatio',
    r'()F',
  );

  static final _getPixelRatio = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallFloatMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public float getPixelRatio()`
  double getPixelRatio() {
    return _getPixelRatio(
            reference.pointer, _id_getPixelRatio as jni.JMethodIDPtr)
        .float;
  }

  static final _id_getIncludeIdeographs = _class.instanceMethodId(
    r'getIncludeIdeographs',
    r'()Z',
  );

  static final _getIncludeIdeographs = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallBooleanMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public boolean getIncludeIdeographs()`
  bool getIncludeIdeographs() {
    return _getIncludeIdeographs(
            reference.pointer, _id_getIncludeIdeographs as jni.JMethodIDPtr)
        .boolean;
  }

  static final _id_new0 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/geojson/Geometry;DDF)V',
  );

  static final _new0 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Double,
                        ffi.Double,
                        ffi.Double
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>,
              jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              double,
              double,
              double)>();

  /// from: `public void <init>(java.lang.String string, org.maplibre.geojson.Geometry geometry, double d, double d1, float f)`
  /// The returned object must be released after use, by calling the [release] method.
  factory OfflineGeometryRegionDefinition(
    jni.JString string,
    jni.JObject geometry,
    double d,
    double d1,
    double f,
  ) {
    return OfflineGeometryRegionDefinition.fromReference(_new0(
            _class.reference.pointer,
            _id_new0 as jni.JMethodIDPtr,
            string.reference.pointer,
            geometry.reference.pointer,
            d,
            d1,
            f)
        .reference);
  }

  static final _id_new1 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/geojson/Geometry;DDFZ)V',
  );

  static final _new1 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Double,
                        ffi.Double,
                        ffi.Double,
                        $Int32
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>,
              jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              double,
              double,
              double,
              int)>();

  /// from: `public void <init>(java.lang.String string, org.maplibre.geojson.Geometry geometry, double d, double d1, float f, boolean z)`
  /// The returned object must be released after use, by calling the [release] method.
  factory OfflineGeometryRegionDefinition.new1(
    jni.JString string,
    jni.JObject geometry,
    double d,
    double d1,
    double f,
    bool z,
  ) {
    return OfflineGeometryRegionDefinition.fromReference(_new1(
            _class.reference.pointer,
            _id_new1 as jni.JMethodIDPtr,
            string.reference.pointer,
            geometry.reference.pointer,
            d,
            d1,
            f,
            z ? 1 : 0)
        .reference);
  }

  static final _id_new2 = _class.constructorId(
    r'(Landroid/os/Parcel;)V',
  );

  static final _new2 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(android.os.Parcel parcel)`
  /// The returned object must be released after use, by calling the [release] method.
  factory OfflineGeometryRegionDefinition.new2(
    jni.JObject parcel,
  ) {
    return OfflineGeometryRegionDefinition.fromReference(_new2(
            _class.reference.pointer,
            _id_new2 as jni.JMethodIDPtr,
            parcel.reference.pointer)
        .reference);
  }

  static final _id_getBounds = _class.instanceMethodId(
    r'getBounds',
    r'()Lorg/maplibre/android/geometry/LatLngBounds;',
  );

  static final _getBounds = ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.geometry.LatLngBounds getBounds()`
  /// The returned object must be released after use, by calling the [release] method.
  latlngbounds_.LatLngBounds getBounds() {
    return _getBounds(reference.pointer, _id_getBounds as jni.JMethodIDPtr)
        .object(const latlngbounds_.$LatLngBoundsType());
  }

  static final _id_getType = _class.instanceMethodId(
    r'getType',
    r'()Ljava/lang/String;',
  );

  static final _getType = ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getType()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString getType() {
    return _getType(reference.pointer, _id_getType as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_describeContents = _class.instanceMethodId(
    r'describeContents',
    r'()I',
  );

  static final _describeContents = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallIntMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public int describeContents()`
  int describeContents() {
    return _describeContents(
            reference.pointer, _id_describeContents as jni.JMethodIDPtr)
        .integer;
  }

  static final _id_writeToParcel = _class.instanceMethodId(
    r'writeToParcel',
    r'(Landroid/os/Parcel;I)V',
  );

  static final _writeToParcel = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>, $Int32)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, int)>();

  /// from: `public void writeToParcel(android.os.Parcel parcel, int i)`
  void writeToParcel(
    jni.JObject parcel,
    int i,
  ) {
    _writeToParcel(reference.pointer, _id_writeToParcel as jni.JMethodIDPtr,
            parcel.reference.pointer, i)
        .check();
  }
}

final class $OfflineGeometryRegionDefinitionType
    extends jni.JObjType<OfflineGeometryRegionDefinition> {
  const $OfflineGeometryRegionDefinitionType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/offline/OfflineGeometryRegionDefinition;';

  @override
  OfflineGeometryRegionDefinition fromReference(jni.JReference reference) =>
      OfflineGeometryRegionDefinition.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($OfflineGeometryRegionDefinitionType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($OfflineGeometryRegionDefinitionType) &&
        other is $OfflineGeometryRegionDefinitionType;
  }
}
