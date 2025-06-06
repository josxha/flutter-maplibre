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

import 'LocationEngineCallback.dart' as locationenginecallback$_;

import 'LocationEngineImpl.dart' as locationengineimpl$_;

import 'LocationEngineRequest.dart' as locationenginerequest$_;

import 'LocationEngineResult.dart' as locationengineresult$_;

/// from: `org.maplibre.android.location.engine.LocationEngineProxy`
class LocationEngineProxy<$T extends jni$_.JObject?> extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<LocationEngineProxy<$T>> $type;

  @jni$_.internal
  final jni$_.JObjType<$T> T;

  @jni$_.internal
  LocationEngineProxy.fromReference(this.T, jni$_.JReference reference)
    : $type = type<$T>(T),
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
    r'org/maplibre/android/location/engine/LocationEngineProxy',
  );

  /// The type which includes information such as the signature of this class.
  static $LocationEngineProxy$NullableType<$T>
  nullableType<$T extends jni$_.JObject?>(jni$_.JObjType<$T> T) {
    return $LocationEngineProxy$NullableType<$T>(T);
  }

  static $LocationEngineProxy$Type<$T> type<$T extends jni$_.JObject?>(
    jni$_.JObjType<$T> T,
  ) {
    return $LocationEngineProxy$Type<$T>(T);
  }

  static final _id_new$ = _class.constructorId(
    r'(Lorg/maplibre/android/location/engine/LocationEngineImpl;)V',
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

  /// from: `public void <init>(org.maplibre.android.location.engine.LocationEngineImpl<T> locationEngineImpl)`
  /// The returned object must be released after use, by calling the [release] method.
  factory LocationEngineProxy(
    locationengineimpl$_.LocationEngineImpl<$T?>? locationEngineImpl, {
    required jni$_.JObjType<$T> T,
  }) {
    final _$locationEngineImpl =
        locationEngineImpl?.reference ?? jni$_.jNullReference;
    return LocationEngineProxy<$T>.fromReference(
      T,
      _new$(
        _class.reference.pointer,
        _id_new$ as jni$_.JMethodIDPtr,
        _$locationEngineImpl.pointer,
      ).reference,
    );
  }

  static final _id_getLastLocation = _class.instanceMethodId(
    r'getLastLocation',
    r'(Lorg/maplibre/android/location/engine/LocationEngineCallback;)V',
  );

  static final _getLastLocation =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public void getLastLocation(org.maplibre.android.location.engine.LocationEngineCallback<org.maplibre.android.location.engine.LocationEngineResult> locationEngineCallback)`
  void getLastLocation(
    locationenginecallback$_.LocationEngineCallback<
      locationengineresult$_.LocationEngineResult?
    >
    locationEngineCallback,
  ) {
    final _$locationEngineCallback = locationEngineCallback.reference;
    _getLastLocation(
      reference.pointer,
      _id_getLastLocation as jni$_.JMethodIDPtr,
      _$locationEngineCallback.pointer,
    ).check();
  }

  static final _id_requestLocationUpdates = _class.instanceMethodId(
    r'requestLocationUpdates',
    r'(Lorg/maplibre/android/location/engine/LocationEngineRequest;Lorg/maplibre/android/location/engine/LocationEngineCallback;Landroid/os/Looper;)V',
  );

  static final _requestLocationUpdates =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<
                  (
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Pointer<jni$_.Void>,
                  )
                >,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public void requestLocationUpdates(org.maplibre.android.location.engine.LocationEngineRequest locationEngineRequest, org.maplibre.android.location.engine.LocationEngineCallback<org.maplibre.android.location.engine.LocationEngineResult> locationEngineCallback, android.os.Looper looper)`
  void requestLocationUpdates(
    locationenginerequest$_.LocationEngineRequest locationEngineRequest,
    locationenginecallback$_.LocationEngineCallback<
      locationengineresult$_.LocationEngineResult?
    >
    locationEngineCallback,
    jni$_.JObject? looper,
  ) {
    final _$locationEngineRequest = locationEngineRequest.reference;
    final _$locationEngineCallback = locationEngineCallback.reference;
    final _$looper = looper?.reference ?? jni$_.jNullReference;
    _requestLocationUpdates(
      reference.pointer,
      _id_requestLocationUpdates as jni$_.JMethodIDPtr,
      _$locationEngineRequest.pointer,
      _$locationEngineCallback.pointer,
      _$looper.pointer,
    ).check();
  }

  static final _id_requestLocationUpdates$1 = _class.instanceMethodId(
    r'requestLocationUpdates',
    r'(Lorg/maplibre/android/location/engine/LocationEngineRequest;Landroid/app/PendingIntent;)V',
  );

  static final _requestLocationUpdates$1 =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<
                  (jni$_.Pointer<jni$_.Void>, jni$_.Pointer<jni$_.Void>)
                >,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public void requestLocationUpdates(org.maplibre.android.location.engine.LocationEngineRequest locationEngineRequest, android.app.PendingIntent pendingIntent)`
  void requestLocationUpdates$1(
    locationenginerequest$_.LocationEngineRequest locationEngineRequest,
    jni$_.JObject? pendingIntent,
  ) {
    final _$locationEngineRequest = locationEngineRequest.reference;
    final _$pendingIntent = pendingIntent?.reference ?? jni$_.jNullReference;
    _requestLocationUpdates$1(
      reference.pointer,
      _id_requestLocationUpdates$1 as jni$_.JMethodIDPtr,
      _$locationEngineRequest.pointer,
      _$pendingIntent.pointer,
    ).check();
  }

  static final _id_removeLocationUpdates = _class.instanceMethodId(
    r'removeLocationUpdates',
    r'(Lorg/maplibre/android/location/engine/LocationEngineCallback;)V',
  );

  static final _removeLocationUpdates =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public void removeLocationUpdates(org.maplibre.android.location.engine.LocationEngineCallback<org.maplibre.android.location.engine.LocationEngineResult> locationEngineCallback)`
  void removeLocationUpdates(
    locationenginecallback$_.LocationEngineCallback<
      locationengineresult$_.LocationEngineResult?
    >
    locationEngineCallback,
  ) {
    final _$locationEngineCallback = locationEngineCallback.reference;
    _removeLocationUpdates(
      reference.pointer,
      _id_removeLocationUpdates as jni$_.JMethodIDPtr,
      _$locationEngineCallback.pointer,
    ).check();
  }

  static final _id_removeLocationUpdates$1 = _class.instanceMethodId(
    r'removeLocationUpdates',
    r'(Landroid/app/PendingIntent;)V',
  );

  static final _removeLocationUpdates$1 =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public void removeLocationUpdates(android.app.PendingIntent pendingIntent)`
  void removeLocationUpdates$1(jni$_.JObject? pendingIntent) {
    final _$pendingIntent = pendingIntent?.reference ?? jni$_.jNullReference;
    _removeLocationUpdates$1(
      reference.pointer,
      _id_removeLocationUpdates$1 as jni$_.JMethodIDPtr,
      _$pendingIntent.pointer,
    ).check();
  }
}

final class $LocationEngineProxy$NullableType<$T extends jni$_.JObject?>
    extends jni$_.JObjType<LocationEngineProxy<$T>?> {
  @jni$_.internal
  final jni$_.JObjType<$T> T;

  @jni$_.internal
  const $LocationEngineProxy$NullableType(this.T);

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/location/engine/LocationEngineProxy;';

  @jni$_.internal
  @core$_.override
  LocationEngineProxy<$T>? fromReference(jni$_.JReference reference) =>
      reference.isNull
      ? null
      : LocationEngineProxy<$T>.fromReference(T, reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<LocationEngineProxy<$T>?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => Object.hash($LocationEngineProxy$NullableType, T);

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LocationEngineProxy$NullableType<$T>) &&
        other is $LocationEngineProxy$NullableType<$T> &&
        T == other.T;
  }
}

final class $LocationEngineProxy$Type<$T extends jni$_.JObject?>
    extends jni$_.JObjType<LocationEngineProxy<$T>> {
  @jni$_.internal
  final jni$_.JObjType<$T> T;

  @jni$_.internal
  const $LocationEngineProxy$Type(this.T);

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/location/engine/LocationEngineProxy;';

  @jni$_.internal
  @core$_.override
  LocationEngineProxy<$T> fromReference(jni$_.JReference reference) =>
      LocationEngineProxy<$T>.fromReference(T, reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<LocationEngineProxy<$T>?> get nullableType =>
      $LocationEngineProxy$NullableType<$T>(T);

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => Object.hash($LocationEngineProxy$Type, T);

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LocationEngineProxy$Type<$T>) &&
        other is $LocationEngineProxy$Type<$T> &&
        T == other.T;
  }
}
