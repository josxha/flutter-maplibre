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

/// from: `org.maplibre.android.location.engine.LocationEngineCallback`
class LocationEngineCallback<$T extends jni.JObject> extends jni.JObject {
  @override
  late final jni.JObjType<LocationEngineCallback<$T>> $type = type(T);

  final jni.JObjType<$T> T;

  LocationEngineCallback.fromReference(
    this.T,
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/location/engine/LocationEngineCallback');

  /// The type which includes information such as the signature of this class.
  static $LocationEngineCallbackType<$T> type<$T extends jni.JObject>(
    jni.JObjType<$T> T,
  ) {
    return $LocationEngineCallbackType(
      T,
    );
  }

  static final _id_onSuccess = _class.instanceMethodId(
    r'onSuccess',
    r'(Ljava/lang/Object;)V',
  );

  static final _onSuccess = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public abstract void onSuccess(T object)`
  void onSuccess(
    $T object,
  ) {
    _onSuccess(reference.pointer, _id_onSuccess as jni.JMethodIDPtr,
            object.reference.pointer)
        .check();
  }

  static final _id_onFailure = _class.instanceMethodId(
    r'onFailure',
    r'(Ljava/lang/Exception;)V',
  );

  static final _onFailure = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public abstract void onFailure(java.lang.Exception exception)`
  void onFailure(
    jni.JObject exception,
  ) {
    _onFailure(reference.pointer, _id_onFailure as jni.JMethodIDPtr,
            exception.reference.pointer)
        .check();
  }

  /// Maps a specific port to the implemented interface.
  static final Map<int, $LocationEngineCallbackImpl> _$impls = {};
  ReceivePort? _$p;

  static jni.JObjectPtr _$invoke(
    int port,
    jni.JObjectPtr descriptor,
    jni.JObjectPtr args,
  ) {
    return _$invokeMethod(
      port,
      $MethodInvocation.fromAddresses(
        0,
        descriptor.address,
        args.address,
      ),
    );
  }

  static final ffi.Pointer<
          ffi.NativeFunction<
              jni.JObjectPtr Function(
                  ffi.Uint64, jni.JObjectPtr, jni.JObjectPtr)>>
      _$invokePointer = ffi.Pointer.fromFunction(_$invoke);

  static ffi.Pointer<ffi.Void> _$invokeMethod(
    int $p,
    $MethodInvocation $i,
  ) {
    try {
      final $d = $i.methodDescriptor.toDartString(releaseOriginal: true);
      final $a = $i.args;
      if ($d == r'onSuccess(Ljava/lang/Object;)V') {
        _$impls[$p]!.onSuccess(
          $a[0].castTo(_$impls[$p]!.T, releaseOriginal: true),
        );
        return jni.nullptr;
      }
      if ($d == r'onFailure(Ljava/lang/Exception;)V') {
        _$impls[$p]!.onFailure(
          $a[0].castTo(const jni.JObjectType(), releaseOriginal: true),
        );
        return jni.nullptr;
      }
    } catch (e) {
      return ProtectedJniExtensions.newDartException(e);
    }
    return jni.nullptr;
  }

  factory LocationEngineCallback.implement(
    $LocationEngineCallbackImpl<$T> $impl,
  ) {
    final $p = ReceivePort();
    final $x = LocationEngineCallback.fromReference(
      $impl.T,
      ProtectedJniExtensions.newPortProxy(
        r'org.maplibre.android.location.engine.LocationEngineCallback',
        $p,
        _$invokePointer,
      ),
    ).._$p = $p;
    final $a = $p.sendPort.nativePort;
    _$impls[$a] = $impl;
    $p.listen(($m) {
      if ($m == null) {
        _$impls.remove($p.sendPort.nativePort);
        $p.close();
        return;
      }
      final $i = $MethodInvocation.fromMessage($m as List<dynamic>);
      final $r = _$invokeMethod($p.sendPort.nativePort, $i);
      ProtectedJniExtensions.returnResult($i.result, $r);
    });
    return $x;
  }
}

abstract interface class $LocationEngineCallbackImpl<$T extends jni.JObject> {
  factory $LocationEngineCallbackImpl({
    required jni.JObjType<$T> T,
    required void Function($T object) onSuccess,
    required void Function(jni.JObject exception) onFailure,
  }) = _$LocationEngineCallbackImpl;

  jni.JObjType<$T> get T;

  void onSuccess($T object);
  void onFailure(jni.JObject exception);
}

class _$LocationEngineCallbackImpl<$T extends jni.JObject>
    implements $LocationEngineCallbackImpl<$T> {
  _$LocationEngineCallbackImpl({
    required this.T,
    required void Function($T object) onSuccess,
    required void Function(jni.JObject exception) onFailure,
  })  : _onSuccess = onSuccess,
        _onFailure = onFailure;

  @override
  final jni.JObjType<$T> T;

  final void Function($T object) _onSuccess;
  final void Function(jni.JObject exception) _onFailure;

  void onSuccess($T object) {
    return _onSuccess(object);
  }

  void onFailure(jni.JObject exception) {
    return _onFailure(exception);
  }
}

final class $LocationEngineCallbackType<$T extends jni.JObject>
    extends jni.JObjType<LocationEngineCallback<$T>> {
  final jni.JObjType<$T> T;

  const $LocationEngineCallbackType(
    this.T,
  );

  @override
  String get signature =>
      r'Lorg/maplibre/android/location/engine/LocationEngineCallback;';

  @override
  LocationEngineCallback<$T> fromReference(jni.JReference reference) =>
      LocationEngineCallback.fromReference(T, reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => Object.hash($LocationEngineCallbackType, T);

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($LocationEngineCallbackType<$T>) &&
        other is $LocationEngineCallbackType<$T> &&
        T == other.T;
  }
}