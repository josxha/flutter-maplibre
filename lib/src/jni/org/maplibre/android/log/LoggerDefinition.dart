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

/// from: `org.maplibre.android.log.LoggerDefinition`
class LoggerDefinition extends jni.JObject {
  @override
  late final jni.JObjType<LoggerDefinition> $type = type;

  LoggerDefinition.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/log/LoggerDefinition');

  /// The type which includes information such as the signature of this class.
  static const type = $LoggerDefinitionType();
  static final _id_v = _class.instanceMethodId(
    r'v',
    r'(Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _v = ProtectedJniExtensions.lookup<
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

  /// from: `public abstract void v(java.lang.String string, java.lang.String string1)`
  void v(
    jni.JString string,
    jni.JString string1,
  ) {
    _v(reference.pointer, _id_v as jni.JMethodIDPtr, string.reference.pointer,
            string1.reference.pointer)
        .check();
  }

  static final _id_v1 = _class.instanceMethodId(
    r'v',
    r'(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V',
  );

  static final _v1 = ProtectedJniExtensions.lookup<
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

  /// from: `public abstract void v(java.lang.String string, java.lang.String string1, java.lang.Throwable throwable)`
  void v1(
    jni.JString string,
    jni.JString string1,
    jni.JObject throwable,
  ) {
    _v1(reference.pointer, _id_v1 as jni.JMethodIDPtr, string.reference.pointer,
            string1.reference.pointer, throwable.reference.pointer)
        .check();
  }

  static final _id_d = _class.instanceMethodId(
    r'd',
    r'(Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _d = ProtectedJniExtensions.lookup<
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

  /// from: `public abstract void d(java.lang.String string, java.lang.String string1)`
  void d(
    jni.JString string,
    jni.JString string1,
  ) {
    _d(reference.pointer, _id_d as jni.JMethodIDPtr, string.reference.pointer,
            string1.reference.pointer)
        .check();
  }

  static final _id_d1 = _class.instanceMethodId(
    r'd',
    r'(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V',
  );

  static final _d1 = ProtectedJniExtensions.lookup<
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

  /// from: `public abstract void d(java.lang.String string, java.lang.String string1, java.lang.Throwable throwable)`
  void d1(
    jni.JString string,
    jni.JString string1,
    jni.JObject throwable,
  ) {
    _d1(reference.pointer, _id_d1 as jni.JMethodIDPtr, string.reference.pointer,
            string1.reference.pointer, throwable.reference.pointer)
        .check();
  }

  static final _id_i = _class.instanceMethodId(
    r'i',
    r'(Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _i = ProtectedJniExtensions.lookup<
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

  /// from: `public abstract void i(java.lang.String string, java.lang.String string1)`
  void i(
    jni.JString string,
    jni.JString string1,
  ) {
    _i(reference.pointer, _id_i as jni.JMethodIDPtr, string.reference.pointer,
            string1.reference.pointer)
        .check();
  }

  static final _id_i1 = _class.instanceMethodId(
    r'i',
    r'(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V',
  );

  static final _i1 = ProtectedJniExtensions.lookup<
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

  /// from: `public abstract void i(java.lang.String string, java.lang.String string1, java.lang.Throwable throwable)`
  void i1(
    jni.JString string,
    jni.JString string1,
    jni.JObject throwable,
  ) {
    _i1(reference.pointer, _id_i1 as jni.JMethodIDPtr, string.reference.pointer,
            string1.reference.pointer, throwable.reference.pointer)
        .check();
  }

  static final _id_w = _class.instanceMethodId(
    r'w',
    r'(Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _w = ProtectedJniExtensions.lookup<
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

  /// from: `public abstract void w(java.lang.String string, java.lang.String string1)`
  void w(
    jni.JString string,
    jni.JString string1,
  ) {
    _w(reference.pointer, _id_w as jni.JMethodIDPtr, string.reference.pointer,
            string1.reference.pointer)
        .check();
  }

  static final _id_w1 = _class.instanceMethodId(
    r'w',
    r'(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V',
  );

  static final _w1 = ProtectedJniExtensions.lookup<
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

  /// from: `public abstract void w(java.lang.String string, java.lang.String string1, java.lang.Throwable throwable)`
  void w1(
    jni.JString string,
    jni.JString string1,
    jni.JObject throwable,
  ) {
    _w1(reference.pointer, _id_w1 as jni.JMethodIDPtr, string.reference.pointer,
            string1.reference.pointer, throwable.reference.pointer)
        .check();
  }

  static final _id_e = _class.instanceMethodId(
    r'e',
    r'(Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _e = ProtectedJniExtensions.lookup<
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

  /// from: `public abstract void e(java.lang.String string, java.lang.String string1)`
  void e(
    jni.JString string,
    jni.JString string1,
  ) {
    _e(reference.pointer, _id_e as jni.JMethodIDPtr, string.reference.pointer,
            string1.reference.pointer)
        .check();
  }

  static final _id_e1 = _class.instanceMethodId(
    r'e',
    r'(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V',
  );

  static final _e1 = ProtectedJniExtensions.lookup<
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

  /// from: `public abstract void e(java.lang.String string, java.lang.String string1, java.lang.Throwable throwable)`
  void e1(
    jni.JString string,
    jni.JString string1,
    jni.JObject throwable,
  ) {
    _e1(reference.pointer, _id_e1 as jni.JMethodIDPtr, string.reference.pointer,
            string1.reference.pointer, throwable.reference.pointer)
        .check();
  }

  /// Maps a specific port to the implemented interface.
  static final Map<int, $LoggerDefinitionImpl> _$impls = {};
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
      if ($d == r'v(Ljava/lang/String;Ljava/lang/String;)V') {
        _$impls[$p]!.v(
          $a[0].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[1].castTo(const jni.JStringType(), releaseOriginal: true),
        );
        return jni.nullptr;
      }
      if ($d ==
          r'v(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V') {
        _$impls[$p]!.v1(
          $a[0].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[1].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[2].castTo(const jni.JObjectType(), releaseOriginal: true),
        );
        return jni.nullptr;
      }
      if ($d == r'd(Ljava/lang/String;Ljava/lang/String;)V') {
        _$impls[$p]!.d(
          $a[0].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[1].castTo(const jni.JStringType(), releaseOriginal: true),
        );
        return jni.nullptr;
      }
      if ($d ==
          r'd(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V') {
        _$impls[$p]!.d1(
          $a[0].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[1].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[2].castTo(const jni.JObjectType(), releaseOriginal: true),
        );
        return jni.nullptr;
      }
      if ($d == r'i(Ljava/lang/String;Ljava/lang/String;)V') {
        _$impls[$p]!.i(
          $a[0].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[1].castTo(const jni.JStringType(), releaseOriginal: true),
        );
        return jni.nullptr;
      }
      if ($d ==
          r'i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V') {
        _$impls[$p]!.i1(
          $a[0].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[1].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[2].castTo(const jni.JObjectType(), releaseOriginal: true),
        );
        return jni.nullptr;
      }
      if ($d == r'w(Ljava/lang/String;Ljava/lang/String;)V') {
        _$impls[$p]!.w(
          $a[0].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[1].castTo(const jni.JStringType(), releaseOriginal: true),
        );
        return jni.nullptr;
      }
      if ($d ==
          r'w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V') {
        _$impls[$p]!.w1(
          $a[0].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[1].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[2].castTo(const jni.JObjectType(), releaseOriginal: true),
        );
        return jni.nullptr;
      }
      if ($d == r'e(Ljava/lang/String;Ljava/lang/String;)V') {
        _$impls[$p]!.e(
          $a[0].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[1].castTo(const jni.JStringType(), releaseOriginal: true),
        );
        return jni.nullptr;
      }
      if ($d ==
          r'e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V') {
        _$impls[$p]!.e1(
          $a[0].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[1].castTo(const jni.JStringType(), releaseOriginal: true),
          $a[2].castTo(const jni.JObjectType(), releaseOriginal: true),
        );
        return jni.nullptr;
      }
    } catch (e) {
      return ProtectedJniExtensions.newDartException(e);
    }
    return jni.nullptr;
  }

  factory LoggerDefinition.implement(
    $LoggerDefinitionImpl $impl,
  ) {
    final $p = ReceivePort();
    final $x = LoggerDefinition.fromReference(
      ProtectedJniExtensions.newPortProxy(
        r'org.maplibre.android.log.LoggerDefinition',
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

abstract interface class $LoggerDefinitionImpl {
  factory $LoggerDefinitionImpl({
    required void Function(jni.JString string, jni.JString string1) v,
    required void Function(
            jni.JString string, jni.JString string1, jni.JObject throwable)
        v1,
    required void Function(jni.JString string, jni.JString string1) d,
    required void Function(
            jni.JString string, jni.JString string1, jni.JObject throwable)
        d1,
    required void Function(jni.JString string, jni.JString string1) i,
    required void Function(
            jni.JString string, jni.JString string1, jni.JObject throwable)
        i1,
    required void Function(jni.JString string, jni.JString string1) w,
    required void Function(
            jni.JString string, jni.JString string1, jni.JObject throwable)
        w1,
    required void Function(jni.JString string, jni.JString string1) e,
    required void Function(
            jni.JString string, jni.JString string1, jni.JObject throwable)
        e1,
  }) = _$LoggerDefinitionImpl;

  void v(jni.JString string, jni.JString string1);
  void v1(jni.JString string, jni.JString string1, jni.JObject throwable);
  void d(jni.JString string, jni.JString string1);
  void d1(jni.JString string, jni.JString string1, jni.JObject throwable);
  void i(jni.JString string, jni.JString string1);
  void i1(jni.JString string, jni.JString string1, jni.JObject throwable);
  void w(jni.JString string, jni.JString string1);
  void w1(jni.JString string, jni.JString string1, jni.JObject throwable);
  void e(jni.JString string, jni.JString string1);
  void e1(jni.JString string, jni.JString string1, jni.JObject throwable);
}

class _$LoggerDefinitionImpl implements $LoggerDefinitionImpl {
  _$LoggerDefinitionImpl({
    required void Function(jni.JString string, jni.JString string1) v,
    required void Function(
            jni.JString string, jni.JString string1, jni.JObject throwable)
        v1,
    required void Function(jni.JString string, jni.JString string1) d,
    required void Function(
            jni.JString string, jni.JString string1, jni.JObject throwable)
        d1,
    required void Function(jni.JString string, jni.JString string1) i,
    required void Function(
            jni.JString string, jni.JString string1, jni.JObject throwable)
        i1,
    required void Function(jni.JString string, jni.JString string1) w,
    required void Function(
            jni.JString string, jni.JString string1, jni.JObject throwable)
        w1,
    required void Function(jni.JString string, jni.JString string1) e,
    required void Function(
            jni.JString string, jni.JString string1, jni.JObject throwable)
        e1,
  })  : _v = v,
        _v1 = v1,
        _d = d,
        _d1 = d1,
        _i = i,
        _i1 = i1,
        _w = w,
        _w1 = w1,
        _e = e,
        _e1 = e1;

  final void Function(jni.JString string, jni.JString string1) _v;
  final void Function(
      jni.JString string, jni.JString string1, jni.JObject throwable) _v1;
  final void Function(jni.JString string, jni.JString string1) _d;
  final void Function(
      jni.JString string, jni.JString string1, jni.JObject throwable) _d1;
  final void Function(jni.JString string, jni.JString string1) _i;
  final void Function(
      jni.JString string, jni.JString string1, jni.JObject throwable) _i1;
  final void Function(jni.JString string, jni.JString string1) _w;
  final void Function(
      jni.JString string, jni.JString string1, jni.JObject throwable) _w1;
  final void Function(jni.JString string, jni.JString string1) _e;
  final void Function(
      jni.JString string, jni.JString string1, jni.JObject throwable) _e1;

  void v(jni.JString string, jni.JString string1) {
    return _v(string, string1);
  }

  void v1(jni.JString string, jni.JString string1, jni.JObject throwable) {
    return _v1(string, string1, throwable);
  }

  void d(jni.JString string, jni.JString string1) {
    return _d(string, string1);
  }

  void d1(jni.JString string, jni.JString string1, jni.JObject throwable) {
    return _d1(string, string1, throwable);
  }

  void i(jni.JString string, jni.JString string1) {
    return _i(string, string1);
  }

  void i1(jni.JString string, jni.JString string1, jni.JObject throwable) {
    return _i1(string, string1, throwable);
  }

  void w(jni.JString string, jni.JString string1) {
    return _w(string, string1);
  }

  void w1(jni.JString string, jni.JString string1, jni.JObject throwable) {
    return _w1(string, string1, throwable);
  }

  void e(jni.JString string, jni.JString string1) {
    return _e(string, string1);
  }

  void e1(jni.JString string, jni.JString string1, jni.JObject throwable) {
    return _e1(string, string1, throwable);
  }
}

final class $LoggerDefinitionType extends jni.JObjType<LoggerDefinition> {
  const $LoggerDefinitionType();

  @override
  String get signature => r'Lorg/maplibre/android/log/LoggerDefinition;';

  @override
  LoggerDefinition fromReference(jni.JReference reference) =>
      LoggerDefinition.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($LoggerDefinitionType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($LoggerDefinitionType) &&
        other is $LoggerDefinitionType;
  }
}
