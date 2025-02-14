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

import 'AndroidLocationEngineImpl.dart' as androidlocationengineimpl$_;

import 'LocationEngineCallback.dart' as locationenginecallback$_;

import 'LocationEngineRequest.dart' as locationenginerequest$_;

import 'LocationEngineResult.dart' as locationengineresult$_;

/// from: `org.maplibre.android.location.engine.MapLibreFusedLocationEngineImpl`
class MapLibreFusedLocationEngineImpl
    extends androidlocationengineimpl$_.AndroidLocationEngineImpl {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<MapLibreFusedLocationEngineImpl> $type;

  @jni$_.internal
  MapLibreFusedLocationEngineImpl.fromReference(jni$_.JReference reference)
    : $type = type,
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
    r'org/maplibre/android/location/engine/MapLibreFusedLocationEngineImpl',
  );

  /// The type which includes information such as the signature of this class.
  static const nullableType = $MapLibreFusedLocationEngineImpl$NullableType();
  static const type = $MapLibreFusedLocationEngineImpl$Type();
  static final _id_new$ = _class.constructorId(r'(Landroid/content/Context;)V');

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

  /// from: `public void <init>(android.content.Context context)`
  /// The returned object must be released after use, by calling the [release] method.
  factory MapLibreFusedLocationEngineImpl(jni$_.JObject context) {
    final _$context = context.reference;
    return MapLibreFusedLocationEngineImpl.fromReference(
      _new$(
        _class.reference.pointer,
        _id_new$ as jni$_.JMethodIDPtr,
        _$context.pointer,
      ).reference,
    );
  }

  static final _id_createListener = _class.instanceMethodId(
    r'createListener',
    r'(Lorg/maplibre/android/location/engine/LocationEngineCallback;)Landroid/location/LocationListener;',
  );

  static final _createListener =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public android.location.LocationListener createListener(org.maplibre.android.location.engine.LocationEngineCallback locationEngineCallback)`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JObject createListener(
    locationenginecallback$_.LocationEngineCallback<
      locationengineresult$_.LocationEngineResult?
    >?
    locationEngineCallback,
  ) {
    final _$locationEngineCallback =
        locationEngineCallback?.reference ?? jni$_.jNullReference;
    return _createListener(
      reference.pointer,
      _id_createListener as jni$_.JMethodIDPtr,
      _$locationEngineCallback.pointer,
    ).object<jni$_.JObject>(const jni$_.JObjectType());
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

  /// from: `public void getLastLocation(org.maplibre.android.location.engine.LocationEngineCallback locationEngineCallback)`
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
    r'(Lorg/maplibre/android/location/engine/LocationEngineRequest;Landroid/location/LocationListener;Landroid/os/Looper;)V',
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

  /// from: `public void requestLocationUpdates(org.maplibre.android.location.engine.LocationEngineRequest locationEngineRequest, android.location.LocationListener locationListener, android.os.Looper looper)`
  void requestLocationUpdates(
    locationenginerequest$_.LocationEngineRequest locationEngineRequest,
    jni$_.JObject locationListener,
    jni$_.JObject? looper,
  ) {
    final _$locationEngineRequest = locationEngineRequest.reference;
    final _$locationListener = locationListener.reference;
    final _$looper = looper?.reference ?? jni$_.jNullReference;
    _requestLocationUpdates(
      reference.pointer,
      _id_requestLocationUpdates as jni$_.JMethodIDPtr,
      _$locationEngineRequest.pointer,
      _$locationListener.pointer,
      _$looper.pointer,
    ).check();
  }

  static final _id_requestLocationUpdates1 = _class.instanceMethodId(
    r'requestLocationUpdates',
    r'(Lorg/maplibre/android/location/engine/LocationEngineRequest;Landroid/app/PendingIntent;)V',
  );

  static final _requestLocationUpdates1 =
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
  void requestLocationUpdates1(
    locationenginerequest$_.LocationEngineRequest locationEngineRequest,
    jni$_.JObject pendingIntent,
  ) {
    final _$locationEngineRequest = locationEngineRequest.reference;
    final _$pendingIntent = pendingIntent.reference;
    _requestLocationUpdates1(
      reference.pointer,
      _id_requestLocationUpdates1 as jni$_.JMethodIDPtr,
      _$locationEngineRequest.pointer,
      _$pendingIntent.pointer,
    ).check();
  }
}

final class $MapLibreFusedLocationEngineImpl$NullableType
    extends jni$_.JObjType<MapLibreFusedLocationEngineImpl?> {
  @jni$_.internal
  const $MapLibreFusedLocationEngineImpl$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/location/engine/MapLibreFusedLocationEngineImpl;';

  @jni$_.internal
  @core$_.override
  MapLibreFusedLocationEngineImpl? fromReference(jni$_.JReference reference) =>
      reference.isNull
          ? null
          : MapLibreFusedLocationEngineImpl.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType =>
      const androidlocationengineimpl$_.$AndroidLocationEngineImpl$NullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MapLibreFusedLocationEngineImpl?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 2;

  @core$_.override
  int get hashCode => ($MapLibreFusedLocationEngineImpl$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($MapLibreFusedLocationEngineImpl$NullableType) &&
        other is $MapLibreFusedLocationEngineImpl$NullableType;
  }
}

final class $MapLibreFusedLocationEngineImpl$Type
    extends jni$_.JObjType<MapLibreFusedLocationEngineImpl> {
  @jni$_.internal
  const $MapLibreFusedLocationEngineImpl$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/location/engine/MapLibreFusedLocationEngineImpl;';

  @jni$_.internal
  @core$_.override
  MapLibreFusedLocationEngineImpl fromReference(jni$_.JReference reference) =>
      MapLibreFusedLocationEngineImpl.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType =>
      const androidlocationengineimpl$_.$AndroidLocationEngineImpl$NullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MapLibreFusedLocationEngineImpl?> get nullableType =>
      const $MapLibreFusedLocationEngineImpl$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 2;

  @core$_.override
  int get hashCode => ($MapLibreFusedLocationEngineImpl$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapLibreFusedLocationEngineImpl$Type) &&
        other is $MapLibreFusedLocationEngineImpl$Type;
  }
}
