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

import 'LatLng.dart' as latlng$_;

import 'LatLngBounds.dart' as latlngbounds$_;

/// from: `org.maplibre.android.geometry.VisibleRegion$Companion`
class VisibleRegion$Companion extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<VisibleRegion$Companion> $type;

  @jni$_.internal
  VisibleRegion$Companion.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
      r'org/maplibre/android/geometry/VisibleRegion$Companion');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $VisibleRegion$Companion$NullableType();
  static const type = $VisibleRegion$Companion$Type();
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
  factory VisibleRegion$Companion(
    jni$_.JObject? defaultConstructorMarker,
  ) {
    final _$defaultConstructorMarker =
        defaultConstructorMarker?.reference ?? jni$_.jNullReference;
    return VisibleRegion$Companion.fromReference(_new$(_class.reference.pointer,
            _id_new$ as jni$_.JMethodIDPtr, _$defaultConstructorMarker.pointer)
        .reference);
  }
}

final class $VisibleRegion$Companion$NullableType
    extends jni$_.JObjType<VisibleRegion$Companion?> {
  @jni$_.internal
  const $VisibleRegion$Companion$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/geometry/VisibleRegion$Companion;';

  @jni$_.internal
  @core$_.override
  VisibleRegion$Companion? fromReference(jni$_.JReference reference) =>
      reference.isNull
          ? null
          : VisibleRegion$Companion.fromReference(
              reference,
            );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<VisibleRegion$Companion?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($VisibleRegion$Companion$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($VisibleRegion$Companion$NullableType) &&
        other is $VisibleRegion$Companion$NullableType;
  }
}

final class $VisibleRegion$Companion$Type
    extends jni$_.JObjType<VisibleRegion$Companion> {
  @jni$_.internal
  const $VisibleRegion$Companion$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/geometry/VisibleRegion$Companion;';

  @jni$_.internal
  @core$_.override
  VisibleRegion$Companion fromReference(jni$_.JReference reference) =>
      VisibleRegion$Companion.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<VisibleRegion$Companion?> get nullableType =>
      const $VisibleRegion$Companion$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($VisibleRegion$Companion$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($VisibleRegion$Companion$Type) &&
        other is $VisibleRegion$Companion$Type;
  }
}

/// from: `org.maplibre.android.geometry.VisibleRegion`
class VisibleRegion extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<VisibleRegion> $type;

  @jni$_.internal
  VisibleRegion.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/geometry/VisibleRegion');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $VisibleRegion$NullableType();
  static const type = $VisibleRegion$Type();
  static final _id_Companion = _class.staticFieldId(
    r'Companion',
    r'Lorg/maplibre/android/geometry/VisibleRegion$Companion;',
  );

  /// from: `static public final org.maplibre.android.geometry.VisibleRegion$Companion Companion`
  /// The returned object must be released after use, by calling the [release] method.
  static VisibleRegion$Companion? get Companion =>
      _id_Companion.get(_class, const $VisibleRegion$Companion$NullableType());

  static final _id_farLeft = _class.instanceFieldId(
    r'farLeft',
    r'Lorg/maplibre/android/geometry/LatLng;',
  );

  /// from: `public final org.maplibre.android.geometry.LatLng farLeft`
  /// The returned object must be released after use, by calling the [release] method.
  latlng$_.LatLng? get farLeft =>
      _id_farLeft.get(this, const latlng$_.$LatLng$NullableType());

  static final _id_farRight = _class.instanceFieldId(
    r'farRight',
    r'Lorg/maplibre/android/geometry/LatLng;',
  );

  /// from: `public final org.maplibre.android.geometry.LatLng farRight`
  /// The returned object must be released after use, by calling the [release] method.
  latlng$_.LatLng? get farRight =>
      _id_farRight.get(this, const latlng$_.$LatLng$NullableType());

  static final _id_nearLeft = _class.instanceFieldId(
    r'nearLeft',
    r'Lorg/maplibre/android/geometry/LatLng;',
  );

  /// from: `public final org.maplibre.android.geometry.LatLng nearLeft`
  /// The returned object must be released after use, by calling the [release] method.
  latlng$_.LatLng? get nearLeft =>
      _id_nearLeft.get(this, const latlng$_.$LatLng$NullableType());

  static final _id_nearRight = _class.instanceFieldId(
    r'nearRight',
    r'Lorg/maplibre/android/geometry/LatLng;',
  );

  /// from: `public final org.maplibre.android.geometry.LatLng nearRight`
  /// The returned object must be released after use, by calling the [release] method.
  latlng$_.LatLng? get nearRight =>
      _id_nearRight.get(this, const latlng$_.$LatLng$NullableType());

  static final _id_latLngBounds = _class.instanceFieldId(
    r'latLngBounds',
    r'Lorg/maplibre/android/geometry/LatLngBounds;',
  );

  /// from: `public final org.maplibre.android.geometry.LatLngBounds latLngBounds`
  /// The returned object must be released after use, by calling the [release] method.
  latlngbounds$_.LatLngBounds get latLngBounds =>
      _id_latLngBounds.get(this, const latlngbounds$_.$LatLngBounds$Type());

  static final _id_CREATOR = _class.staticFieldId(
    r'CREATOR',
    r'Landroid/os/Parcelable$Creator;',
  );

  /// from: `static public final android.os.Parcelable$Creator CREATOR`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JObject? get CREATOR =>
      _id_CREATOR.get(_class, const jni$_.JObjectNullableType());

  static final _id_new$ = _class.constructorId(
    r'(Lorg/maplibre/android/geometry/LatLng;Lorg/maplibre/android/geometry/LatLng;Lorg/maplibre/android/geometry/LatLng;Lorg/maplibre/android/geometry/LatLng;Lorg/maplibre/android/geometry/LatLngBounds;)V',
  );

  static final _new$ = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void <init>(org.maplibre.android.geometry.LatLng latLng, org.maplibre.android.geometry.LatLng latLng1, org.maplibre.android.geometry.LatLng latLng2, org.maplibre.android.geometry.LatLng latLng3, org.maplibre.android.geometry.LatLngBounds latLngBounds)`
  /// The returned object must be released after use, by calling the [release] method.
  factory VisibleRegion(
    latlng$_.LatLng latLng,
    latlng$_.LatLng latLng1,
    latlng$_.LatLng latLng2,
    latlng$_.LatLng latLng3,
    latlngbounds$_.LatLngBounds latLngBounds,
  ) {
    final _$latLng = latLng.reference;
    final _$latLng1 = latLng1.reference;
    final _$latLng2 = latLng2.reference;
    final _$latLng3 = latLng3.reference;
    final _$latLngBounds = latLngBounds.reference;
    return VisibleRegion.fromReference(_new$(
            _class.reference.pointer,
            _id_new$ as jni$_.JMethodIDPtr,
            _$latLng.pointer,
            _$latLng1.pointer,
            _$latLng2.pointer,
            _$latLng3.pointer,
            _$latLngBounds.pointer)
        .reference);
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

  static final _id_new$1 = _class.constructorId(
    r'(Landroid/os/Parcel;Lkotlin/jvm/internal/DefaultConstructorMarker;)V',
  );

  static final _new$1 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `synthetic public void <init>(android.os.Parcel parcel, kotlin.jvm.internal.DefaultConstructorMarker defaultConstructorMarker)`
  /// The returned object must be released after use, by calling the [release] method.
  factory VisibleRegion.new$1(
    jni$_.JObject? parcel,
    jni$_.JObject? defaultConstructorMarker,
  ) {
    final _$parcel = parcel?.reference ?? jni$_.jNullReference;
    final _$defaultConstructorMarker =
        defaultConstructorMarker?.reference ?? jni$_.jNullReference;
    return VisibleRegion.fromReference(_new$1(
            _class.reference.pointer,
            _id_new$1 as jni$_.JMethodIDPtr,
            _$parcel.pointer,
            _$defaultConstructorMarker.pointer)
        .reference);
  }
}

final class $VisibleRegion$NullableType extends jni$_.JObjType<VisibleRegion?> {
  @jni$_.internal
  const $VisibleRegion$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/geometry/VisibleRegion;';

  @jni$_.internal
  @core$_.override
  VisibleRegion? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : VisibleRegion.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<VisibleRegion?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($VisibleRegion$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($VisibleRegion$NullableType) &&
        other is $VisibleRegion$NullableType;
  }
}

final class $VisibleRegion$Type extends jni$_.JObjType<VisibleRegion> {
  @jni$_.internal
  const $VisibleRegion$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/geometry/VisibleRegion;';

  @jni$_.internal
  @core$_.override
  VisibleRegion fromReference(jni$_.JReference reference) =>
      VisibleRegion.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<VisibleRegion?> get nullableType =>
      const $VisibleRegion$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($VisibleRegion$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($VisibleRegion$Type) &&
        other is $VisibleRegion$Type;
  }
}