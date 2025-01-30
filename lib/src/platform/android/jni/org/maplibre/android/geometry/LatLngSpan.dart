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

/// from: `org.maplibre.android.geometry.LatLngSpan$Companion`
class LatLngSpan$Companion extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<LatLngSpan$Companion> $type;

  @jni$_.internal
  LatLngSpan$Companion.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
      r'org/maplibre/android/geometry/LatLngSpan$Companion');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $LatLngSpan$Companion$NullableType();
  static const type = $LatLngSpan$Companion$Type();
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
  factory LatLngSpan$Companion(
    jni$_.JObject? defaultConstructorMarker,
  ) {
    final _$defaultConstructorMarker =
        defaultConstructorMarker?.reference ?? jni$_.jNullReference;
    return LatLngSpan$Companion.fromReference(_new$(_class.reference.pointer,
            _id_new$ as jni$_.JMethodIDPtr, _$defaultConstructorMarker.pointer)
        .reference);
  }
}

final class $LatLngSpan$Companion$NullableType
    extends jni$_.JObjType<LatLngSpan$Companion?> {
  @jni$_.internal
  const $LatLngSpan$Companion$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/geometry/LatLngSpan$Companion;';

  @jni$_.internal
  @core$_.override
  LatLngSpan$Companion? fromReference(jni$_.JReference reference) =>
      reference.isNull
          ? null
          : LatLngSpan$Companion.fromReference(
              reference,
            );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<LatLngSpan$Companion?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($LatLngSpan$Companion$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LatLngSpan$Companion$NullableType) &&
        other is $LatLngSpan$Companion$NullableType;
  }
}

final class $LatLngSpan$Companion$Type
    extends jni$_.JObjType<LatLngSpan$Companion> {
  @jni$_.internal
  const $LatLngSpan$Companion$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/geometry/LatLngSpan$Companion;';

  @jni$_.internal
  @core$_.override
  LatLngSpan$Companion fromReference(jni$_.JReference reference) =>
      LatLngSpan$Companion.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<LatLngSpan$Companion?> get nullableType =>
      const $LatLngSpan$Companion$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($LatLngSpan$Companion$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LatLngSpan$Companion$Type) &&
        other is $LatLngSpan$Companion$Type;
  }
}

/// from: `org.maplibre.android.geometry.LatLngSpan`
class LatLngSpan extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<LatLngSpan> $type;

  @jni$_.internal
  LatLngSpan.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/geometry/LatLngSpan');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $LatLngSpan$NullableType();
  static const type = $LatLngSpan$Type();
  static final _id_Companion = _class.staticFieldId(
    r'Companion',
    r'Lorg/maplibre/android/geometry/LatLngSpan$Companion;',
  );

  /// from: `static public final org.maplibre.android.geometry.LatLngSpan$Companion Companion`
  /// The returned object must be released after use, by calling the [release] method.
  static LatLngSpan$Companion get Companion =>
      _id_Companion.get(_class, const $LatLngSpan$Companion$Type());

  static final _id_CREATOR = _class.staticFieldId(
    r'CREATOR',
    r'Landroid/os/Parcelable$Creator;',
  );

  /// from: `static public final android.os.Parcelable$Creator CREATOR`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JObject get CREATOR =>
      _id_CREATOR.get(_class, const jni$_.JObjectType());

  static final _id_getLatitudeSpan = _class.instanceMethodId(
    r'getLatitudeSpan',
    r'()D',
  );

  static final _getLatitudeSpan = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public final double getLatitudeSpan()`
  double getLatitudeSpan() {
    return _getLatitudeSpan(
            reference.pointer, _id_getLatitudeSpan as jni$_.JMethodIDPtr)
        .doubleFloat;
  }

  static final _id_setLatitudeSpan = _class.instanceMethodId(
    r'setLatitudeSpan',
    r'(D)V',
  );

  static final _setLatitudeSpan = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<(jni$_.Double,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, double)>();

  /// from: `public final void setLatitudeSpan(double d)`
  void setLatitudeSpan(
    double d,
  ) {
    _setLatitudeSpan(
            reference.pointer, _id_setLatitudeSpan as jni$_.JMethodIDPtr, d)
        .check();
  }

  static final _id_getLongitudeSpan = _class.instanceMethodId(
    r'getLongitudeSpan',
    r'()D',
  );

  static final _getLongitudeSpan = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public final double getLongitudeSpan()`
  double getLongitudeSpan() {
    return _getLongitudeSpan(
            reference.pointer, _id_getLongitudeSpan as jni$_.JMethodIDPtr)
        .doubleFloat;
  }

  static final _id_setLongitudeSpan = _class.instanceMethodId(
    r'setLongitudeSpan',
    r'(D)V',
  );

  static final _setLongitudeSpan = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<(jni$_.Double,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, double)>();

  /// from: `public final void setLongitudeSpan(double d)`
  void setLongitudeSpan(
    double d,
  ) {
    _setLongitudeSpan(
            reference.pointer, _id_setLongitudeSpan as jni$_.JMethodIDPtr, d)
        .check();
  }

  static final _id_new$ = _class.constructorId(
    r'(DD)V',
  );

  static final _new$ = jni$_.ProtectedJniExtensions.lookup<
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
  factory LatLngSpan(
    double d,
    double d1,
  ) {
    return LatLngSpan.fromReference(
        _new$(_class.reference.pointer, _id_new$ as jni$_.JMethodIDPtr, d, d1)
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
  factory LatLngSpan.new$1(
    jni$_.JObject? parcel,
    jni$_.JObject? defaultConstructorMarker,
  ) {
    final _$parcel = parcel?.reference ?? jni$_.jNullReference;
    final _$defaultConstructorMarker =
        defaultConstructorMarker?.reference ?? jni$_.jNullReference;
    return LatLngSpan.fromReference(_new$1(
            _class.reference.pointer,
            _id_new$1 as jni$_.JMethodIDPtr,
            _$parcel.pointer,
            _$defaultConstructorMarker.pointer)
        .reference);
  }
}

final class $LatLngSpan$NullableType extends jni$_.JObjType<LatLngSpan?> {
  @jni$_.internal
  const $LatLngSpan$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/geometry/LatLngSpan;';

  @jni$_.internal
  @core$_.override
  LatLngSpan? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : LatLngSpan.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<LatLngSpan?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($LatLngSpan$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LatLngSpan$NullableType) &&
        other is $LatLngSpan$NullableType;
  }
}

final class $LatLngSpan$Type extends jni$_.JObjType<LatLngSpan> {
  @jni$_.internal
  const $LatLngSpan$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/geometry/LatLngSpan;';

  @jni$_.internal
  @core$_.override
  LatLngSpan fromReference(jni$_.JReference reference) =>
      LatLngSpan.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<LatLngSpan?> get nullableType =>
      const $LatLngSpan$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($LatLngSpan$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LatLngSpan$Type) && other is $LatLngSpan$Type;
  }
}
