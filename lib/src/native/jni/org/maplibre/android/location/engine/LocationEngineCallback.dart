// Autogenerated by jnigen. DO NOT EDIT!

// coverage:ignore-file
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
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable
// ignore_for_file: unused_shown_name
// ignore_for_file: use_super_parameters

import 'dart:core' show Object, String, bool, double, int;
import 'dart:core' as _$core;

import 'package:jni/_internal.dart' as _$jni;
import 'package:jni/jni.dart' as _$jni;

/// from: `org.maplibre.android.location.engine.LocationEngineCallback`
class LocationEngineCallback<$T extends _$jni.JObject> extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<LocationEngineCallback<$T>> $type;

  @_$jni.internal
  final _$jni.JObjType<$T> T;

  @_$jni.internal
  LocationEngineCallback.fromReference(
    this.T,
    _$jni.JReference reference,
  )   : $type = type(T),
        super.fromReference(reference);

  static final _class = _$jni.JClass.forName(
      r'org/maplibre/android/location/engine/LocationEngineCallback');

  /// The type which includes information such as the signature of this class.
  static $LocationEngineCallback$Type<$T> type<$T extends _$jni.JObject>(
    _$jni.JObjType<$T> T,
  ) {
    return $LocationEngineCallback$Type(
      T,
    );
  }

  static final _id_onSuccess = _class.instanceMethodId(
    r'onSuccess',
    r'(Ljava/lang/Object;)V',
  );

  static final _onSuccess = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public abstract void onSuccess(T object)`
  void onSuccess(
    $T object,
  ) {
    _onSuccess(reference.pointer, _id_onSuccess as _$jni.JMethodIDPtr,
            object.reference.pointer)
        .check();
  }

  static final _id_onFailure = _class.instanceMethodId(
    r'onFailure',
    r'(Ljava/lang/Exception;)V',
  );

  static final _onFailure = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public abstract void onFailure(java.lang.Exception exception)`
  void onFailure(
    _$jni.JObject exception,
  ) {
    _onFailure(reference.pointer, _id_onFailure as _$jni.JMethodIDPtr,
            exception.reference.pointer)
        .check();
  }

  /// Maps a specific port to the implemented interface.
  static final _$core.Map<int, $LocationEngineCallback> _$impls = {};
  static _$jni.JObjectPtr _$invoke(
    int port,
    _$jni.JObjectPtr descriptor,
    _$jni.JObjectPtr args,
  ) {
    return _$invokeMethod(
      port,
      _$jni.MethodInvocation.fromAddresses(
        0,
        descriptor.address,
        args.address,
      ),
    );
  }

  static final _$jni.Pointer<
          _$jni.NativeFunction<
              _$jni.JObjectPtr Function(
                  _$jni.Int64, _$jni.JObjectPtr, _$jni.JObjectPtr)>>
      _$invokePointer = _$jni.Pointer.fromFunction(_$invoke);

  static _$jni.Pointer<_$jni.Void> _$invokeMethod(
    int $p,
    _$jni.MethodInvocation $i,
  ) {
    try {
      final $d = $i.methodDescriptor.toDartString(releaseOriginal: true);
      final $a = $i.args;
      if ($d == r'onSuccess(Ljava/lang/Object;)V') {
        _$impls[$p]!.onSuccess(
          $a[0].as(_$impls[$p]!.T, releaseOriginal: true),
        );
        return _$jni.nullptr;
      }
      if ($d == r'onFailure(Ljava/lang/Exception;)V') {
        _$impls[$p]!.onFailure(
          $a[0].as(const _$jni.JObjectType(), releaseOriginal: true),
        );
        return _$jni.nullptr;
      }
    } catch (e) {
      return _$jni.ProtectedJniExtensions.newDartException(e);
    }
    return _$jni.nullptr;
  }

  static void implementIn<$T extends _$jni.JObject>(
    _$jni.JImplementer implementer,
    $LocationEngineCallback<$T> $impl,
  ) {
    late final _$jni.RawReceivePort $p;
    $p = _$jni.RawReceivePort(($m) {
      if ($m == null) {
        _$impls.remove($p.sendPort.nativePort);
        $p.close();
        return;
      }
      final $i = _$jni.MethodInvocation.fromMessage($m);
      final $r = _$invokeMethod($p.sendPort.nativePort, $i);
      _$jni.ProtectedJniExtensions.returnResult($i.result, $r);
    });
    implementer.add(
      r'org.maplibre.android.location.engine.LocationEngineCallback',
      $p,
      _$invokePointer,
      [
        if ($impl.onSuccess$async) r'onSuccess(Ljava/lang/Object;)V',
        if ($impl.onFailure$async) r'onFailure(Ljava/lang/Exception;)V',
      ],
    );
    final $a = $p.sendPort.nativePort;
    _$impls[$a] = $impl;
  }

  factory LocationEngineCallback.implement(
    $LocationEngineCallback<$T> $impl,
  ) {
    final $i = _$jni.JImplementer();
    implementIn($i, $impl);
    return LocationEngineCallback.fromReference(
      $impl.T,
      $i.implementReference(),
    );
  }
}

abstract base mixin class $LocationEngineCallback<$T extends _$jni.JObject> {
  factory $LocationEngineCallback({
    required _$jni.JObjType<$T> T,
    required void Function($T object) onSuccess,
    bool onSuccess$async,
    required void Function(_$jni.JObject exception) onFailure,
    bool onFailure$async,
  }) = _$LocationEngineCallback;

  _$jni.JObjType<$T> get T;

  void onSuccess($T object);
  bool get onSuccess$async => false;
  void onFailure(_$jni.JObject exception);
  bool get onFailure$async => false;
}

final class _$LocationEngineCallback<$T extends _$jni.JObject>
    with $LocationEngineCallback<$T> {
  _$LocationEngineCallback({
    required this.T,
    required void Function($T object) onSuccess,
    this.onSuccess$async = false,
    required void Function(_$jni.JObject exception) onFailure,
    this.onFailure$async = false,
  })  : _onSuccess = onSuccess,
        _onFailure = onFailure;

  @_$core.override
  final _$jni.JObjType<$T> T;

  final void Function($T object) _onSuccess;
  final bool onSuccess$async;
  final void Function(_$jni.JObject exception) _onFailure;
  final bool onFailure$async;

  void onSuccess($T object) {
    return _onSuccess(object);
  }

  void onFailure(_$jni.JObject exception) {
    return _onFailure(exception);
  }
}

final class $LocationEngineCallback$Type<$T extends _$jni.JObject>
    extends _$jni.JObjType<LocationEngineCallback<$T>> {
  @_$jni.internal
  final _$jni.JObjType<$T> T;

  @_$jni.internal
  const $LocationEngineCallback$Type(
    this.T,
  );

  @_$jni.internal
  @_$core.override
  String get signature =>
      r'Lorg/maplibre/android/location/engine/LocationEngineCallback;';

  @_$jni.internal
  @_$core.override
  LocationEngineCallback<$T> fromReference(_$jni.JReference reference) =>
      LocationEngineCallback.fromReference(T, reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode => Object.hash($LocationEngineCallback$Type, T);

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LocationEngineCallback$Type<$T>) &&
        other is $LocationEngineCallback$Type<$T> &&
        T == other.T;
  }
}
