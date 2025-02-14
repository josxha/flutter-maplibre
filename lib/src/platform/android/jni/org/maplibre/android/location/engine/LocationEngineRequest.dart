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

/// from: `org.maplibre.android.location.engine.LocationEngineRequest$Builder`
class LocationEngineRequest$Builder extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<LocationEngineRequest$Builder> $type;

  @jni$_.internal
  LocationEngineRequest$Builder.fromReference(jni$_.JReference reference)
    : $type = type,
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
    r'org/maplibre/android/location/engine/LocationEngineRequest$Builder',
  );

  /// The type which includes information such as the signature of this class.
  static const nullableType = $LocationEngineRequest$Builder$NullableType();
  static const type = $LocationEngineRequest$Builder$Type();
  static final _id_new$ = _class.constructorId(r'(J)V');

  static final _new$ =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Int64,)>,
              )
            >
          >('globalEnv_NewObject')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              int,
            )
          >();

  /// from: `public void <init>(long j)`
  /// The returned object must be released after use, by calling the [release] method.
  factory LocationEngineRequest$Builder(int j) {
    return LocationEngineRequest$Builder.fromReference(
      _new$(
        _class.reference.pointer,
        _id_new$ as jni$_.JMethodIDPtr,
        j,
      ).reference,
    );
  }

  static final _id_setPriority = _class.instanceMethodId(
    r'setPriority',
    r'(I)Lorg/maplibre/android/location/engine/LocationEngineRequest$Builder;',
  );

  static final _setPriority =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Int32,)>,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              int,
            )
          >();

  /// from: `public org.maplibre.android.location.engine.LocationEngineRequest$Builder setPriority(int i)`
  /// The returned object must be released after use, by calling the [release] method.
  LocationEngineRequest$Builder? setPriority(int i) {
    return _setPriority(
      reference.pointer,
      _id_setPriority as jni$_.JMethodIDPtr,
      i,
    ).object<LocationEngineRequest$Builder?>(
      const $LocationEngineRequest$Builder$NullableType(),
    );
  }

  static final _id_setDisplacement = _class.instanceMethodId(
    r'setDisplacement',
    r'(F)Lorg/maplibre/android/location/engine/LocationEngineRequest$Builder;',
  );

  static final _setDisplacement =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Double,)>,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              double,
            )
          >();

  /// from: `public org.maplibre.android.location.engine.LocationEngineRequest$Builder setDisplacement(float f)`
  /// The returned object must be released after use, by calling the [release] method.
  LocationEngineRequest$Builder? setDisplacement(double f) {
    return _setDisplacement(
      reference.pointer,
      _id_setDisplacement as jni$_.JMethodIDPtr,
      f,
    ).object<LocationEngineRequest$Builder?>(
      const $LocationEngineRequest$Builder$NullableType(),
    );
  }

  static final _id_setMaxWaitTime = _class.instanceMethodId(
    r'setMaxWaitTime',
    r'(J)Lorg/maplibre/android/location/engine/LocationEngineRequest$Builder;',
  );

  static final _setMaxWaitTime =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Int64,)>,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              int,
            )
          >();

  /// from: `public org.maplibre.android.location.engine.LocationEngineRequest$Builder setMaxWaitTime(long j)`
  /// The returned object must be released after use, by calling the [release] method.
  LocationEngineRequest$Builder? setMaxWaitTime(int j) {
    return _setMaxWaitTime(
      reference.pointer,
      _id_setMaxWaitTime as jni$_.JMethodIDPtr,
      j,
    ).object<LocationEngineRequest$Builder?>(
      const $LocationEngineRequest$Builder$NullableType(),
    );
  }

  static final _id_setFastestInterval = _class.instanceMethodId(
    r'setFastestInterval',
    r'(J)Lorg/maplibre/android/location/engine/LocationEngineRequest$Builder;',
  );

  static final _setFastestInterval =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Int64,)>,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              int,
            )
          >();

  /// from: `public org.maplibre.android.location.engine.LocationEngineRequest$Builder setFastestInterval(long j)`
  /// The returned object must be released after use, by calling the [release] method.
  LocationEngineRequest$Builder? setFastestInterval(int j) {
    return _setFastestInterval(
      reference.pointer,
      _id_setFastestInterval as jni$_.JMethodIDPtr,
      j,
    ).object<LocationEngineRequest$Builder?>(
      const $LocationEngineRequest$Builder$NullableType(),
    );
  }

  static final _id_build = _class.instanceMethodId(
    r'build',
    r'()Lorg/maplibre/android/location/engine/LocationEngineRequest;',
  );

  static final _build =
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

  /// from: `public org.maplibre.android.location.engine.LocationEngineRequest build()`
  /// The returned object must be released after use, by calling the [release] method.
  LocationEngineRequest? build() {
    return _build(
      reference.pointer,
      _id_build as jni$_.JMethodIDPtr,
    ).object<LocationEngineRequest?>(
      const $LocationEngineRequest$NullableType(),
    );
  }
}

final class $LocationEngineRequest$Builder$NullableType
    extends jni$_.JObjType<LocationEngineRequest$Builder?> {
  @jni$_.internal
  const $LocationEngineRequest$Builder$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/location/engine/LocationEngineRequest$Builder;';

  @jni$_.internal
  @core$_.override
  LocationEngineRequest$Builder? fromReference(jni$_.JReference reference) =>
      reference.isNull
          ? null
          : LocationEngineRequest$Builder.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<LocationEngineRequest$Builder?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($LocationEngineRequest$Builder$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LocationEngineRequest$Builder$NullableType) &&
        other is $LocationEngineRequest$Builder$NullableType;
  }
}

final class $LocationEngineRequest$Builder$Type
    extends jni$_.JObjType<LocationEngineRequest$Builder> {
  @jni$_.internal
  const $LocationEngineRequest$Builder$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/location/engine/LocationEngineRequest$Builder;';

  @jni$_.internal
  @core$_.override
  LocationEngineRequest$Builder fromReference(jni$_.JReference reference) =>
      LocationEngineRequest$Builder.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<LocationEngineRequest$Builder?> get nullableType =>
      const $LocationEngineRequest$Builder$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($LocationEngineRequest$Builder$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LocationEngineRequest$Builder$Type) &&
        other is $LocationEngineRequest$Builder$Type;
  }
}

/// from: `org.maplibre.android.location.engine.LocationEngineRequest`
class LocationEngineRequest extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<LocationEngineRequest> $type;

  @jni$_.internal
  LocationEngineRequest.fromReference(jni$_.JReference reference)
    : $type = type,
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
    r'org/maplibre/android/location/engine/LocationEngineRequest',
  );

  /// The type which includes information such as the signature of this class.
  static const nullableType = $LocationEngineRequest$NullableType();
  static const type = $LocationEngineRequest$Type();

  /// from: `static public final int PRIORITY_HIGH_ACCURACY`
  static const PRIORITY_HIGH_ACCURACY = 0;

  /// from: `static public final int PRIORITY_BALANCED_POWER_ACCURACY`
  static const PRIORITY_BALANCED_POWER_ACCURACY = 1;

  /// from: `static public final int PRIORITY_LOW_POWER`
  static const PRIORITY_LOW_POWER = 2;

  /// from: `static public final int PRIORITY_NO_POWER`
  static const PRIORITY_NO_POWER = 3;
  static final _id_getInterval = _class.instanceMethodId(
    r'getInterval',
    r'()J',
  );

  static final _getInterval =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallLongMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public long getInterval()`
  int getInterval() {
    return _getInterval(
      reference.pointer,
      _id_getInterval as jni$_.JMethodIDPtr,
    ).long;
  }

  static final _id_getPriority = _class.instanceMethodId(
    r'getPriority',
    r'()I',
  );

  static final _getPriority =
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

  /// from: `public int getPriority()`
  int getPriority() {
    return _getPriority(
      reference.pointer,
      _id_getPriority as jni$_.JMethodIDPtr,
    ).integer;
  }

  static final _id_getDisplacement = _class.instanceMethodId(
    r'getDisplacement',
    r'()F',
  );

  static final _getDisplacement =
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

  /// from: `public float getDisplacement()`
  double getDisplacement() {
    return _getDisplacement(
      reference.pointer,
      _id_getDisplacement as jni$_.JMethodIDPtr,
    ).float;
  }

  static final _id_getMaxWaitTime = _class.instanceMethodId(
    r'getMaxWaitTime',
    r'()J',
  );

  static final _getMaxWaitTime =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallLongMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public long getMaxWaitTime()`
  int getMaxWaitTime() {
    return _getMaxWaitTime(
      reference.pointer,
      _id_getMaxWaitTime as jni$_.JMethodIDPtr,
    ).long;
  }

  static final _id_getFastestInterval = _class.instanceMethodId(
    r'getFastestInterval',
    r'()J',
  );

  static final _getFastestInterval =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallLongMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public long getFastestInterval()`
  int getFastestInterval() {
    return _getFastestInterval(
      reference.pointer,
      _id_getFastestInterval as jni$_.JMethodIDPtr,
    ).long;
  }

  static final _id_equals = _class.instanceMethodId(
    r'equals',
    r'(Ljava/lang/Object;)Z',
  );

  static final _equals =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_CallBooleanMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public boolean equals(java.lang.Object object)`
  bool equals(jni$_.JObject? object) {
    final _$object = object?.reference ?? jni$_.jNullReference;
    return _equals(
      reference.pointer,
      _id_equals as jni$_.JMethodIDPtr,
      _$object.pointer,
    ).boolean;
  }

  static final _id_hashCode$1 = _class.instanceMethodId(r'hashCode', r'()I');

  static final _hashCode$1 =
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

  /// from: `public int hashCode()`
  int hashCode$1() {
    return _hashCode$1(
      reference.pointer,
      _id_hashCode$1 as jni$_.JMethodIDPtr,
    ).integer;
  }
}

final class $LocationEngineRequest$NullableType
    extends jni$_.JObjType<LocationEngineRequest?> {
  @jni$_.internal
  const $LocationEngineRequest$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/location/engine/LocationEngineRequest;';

  @jni$_.internal
  @core$_.override
  LocationEngineRequest? fromReference(jni$_.JReference reference) =>
      reference.isNull ? null : LocationEngineRequest.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<LocationEngineRequest?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($LocationEngineRequest$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LocationEngineRequest$NullableType) &&
        other is $LocationEngineRequest$NullableType;
  }
}

final class $LocationEngineRequest$Type
    extends jni$_.JObjType<LocationEngineRequest> {
  @jni$_.internal
  const $LocationEngineRequest$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/location/engine/LocationEngineRequest;';

  @jni$_.internal
  @core$_.override
  LocationEngineRequest fromReference(jni$_.JReference reference) =>
      LocationEngineRequest.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<LocationEngineRequest?> get nullableType =>
      const $LocationEngineRequest$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($LocationEngineRequest$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LocationEngineRequest$Type) &&
        other is $LocationEngineRequest$Type;
  }
}
