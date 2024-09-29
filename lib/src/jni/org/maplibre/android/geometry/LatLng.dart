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

/// from: `org.maplibre.android.geometry.LatLng$Companion`
class LatLng_Companion extends jni.JObject {
  @override
  late final jni.JObjType<LatLng_Companion> $type = type;

  LatLng_Companion.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/geometry/LatLng$Companion');

  /// The type which includes information such as the signature of this class.
  static const type = $LatLng_CompanionType();
  static final _id_wrap = _class.instanceMethodId(
    r'wrap',
    r'(DDD)D',
  );

  static final _wrap = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Double, ffi.Double, ffi.Double)>)>>(
          'globalEnv_CallDoubleMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              double, double, double)>();

  /// from: `public final double wrap(double d, double d1, double d2)`
  double wrap(
    double d,
    double d1,
    double d2,
  ) {
    return _wrap(reference.pointer, _id_wrap as jni.JMethodIDPtr, d, d1, d2)
        .doubleFloat;
  }

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
  factory LatLng_Companion(
    jni.JObject defaultConstructorMarker,
  ) {
    return LatLng_Companion.fromReference(_new0(
            _class.reference.pointer,
            _id_new0 as jni.JMethodIDPtr,
            defaultConstructorMarker.reference.pointer)
        .reference);
  }
}

final class $LatLng_CompanionType extends jni.JObjType<LatLng_Companion> {
  const $LatLng_CompanionType();

  @override
  String get signature => r'Lorg/maplibre/android/geometry/LatLng$Companion;';

  @override
  LatLng_Companion fromReference(jni.JReference reference) =>
      LatLng_Companion.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($LatLng_CompanionType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($LatLng_CompanionType) &&
        other is $LatLng_CompanionType;
  }
}

/// from: `org.maplibre.android.geometry.LatLng`
class LatLng extends jni.JObject {
  @override
  late final jni.JObjType<LatLng> $type = type;

  LatLng.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/geometry/LatLng');

  /// The type which includes information such as the signature of this class.
  static const type = $LatLngType();
  static final _id_Companion = _class.staticFieldId(
    r'Companion',
    r'Lorg/maplibre/android/geometry/LatLng$Companion;',
  );

  /// from: `static public final org.maplibre.android.geometry.LatLng$Companion Companion`
  /// The returned object must be released after use, by calling the [release] method.
  static LatLng_Companion get Companion =>
      _id_Companion.get(_class, const $LatLng_CompanionType());

  static final _id_CREATOR = _class.staticFieldId(
    r'CREATOR',
    r'Landroid/os/Parcelable$Creator;',
  );

  /// from: `static public final android.os.Parcelable$Creator CREATOR`
  /// The returned object must be released after use, by calling the [release] method.
  static jni.JObject get CREATOR =>
      _id_CREATOR.get(_class, const jni.JObjectType());

  static final _id_getLatitude = _class.instanceMethodId(
    r'getLatitude',
    r'()D',
  );

  static final _getLatitude = ProtectedJniExtensions.lookup<
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

  /// from: `public final double getLatitude()`
  double getLatitude() {
    return _getLatitude(reference.pointer, _id_getLatitude as jni.JMethodIDPtr)
        .doubleFloat;
  }

  static final _id_setLatitude = _class.instanceMethodId(
    r'setLatitude',
    r'(D)V',
  );

  static final _setLatitude = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<(ffi.Double,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, double)>();

  /// from: `public final void setLatitude(double d)`
  void setLatitude(
    double d,
  ) {
    _setLatitude(reference.pointer, _id_setLatitude as jni.JMethodIDPtr, d)
        .check();
  }

  static final _id_getLongitude = _class.instanceMethodId(
    r'getLongitude',
    r'()D',
  );

  static final _getLongitude = ProtectedJniExtensions.lookup<
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

  /// from: `public final double getLongitude()`
  double getLongitude() {
    return _getLongitude(
            reference.pointer, _id_getLongitude as jni.JMethodIDPtr)
        .doubleFloat;
  }

  static final _id_setLongitude = _class.instanceMethodId(
    r'setLongitude',
    r'(D)V',
  );

  static final _setLongitude = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<(ffi.Double,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, double)>();

  /// from: `public final void setLongitude(double d)`
  void setLongitude(
    double d,
  ) {
    _setLongitude(reference.pointer, _id_setLongitude as jni.JMethodIDPtr, d)
        .check();
  }

  static final _id_getAltitude = _class.instanceMethodId(
    r'getAltitude',
    r'()D',
  );

  static final _getAltitude = ProtectedJniExtensions.lookup<
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

  /// from: `public final double getAltitude()`
  double getAltitude() {
    return _getAltitude(reference.pointer, _id_getAltitude as jni.JMethodIDPtr)
        .doubleFloat;
  }

  static final _id_setAltitude = _class.instanceMethodId(
    r'setAltitude',
    r'(D)V',
  );

  static final _setAltitude = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<(ffi.Double,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, double)>();

  /// from: `public final void setAltitude(double d)`
  void setAltitude(
    double d,
  ) {
    _setAltitude(reference.pointer, _id_setAltitude as jni.JMethodIDPtr, d)
        .check();
  }

  static final _id_new0 = _class.constructorId(
    r'()V',
  );

  static final _new0 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public void <init>()`
  /// The returned object must be released after use, by calling the [release] method.
  factory LatLng() {
    return LatLng.fromReference(
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr)
            .reference);
  }

  static final _id_new1 = _class.constructorId(
    r'(DD)V',
  );

  static final _new1 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Double, ffi.Double)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, double, double)>();

  /// from: `public void <init>(double d, double d1)`
  /// The returned object must be released after use, by calling the [release] method.
  factory LatLng.new1(
    double d,
    double d1,
  ) {
    return LatLng.fromReference(
        _new1(_class.reference.pointer, _id_new1 as jni.JMethodIDPtr, d, d1)
            .reference);
  }

  static final _id_new2 = _class.constructorId(
    r'(DDD)V',
  );

  static final _new2 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Double, ffi.Double, ffi.Double)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              double, double, double)>();

  /// from: `public void <init>(double d, double d1, double d2)`
  /// The returned object must be released after use, by calling the [release] method.
  factory LatLng.new2(
    double d,
    double d1,
    double d2,
  ) {
    return LatLng.fromReference(
        _new2(_class.reference.pointer, _id_new2 as jni.JMethodIDPtr, d, d1, d2)
            .reference);
  }

  static final _id_new3 = _class.constructorId(
    r'(Landroid/location/Location;)V',
  );

  static final _new3 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(android.location.Location location)`
  /// The returned object must be released after use, by calling the [release] method.
  factory LatLng.new3(
    jni.JObject location,
  ) {
    return LatLng.fromReference(_new3(_class.reference.pointer,
            _id_new3 as jni.JMethodIDPtr, location.reference.pointer)
        .reference);
  }

  static final _id_new4 = _class.constructorId(
    r'(Lorg/maplibre/android/geometry/LatLng;)V',
  );

  static final _new4 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(org.maplibre.android.geometry.LatLng latLng)`
  /// The returned object must be released after use, by calling the [release] method.
  factory LatLng.new4(
    LatLng latLng,
  ) {
    return LatLng.fromReference(_new4(_class.reference.pointer,
            _id_new4 as jni.JMethodIDPtr, latLng.reference.pointer)
        .reference);
  }

  static final _id_new5 = _class.constructorId(
    r'(Landroid/os/Parcel;)V',
  );

  static final _new5 = ProtectedJniExtensions.lookup<
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
  factory LatLng.new5(
    jni.JObject parcel,
  ) {
    return LatLng.fromReference(_new5(_class.reference.pointer,
            _id_new5 as jni.JMethodIDPtr, parcel.reference.pointer)
        .reference);
  }

  static final _id_wrap = _class.instanceMethodId(
    r'wrap',
    r'()Lorg/maplibre/android/geometry/LatLng;',
  );

  static final _wrap = ProtectedJniExtensions.lookup<
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

  /// from: `public final org.maplibre.android.geometry.LatLng wrap()`
  /// The returned object must be released after use, by calling the [release] method.
  LatLng wrap() {
    return _wrap(reference.pointer, _id_wrap as jni.JMethodIDPtr)
        .object(const $LatLngType());
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

  static final _id_toString1 = _class.instanceMethodId(
    r'toString',
    r'()Ljava/lang/String;',
  );

  static final _toString1 = ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String toString()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString toString1() {
    return _toString1(reference.pointer, _id_toString1 as jni.JMethodIDPtr)
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

  static final _id_distanceTo = _class.instanceMethodId(
    r'distanceTo',
    r'(Lorg/maplibre/android/geometry/LatLng;)D',
  );

  static final _distanceTo = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallDoubleMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final double distanceTo(org.maplibre.android.geometry.LatLng latLng)`
  double distanceTo(
    LatLng latLng,
  ) {
    return _distanceTo(reference.pointer, _id_distanceTo as jni.JMethodIDPtr,
            latLng.reference.pointer)
        .doubleFloat;
  }
}

final class $LatLngType extends jni.JObjType<LatLng> {
  const $LatLngType();

  @override
  String get signature => r'Lorg/maplibre/android/geometry/LatLng;';

  @override
  LatLng fromReference(jni.JReference reference) =>
      LatLng.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($LatLngType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($LatLngType) && other is $LatLngType;
  }
}
