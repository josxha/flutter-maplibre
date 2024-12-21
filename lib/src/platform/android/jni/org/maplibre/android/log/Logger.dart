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

import 'LoggerDefinition.dart' as loggerdefinition$_;

/// from: `org.maplibre.android.log.Logger$LogLevel`
class Logger$LogLevel extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<Logger$LogLevel> $type;

  @jni$_.internal
  Logger$LogLevel.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/log/Logger$LogLevel');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $Logger$LogLevel$NullableType();
  static const type = $Logger$LogLevel$Type();

  /// Maps a specific port to the implemented interface.
  static final core$_.Map<int, $Logger$LogLevel> _$impls = {};
  static jni$_.JObjectPtr _$invoke(
    int port,
    jni$_.JObjectPtr descriptor,
    jni$_.JObjectPtr args,
  ) {
    return _$invokeMethod(
      port,
      jni$_.MethodInvocation.fromAddresses(
        0,
        descriptor.address,
        args.address,
      ),
    );
  }

  static final jni$_.Pointer<
          jni$_.NativeFunction<
              jni$_.JObjectPtr Function(
                  jni$_.Int64, jni$_.JObjectPtr, jni$_.JObjectPtr)>>
      _$invokePointer = jni$_.Pointer.fromFunction(_$invoke);

  static jni$_.Pointer<jni$_.Void> _$invokeMethod(
    int $p,
    jni$_.MethodInvocation $i,
  ) {
    try {
      final $d = $i.methodDescriptor.toDartString(releaseOriginal: true);
      final $a = $i.args;
    } catch (e) {
      return jni$_.ProtectedJniExtensions.newDartException(e);
    }
    return jni$_.nullptr;
  }

  static void implementIn(
    jni$_.JImplementer implementer,
    $Logger$LogLevel $impl,
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
      r'org.maplibre.android.log.Logger$LogLevel',
      $p,
      _$invokePointer,
      [],
    );
    final $a = $p.sendPort.nativePort;
    _$impls[$a] = $impl;
  }

  factory Logger$LogLevel.implement(
    $Logger$LogLevel $impl,
  ) {
    final $i = jni$_.JImplementer();
    implementIn($i, $impl);
    return Logger$LogLevel.fromReference(
      $i.implementReference(),
    );
  }
}

abstract base mixin class $Logger$LogLevel {
  factory $Logger$LogLevel() = _$Logger$LogLevel;
}

final class _$Logger$LogLevel with $Logger$LogLevel {
  _$Logger$LogLevel();
}

final class $Logger$LogLevel$NullableType
    extends jni$_.JObjType<Logger$LogLevel?> {
  @jni$_.internal
  const $Logger$LogLevel$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/log/Logger$LogLevel;';

  @jni$_.internal
  @core$_.override
  Logger$LogLevel? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : Logger$LogLevel.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Logger$LogLevel?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Logger$LogLevel$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Logger$LogLevel$NullableType) &&
        other is $Logger$LogLevel$NullableType;
  }
}

final class $Logger$LogLevel$Type extends jni$_.JObjType<Logger$LogLevel> {
  @jni$_.internal
  const $Logger$LogLevel$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/log/Logger$LogLevel;';

  @jni$_.internal
  @core$_.override
  Logger$LogLevel fromReference(jni$_.JReference reference) =>
      Logger$LogLevel.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Logger$LogLevel?> get nullableType =>
      const $Logger$LogLevel$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Logger$LogLevel$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Logger$LogLevel$Type) &&
        other is $Logger$LogLevel$Type;
  }
}

/// from: `org.maplibre.android.log.Logger`
class Logger extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<Logger> $type;

  @jni$_.internal
  Logger.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/log/Logger');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $Logger$NullableType();
  static const type = $Logger$Type();

  /// from: `static public final int VERBOSE`
  static const VERBOSE = 2;

  /// from: `static public final int DEBUG`
  static const DEBUG = 3;

  /// from: `static public final int INFO`
  static const INFO = 4;

  /// from: `static public final int WARN`
  static const WARN = 5;

  /// from: `static public final int ERROR`
  static const ERROR = 6;

  /// from: `static public final int NONE`
  static const NONE = 99;
  static final _id_new$ = _class.constructorId(
    r'()V',
  );

  static final _new$ = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public void <init>()`
  /// The returned object must be released after use, by calling the [release] method.
  factory Logger() {
    return Logger.fromReference(
        _new$(_class.reference.pointer, _id_new$ as jni$_.JMethodIDPtr)
            .reference);
  }

  static final _id_setVerbosity = _class.staticMethodId(
    r'setVerbosity',
    r'(I)V',
  );

  static final _setVerbosity = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr, jni$_.VarArgs<(jni$_.Int32,)>)>>(
          'globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, int)>();

  /// from: `static public void setVerbosity(int i)`
  static void setVerbosity(
    int i,
  ) {
    _setVerbosity(
            _class.reference.pointer, _id_setVerbosity as jni$_.JMethodIDPtr, i)
        .check();
  }

  static final _id_setLoggerDefinition = _class.staticMethodId(
    r'setLoggerDefinition',
    r'(Lorg/maplibre/android/log/LoggerDefinition;)V',
  );

  static final _setLoggerDefinition = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public void setLoggerDefinition(org.maplibre.android.log.LoggerDefinition loggerDefinition)`
  static void setLoggerDefinition(
    loggerdefinition$_.LoggerDefinition? loggerDefinition,
  ) {
    final _$loggerDefinition =
        loggerDefinition?.reference ?? jni$_.jNullReference;
    _setLoggerDefinition(
            _class.reference.pointer,
            _id_setLoggerDefinition as jni$_.JMethodIDPtr,
            _$loggerDefinition.pointer)
        .check();
  }

  static final _id_v = _class.staticMethodId(
    r'v',
    r'(Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _v = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public void v(java.lang.String string, java.lang.String string1)`
  static void v(
    jni$_.JString? string,
    jni$_.JString? string1,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    _v(_class.reference.pointer, _id_v as jni$_.JMethodIDPtr, _$string.pointer,
            _$string1.pointer)
        .check();
  }

  static final _id_v$1 = _class.staticMethodId(
    r'v',
    r'(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V',
  );

  static final _v$1 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public void v(java.lang.String string, java.lang.String string1, java.lang.Throwable throwable)`
  static void v$1(
    jni$_.JString? string,
    jni$_.JString? string1,
    jni$_.JObject? throwable,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    final _$throwable = throwable?.reference ?? jni$_.jNullReference;
    _v$1(_class.reference.pointer, _id_v$1 as jni$_.JMethodIDPtr,
            _$string.pointer, _$string1.pointer, _$throwable.pointer)
        .check();
  }

  static final _id_d = _class.staticMethodId(
    r'd',
    r'(Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _d = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public void d(java.lang.String string, java.lang.String string1)`
  static void d(
    jni$_.JString? string,
    jni$_.JString? string1,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    _d(_class.reference.pointer, _id_d as jni$_.JMethodIDPtr, _$string.pointer,
            _$string1.pointer)
        .check();
  }

  static final _id_d$1 = _class.staticMethodId(
    r'd',
    r'(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V',
  );

  static final _d$1 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public void d(java.lang.String string, java.lang.String string1, java.lang.Throwable throwable)`
  static void d$1(
    jni$_.JString? string,
    jni$_.JString? string1,
    jni$_.JObject? throwable,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    final _$throwable = throwable?.reference ?? jni$_.jNullReference;
    _d$1(_class.reference.pointer, _id_d$1 as jni$_.JMethodIDPtr,
            _$string.pointer, _$string1.pointer, _$throwable.pointer)
        .check();
  }

  static final _id_i = _class.staticMethodId(
    r'i',
    r'(Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _i = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public void i(java.lang.String string, java.lang.String string1)`
  static void i(
    jni$_.JString? string,
    jni$_.JString? string1,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    _i(_class.reference.pointer, _id_i as jni$_.JMethodIDPtr, _$string.pointer,
            _$string1.pointer)
        .check();
  }

  static final _id_i$1 = _class.staticMethodId(
    r'i',
    r'(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V',
  );

  static final _i$1 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public void i(java.lang.String string, java.lang.String string1, java.lang.Throwable throwable)`
  static void i$1(
    jni$_.JString? string,
    jni$_.JString? string1,
    jni$_.JObject? throwable,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    final _$throwable = throwable?.reference ?? jni$_.jNullReference;
    _i$1(_class.reference.pointer, _id_i$1 as jni$_.JMethodIDPtr,
            _$string.pointer, _$string1.pointer, _$throwable.pointer)
        .check();
  }

  static final _id_w = _class.staticMethodId(
    r'w',
    r'(Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _w = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public void w(java.lang.String string, java.lang.String string1)`
  static void w(
    jni$_.JString? string,
    jni$_.JString? string1,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    _w(_class.reference.pointer, _id_w as jni$_.JMethodIDPtr, _$string.pointer,
            _$string1.pointer)
        .check();
  }

  static final _id_w$1 = _class.staticMethodId(
    r'w',
    r'(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V',
  );

  static final _w$1 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public void w(java.lang.String string, java.lang.String string1, java.lang.Throwable throwable)`
  static void w$1(
    jni$_.JString? string,
    jni$_.JString? string1,
    jni$_.JObject? throwable,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    final _$throwable = throwable?.reference ?? jni$_.jNullReference;
    _w$1(_class.reference.pointer, _id_w$1 as jni$_.JMethodIDPtr,
            _$string.pointer, _$string1.pointer, _$throwable.pointer)
        .check();
  }

  static final _id_e = _class.staticMethodId(
    r'e',
    r'(Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _e = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public void e(java.lang.String string, java.lang.String string1)`
  static void e(
    jni$_.JString? string,
    jni$_.JString? string1,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    _e(_class.reference.pointer, _id_e as jni$_.JMethodIDPtr, _$string.pointer,
            _$string1.pointer)
        .check();
  }

  static final _id_e$1 = _class.staticMethodId(
    r'e',
    r'(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V',
  );

  static final _e$1 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public void e(java.lang.String string, java.lang.String string1, java.lang.Throwable throwable)`
  static void e$1(
    jni$_.JString? string,
    jni$_.JString? string1,
    jni$_.JObject? throwable,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    final _$throwable = throwable?.reference ?? jni$_.jNullReference;
    _e$1(_class.reference.pointer, _id_e$1 as jni$_.JMethodIDPtr,
            _$string.pointer, _$string1.pointer, _$throwable.pointer)
        .check();
  }

  static final _id_log = _class.staticMethodId(
    r'log',
    r'(ILjava/lang/String;Ljava/lang/String;)V',
  );

  static final _log = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Int32,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              int,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public void log(int i, java.lang.String string, java.lang.String string1)`
  static void log(
    int i,
    jni$_.JString? string,
    jni$_.JString? string1,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    _log(_class.reference.pointer, _id_log as jni$_.JMethodIDPtr, i,
            _$string.pointer, _$string1.pointer)
        .check();
  }
}

final class $Logger$NullableType extends jni$_.JObjType<Logger?> {
  @jni$_.internal
  const $Logger$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/log/Logger;';

  @jni$_.internal
  @core$_.override
  Logger? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : Logger.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Logger?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Logger$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Logger$NullableType) &&
        other is $Logger$NullableType;
  }
}

final class $Logger$Type extends jni$_.JObjType<Logger> {
  @jni$_.internal
  const $Logger$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/log/Logger;';

  @jni$_.internal
  @core$_.override
  Logger fromReference(jni$_.JReference reference) => Logger.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Logger?> get nullableType => const $Logger$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Logger$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Logger$Type) && other is $Logger$Type;
  }
}