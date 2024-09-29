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

import 'PermissionsListener.dart' as permissionslistener_;

/// from: `org.maplibre.android.location.permissions.PermissionsManager`
class PermissionsManager extends jni.JObject {
  @override
  late final jni.JObjType<PermissionsManager> $type = type;

  PermissionsManager.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/location/permissions/PermissionsManager');

  /// The type which includes information such as the signature of this class.
  static const type = $PermissionsManagerType();
  static final _id_new0 = _class.constructorId(
    r'(Lorg/maplibre/android/location/permissions/PermissionsListener;)V',
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

  /// from: `public void <init>(org.maplibre.android.location.permissions.PermissionsListener permissionsListener)`
  /// The returned object must be released after use, by calling the [release] method.
  factory PermissionsManager(
    permissionslistener_.PermissionsListener permissionsListener,
  ) {
    return PermissionsManager.fromReference(_new0(_class.reference.pointer,
            _id_new0 as jni.JMethodIDPtr, permissionsListener.reference.pointer)
        .reference);
  }

  static final _id_getListener = _class.instanceMethodId(
    r'getListener',
    r'()Lorg/maplibre/android/location/permissions/PermissionsListener;',
  );

  static final _getListener = ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.location.permissions.PermissionsListener getListener()`
  /// The returned object must be released after use, by calling the [release] method.
  permissionslistener_.PermissionsListener getListener() {
    return _getListener(reference.pointer, _id_getListener as jni.JMethodIDPtr)
        .object(const permissionslistener_.$PermissionsListenerType());
  }

  static final _id_setListener = _class.instanceMethodId(
    r'setListener',
    r'(Lorg/maplibre/android/location/permissions/PermissionsListener;)V',
  );

  static final _setListener = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void setListener(org.maplibre.android.location.permissions.PermissionsListener permissionsListener)`
  void setListener(
    permissionslistener_.PermissionsListener permissionsListener,
  ) {
    _setListener(reference.pointer, _id_setListener as jni.JMethodIDPtr,
            permissionsListener.reference.pointer)
        .check();
  }

  static final _id_isBackgroundLocationPermissionGranted =
      _class.staticMethodId(
    r'isBackgroundLocationPermissionGranted',
    r'(Landroid/content/Context;)Z',
  );

  static final _isBackgroundLocationPermissionGranted =
      ProtectedJniExtensions.lookup<
                  ffi.NativeFunction<
                      jni.JniResult Function(
                          ffi.Pointer<ffi.Void>,
                          jni.JMethodIDPtr,
                          ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
              'globalEnv_CallStaticBooleanMethod')
          .asFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
                  ffi.Pointer<ffi.Void>)>();

  /// from: `static public boolean isBackgroundLocationPermissionGranted(android.content.Context context)`
  static bool isBackgroundLocationPermissionGranted(
    jni.JObject context,
  ) {
    return _isBackgroundLocationPermissionGranted(
            _class.reference.pointer,
            _id_isBackgroundLocationPermissionGranted as jni.JMethodIDPtr,
            context.reference.pointer)
        .boolean;
  }

  static final _id_areLocationPermissionsGranted = _class.staticMethodId(
    r'areLocationPermissionsGranted',
    r'(Landroid/content/Context;)Z',
  );

  static final _areLocationPermissionsGranted = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallStaticBooleanMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `static public boolean areLocationPermissionsGranted(android.content.Context context)`
  static bool areLocationPermissionsGranted(
    jni.JObject context,
  ) {
    return _areLocationPermissionsGranted(
            _class.reference.pointer,
            _id_areLocationPermissionsGranted as jni.JMethodIDPtr,
            context.reference.pointer)
        .boolean;
  }

  static final _id_areRuntimePermissionsRequired = _class.staticMethodId(
    r'areRuntimePermissionsRequired',
    r'()Z',
  );

  static final _areRuntimePermissionsRequired = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallStaticBooleanMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `static public boolean areRuntimePermissionsRequired()`
  static bool areRuntimePermissionsRequired() {
    return _areRuntimePermissionsRequired(_class.reference.pointer,
            _id_areRuntimePermissionsRequired as jni.JMethodIDPtr)
        .boolean;
  }

  static final _id_requestLocationPermissions = _class.instanceMethodId(
    r'requestLocationPermissions',
    r'(Landroid/app/Activity;)V',
  );

  static final _requestLocationPermissions = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void requestLocationPermissions(android.app.Activity activity)`
  void requestLocationPermissions(
    jni.JObject activity,
  ) {
    _requestLocationPermissions(
            reference.pointer,
            _id_requestLocationPermissions as jni.JMethodIDPtr,
            activity.reference.pointer)
        .check();
  }

  static final _id_onRequestPermissionsResult = _class.instanceMethodId(
    r'onRequestPermissionsResult',
    r'(I[Ljava/lang/String;[I)V',
  );

  static final _onRequestPermissionsResult = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        $Int32,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              int, ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `public void onRequestPermissionsResult(int i, java.lang.String[] strings, int[] is)`
  void onRequestPermissionsResult(
    int i,
    jni.JArray<jni.JString> strings,
    jni.JArray<jni.jint> is0,
  ) {
    _onRequestPermissionsResult(
            reference.pointer,
            _id_onRequestPermissionsResult as jni.JMethodIDPtr,
            i,
            strings.reference.pointer,
            is0.reference.pointer)
        .check();
  }
}

final class $PermissionsManagerType extends jni.JObjType<PermissionsManager> {
  const $PermissionsManagerType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/location/permissions/PermissionsManager;';

  @override
  PermissionsManager fromReference(jni.JReference reference) =>
      PermissionsManager.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($PermissionsManagerType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($PermissionsManagerType) &&
        other is $PermissionsManagerType;
  }
}
