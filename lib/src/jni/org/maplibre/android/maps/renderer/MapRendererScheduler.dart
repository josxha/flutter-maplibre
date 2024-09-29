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

/// from: `org.maplibre.android.maps.renderer.MapRendererScheduler`
class MapRendererScheduler extends jni.JObject {
  @override
  late final jni.JObjType<MapRendererScheduler> $type = type;

  MapRendererScheduler.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/maps/renderer/MapRendererScheduler');

  /// The type which includes information such as the signature of this class.
  static const type = $MapRendererSchedulerType();
  static final _id_requestRender = _class.instanceMethodId(
    r'requestRender',
    r'()V',
  );

  static final _requestRender = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public abstract void requestRender()`
  void requestRender() {
    _requestRender(reference.pointer, _id_requestRender as jni.JMethodIDPtr)
        .check();
  }

  static final _id_queueEvent = _class.instanceMethodId(
    r'queueEvent',
    r'(Ljava/lang/Runnable;)V',
  );

  static final _queueEvent = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public abstract void queueEvent(java.lang.Runnable runnable)`
  void queueEvent(
    jni.JObject runnable,
  ) {
    _queueEvent(reference.pointer, _id_queueEvent as jni.JMethodIDPtr,
            runnable.reference.pointer)
        .check();
  }

  static final _id_waitForEmpty = _class.instanceMethodId(
    r'waitForEmpty',
    r'()V',
  );

  static final _waitForEmpty = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public abstract void waitForEmpty()`
  void waitForEmpty() {
    _waitForEmpty(reference.pointer, _id_waitForEmpty as jni.JMethodIDPtr)
        .check();
  }

  /// Maps a specific port to the implemented interface.
  static final Map<int, $MapRendererSchedulerImpl> _$impls = {};
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
      if ($d == r'requestRender()V') {
        _$impls[$p]!.requestRender();
        return jni.nullptr;
      }
      if ($d == r'queueEvent(Ljava/lang/Runnable;)V') {
        _$impls[$p]!.queueEvent(
          $a[0].castTo(const jni.JObjectType(), releaseOriginal: true),
        );
        return jni.nullptr;
      }
      if ($d == r'waitForEmpty()V') {
        _$impls[$p]!.waitForEmpty();
        return jni.nullptr;
      }
    } catch (e) {
      return ProtectedJniExtensions.newDartException(e);
    }
    return jni.nullptr;
  }

  factory MapRendererScheduler.implement(
    $MapRendererSchedulerImpl $impl,
  ) {
    final $p = ReceivePort();
    final $x = MapRendererScheduler.fromReference(
      ProtectedJniExtensions.newPortProxy(
        r'org.maplibre.android.maps.renderer.MapRendererScheduler',
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

abstract interface class $MapRendererSchedulerImpl {
  factory $MapRendererSchedulerImpl({
    required void Function() requestRender,
    required void Function(jni.JObject runnable) queueEvent,
    required void Function() waitForEmpty,
  }) = _$MapRendererSchedulerImpl;

  void requestRender();
  void queueEvent(jni.JObject runnable);
  void waitForEmpty();
}

class _$MapRendererSchedulerImpl implements $MapRendererSchedulerImpl {
  _$MapRendererSchedulerImpl({
    required void Function() requestRender,
    required void Function(jni.JObject runnable) queueEvent,
    required void Function() waitForEmpty,
  })  : _requestRender = requestRender,
        _queueEvent = queueEvent,
        _waitForEmpty = waitForEmpty;

  final void Function() _requestRender;
  final void Function(jni.JObject runnable) _queueEvent;
  final void Function() _waitForEmpty;

  void requestRender() {
    return _requestRender();
  }

  void queueEvent(jni.JObject runnable) {
    return _queueEvent(runnable);
  }

  void waitForEmpty() {
    return _waitForEmpty();
  }
}

final class $MapRendererSchedulerType
    extends jni.JObjType<MapRendererScheduler> {
  const $MapRendererSchedulerType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/maps/renderer/MapRendererScheduler;';

  @override
  MapRendererScheduler fromReference(jni.JReference reference) =>
      MapRendererScheduler.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($MapRendererSchedulerType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapRendererSchedulerType) &&
        other is $MapRendererSchedulerType;
  }
}
