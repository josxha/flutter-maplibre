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

/// from: `org.maplibre.android.http.HttpResponder`
class HttpResponder extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<HttpResponder> $type;

  @_$jni.internal
  HttpResponder.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      _$jni.JClass.forName(r'org/maplibre/android/http/HttpResponder');

  /// The type which includes information such as the signature of this class.
  static const type = $HttpResponder$Type();
  static final _id_onResponse = _class.instanceMethodId(
    r'onResponse',
    r'(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V',
  );

  static final _onResponse = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JThrowablePtr Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Int32,
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              int,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `public abstract void onResponse(int i, java.lang.String string, java.lang.String string1, java.lang.String string2, java.lang.String string3, java.lang.String string4, java.lang.String string5, byte[] bs)`
  void onResponse(
    int i,
    _$jni.JString string,
    _$jni.JString string1,
    _$jni.JString string2,
    _$jni.JString string3,
    _$jni.JString string4,
    _$jni.JString string5,
    _$jni.JArray<_$jni.jbyte> bs,
  ) {
    _onResponse(
            reference.pointer,
            _id_onResponse as _$jni.JMethodIDPtr,
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

  static final _handleFailure = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni
                          .VarArgs<(_$jni.Int32, _$jni.Pointer<_$jni.Void>)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, int, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public abstract void handleFailure(int i, java.lang.String string)`
  void handleFailure(
    int i,
    _$jni.JString string,
  ) {
    _handleFailure(reference.pointer, _id_handleFailure as _$jni.JMethodIDPtr,
            i, string.reference.pointer)
        .check();
  }

  /// Maps a specific port to the implemented interface.
  static final _$core.Map<int, $HttpResponder> _$impls = {};
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
      if ($d ==
          r'onResponse(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V') {
        _$impls[$p]!.onResponse(
          $a[0]
              .as(const _$jni.JIntegerType(), releaseOriginal: true)
              .intValue(releaseOriginal: true),
          $a[1].as(const _$jni.JStringType(), releaseOriginal: true),
          $a[2].as(const _$jni.JStringType(), releaseOriginal: true),
          $a[3].as(const _$jni.JStringType(), releaseOriginal: true),
          $a[4].as(const _$jni.JStringType(), releaseOriginal: true),
          $a[5].as(const _$jni.JStringType(), releaseOriginal: true),
          $a[6].as(const _$jni.JStringType(), releaseOriginal: true),
          $a[7].as(const _$jni.JArrayType(_$jni.jbyteType()),
              releaseOriginal: true),
        );
        return _$jni.nullptr;
      }
      if ($d == r'handleFailure(ILjava/lang/String;)V') {
        _$impls[$p]!.handleFailure(
          $a[0]
              .as(const _$jni.JIntegerType(), releaseOriginal: true)
              .intValue(releaseOriginal: true),
          $a[1].as(const _$jni.JStringType(), releaseOriginal: true),
        );
        return _$jni.nullptr;
      }
    } catch (e) {
      return _$jni.ProtectedJniExtensions.newDartException(e);
    }
    return _$jni.nullptr;
  }

  static void implementIn(
    _$jni.JImplementer implementer,
    $HttpResponder $impl,
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
      r'org.maplibre.android.http.HttpResponder',
      $p,
      _$invokePointer,
      [
        if ($impl.onResponse$async)
          r'onResponse(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V',
        if ($impl.handleFailure$async) r'handleFailure(ILjava/lang/String;)V',
      ],
    );
    final $a = $p.sendPort.nativePort;
    _$impls[$a] = $impl;
  }

  factory HttpResponder.implement(
    $HttpResponder $impl,
  ) {
    final $i = _$jni.JImplementer();
    implementIn($i, $impl);
    return HttpResponder.fromReference(
      $i.implementReference(),
    );
  }
}

abstract base mixin class $HttpResponder {
  factory $HttpResponder({
    required void Function(
            int i,
            _$jni.JString string,
            _$jni.JString string1,
            _$jni.JString string2,
            _$jni.JString string3,
            _$jni.JString string4,
            _$jni.JString string5,
            _$jni.JArray<_$jni.jbyte> bs)
        onResponse,
    bool onResponse$async,
    required void Function(int i, _$jni.JString string) handleFailure,
    bool handleFailure$async,
  }) = _$HttpResponder;

  void onResponse(
      int i,
      _$jni.JString string,
      _$jni.JString string1,
      _$jni.JString string2,
      _$jni.JString string3,
      _$jni.JString string4,
      _$jni.JString string5,
      _$jni.JArray<_$jni.jbyte> bs);
  bool get onResponse$async => false;
  void handleFailure(int i, _$jni.JString string);
  bool get handleFailure$async => false;
}

final class _$HttpResponder with $HttpResponder {
  _$HttpResponder({
    required void Function(
            int i,
            _$jni.JString string,
            _$jni.JString string1,
            _$jni.JString string2,
            _$jni.JString string3,
            _$jni.JString string4,
            _$jni.JString string5,
            _$jni.JArray<_$jni.jbyte> bs)
        onResponse,
    this.onResponse$async = false,
    required void Function(int i, _$jni.JString string) handleFailure,
    this.handleFailure$async = false,
  })  : _onResponse = onResponse,
        _handleFailure = handleFailure;

  final void Function(
      int i,
      _$jni.JString string,
      _$jni.JString string1,
      _$jni.JString string2,
      _$jni.JString string3,
      _$jni.JString string4,
      _$jni.JString string5,
      _$jni.JArray<_$jni.jbyte> bs) _onResponse;
  final bool onResponse$async;
  final void Function(int i, _$jni.JString string) _handleFailure;
  final bool handleFailure$async;

  void onResponse(
      int i,
      _$jni.JString string,
      _$jni.JString string1,
      _$jni.JString string2,
      _$jni.JString string3,
      _$jni.JString string4,
      _$jni.JString string5,
      _$jni.JArray<_$jni.jbyte> bs) {
    return _onResponse(
        i, string, string1, string2, string3, string4, string5, bs);
  }

  void handleFailure(int i, _$jni.JString string) {
    return _handleFailure(i, string);
  }
}

final class $HttpResponder$Type extends _$jni.JObjType<HttpResponder> {
  @_$jni.internal
  const $HttpResponder$Type();

  @_$jni.internal
  @_$core.override
  String get signature => r'Lorg/maplibre/android/http/HttpResponder;';

  @_$jni.internal
  @_$core.override
  HttpResponder fromReference(_$jni.JReference reference) =>
      HttpResponder.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode => ($HttpResponder$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($HttpResponder$Type) &&
        other is $HttpResponder$Type;
  }
}
