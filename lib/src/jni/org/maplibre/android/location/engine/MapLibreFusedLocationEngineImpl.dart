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

import 'AndroidLocationEngineImpl.dart' as androidlocationengineimpl_;

import 'LocationEngineCallback.dart' as locationenginecallback_;

import 'LocationEngineRequest.dart' as locationenginerequest_;

import 'LocationEngineResult.dart' as locationengineresult_;

/// from: `org.maplibre.android.location.engine.MapLibreFusedLocationEngineImpl`
class MapLibreFusedLocationEngineImpl
    extends androidlocationengineimpl_.AndroidLocationEngineImpl {
  @override
  late final jni.JObjType<MapLibreFusedLocationEngineImpl> $type = type;

  MapLibreFusedLocationEngineImpl.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/location/engine/MapLibreFusedLocationEngineImpl');

  /// The type which includes information such as the signature of this class.
  static const type = $MapLibreFusedLocationEngineImplType();
  static final _id_new0 = _class.constructorId(
    r'(Landroid/content/Context;)V',
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

  /// from: `public void <init>(android.content.Context context)`
  /// The returned object must be released after use, by calling the [release] method.
  factory MapLibreFusedLocationEngineImpl(
    jni.JObject context,
  ) {
    return MapLibreFusedLocationEngineImpl.fromReference(_new0(
            _class.reference.pointer,
            _id_new0 as jni.JMethodIDPtr,
            context.reference.pointer)
        .reference);
  }

  static final _id_createListener = _class.instanceMethodId(
    r'createListener',
    r'(Lorg/maplibre/android/location/engine/LocationEngineCallback;)Landroid/location/LocationListener;',
  );

  static final _createListener = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public android.location.LocationListener createListener(org.maplibre.android.location.engine.LocationEngineCallback locationEngineCallback)`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject createListener(
    locationenginecallback_
        .LocationEngineCallback<locationengineresult_.LocationEngineResult>
        locationEngineCallback,
  ) {
    return _createListener(
            reference.pointer,
            _id_createListener as jni.JMethodIDPtr,
            locationEngineCallback.reference.pointer)
        .object(const jni.JObjectType());
  }

  static final _id_getLastLocation = _class.instanceMethodId(
    r'getLastLocation',
    r'(Lorg/maplibre/android/location/engine/LocationEngineCallback;)V',
  );

  static final _getLastLocation = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void getLastLocation(org.maplibre.android.location.engine.LocationEngineCallback locationEngineCallback)`
  void getLastLocation(
    locationenginecallback_
        .LocationEngineCallback<locationengineresult_.LocationEngineResult>
        locationEngineCallback,
  ) {
    _getLastLocation(reference.pointer, _id_getLastLocation as jni.JMethodIDPtr,
            locationEngineCallback.reference.pointer)
        .check();
  }

  static final _id_requestLocationUpdates = _class.instanceMethodId(
    r'requestLocationUpdates',
    r'(Lorg/maplibre/android/location/engine/LocationEngineRequest;Landroid/location/LocationListener;Landroid/os/Looper;)V',
  );

  static final _requestLocationUpdates = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>,
              jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void requestLocationUpdates(org.maplibre.android.location.engine.LocationEngineRequest locationEngineRequest, android.location.LocationListener locationListener, android.os.Looper looper)`
  void requestLocationUpdates(
    locationenginerequest_.LocationEngineRequest locationEngineRequest,
    jni.JObject locationListener,
    jni.JObject looper,
  ) {
    _requestLocationUpdates(
            reference.pointer,
            _id_requestLocationUpdates as jni.JMethodIDPtr,
            locationEngineRequest.reference.pointer,
            locationListener.reference.pointer,
            looper.reference.pointer)
        .check();
  }

  static final _id_requestLocationUpdates1 = _class.instanceMethodId(
    r'requestLocationUpdates',
    r'(Lorg/maplibre/android/location/engine/LocationEngineRequest;Landroid/app/PendingIntent;)V',
  );

  static final _requestLocationUpdates1 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `public void requestLocationUpdates(org.maplibre.android.location.engine.LocationEngineRequest locationEngineRequest, android.app.PendingIntent pendingIntent)`
  void requestLocationUpdates1(
    locationenginerequest_.LocationEngineRequest locationEngineRequest,
    jni.JObject pendingIntent,
  ) {
    _requestLocationUpdates1(
            reference.pointer,
            _id_requestLocationUpdates1 as jni.JMethodIDPtr,
            locationEngineRequest.reference.pointer,
            pendingIntent.reference.pointer)
        .check();
  }

  static final _id_requestLocationUpdates2 = _class.instanceMethodId(
    r'requestLocationUpdates',
    r'(Lorg/maplibre/android/location/engine/LocationEngineRequest;Ljava/lang/Object;Landroid/os/Looper;)V',
  );

  static final _requestLocationUpdates2 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>,
              jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void requestLocationUpdates(org.maplibre.android.location.engine.LocationEngineRequest locationEngineRequest, java.lang.Object object, android.os.Looper looper)`
  void requestLocationUpdates2(
    locationenginerequest_.LocationEngineRequest locationEngineRequest,
    jni.JObject object,
    jni.JObject looper,
  ) {
    _requestLocationUpdates2(
            reference.pointer,
            _id_requestLocationUpdates2 as jni.JMethodIDPtr,
            locationEngineRequest.reference.pointer,
            object.reference.pointer,
            looper.reference.pointer)
        .check();
  }

  static final _id_createListener1 = _class.instanceMethodId(
    r'createListener',
    r'(Lorg/maplibre/android/location/engine/LocationEngineCallback;)Ljava/lang/Object;',
  );

  static final _createListener1 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public java.lang.Object createListener(org.maplibre.android.location.engine.LocationEngineCallback locationEngineCallback)`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject createListener1(
    locationenginecallback_.LocationEngineCallback<jni.JObject>
        locationEngineCallback,
  ) {
    return _createListener1(
            reference.pointer,
            _id_createListener1 as jni.JMethodIDPtr,
            locationEngineCallback.reference.pointer)
        .object(const jni.JObjectType());
  }
}

final class $MapLibreFusedLocationEngineImplType
    extends jni.JObjType<MapLibreFusedLocationEngineImpl> {
  const $MapLibreFusedLocationEngineImplType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/location/engine/MapLibreFusedLocationEngineImpl;';

  @override
  MapLibreFusedLocationEngineImpl fromReference(jni.JReference reference) =>
      MapLibreFusedLocationEngineImpl.fromReference(reference);

  @override
  jni.JObjType get superType =>
      const androidlocationengineimpl_.$AndroidLocationEngineImplType();

  @override
  final superCount = 2;

  @override
  int get hashCode => ($MapLibreFusedLocationEngineImplType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapLibreFusedLocationEngineImplType) &&
        other is $MapLibreFusedLocationEngineImplType;
  }
}
