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

import 'LatLng.dart' as latlng_;

import 'LatLngBounds.dart' as latlngbounds_;

/// from: `org.maplibre.android.geometry.VisibleRegion$Companion`
class VisibleRegion_Companion extends jni.JObject {
  @override
  late final jni.JObjType<VisibleRegion_Companion> $type = type;

  VisibleRegion_Companion.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/geometry/VisibleRegion$Companion');

  /// The type which includes information such as the signature of this class.
  static const type = $VisibleRegion_CompanionType();
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
  factory VisibleRegion_Companion(
    jni.JObject defaultConstructorMarker,
  ) {
    return VisibleRegion_Companion.fromReference(_new0(
            _class.reference.pointer,
            _id_new0 as jni.JMethodIDPtr,
            defaultConstructorMarker.reference.pointer)
        .reference);
  }
}

final class $VisibleRegion_CompanionType
    extends jni.JObjType<VisibleRegion_Companion> {
  const $VisibleRegion_CompanionType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/geometry/VisibleRegion$Companion;';

  @override
  VisibleRegion_Companion fromReference(jni.JReference reference) =>
      VisibleRegion_Companion.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($VisibleRegion_CompanionType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($VisibleRegion_CompanionType) &&
        other is $VisibleRegion_CompanionType;
  }
}

/// from: `org.maplibre.android.geometry.VisibleRegion`
class VisibleRegion extends jni.JObject {
  @override
  late final jni.JObjType<VisibleRegion> $type = type;

  VisibleRegion.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/geometry/VisibleRegion');

  /// The type which includes information such as the signature of this class.
  static const type = $VisibleRegionType();
  static final _id_Companion = _class.staticFieldId(
    r'Companion',
    r'Lorg/maplibre/android/geometry/VisibleRegion$Companion;',
  );

  /// from: `static public final org.maplibre.android.geometry.VisibleRegion$Companion Companion`
  /// The returned object must be released after use, by calling the [release] method.
  static VisibleRegion_Companion get Companion =>
      _id_Companion.get(_class, const $VisibleRegion_CompanionType());

  static final _id_farLeft = _class.instanceFieldId(
    r'farLeft',
    r'Lorg/maplibre/android/geometry/LatLng;',
  );

  /// from: `public final org.maplibre.android.geometry.LatLng farLeft`
  /// The returned object must be released after use, by calling the [release] method.
  latlng_.LatLng get farLeft =>
      _id_farLeft.get(this, const latlng_.$LatLngType());

  static final _id_farRight = _class.instanceFieldId(
    r'farRight',
    r'Lorg/maplibre/android/geometry/LatLng;',
  );

  /// from: `public final org.maplibre.android.geometry.LatLng farRight`
  /// The returned object must be released after use, by calling the [release] method.
  latlng_.LatLng get farRight =>
      _id_farRight.get(this, const latlng_.$LatLngType());

  static final _id_nearLeft = _class.instanceFieldId(
    r'nearLeft',
    r'Lorg/maplibre/android/geometry/LatLng;',
  );

  /// from: `public final org.maplibre.android.geometry.LatLng nearLeft`
  /// The returned object must be released after use, by calling the [release] method.
  latlng_.LatLng get nearLeft =>
      _id_nearLeft.get(this, const latlng_.$LatLngType());

  static final _id_nearRight = _class.instanceFieldId(
    r'nearRight',
    r'Lorg/maplibre/android/geometry/LatLng;',
  );

  /// from: `public final org.maplibre.android.geometry.LatLng nearRight`
  /// The returned object must be released after use, by calling the [release] method.
  latlng_.LatLng get nearRight =>
      _id_nearRight.get(this, const latlng_.$LatLngType());

  static final _id_latLngBounds = _class.instanceFieldId(
    r'latLngBounds',
    r'Lorg/maplibre/android/geometry/LatLngBounds;',
  );

  /// from: `public final org.maplibre.android.geometry.LatLngBounds latLngBounds`
  /// The returned object must be released after use, by calling the [release] method.
  latlngbounds_.LatLngBounds get latLngBounds =>
      _id_latLngBounds.get(this, const latlngbounds_.$LatLngBoundsType());

  static final _id_CREATOR = _class.staticFieldId(
    r'CREATOR',
    r'Landroid/os/Parcelable$Creator;',
  );

  /// from: `static public final android.os.Parcelable$Creator CREATOR`
  /// The returned object must be released after use, by calling the [release] method.
  static jni.JObject get CREATOR =>
      _id_CREATOR.get(_class, const jni.JObjectType());

  static final _id_new0 = _class.constructorId(
    r'(Lorg/maplibre/android/geometry/LatLng;Lorg/maplibre/android/geometry/LatLng;Lorg/maplibre/android/geometry/LatLng;Lorg/maplibre/android/geometry/LatLng;Lorg/maplibre/android/geometry/LatLngBounds;)V',
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
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(org.maplibre.android.geometry.LatLng latLng, org.maplibre.android.geometry.LatLng latLng1, org.maplibre.android.geometry.LatLng latLng2, org.maplibre.android.geometry.LatLng latLng3, org.maplibre.android.geometry.LatLngBounds latLngBounds)`
  /// The returned object must be released after use, by calling the [release] method.
  factory VisibleRegion(
    latlng_.LatLng latLng,
    latlng_.LatLng latLng1,
    latlng_.LatLng latLng2,
    latlng_.LatLng latLng3,
    latlngbounds_.LatLngBounds latLngBounds,
  ) {
    return VisibleRegion.fromReference(_new0(
            _class.reference.pointer,
            _id_new0 as jni.JMethodIDPtr,
            latLng.reference.pointer,
            latLng1.reference.pointer,
            latLng2.reference.pointer,
            latLng3.reference.pointer,
            latLngBounds.reference.pointer)
        .reference);
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

  static final _id_new1 = _class.constructorId(
    r'(Landroid/os/Parcel;Lkotlin/jvm/internal/DefaultConstructorMarker;)V',
  );

  static final _new1 = ProtectedJniExtensions.lookup<
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

  /// from: `public void <init>(android.os.Parcel parcel, kotlin.jvm.internal.DefaultConstructorMarker defaultConstructorMarker)`
  /// The returned object must be released after use, by calling the [release] method.
  factory VisibleRegion.new1(
    jni.JObject parcel,
    jni.JObject defaultConstructorMarker,
  ) {
    return VisibleRegion.fromReference(_new1(
            _class.reference.pointer,
            _id_new1 as jni.JMethodIDPtr,
            parcel.reference.pointer,
            defaultConstructorMarker.reference.pointer)
        .reference);
  }
}

final class $VisibleRegionType extends jni.JObjType<VisibleRegion> {
  const $VisibleRegionType();

  @override
  String get signature => r'Lorg/maplibre/android/geometry/VisibleRegion;';

  @override
  VisibleRegion fromReference(jni.JReference reference) =>
      VisibleRegion.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($VisibleRegionType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($VisibleRegionType) &&
        other is $VisibleRegionType;
  }
}
