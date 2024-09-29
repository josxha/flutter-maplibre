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

import '../../geometry/LatLngBounds.dart' as latlngbounds_;

import 'CustomGeometrySourceOptions.dart' as customgeometrysourceoptions_;

import 'GeometryTileProvider.dart' as geometrytileprovider_;

import 'Source.dart' as source_;

/// from: `org.maplibre.android.style.sources.CustomGeometrySource$Companion`
class CustomGeometrySource_Companion extends jni.JObject {
  @override
  late final jni.JObjType<CustomGeometrySource_Companion> $type = type;

  CustomGeometrySource_Companion.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/style/sources/CustomGeometrySource$Companion');

  /// The type which includes information such as the signature of this class.
  static const type = $CustomGeometrySource_CompanionType();
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
  factory CustomGeometrySource_Companion(
    jni.JObject defaultConstructorMarker,
  ) {
    return CustomGeometrySource_Companion.fromReference(_new0(
            _class.reference.pointer,
            _id_new0 as jni.JMethodIDPtr,
            defaultConstructorMarker.reference.pointer)
        .reference);
  }
}

final class $CustomGeometrySource_CompanionType
    extends jni.JObjType<CustomGeometrySource_Companion> {
  const $CustomGeometrySource_CompanionType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/style/sources/CustomGeometrySource$Companion;';

  @override
  CustomGeometrySource_Companion fromReference(jni.JReference reference) =>
      CustomGeometrySource_Companion.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($CustomGeometrySource_CompanionType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($CustomGeometrySource_CompanionType) &&
        other is $CustomGeometrySource_CompanionType;
  }
}

/// from: `org.maplibre.android.style.sources.CustomGeometrySource$GeometryTileRequest`
class CustomGeometrySource_GeometryTileRequest extends jni.JObject {
  @override
  late final jni.JObjType<CustomGeometrySource_GeometryTileRequest> $type =
      type;

  CustomGeometrySource_GeometryTileRequest.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/style/sources/CustomGeometrySource$GeometryTileRequest');

  /// The type which includes information such as the signature of this class.
  static const type = $CustomGeometrySource_GeometryTileRequestType();
  static final _id_new0 = _class.constructorId(
    r'(Lorg/maplibre/android/style/sources/CustomGeometrySource$TileID;Lorg/maplibre/android/style/sources/GeometryTileProvider;Ljava/util/Map;Ljava/util/Map;Lorg/maplibre/android/style/sources/CustomGeometrySource;Ljava/util/concurrent/atomic/AtomicBoolean;)V',
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
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>,
              jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(org.maplibre.android.style.sources.CustomGeometrySource$TileID tileID, org.maplibre.android.style.sources.GeometryTileProvider geometryTileProvider, java.util.Map map, java.util.Map map1, org.maplibre.android.style.sources.CustomGeometrySource customGeometrySource, java.util.concurrent.atomic.AtomicBoolean atomicBoolean)`
  /// The returned object must be released after use, by calling the [release] method.
  factory CustomGeometrySource_GeometryTileRequest(
    CustomGeometrySource_TileID tileID,
    geometrytileprovider_.GeometryTileProvider geometryTileProvider,
    jni.JMap<CustomGeometrySource_TileID,
            CustomGeometrySource_GeometryTileRequest>
        map,
    jni.JMap<CustomGeometrySource_TileID, jni.JObject> map1,
    CustomGeometrySource customGeometrySource,
    jni.JObject atomicBoolean,
  ) {
    return CustomGeometrySource_GeometryTileRequest.fromReference(_new0(
            _class.reference.pointer,
            _id_new0 as jni.JMethodIDPtr,
            tileID.reference.pointer,
            geometryTileProvider.reference.pointer,
            map.reference.pointer,
            map1.reference.pointer,
            customGeometrySource.reference.pointer,
            atomicBoolean.reference.pointer)
        .reference);
  }

  static final _id_run = _class.instanceMethodId(
    r'run',
    r'()V',
  );

  static final _run = ProtectedJniExtensions.lookup<
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

  /// from: `public void run()`
  void run() {
    _run(reference.pointer, _id_run as jni.JMethodIDPtr).check();
  }

  static final _id_equals = _class.instanceMethodId(
    r'equals',
    r'(Ljava/lang/Object;)Z',
  );

  static final _equals = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallBooleanMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public boolean equals(java.lang.Object object)`
  bool equals(
    jni.JObject object,
  ) {
    return _equals(reference.pointer, _id_equals as jni.JMethodIDPtr,
            object.reference.pointer)
        .boolean;
  }
}

final class $CustomGeometrySource_GeometryTileRequestType
    extends jni.JObjType<CustomGeometrySource_GeometryTileRequest> {
  const $CustomGeometrySource_GeometryTileRequestType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/style/sources/CustomGeometrySource$GeometryTileRequest;';

  @override
  CustomGeometrySource_GeometryTileRequest fromReference(
          jni.JReference reference) =>
      CustomGeometrySource_GeometryTileRequest.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($CustomGeometrySource_GeometryTileRequestType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($CustomGeometrySource_GeometryTileRequestType) &&
        other is $CustomGeometrySource_GeometryTileRequestType;
  }
}

/// from: `org.maplibre.android.style.sources.CustomGeometrySource$TileID`
class CustomGeometrySource_TileID extends jni.JObject {
  @override
  late final jni.JObjType<CustomGeometrySource_TileID> $type = type;

  CustomGeometrySource_TileID.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/style/sources/CustomGeometrySource$TileID');

  /// The type which includes information such as the signature of this class.
  static const type = $CustomGeometrySource_TileIDType();
  static final _id_new0 = _class.constructorId(
    r'(III)V',
  );

  static final _new0 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<($Int32, $Int32, $Int32)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int, int, int)>();

  /// from: `public void <init>(int i, int i1, int i2)`
  /// The returned object must be released after use, by calling the [release] method.
  factory CustomGeometrySource_TileID(
    int i,
    int i1,
    int i2,
  ) {
    return CustomGeometrySource_TileID.fromReference(
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr, i, i1, i2)
            .reference);
  }

  static final _id_getZ = _class.instanceMethodId(
    r'getZ',
    r'()I',
  );

  static final _getZ = ProtectedJniExtensions.lookup<
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

  /// from: `public final int getZ()`
  int getZ() {
    return _getZ(reference.pointer, _id_getZ as jni.JMethodIDPtr).integer;
  }

  static final _id_setZ = _class.instanceMethodId(
    r'setZ',
    r'(I)V',
  );

  static final _setZ = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<($Int32,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int)>();

  /// from: `public final void setZ(int i)`
  void setZ(
    int i,
  ) {
    _setZ(reference.pointer, _id_setZ as jni.JMethodIDPtr, i).check();
  }

  static final _id_getX = _class.instanceMethodId(
    r'getX',
    r'()I',
  );

  static final _getX = ProtectedJniExtensions.lookup<
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

  /// from: `public final int getX()`
  int getX() {
    return _getX(reference.pointer, _id_getX as jni.JMethodIDPtr).integer;
  }

  static final _id_setX = _class.instanceMethodId(
    r'setX',
    r'(I)V',
  );

  static final _setX = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<($Int32,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int)>();

  /// from: `public final void setX(int i)`
  void setX(
    int i,
  ) {
    _setX(reference.pointer, _id_setX as jni.JMethodIDPtr, i).check();
  }

  static final _id_getY = _class.instanceMethodId(
    r'getY',
    r'()I',
  );

  static final _getY = ProtectedJniExtensions.lookup<
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

  /// from: `public final int getY()`
  int getY() {
    return _getY(reference.pointer, _id_getY as jni.JMethodIDPtr).integer;
  }

  static final _id_setY = _class.instanceMethodId(
    r'setY',
    r'(I)V',
  );

  static final _setY = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<($Int32,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int)>();

  /// from: `public final void setY(int i)`
  void setY(
    int i,
  ) {
    _setY(reference.pointer, _id_setY as jni.JMethodIDPtr, i).check();
  }

  static final _id_hashCode1 = _class.instanceMethodId(
    r'hashCode',
    r'()I',
  );

  static final _hashCode1 = ProtectedJniExtensions.lookup<
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

  /// from: `public int hashCode()`
  int hashCode1() {
    return _hashCode1(reference.pointer, _id_hashCode1 as jni.JMethodIDPtr)
        .integer;
  }

  static final _id_equals = _class.instanceMethodId(
    r'equals',
    r'(Ljava/lang/Object;)Z',
  );

  static final _equals = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallBooleanMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public boolean equals(java.lang.Object object)`
  bool equals(
    jni.JObject object,
  ) {
    return _equals(reference.pointer, _id_equals as jni.JMethodIDPtr,
            object.reference.pointer)
        .boolean;
  }
}

final class $CustomGeometrySource_TileIDType
    extends jni.JObjType<CustomGeometrySource_TileID> {
  const $CustomGeometrySource_TileIDType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/style/sources/CustomGeometrySource$TileID;';

  @override
  CustomGeometrySource_TileID fromReference(jni.JReference reference) =>
      CustomGeometrySource_TileID.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($CustomGeometrySource_TileIDType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($CustomGeometrySource_TileIDType) &&
        other is $CustomGeometrySource_TileIDType;
  }
}

/// from: `org.maplibre.android.style.sources.CustomGeometrySource`
class CustomGeometrySource extends source_.Source {
  @override
  late final jni.JObjType<CustomGeometrySource> $type = type;

  CustomGeometrySource.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/style/sources/CustomGeometrySource');

  /// The type which includes information such as the signature of this class.
  static const type = $CustomGeometrySourceType();
  static final _id_Companion = _class.staticFieldId(
    r'Companion',
    r'Lorg/maplibre/android/style/sources/CustomGeometrySource$Companion;',
  );

  /// from: `static public final org.maplibre.android.style.sources.CustomGeometrySource$Companion Companion`
  /// The returned object must be released after use, by calling the [release] method.
  static CustomGeometrySource_Companion get Companion =>
      _id_Companion.get(_class, const $CustomGeometrySource_CompanionType());

  static final _id_THREAD_PREFIX = _class.staticFieldId(
    r'THREAD_PREFIX',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String THREAD_PREFIX`
  /// The returned object must be released after use, by calling the [release] method.
  static jni.JString get THREAD_PREFIX =>
      _id_THREAD_PREFIX.get(_class, const jni.JStringType());

  /// from: `static public final int THREAD_POOL_LIMIT`
  static const THREAD_POOL_LIMIT = 4;
  static final _id_new2 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/android/style/sources/CustomGeometrySourceOptions;Lorg/maplibre/android/style/sources/GeometryTileProvider;)V',
  );

  static final _new2 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>,
              jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(java.lang.String string, org.maplibre.android.style.sources.CustomGeometrySourceOptions customGeometrySourceOptions, org.maplibre.android.style.sources.GeometryTileProvider geometryTileProvider)`
  /// The returned object must be released after use, by calling the [release] method.
  factory CustomGeometrySource.new2(
    jni.JString string,
    customgeometrysourceoptions_.CustomGeometrySourceOptions
        customGeometrySourceOptions,
    geometrytileprovider_.GeometryTileProvider geometryTileProvider,
  ) {
    return CustomGeometrySource.fromReference(_new2(
            _class.reference.pointer,
            _id_new2 as jni.JMethodIDPtr,
            string.reference.pointer,
            customGeometrySourceOptions.reference.pointer,
            geometryTileProvider.reference.pointer)
        .reference);
  }

  static final _id_new3 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/android/style/sources/GeometryTileProvider;)V',
  );

  static final _new3 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(java.lang.String string, org.maplibre.android.style.sources.GeometryTileProvider geometryTileProvider)`
  /// The returned object must be released after use, by calling the [release] method.
  factory CustomGeometrySource.new3(
    jni.JString string,
    geometrytileprovider_.GeometryTileProvider geometryTileProvider,
  ) {
    return CustomGeometrySource.fromReference(_new3(
            _class.reference.pointer,
            _id_new3 as jni.JMethodIDPtr,
            string.reference.pointer,
            geometryTileProvider.reference.pointer)
        .reference);
  }

  static final _id_invalidateRegion = _class.instanceMethodId(
    r'invalidateRegion',
    r'(Lorg/maplibre/android/geometry/LatLngBounds;)V',
  );

  static final _invalidateRegion = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void invalidateRegion(org.maplibre.android.geometry.LatLngBounds latLngBounds)`
  void invalidateRegion(
    latlngbounds_.LatLngBounds latLngBounds,
  ) {
    _invalidateRegion(
            reference.pointer,
            _id_invalidateRegion as jni.JMethodIDPtr,
            latLngBounds.reference.pointer)
        .check();
  }

  static final _id_invalidateTile = _class.instanceMethodId(
    r'invalidateTile',
    r'(III)V',
  );

  static final _invalidateTile = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<($Int32, $Int32, $Int32)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int, int, int)>();

  /// from: `public final void invalidateTile(int i, int i1, int i2)`
  void invalidateTile(
    int i,
    int i1,
    int i2,
  ) {
    _invalidateTile(reference.pointer, _id_invalidateTile as jni.JMethodIDPtr,
            i, i1, i2)
        .check();
  }

  static final _id_setTileData = _class.instanceMethodId(
    r'setTileData',
    r'(IIILorg/maplibre/geojson/FeatureCollection;)V',
  );

  static final _setTileData = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        $Int32,
                        $Int32,
                        $Int32,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              int, int, int, ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setTileData(int i, int i1, int i2, org.maplibre.geojson.FeatureCollection featureCollection)`
  void setTileData(
    int i,
    int i1,
    int i2,
    jni.JObject featureCollection,
  ) {
    _setTileData(reference.pointer, _id_setTileData as jni.JMethodIDPtr, i, i1,
            i2, featureCollection.reference.pointer)
        .check();
  }

  static final _id_querySourceFeatures = _class.instanceMethodId(
    r'querySourceFeatures',
    r'(Lorg/maplibre/android/style/expressions/Expression;)Ljava/util/List;',
  );

  static final _querySourceFeatures = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final java.util.List querySourceFeatures(org.maplibre.android.style.expressions.Expression expression)`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JList<jni.JObject> querySourceFeatures(
    jni.JObject expression,
  ) {
    return _querySourceFeatures(
            reference.pointer,
            _id_querySourceFeatures as jni.JMethodIDPtr,
            expression.reference.pointer)
        .object(const jni.JListType(jni.JObjectType()));
  }

  static final _id_finalize = _class.instanceMethodId(
    r'finalize',
    r'()V',
  );

  static final _finalize = ProtectedJniExtensions.lookup<
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

  /// from: `protected native final void finalize()`
  void finalize() {
    _finalize(reference.pointer, _id_finalize as jni.JMethodIDPtr).check();
  }
}

final class $CustomGeometrySourceType
    extends jni.JObjType<CustomGeometrySource> {
  const $CustomGeometrySourceType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/style/sources/CustomGeometrySource;';

  @override
  CustomGeometrySource fromReference(jni.JReference reference) =>
      CustomGeometrySource.fromReference(reference);

  @override
  jni.JObjType get superType => const source_.$SourceType();

  @override
  final superCount = 2;

  @override
  int get hashCode => ($CustomGeometrySourceType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($CustomGeometrySourceType) &&
        other is $CustomGeometrySourceType;
  }
}
