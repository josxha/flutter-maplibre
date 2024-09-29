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

/// from: `org.maplibre.android.http.HttpResponder`
class HttpResponder extends jni.JObject {
  @override
  late final jni.JObjType<HttpResponder> $type = type;

  HttpResponder.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/http/HttpResponder');

  /// The type which includes information such as the signature of this class.
  static const type = $HttpResponderType();
  static final _id_onResponse = _class.instanceMethodId(
    r'onResponse',
    r'(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V',
  );

  static final _onResponse = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        $Int32,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>,
              jni.JMethodIDPtr,
              int,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public abstract void onResponse(int i, java.lang.String string, java.lang.String string1, java.lang.String string2, java.lang.String string3, java.lang.String string4, java.lang.String string5, byte[] bs)`
  void onResponse(
    int i,
    jni.JString string,
    jni.JString string1,
    jni.JString string2,
    jni.JString string3,
    jni.JString string4,
    jni.JString string5,
    jni.JArray<jni.jbyte> bs,
  ) {
    _onResponse(
            reference.pointer,
            _id_onResponse as jni.JMethodIDPtr,
            i,
            string.reference.pointer,
            string1.reference.pointer,
            string2.reference.pointer,
            string3.reference.pointer,
            string4.reference.pointer,
            string5.reference.pointer,
            bs.reference.pointer)
        .check();
  }

  static final _id_handleFailure = _class.instanceMethodId(
    r'handleFailure',
    r'(ILjava/lang/String;)V',
  );

  static final _handleFailure = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<($Int32, ffi.Pointer<ffi.Void>)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              int, ffi.Pointer<ffi.Void>)>();

  /// from: `public abstract void handleFailure(int i, java.lang.String string)`
  void handleFailure(
    int i,
    jni.JString string,
  ) {
    _handleFailure(reference.pointer, _id_handleFailure as jni.JMethodIDPtr, i,
            string.reference.pointer)
        .check();
  }

  /// Maps a specific port to the implemented interface.
  static final Map<int, $HttpResponderImpl> _$impls = {};
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
          r'onResponse(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V') {
        _$impls[$p]!.onResponse(
          $a[0]
              .castTo(const jni.JIntegerType(), releaseOriginal: true)
              .intValue(releaseOriginal: true),
          $a[1].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[2].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[3].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[4].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[5].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[6].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[7].castTo(const jni.JArrayType(jni.jbyteType()),
              releaseOriginal: true),
        );
        return jni.nullptr;
      }
      if ($d == r'handleFailure(ILjava/lang/String;)V') {
        _$impls[$p]!.handleFailure(
          $a[0]
              .castTo(const jni.JIntegerType(), releaseOriginal: true)
              .intValue(releaseOriginal: true),
          $a[1].castTo(const jni.JStringType(), releaseOriginal: true),
        );
        return jni.nullptr;
      }
    } catch (e) {
      return ProtectedJniExtensions.newDartException(e);
    }
    return jni.nullptr;
  }

  factory HttpResponder.implement(
    $HttpResponderImpl $impl,
  ) {
    final $p = ReceivePort();
    final $x = HttpResponder.fromReference(
      ProtectedJniExtensions.newPortProxy(
        r'org.maplibre.android.http.HttpResponder',
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

abstract interface class $HttpResponderImpl {
  factory $HttpResponderImpl({
    required void Function(
            int i,
            jni.JString string,
            jni.JString string1,
            jni.JString string2,
            jni.JString string3,
            jni.JString string4,
            jni.JString string5,
            jni.JArray<jni.jbyte> bs)
        onResponse,
    required void Function(int i, jni.JString string) handleFailure,
  }) = _$HttpResponderImpl;

  void onResponse(
      int i,
      jni.JString string,
      jni.JString string1,
      jni.JString string2,
      jni.JString string3,
      jni.JString string4,
      jni.JString string5,
      jni.JArray<jni.jbyte> bs);
  void handleFailure(int i, jni.JString string);
}

class _$HttpResponderImpl implements $HttpResponderImpl {
  _$HttpResponderImpl({
    required void Function(
            int i,
            jni.JString string,
            jni.JString string1,
            jni.JString string2,
            jni.JString string3,
            jni.JString string4,
            jni.JString string5,
            jni.JArray<jni.jbyte> bs)
        onResponse,
    required void Function(int i, jni.JString string) handleFailure,
  })  : _onResponse = onResponse,
        _handleFailure = handleFailure;

  final void Function(
      int i,
      jni.JString string,
      jni.JString string1,
      jni.JString string2,
      jni.JString string3,
      jni.JString string4,
      jni.JString string5,
      jni.JArray<jni.jbyte> bs) _onResponse;
  final void Function(int i, jni.JString string) _handleFailure;

  void onResponse(
      int i,
      jni.JString string,
      jni.JString string1,
      jni.JString string2,
      jni.JString string3,
      jni.JString string4,
      jni.JString string5,
      jni.JArray<jni.jbyte> bs) {
    return _onResponse(
        i, string, string1, string2, string3, string4, string5, bs);
  }

  void handleFailure(int i, jni.JString string) {
    return _handleFailure(i, string);
  }
}

final class $HttpResponderType extends jni.JObjType<HttpResponder> {
  const $HttpResponderType();

  @override
  String get signature => r'Lorg/maplibre/android/http/HttpResponder;';

  @override
  HttpResponder fromReference(jni.JReference reference) =>
      HttpResponder.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($HttpResponderType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($HttpResponderType) &&
        other is $HttpResponderType;
  }
}
