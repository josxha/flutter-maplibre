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

import 'HttpResponder.dart' as httpresponder_;

/// from: `org.maplibre.android.http.HttpRequest`
class HttpRequest extends jni.JObject {
  @override
  late final jni.JObjType<HttpRequest> $type = type;

  HttpRequest.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/http/HttpRequest');

  /// The type which includes information such as the signature of this class.
  static const type = $HttpRequestType();

  /// from: `static public final int CONNECTION_ERROR`
  static const CONNECTION_ERROR = 0;

  /// from: `static public final int TEMPORARY_ERROR`
  static const TEMPORARY_ERROR = 1;

  /// from: `static public final int PERMANENT_ERROR`
  static const PERMANENT_ERROR = 2;
  static final _id_executeRequest = _class.instanceMethodId(
    r'executeRequest',
    r'(Lorg/maplibre/android/http/HttpResponder;JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V',
  );

  static final _executeRequest = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Int64,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        $Int32
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>,
              jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>,
              int,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              int)>();

  /// from: `public abstract void executeRequest(org.maplibre.android.http.HttpResponder httpResponder, long j, java.lang.String string, java.lang.String string1, java.lang.String string2, boolean z)`
  void executeRequest(
    httpresponder_.HttpResponder httpResponder,
    int j,
    jni.JString string,
    jni.JString string1,
    jni.JString string2,
    bool z,
  ) {
    _executeRequest(
            reference.pointer,
            _id_executeRequest as jni.JMethodIDPtr,
            httpResponder.reference.pointer,
            j,
            string.reference.pointer,
            string1.reference.pointer,
            string2.reference.pointer,
            z ? 1 : 0)
        .check();
  }

  static final _id_cancelRequest = _class.instanceMethodId(
    r'cancelRequest',
    r'()V',
  );

  static final _cancelRequest = ProtectedJniExtensions.lookup<
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

  /// from: `public abstract void cancelRequest()`
  void cancelRequest() {
    _cancelRequest(reference.pointer, _id_cancelRequest as jni.JMethodIDPtr)
        .check();
  }

  /// Maps a specific port to the implemented interface.
  static final Map<int, $HttpRequestImpl> _$impls = {};
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
      if ($d ==
          r'executeRequest(Lorg/maplibre/android/http/HttpResponder;JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V') {
        _$impls[$p]!.executeRequest(
          $a[0].castTo(const httpresponder_.$HttpResponderType(),
              releaseOriginal: true),
          $a[1]
              .castTo(const jni.JLongType(), releaseOriginal: true)
              .longValue(releaseOriginal: true),
          $a[2].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[3].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[4].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[5]
              .castTo(const jni.JBooleanType(), releaseOriginal: true)
              .booleanValue(releaseOriginal: true),
        );
        return jni.nullptr;
      }
      if ($d == r'cancelRequest()V') {
        _$impls[$p]!.cancelRequest();
        return jni.nullptr;
      }
    } catch (e) {
      return ProtectedJniExtensions.newDartException(e);
    }
    return jni.nullptr;
  }

  factory HttpRequest.implement(
    $HttpRequestImpl $impl,
  ) {
    final $p = ReceivePort();
    final $x = HttpRequest.fromReference(
      ProtectedJniExtensions.newPortProxy(
        r'org.maplibre.android.http.HttpRequest',
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

abstract interface class $HttpRequestImpl {
  factory $HttpRequestImpl({
    required void Function(
            httpresponder_.HttpResponder httpResponder,
            int j,
            jni.JString string,
            jni.JString string1,
            jni.JString string2,
            bool z)
        executeRequest,
    required void Function() cancelRequest,
  }) = _$HttpRequestImpl;

  void executeRequest(httpresponder_.HttpResponder httpResponder, int j,
      jni.JString string, jni.JString string1, jni.JString string2, bool z);
  void cancelRequest();
}

class _$HttpRequestImpl implements $HttpRequestImpl {
  _$HttpRequestImpl({
    required void Function(
            httpresponder_.HttpResponder httpResponder,
            int j,
            jni.JString string,
            jni.JString string1,
            jni.JString string2,
            bool z)
        executeRequest,
    required void Function() cancelRequest,
  })  : _executeRequest = executeRequest,
        _cancelRequest = cancelRequest;

  final void Function(
      httpresponder_.HttpResponder httpResponder,
      int j,
      jni.JString string,
      jni.JString string1,
      jni.JString string2,
      bool z) _executeRequest;
  final void Function() _cancelRequest;

  void executeRequest(httpresponder_.HttpResponder httpResponder, int j,
      jni.JString string, jni.JString string1, jni.JString string2, bool z) {
    return _executeRequest(httpResponder, j, string, string1, string2, z);
  }

  void cancelRequest() {
    return _cancelRequest();
  }
}

final class $HttpRequestType extends jni.JObjType<HttpRequest> {
  const $HttpRequestType();

  @override
  String get signature => r'Lorg/maplibre/android/http/HttpRequest;';

  @override
  HttpRequest fromReference(jni.JReference reference) =>
      HttpRequest.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($HttpRequestType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($HttpRequestType) && other is $HttpRequestType;
  }
}
