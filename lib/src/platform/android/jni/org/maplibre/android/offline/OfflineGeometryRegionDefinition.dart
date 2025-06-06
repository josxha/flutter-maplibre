// AUTO GENERATED BY JNIGEN 0.14.2. DO NOT EDIT!

// ignore_for_file: type=lint

// ignore_for_file: annotate_overrides
// ignore_for_file: argument_type_not_assignable
// ignore_for_file: camel_case_extensions
// ignore_for_file: camel_case_types
// ignore_for_file: constant_identifier_names
// ignore_for_file: comment_references
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

import '../geometry/LatLngBounds.dart' as latlngbounds$_;

/// from: `org.maplibre.android.offline.OfflineGeometryRegionDefinition$Companion`
class OfflineGeometryRegionDefinition$Companion extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<OfflineGeometryRegionDefinition$Companion> $type;

  @jni$_.internal
  OfflineGeometryRegionDefinition$Companion.fromReference(
    jni$_.JReference reference,
  ) : $type = type,
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
    r'org/maplibre/android/offline/OfflineGeometryRegionDefinition$Companion',
  );

  /// The type which includes information such as the signature of this class.
  static const nullableType =
      $OfflineGeometryRegionDefinition$Companion$NullableType();
  static const type = $OfflineGeometryRegionDefinition$Companion$Type();
  static final _id_new$ = _class.constructorId(
    r'(Lkotlin/jvm/internal/DefaultConstructorMarker;)V',
  );

  static final _new$ =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_NewObject')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `synthetic public void <init>(kotlin.jvm.internal.DefaultConstructorMarker defaultConstructorMarker)`
  /// The returned object must be released after use, by calling the [release] method.
  factory OfflineGeometryRegionDefinition$Companion(
    jni$_.JObject? defaultConstructorMarker,
  ) {
    final _$defaultConstructorMarker =
        defaultConstructorMarker?.reference ?? jni$_.jNullReference;
    return OfflineGeometryRegionDefinition$Companion.fromReference(
      _new$(
        _class.reference.pointer,
        _id_new$ as jni$_.JMethodIDPtr,
        _$defaultConstructorMarker.pointer,
      ).reference,
    );
  }
}

final class $OfflineGeometryRegionDefinition$Companion$NullableType
    extends jni$_.JObjType<OfflineGeometryRegionDefinition$Companion?> {
  @jni$_.internal
  const $OfflineGeometryRegionDefinition$Companion$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/offline/OfflineGeometryRegionDefinition$Companion;';

  @jni$_.internal
  @core$_.override
  OfflineGeometryRegionDefinition$Companion? fromReference(
    jni$_.JReference reference,
  ) => reference.isNull
      ? null
      : OfflineGeometryRegionDefinition$Companion.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<OfflineGeometryRegionDefinition$Companion?> get nullableType =>
      this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode =>
      ($OfflineGeometryRegionDefinition$Companion$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($OfflineGeometryRegionDefinition$Companion$NullableType) &&
        other is $OfflineGeometryRegionDefinition$Companion$NullableType;
  }
}

final class $OfflineGeometryRegionDefinition$Companion$Type
    extends jni$_.JObjType<OfflineGeometryRegionDefinition$Companion> {
  @jni$_.internal
  const $OfflineGeometryRegionDefinition$Companion$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/offline/OfflineGeometryRegionDefinition$Companion;';

  @jni$_.internal
  @core$_.override
  OfflineGeometryRegionDefinition$Companion fromReference(
    jni$_.JReference reference,
  ) => OfflineGeometryRegionDefinition$Companion.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<OfflineGeometryRegionDefinition$Companion?> get nullableType =>
      const $OfflineGeometryRegionDefinition$Companion$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode =>
      ($OfflineGeometryRegionDefinition$Companion$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($OfflineGeometryRegionDefinition$Companion$Type) &&
        other is $OfflineGeometryRegionDefinition$Companion$Type;
  }
}

/// from: `org.maplibre.android.offline.OfflineGeometryRegionDefinition`
class OfflineGeometryRegionDefinition extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<OfflineGeometryRegionDefinition> $type;

  @jni$_.internal
  OfflineGeometryRegionDefinition.fromReference(jni$_.JReference reference)
    : $type = type,
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
    r'org/maplibre/android/offline/OfflineGeometryRegionDefinition',
  );

  /// The type which includes information such as the signature of this class.
  static const nullableType = $OfflineGeometryRegionDefinition$NullableType();
  static const type = $OfflineGeometryRegionDefinition$Type();
  static final _id_Companion = _class.staticFieldId(
    r'Companion',
    r'Lorg/maplibre/android/offline/OfflineGeometryRegionDefinition$Companion;',
  );

  /// from: `static public final org.maplibre.android.offline.OfflineGeometryRegionDefinition$Companion Companion`
  /// The returned object must be released after use, by calling the [release] method.
  static OfflineGeometryRegionDefinition$Companion get Companion =>
      _id_Companion.get(
        _class,
        const $OfflineGeometryRegionDefinition$Companion$Type(),
      );

  static final _id_CREATOR = _class.staticFieldId(
    r'CREATOR',
    r'Landroid/os/Parcelable$Creator;',
  );

  /// from: `static public final android.os.Parcelable$Creator<?> CREATOR`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JObject get CREATOR =>
      _id_CREATOR.get(_class, const jni$_.JObjectType());

  static final _id_getStyleURL = _class.instanceMethodId(
    r'getStyleURL',
    r'()Ljava/lang/String;',
  );

  static final _getStyleURL =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.lang.String getStyleURL()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getStyleURL() {
    return _getStyleURL(
      reference.pointer,
      _id_getStyleURL as jni$_.JMethodIDPtr,
    ).object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getGeometry = _class.instanceMethodId(
    r'getGeometry',
    r'()Lorg/maplibre/geojson/Geometry;',
  );

  static final _getGeometry =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public final org.maplibre.geojson.Geometry getGeometry()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JObject? getGeometry() {
    return _getGeometry(
      reference.pointer,
      _id_getGeometry as jni$_.JMethodIDPtr,
    ).object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_getMinZoom = _class.instanceMethodId(r'getMinZoom', r'()D');

  static final _getMinZoom =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallDoubleMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public double getMinZoom()`
  double getMinZoom() {
    return _getMinZoom(
      reference.pointer,
      _id_getMinZoom as jni$_.JMethodIDPtr,
    ).doubleFloat;
  }

  static final _id_getMaxZoom = _class.instanceMethodId(r'getMaxZoom', r'()D');

  static final _getMaxZoom =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallDoubleMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public double getMaxZoom()`
  double getMaxZoom() {
    return _getMaxZoom(
      reference.pointer,
      _id_getMaxZoom as jni$_.JMethodIDPtr,
    ).doubleFloat;
  }

  static final _id_getPixelRatio = _class.instanceMethodId(
    r'getPixelRatio',
    r'()F',
  );

  static final _getPixelRatio =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallFloatMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public float getPixelRatio()`
  double getPixelRatio() {
    return _getPixelRatio(
      reference.pointer,
      _id_getPixelRatio as jni$_.JMethodIDPtr,
    ).float;
  }

  static final _id_getIncludeIdeographs = _class.instanceMethodId(
    r'getIncludeIdeographs',
    r'()Z',
  );

  static final _getIncludeIdeographs =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallBooleanMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public boolean getIncludeIdeographs()`
  bool getIncludeIdeographs() {
    return _getIncludeIdeographs(
      reference.pointer,
      _id_getIncludeIdeographs as jni$_.JMethodIDPtr,
    ).boolean;
  }

  static final _id_new$ = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/geojson/Geometry;DDF)V',
  );

  static final _new$ =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<
                  (
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Double,
                    jni$_.Double,
                    jni$_.Double,
                  )
                >,
              )
            >
          >('globalEnv_NewObject')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              double,
              double,
              double,
            )
          >();

  /// from: `public void <init>(java.lang.String string, org.maplibre.geojson.Geometry geometry, double d, double d1, float f)`
  /// The returned object must be released after use, by calling the [release] method.
  factory OfflineGeometryRegionDefinition(
    jni$_.JString? string,
    jni$_.JObject? geometry,
    double d,
    double d1,
    double f,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$geometry = geometry?.reference ?? jni$_.jNullReference;
    return OfflineGeometryRegionDefinition.fromReference(
      _new$(
        _class.reference.pointer,
        _id_new$ as jni$_.JMethodIDPtr,
        _$string.pointer,
        _$geometry.pointer,
        d,
        d1,
        f,
      ).reference,
    );
  }

  static final _id_new$1 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/geojson/Geometry;DDFZ)V',
  );

  static final _new$1 =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<
                  (
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Double,
                    jni$_.Double,
                    jni$_.Double,
                    jni$_.Int32,
                  )
                >,
              )
            >
          >('globalEnv_NewObject')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              double,
              double,
              double,
              int,
            )
          >();

  /// from: `public void <init>(java.lang.String string, org.maplibre.geojson.Geometry geometry, double d, double d1, float f, boolean z)`
  /// The returned object must be released after use, by calling the [release] method.
  factory OfflineGeometryRegionDefinition.new$1(
    jni$_.JString? string,
    jni$_.JObject? geometry,
    double d,
    double d1,
    double f,
    bool z,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$geometry = geometry?.reference ?? jni$_.jNullReference;
    return OfflineGeometryRegionDefinition.fromReference(
      _new$1(
        _class.reference.pointer,
        _id_new$1 as jni$_.JMethodIDPtr,
        _$string.pointer,
        _$geometry.pointer,
        d,
        d1,
        f,
        z ? 1 : 0,
      ).reference,
    );
  }

  static final _id_new$2 = _class.constructorId(r'(Landroid/os/Parcel;)V');

  static final _new$2 =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_NewObject')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public void <init>(android.os.Parcel parcel)`
  /// The returned object must be released after use, by calling the [release] method.
  factory OfflineGeometryRegionDefinition.new$2(jni$_.JObject parcel) {
    final _$parcel = parcel.reference;
    return OfflineGeometryRegionDefinition.fromReference(
      _new$2(
        _class.reference.pointer,
        _id_new$2 as jni$_.JMethodIDPtr,
        _$parcel.pointer,
      ).reference,
    );
  }

  static final _id_getBounds = _class.instanceMethodId(
    r'getBounds',
    r'()Lorg/maplibre/android/geometry/LatLngBounds;',
  );

  static final _getBounds =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public org.maplibre.android.geometry.LatLngBounds getBounds()`
  /// The returned object must be released after use, by calling the [release] method.
  latlngbounds$_.LatLngBounds? getBounds() {
    return _getBounds(
      reference.pointer,
      _id_getBounds as jni$_.JMethodIDPtr,
    ).object<latlngbounds$_.LatLngBounds?>(
      const latlngbounds$_.$LatLngBounds$NullableType(),
    );
  }

  static final _id_getType = _class.instanceMethodId(
    r'getType',
    r'()Ljava/lang/String;',
  );

  static final _getType =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public java.lang.String getType()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString getType() {
    return _getType(
      reference.pointer,
      _id_getType as jni$_.JMethodIDPtr,
    ).object<jni$_.JString>(const jni$_.JStringType());
  }

  static final _id_describeContents = _class.instanceMethodId(
    r'describeContents',
    r'()I',
  );

  static final _describeContents =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallIntMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public int describeContents()`
  int describeContents() {
    return _describeContents(
      reference.pointer,
      _id_describeContents as jni$_.JMethodIDPtr,
    ).integer;
  }

  static final _id_writeToParcel = _class.instanceMethodId(
    r'writeToParcel',
    r'(Landroid/os/Parcel;I)V',
  );

  static final _writeToParcel =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>, jni$_.Int32)>,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              int,
            )
          >();

  /// from: `public void writeToParcel(android.os.Parcel parcel, int i)`
  void writeToParcel(jni$_.JObject parcel, int i) {
    final _$parcel = parcel.reference;
    _writeToParcel(
      reference.pointer,
      _id_writeToParcel as jni$_.JMethodIDPtr,
      _$parcel.pointer,
      i,
    ).check();
  }
}

final class $OfflineGeometryRegionDefinition$NullableType
    extends jni$_.JObjType<OfflineGeometryRegionDefinition?> {
  @jni$_.internal
  const $OfflineGeometryRegionDefinition$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/offline/OfflineGeometryRegionDefinition;';

  @jni$_.internal
  @core$_.override
  OfflineGeometryRegionDefinition? fromReference(jni$_.JReference reference) =>
      reference.isNull
      ? null
      : OfflineGeometryRegionDefinition.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<OfflineGeometryRegionDefinition?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($OfflineGeometryRegionDefinition$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($OfflineGeometryRegionDefinition$NullableType) &&
        other is $OfflineGeometryRegionDefinition$NullableType;
  }
}

final class $OfflineGeometryRegionDefinition$Type
    extends jni$_.JObjType<OfflineGeometryRegionDefinition> {
  @jni$_.internal
  const $OfflineGeometryRegionDefinition$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/offline/OfflineGeometryRegionDefinition;';

  @jni$_.internal
  @core$_.override
  OfflineGeometryRegionDefinition fromReference(jni$_.JReference reference) =>
      OfflineGeometryRegionDefinition.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<OfflineGeometryRegionDefinition?> get nullableType =>
      const $OfflineGeometryRegionDefinition$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($OfflineGeometryRegionDefinition$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($OfflineGeometryRegionDefinition$Type) &&
        other is $OfflineGeometryRegionDefinition$Type;
  }
}
