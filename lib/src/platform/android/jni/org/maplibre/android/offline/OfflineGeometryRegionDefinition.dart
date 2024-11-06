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

import '../geometry/LatLngBounds.dart' as latlngbounds_;

/// from: `org.maplibre.android.offline.OfflineGeometryRegionDefinition$Companion`
class OfflineGeometryRegionDefinition_Companion extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<OfflineGeometryRegionDefinition_Companion> $type;

  @_$jni.internal
  OfflineGeometryRegionDefinition_Companion.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = _$jni.JClass.forName(
      r'org/maplibre/android/offline/OfflineGeometryRegionDefinition$Companion');

  /// The type which includes information such as the signature of this class.
  static const type = $OfflineGeometryRegionDefinition_Companion$Type();
  static final _id_new$ = _class.constructorId(
    r'(Lkotlin/jvm/internal/DefaultConstructorMarker;)V',
  );

  static final _new$ = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `synthetic public void <init>(kotlin.jvm.internal.DefaultConstructorMarker defaultConstructorMarker)`
  /// The returned object must be released after use, by calling the [release] method.
  factory OfflineGeometryRegionDefinition_Companion(
    _$jni.JObject defaultConstructorMarker,
  ) {
    return OfflineGeometryRegionDefinition_Companion.fromReference(_new$(
            _class.reference.pointer,
            _id_new$ as _$jni.JMethodIDPtr,
            defaultConstructorMarker.reference.pointer)
        .reference);
  }
}

final class $OfflineGeometryRegionDefinition_Companion$Type
    extends _$jni.JObjType<OfflineGeometryRegionDefinition_Companion> {
  @_$jni.internal
  const $OfflineGeometryRegionDefinition_Companion$Type();

  @_$jni.internal
  @_$core.override
  String get signature =>
      r'Lorg/maplibre/android/offline/OfflineGeometryRegionDefinition$Companion;';

  @_$jni.internal
  @_$core.override
  OfflineGeometryRegionDefinition_Companion fromReference(
          _$jni.JReference reference) =>
      OfflineGeometryRegionDefinition_Companion.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode =>
      ($OfflineGeometryRegionDefinition_Companion$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($OfflineGeometryRegionDefinition_Companion$Type) &&
        other is $OfflineGeometryRegionDefinition_Companion$Type;
  }
}

/// from: `org.maplibre.android.offline.OfflineGeometryRegionDefinition`
class OfflineGeometryRegionDefinition extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<OfflineGeometryRegionDefinition> $type;

  @_$jni.internal
  OfflineGeometryRegionDefinition.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = _$jni.JClass.forName(
      r'org/maplibre/android/offline/OfflineGeometryRegionDefinition');

  /// The type which includes information such as the signature of this class.
  static const type = $OfflineGeometryRegionDefinition$Type();
  static final _id_Companion = _class.staticFieldId(
    r'Companion',
    r'Lorg/maplibre/android/offline/OfflineGeometryRegionDefinition$Companion;',
  );

  /// from: `static public final org.maplibre.android.offline.OfflineGeometryRegionDefinition$Companion Companion`
  /// The returned object must be released after use, by calling the [release] method.
  static OfflineGeometryRegionDefinition_Companion get Companion =>
      _id_Companion.get(
          _class, const $OfflineGeometryRegionDefinition_Companion$Type());

  static final _id_CREATOR = _class.staticFieldId(
    r'CREATOR',
    r'Landroid/os/Parcelable$Creator;',
  );

  /// from: `static public final android.os.Parcelable$Creator CREATOR`
  /// The returned object must be released after use, by calling the [release] method.
  static _$jni.JObject get CREATOR =>
      _id_CREATOR.get(_class, const _$jni.JObjectType());

  static final _id_getStyleURL = _class.instanceMethodId(
    r'getStyleURL',
    r'()Ljava/lang/String;',
  );

  static final _getStyleURL = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getStyleURL()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JString getStyleURL() {
    return _getStyleURL(
            reference.pointer, _id_getStyleURL as _$jni.JMethodIDPtr)
        .object(const _$jni.JStringType());
  }

  static final _id_getGeometry = _class.instanceMethodId(
    r'getGeometry',
    r'()Lorg/maplibre/geojson/Geometry;',
  );

  static final _getGeometry = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public final org.maplibre.geojson.Geometry getGeometry()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JObject getGeometry() {
    return _getGeometry(
            reference.pointer, _id_getGeometry as _$jni.JMethodIDPtr)
        .object(const _$jni.JObjectType());
  }

  static final _id_getMinZoom = _class.instanceMethodId(
    r'getMinZoom',
    r'()D',
  );

  static final _getMinZoom = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallDoubleMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public double getMinZoom()`
  double getMinZoom() {
    return _getMinZoom(reference.pointer, _id_getMinZoom as _$jni.JMethodIDPtr)
        .doubleFloat;
  }

  static final _id_getMaxZoom = _class.instanceMethodId(
    r'getMaxZoom',
    r'()D',
  );

  static final _getMaxZoom = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallDoubleMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public double getMaxZoom()`
  double getMaxZoom() {
    return _getMaxZoom(reference.pointer, _id_getMaxZoom as _$jni.JMethodIDPtr)
        .doubleFloat;
  }

  static final _id_getPixelRatio = _class.instanceMethodId(
    r'getPixelRatio',
    r'()F',
  );

  static final _getPixelRatio = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallFloatMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public float getPixelRatio()`
  double getPixelRatio() {
    return _getPixelRatio(
            reference.pointer, _id_getPixelRatio as _$jni.JMethodIDPtr)
        .float;
  }

  static final _id_getIncludeIdeographs = _class.instanceMethodId(
    r'getIncludeIdeographs',
    r'()Z',
  );

  static final _getIncludeIdeographs = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public boolean getIncludeIdeographs()`
  bool getIncludeIdeographs() {
    return _getIncludeIdeographs(
            reference.pointer, _id_getIncludeIdeographs as _$jni.JMethodIDPtr)
        .boolean;
  }

  static final _id_new$ = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/geojson/Geometry;DDF)V',
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
                        _$jni.Double,
                        _$jni.Double,
                        _$jni.Double
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>,
              double,
              double,
              double)>();

  /// from: `public void <init>(java.lang.String string, org.maplibre.geojson.Geometry geometry, double d, double d1, float f)`
  /// The returned object must be released after use, by calling the [release] method.
  factory OfflineGeometryRegionDefinition(
    _$jni.JString string,
    _$jni.JObject geometry,
    double d,
    double d1,
    double f,
  ) {
    return OfflineGeometryRegionDefinition.fromReference(_new$(
            _class.reference.pointer,
            _id_new$ as _$jni.JMethodIDPtr,
            string.reference.pointer,
            geometry.reference.pointer,
            d,
            d1,
            f)
        .reference);
  }

  static final _id_new$1 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/geojson/Geometry;DDFZ)V',
  );

  static final _new$1 = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Double,
                        _$jni.Double,
                        _$jni.Double,
                        _$jni.Int32
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>,
              double,
              double,
              double,
              int)>();

  /// from: `public void <init>(java.lang.String string, org.maplibre.geojson.Geometry geometry, double d, double d1, float f, boolean z)`
  /// The returned object must be released after use, by calling the [release] method.
  factory OfflineGeometryRegionDefinition.new$1(
    _$jni.JString string,
    _$jni.JObject geometry,
    double d,
    double d1,
    double f,
    bool z,
  ) {
    return OfflineGeometryRegionDefinition.fromReference(_new$1(
            _class.reference.pointer,
            _id_new$1 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            geometry.reference.pointer,
            d,
            d1,
            f,
            z ? 1 : 0)
        .reference);
  }

  static final _id_new$2 = _class.constructorId(
    r'(Landroid/os/Parcel;)V',
  );

  static final _new$2 = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void <init>(android.os.Parcel parcel)`
  /// The returned object must be released after use, by calling the [release] method.
  factory OfflineGeometryRegionDefinition.new$2(
    _$jni.JObject parcel,
  ) {
    return OfflineGeometryRegionDefinition.fromReference(_new$2(
            _class.reference.pointer,
            _id_new$2 as _$jni.JMethodIDPtr,
            parcel.reference.pointer)
        .reference);
  }

  static final _id_getBounds = _class.instanceMethodId(
    r'getBounds',
    r'()Lorg/maplibre/android/geometry/LatLngBounds;',
  );

  static final _getBounds = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.geometry.LatLngBounds getBounds()`
  /// The returned object must be released after use, by calling the [release] method.
  latlngbounds_.LatLngBounds getBounds() {
    return _getBounds(reference.pointer, _id_getBounds as _$jni.JMethodIDPtr)
        .object(const latlngbounds_.$LatLngBounds$Type());
  }

  static final _id_getType = _class.instanceMethodId(
    r'getType',
    r'()Ljava/lang/String;',
  );

  static final _getType = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getType()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JString getType() {
    return _getType(reference.pointer, _id_getType as _$jni.JMethodIDPtr)
        .object(const _$jni.JStringType());
  }

  static final _id_describeContents = _class.instanceMethodId(
    r'describeContents',
    r'()I',
  );

  static final _describeContents = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public int describeContents()`
  int describeContents() {
    return _describeContents(
            reference.pointer, _id_describeContents as _$jni.JMethodIDPtr)
        .integer;
  }

  static final _id_writeToParcel = _class.instanceMethodId(
    r'writeToParcel',
    r'(Landroid/os/Parcel;I)V',
  );

  static final _writeToParcel = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni
                          .VarArgs<(_$jni.Pointer<_$jni.Void>, _$jni.Int32)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>, int)>();

  /// from: `public void writeToParcel(android.os.Parcel parcel, int i)`
  void writeToParcel(
    _$jni.JObject parcel,
    int i,
  ) {
    _writeToParcel(reference.pointer, _id_writeToParcel as _$jni.JMethodIDPtr,
            parcel.reference.pointer, i)
        .check();
  }
}

final class $OfflineGeometryRegionDefinition$Type
    extends _$jni.JObjType<OfflineGeometryRegionDefinition> {
  @_$jni.internal
  const $OfflineGeometryRegionDefinition$Type();

  @_$jni.internal
  @_$core.override
  String get signature =>
      r'Lorg/maplibre/android/offline/OfflineGeometryRegionDefinition;';

  @_$jni.internal
  @_$core.override
  OfflineGeometryRegionDefinition fromReference(_$jni.JReference reference) =>
      OfflineGeometryRegionDefinition.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode => ($OfflineGeometryRegionDefinition$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($OfflineGeometryRegionDefinition$Type) &&
        other is $OfflineGeometryRegionDefinition$Type;
  }
}