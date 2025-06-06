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

/// from: `org.maplibre.android.location.engine.LocationEngineCallback`
class LocationEngineCallback<$T extends jni$_.JObject?> extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<LocationEngineCallback<$T>> $type;

  @jni$_.internal
  final jni$_.JObjType<$T> T;

  @jni$_.internal
  LocationEngineCallback.fromReference(this.T, jni$_.JReference reference)
    : $type = type<$T>(T),
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
    r'org/maplibre/android/location/engine/LocationEngineCallback',
  );

  /// The type which includes information such as the signature of this class.
  static $LocationEngineCallback$NullableType<$T>
  nullableType<$T extends jni$_.JObject?>(jni$_.JObjType<$T> T) {
    return $LocationEngineCallback$NullableType<$T>(T);
  }

  static $LocationEngineCallback$Type<$T> type<$T extends jni$_.JObject?>(
    jni$_.JObjType<$T> T,
  ) {
    return $LocationEngineCallback$Type<$T>(T);
  }

  static final _id_onSuccess = _class.instanceMethodId(
    r'onSuccess',
    r'(Ljava/lang/Object;)V',
  );

  static final _onSuccess =
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

  /// from: `public abstract void onSuccess(T object)`
  void onSuccess($T? object) {
    final _$object = object?.reference ?? jni$_.jNullReference;
    _onSuccess(
      reference.pointer,
      _id_onSuccess as jni$_.JMethodIDPtr,
      _$object.pointer,
    ).check();
  }

  static final _id_onFailure = _class.instanceMethodId(
    r'onFailure',
    r'(Ljava/lang/Exception;)V',
  );

  static final _onFailure =
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

  /// from: `public abstract void onFailure(java.lang.Exception exception)`
  void onFailure(jni$_.JObject exception) {
    final _$exception = exception.reference;
    _onFailure(
      reference.pointer,
      _id_onFailure as jni$_.JMethodIDPtr,
      _$exception.pointer,
    ).check();
  }

  /// Maps a specific port to the implemented interface.
  static final core$_.Map<int, $LocationEngineCallback> _$impls = {};
  static jni$_.JObjectPtr _$invoke(
    int port,
    jni$_.JObjectPtr descriptor,
    jni$_.JObjectPtr args,
  ) {
    return _$invokeMethod(
      port,
      jni$_.MethodInvocation.fromAddresses(0, descriptor.address, args.address),
    );
  }

  static final jni$_.Pointer<
    jni$_.NativeFunction<
      jni$_.JObjectPtr Function(jni$_.Int64, jni$_.JObjectPtr, jni$_.JObjectPtr)
    >
  >
  _$invokePointer = jni$_.Pointer.fromFunction(_$invoke);

  static jni$_.Pointer<jni$_.Void> _$invokeMethod(
    int $p,
    jni$_.MethodInvocation $i,
  ) {
    try {
      final $d = $i.methodDescriptor.toDartString(releaseOriginal: true);
      final $a = $i.args;
      if ($d == r'onSuccess(Ljava/lang/Object;)V') {
        _$impls[$p]!.onSuccess(
          $a![0]?.as(_$impls[$p]!.T, releaseOriginal: true),
        );
        return jni$_.nullptr;
      }
      if ($d == r'onFailure(Ljava/lang/Exception;)V') {
        _$impls[$p]!.onFailure(
          $a![0]!.as(const jni$_.JObjectType(), releaseOriginal: true),
        );
        return jni$_.nullptr;
      }
    } catch (e) {
      return jni$_.ProtectedJniExtensions.newDartException(e);
    }
    return jni$_.nullptr;
  }

  static void implementIn<$T extends jni$_.JObject?>(
    jni$_.JImplementer implementer,
    $LocationEngineCallback<$T> $impl,
  ) {
    late final jni$_.RawReceivePort $p;
    $p = jni$_.RawReceivePort(($m) {
      if ($m == null) {
        _$impls.remove($p.sendPort.nativePort);
        $p.close();
        return;
      }
      final $i = jni$_.MethodInvocation.fromMessage($m);
      final $r = _$invokeMethod($p.sendPort.nativePort, $i);
      jni$_.ProtectedJniExtensions.returnResult($i.result, $r);
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

  factory LocationEngineCallback.implement($LocationEngineCallback<$T> $impl) {
    final $i = jni$_.JImplementer();
    implementIn($i, $impl);
    return LocationEngineCallback<$T>.fromReference(
      $impl.T,
      $i.implementReference(),
    );
  }
}

abstract base mixin class $LocationEngineCallback<$T extends jni$_.JObject?> {
  factory $LocationEngineCallback({
    required jni$_.JObjType<$T> T,
    required void Function($T? object) onSuccess,
    bool onSuccess$async,
    required void Function(jni$_.JObject exception) onFailure,
    bool onFailure$async,
  }) = _$LocationEngineCallback<$T>;

  jni$_.JObjType<$T> get T;

  void onSuccess($T? object);
  bool get onSuccess$async => false;
  void onFailure(jni$_.JObject exception);
  bool get onFailure$async => false;
}

final class _$LocationEngineCallback<$T extends jni$_.JObject?>
    with $LocationEngineCallback<$T> {
  _$LocationEngineCallback({
    required this.T,
    required void Function($T? object) onSuccess,
    this.onSuccess$async = false,
    required void Function(jni$_.JObject exception) onFailure,
    this.onFailure$async = false,
  }) : _onSuccess = onSuccess,
       _onFailure = onFailure;

  @core$_.override
  final jni$_.JObjType<$T> T;

  final void Function($T? object) _onSuccess;
  final bool onSuccess$async;
  final void Function(jni$_.JObject exception) _onFailure;
  final bool onFailure$async;

  void onSuccess($T? object) {
    return _onSuccess(object);
  }

  void onFailure(jni$_.JObject exception) {
    return _onFailure(exception);
  }
}

final class $LocationEngineCallback$NullableType<$T extends jni$_.JObject?>
    extends jni$_.JObjType<LocationEngineCallback<$T>?> {
  @jni$_.internal
  final jni$_.JObjType<$T> T;

  @jni$_.internal
  const $LocationEngineCallback$NullableType(this.T);

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/location/engine/LocationEngineCallback;';

  @jni$_.internal
  @core$_.override
  LocationEngineCallback<$T>? fromReference(jni$_.JReference reference) =>
      reference.isNull
      ? null
      : LocationEngineCallback<$T>.fromReference(T, reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<LocationEngineCallback<$T>?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => Object.hash($LocationEngineCallback$NullableType, T);

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LocationEngineCallback$NullableType<$T>) &&
        other is $LocationEngineCallback$NullableType<$T> &&
        T == other.T;
  }
}

final class $LocationEngineCallback$Type<$T extends jni$_.JObject?>
    extends jni$_.JObjType<LocationEngineCallback<$T>> {
  @jni$_.internal
  final jni$_.JObjType<$T> T;

  @jni$_.internal
  const $LocationEngineCallback$Type(this.T);

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/location/engine/LocationEngineCallback;';

  @jni$_.internal
  @core$_.override
  LocationEngineCallback<$T> fromReference(jni$_.JReference reference) =>
      LocationEngineCallback<$T>.fromReference(T, reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<LocationEngineCallback<$T>?> get nullableType =>
      $LocationEngineCallback$NullableType<$T>(T);

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => Object.hash($LocationEngineCallback$Type, T);

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($LocationEngineCallback$Type<$T>) &&
        other is $LocationEngineCallback$Type<$T> &&
        T == other.T;
  }
}
