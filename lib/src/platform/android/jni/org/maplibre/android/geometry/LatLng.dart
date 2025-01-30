// Autogenerated by jnigen. DO NOT EDIT!

// ignore_for_file: document_ignores
// ignore_for_file: avoid_catches_without_on_clauses
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

import '../../../../android/location/Location.dart' as location$_;

/// from: `org.maplibre.android.geometry.LatLng$Companion`
class LatLng$Companion extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<LatLng$Companion> $type;

  @jni$_.internal
  LatLng$Companion.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/geometry/LatLng$Companion');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $LatLng$Companion$NullableType();
  static const type = $LatLng$Companion$Type();
  static final _id_wrap = _class.instanceMethodId(
    r'wrap',
    r'(DDD)D',
  );

  static final _wrap = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Double,
                        jni$_.Double,
                        jni$_.Double
                      )>)>>('globalEnv_CallDoubleMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, double, double, double)>();

  /// from: `public final double wrap(double d, double d1, double d2)`
  double wrap(
    double d,
    double d1,
    double d2,
  ) {
    return _wrap(reference.pointer, _id_wrap as jni$_.JMethodIDPtr, d, d1, d2)
        .doubleFloat;
  }

  static final _id_new$ = _class.constructorId(
    r'(Lkotlin/jvm/internal/DefaultConstructorMarker;)V',
  );

  static final _new$ = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `synthetic public void <init>(kotlin.jvm.internal.DefaultConstructorMarker defaultConstructorMarker)`
  /// The returned object must be released after use, by calling the [release] method.
  factory LatLng$Companion(
    jni$_.JObject? defaultConstructorMarker,
  ) {
    final _$defaultConstructorMarker =
        defaultConstructorMarker?.reference ?? jni$_.jNullReference;
    return LatLng$Companion.fromReference(_new$(_class.reference.pointer,
            _id_new$ as jni$_.JMethodIDPtr, _$defaultConstructorMarker.pointer)
        .reference);
  }
}

final class $LatLng$Companion$NullableType
    extends jni$_.JObjType<LatLng$Companion?> {
  @jni$_.internal
  const $LatLng$Companion$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/geometry/LatLng$Companion;';

  @jni$_.internal
  @core$_.override
  LatLng$Companion? fromReference(jni$_.JReference reference) =>
      reference.isNull
          ? null
          : LatLng$Companion.fromReference(
              reference,
            );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<LatLng$Companion?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($LatLng$Companion$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LatLng$Companion$NullableType) &&
        other is $LatLng$Companion$NullableType;
  }
}

final class $LatLng$Companion$Type extends jni$_.JObjType<LatLng$Companion> {
  @jni$_.internal
  const $LatLng$Companion$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/geometry/LatLng$Companion;';

  @jni$_.internal
  @core$_.override
  LatLng$Companion fromReference(jni$_.JReference reference) =>
      LatLng$Companion.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<LatLng$Companion?> get nullableType =>
      const $LatLng$Companion$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($LatLng$Companion$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LatLng$Companion$Type) &&
        other is $LatLng$Companion$Type;
  }
}

/// from: `org.maplibre.android.geometry.LatLng`
class LatLng extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<LatLng> $type;

  @jni$_.internal
  LatLng.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/geometry/LatLng');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $LatLng$NullableType();
  static const type = $LatLng$Type();
  static final _id_Companion = _class.staticFieldId(
    r'Companion',
    r'Lorg/maplibre/android/geometry/LatLng$Companion;',
  );

  /// from: `static public final org.maplibre.android.geometry.LatLng$Companion Companion`
  /// The returned object must be released after use, by calling the [release] method.
  static LatLng$Companion get Companion =>
      _id_Companion.get(_class, const $LatLng$Companion$Type());

  static final _id_CREATOR = _class.staticFieldId(
    r'CREATOR',
    r'Landroid/os/Parcelable$Creator;',
  );

  /// from: `static public final android.os.Parcelable$Creator CREATOR`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JObject get CREATOR =>
      _id_CREATOR.get(_class, const jni$_.JObjectType());

  static final _id_getLatitude = _class.instanceMethodId(
    r'getLatitude',
    r'()D',
  );

  static final _getLatitude = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallDoubleMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public final double getLatitude()`
  double getLatitude() {
    return _getLatitude(
            reference.pointer, _id_getLatitude as jni$_.JMethodIDPtr)
        .doubleFloat;
  }

  static final _id_setLatitude = _class.instanceMethodId(
    r'setLatitude',
    r'(D)V',
  );

  static final _setLatitude = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<(jni$_.Double,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, double)>();

  /// from: `public final void setLatitude(double d)`
  void setLatitude(
    double d,
  ) {
    _setLatitude(reference.pointer, _id_setLatitude as jni$_.JMethodIDPtr, d)
        .check();
  }

  static final _id_getLongitude = _class.instanceMethodId(
    r'getLongitude',
    r'()D',
  );

  static final _getLongitude = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallDoubleMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public final double getLongitude()`
  double getLongitude() {
    return _getLongitude(
            reference.pointer, _id_getLongitude as jni$_.JMethodIDPtr)
        .doubleFloat;
  }

  static final _id_setLongitude = _class.instanceMethodId(
    r'setLongitude',
    r'(D)V',
  );

  static final _setLongitude = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<(jni$_.Double,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, double)>();

  /// from: `public final void setLongitude(double d)`
  void setLongitude(
    double d,
  ) {
    _setLongitude(reference.pointer, _id_setLongitude as jni$_.JMethodIDPtr, d)
        .check();
  }

  static final _id_getAltitude = _class.instanceMethodId(
    r'getAltitude',
    r'()D',
  );

  static final _getAltitude = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallDoubleMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public final double getAltitude()`
  double getAltitude() {
    return _getAltitude(
            reference.pointer, _id_getAltitude as jni$_.JMethodIDPtr)
        .doubleFloat;
  }

  static final _id_setAltitude = _class.instanceMethodId(
    r'setAltitude',
    r'(D)V',
  );

  static final _setAltitude = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<(jni$_.Double,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, double)>();

  /// from: `public final void setAltitude(double d)`
  void setAltitude(
    double d,
  ) {
    _setAltitude(reference.pointer, _id_setAltitude as jni$_.JMethodIDPtr, d)
        .check();
  }

  static final _id_new$ = _class.constructorId(
    r'()V',
  );

  static final _new$ = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public void <init>()`
  /// The returned object must be released after use, by calling the [release] method.
  factory LatLng() {
    return LatLng.fromReference(
        _new$(_class.reference.pointer, _id_new$ as jni$_.JMethodIDPtr)
            .reference);
  }

  static final _id_new$1 = _class.constructorId(
    r'(DD)V',
  );

  static final _new$1 = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Double, jni$_.Double)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, double, double)>();

  /// from: `public void <init>(double d, double d1)`
  /// The returned object must be released after use, by calling the [release] method.
  factory LatLng.new$1(
    double d,
    double d1,
  ) {
    return LatLng.fromReference(
        _new$1(_class.reference.pointer, _id_new$1 as jni$_.JMethodIDPtr, d, d1)
            .reference);
  }

  static final _id_new$2 = _class.constructorId(
    r'(DDD)V',
  );

  static final _new$2 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Double,
                        jni$_.Double,
                        jni$_.Double
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, double, double, double)>();

  /// from: `public void <init>(double d, double d1, double d2)`
  /// The returned object must be released after use, by calling the [release] method.
  factory LatLng.new$2(
    double d,
    double d1,
    double d2,
  ) {
    return LatLng.fromReference(_new$2(_class.reference.pointer,
            _id_new$2 as jni$_.JMethodIDPtr, d, d1, d2)
        .reference);
  }

  static final _id_new$3 = _class.constructorId(
    r'(Landroid/location/Location;)V',
  );

  static final _new$3 = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void <init>(android.location.Location location)`
  /// The returned object must be released after use, by calling the [release] method.
  factory LatLng.new$3(
    location$_.Location location,
  ) {
    final _$location = location.reference;
    return LatLng.fromReference(_new$3(_class.reference.pointer,
            _id_new$3 as jni$_.JMethodIDPtr, _$location.pointer)
        .reference);
  }

  static final _id_new$4 = _class.constructorId(
    r'(Lorg/maplibre/android/geometry/LatLng;)V',
  );

  static final _new$4 = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void <init>(org.maplibre.android.geometry.LatLng latLng)`
  /// The returned object must be released after use, by calling the [release] method.
  factory LatLng.new$4(
    LatLng latLng,
  ) {
    final _$latLng = latLng.reference;
    return LatLng.fromReference(_new$4(_class.reference.pointer,
            _id_new$4 as jni$_.JMethodIDPtr, _$latLng.pointer)
        .reference);
  }

  static final _id_new$5 = _class.constructorId(
    r'(Landroid/os/Parcel;)V',
  );

  static final _new$5 = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void <init>(android.os.Parcel parcel)`
  /// The returned object must be released after use, by calling the [release] method.
  factory LatLng.new$5(
    jni$_.JObject parcel,
  ) {
    final _$parcel = parcel.reference;
    return LatLng.fromReference(_new$5(_class.reference.pointer,
            _id_new$5 as jni$_.JMethodIDPtr, _$parcel.pointer)
        .reference);
  }

  static final _id_wrap = _class.instanceMethodId(
    r'wrap',
    r'()Lorg/maplibre/android/geometry/LatLng;',
  );

  static final _wrap = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public final org.maplibre.android.geometry.LatLng wrap()`
  /// The returned object must be released after use, by calling the [release] method.
  LatLng wrap() {
    return _wrap(reference.pointer, _id_wrap as jni$_.JMethodIDPtr)
        .object<LatLng>(const $LatLng$Type());
  }

  static final _id_equals = _class.instanceMethodId(
    r'equals',
    r'(Ljava/lang/Object;)Z',
  );

  static final _equals = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallBooleanMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public boolean equals(java.lang.Object object)`
  bool equals(
    jni$_.JObject? object,
  ) {
    final _$object = object?.reference ?? jni$_.jNullReference;
    return _equals(reference.pointer, _id_equals as jni$_.JMethodIDPtr,
            _$object.pointer)
        .boolean;
  }

  static final _id_hashCode$1 = _class.instanceMethodId(
    r'hashCode',
    r'()I',
  );

  static final _hashCode$1 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallIntMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public int hashCode()`
  int hashCode$1() {
    return _hashCode$1(reference.pointer, _id_hashCode$1 as jni$_.JMethodIDPtr)
        .integer;
  }

  static final _id_toString$1 = _class.instanceMethodId(
    r'toString',
    r'()Ljava/lang/String;',
  );

  static final _toString$1 = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String toString()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString toString$1() {
    return _toString$1(reference.pointer, _id_toString$1 as jni$_.JMethodIDPtr)
        .object<jni$_.JString>(const jni$_.JStringType());
  }

  static final _id_describeContents = _class.instanceMethodId(
    r'describeContents',
    r'()I',
  );

  static final _describeContents = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallIntMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public int describeContents()`
  int describeContents() {
    return _describeContents(
            reference.pointer, _id_describeContents as jni$_.JMethodIDPtr)
        .integer;
  }

  static final _id_writeToParcel = _class.instanceMethodId(
    r'writeToParcel',
    r'(Landroid/os/Parcel;I)V',
  );

  static final _writeToParcel = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_
                          .VarArgs<(jni$_.Pointer<jni$_.Void>, jni$_.Int32)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>, int)>();

  /// from: `public void writeToParcel(android.os.Parcel parcel, int i)`
  void writeToParcel(
    jni$_.JObject parcel,
    int i,
  ) {
    final _$parcel = parcel.reference;
    _writeToParcel(reference.pointer, _id_writeToParcel as jni$_.JMethodIDPtr,
            _$parcel.pointer, i)
        .check();
  }

  static final _id_distanceTo = _class.instanceMethodId(
    r'distanceTo',
    r'(Lorg/maplibre/android/geometry/LatLng;)D',
  );

  static final _distanceTo = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallDoubleMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public final double distanceTo(org.maplibre.android.geometry.LatLng latLng)`
  double distanceTo(
    LatLng latLng,
  ) {
    final _$latLng = latLng.reference;
    return _distanceTo(reference.pointer, _id_distanceTo as jni$_.JMethodIDPtr,
            _$latLng.pointer)
        .doubleFloat;
  }
}

final class $LatLng$NullableType extends jni$_.JObjType<LatLng?> {
  @jni$_.internal
  const $LatLng$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/geometry/LatLng;';

  @jni$_.internal
  @core$_.override
  LatLng? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : LatLng.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<LatLng?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($LatLng$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LatLng$NullableType) &&
        other is $LatLng$NullableType;
  }
}

final class $LatLng$Type extends jni$_.JObjType<LatLng> {
  @jni$_.internal
  const $LatLng$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/geometry/LatLng;';

  @jni$_.internal
  @core$_.override
  LatLng fromReference(jni$_.JReference reference) => LatLng.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<LatLng?> get nullableType => const $LatLng$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($LatLng$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LatLng$Type) && other is $LatLng$Type;
  }
}
