// Autogenerated by jnigen. DO NOT EDIT!

// ignore_for_file: document_ignores
// ignore_for_file: avoid_catches_without_on_clauses
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

/// from: `org.maplibre.android.utils.FileUtils$CheckFileReadPermissionTask`
class FileUtils$CheckFileReadPermissionTask extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<FileUtils$CheckFileReadPermissionTask> $type;

  @jni$_.internal
  FileUtils$CheckFileReadPermissionTask.fromReference(
    jni$_.JReference reference,
  ) : $type = type,
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
    r'org/maplibre/android/utils/FileUtils$CheckFileReadPermissionTask',
  );

  /// The type which includes information such as the signature of this class.
  static const nullableType =
      $FileUtils$CheckFileReadPermissionTask$NullableType();
  static const type = $FileUtils$CheckFileReadPermissionTask$Type();
  static final _id_new$ = _class.constructorId(
    r'(Lorg/maplibre/android/utils/FileUtils$OnCheckFileReadPermissionListener;)V',
  );

  static final _new$ =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_NewObject')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public void <init>(org.maplibre.android.utils.FileUtils$OnCheckFileReadPermissionListener onCheckFileReadPermissionListener)`
  /// The returned object must be released after use, by calling the [release] method.
  factory FileUtils$CheckFileReadPermissionTask(
    FileUtils$OnCheckFileReadPermissionListener
    onCheckFileReadPermissionListener,
  ) {
    final _$onCheckFileReadPermissionListener =
        onCheckFileReadPermissionListener.reference;
    return FileUtils$CheckFileReadPermissionTask.fromReference(
      _new$(
        _class.reference.pointer,
        _id_new$ as jni$_.JMethodIDPtr,
        _$onCheckFileReadPermissionListener.pointer,
      ).reference,
    );
  }
}

final class $FileUtils$CheckFileReadPermissionTask$NullableType
    extends jni$_.JObjType<FileUtils$CheckFileReadPermissionTask?> {
  @jni$_.internal
  const $FileUtils$CheckFileReadPermissionTask$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/utils/FileUtils$CheckFileReadPermissionTask;';

  @jni$_.internal
  @core$_.override
  FileUtils$CheckFileReadPermissionTask? fromReference(
    jni$_.JReference reference,
  ) =>
      reference.isNull
          ? null
          : FileUtils$CheckFileReadPermissionTask.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<FileUtils$CheckFileReadPermissionTask?> get nullableType =>
      this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode =>
      ($FileUtils$CheckFileReadPermissionTask$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($FileUtils$CheckFileReadPermissionTask$NullableType) &&
        other is $FileUtils$CheckFileReadPermissionTask$NullableType;
  }
}

final class $FileUtils$CheckFileReadPermissionTask$Type
    extends jni$_.JObjType<FileUtils$CheckFileReadPermissionTask> {
  @jni$_.internal
  const $FileUtils$CheckFileReadPermissionTask$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/utils/FileUtils$CheckFileReadPermissionTask;';

  @jni$_.internal
  @core$_.override
  FileUtils$CheckFileReadPermissionTask fromReference(
    jni$_.JReference reference,
  ) => FileUtils$CheckFileReadPermissionTask.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<FileUtils$CheckFileReadPermissionTask?> get nullableType =>
      const $FileUtils$CheckFileReadPermissionTask$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($FileUtils$CheckFileReadPermissionTask$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($FileUtils$CheckFileReadPermissionTask$Type) &&
        other is $FileUtils$CheckFileReadPermissionTask$Type;
  }
}

/// from: `org.maplibre.android.utils.FileUtils$CheckFileWritePermissionTask`
class FileUtils$CheckFileWritePermissionTask extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<FileUtils$CheckFileWritePermissionTask> $type;

  @jni$_.internal
  FileUtils$CheckFileWritePermissionTask.fromReference(
    jni$_.JReference reference,
  ) : $type = type,
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
    r'org/maplibre/android/utils/FileUtils$CheckFileWritePermissionTask',
  );

  /// The type which includes information such as the signature of this class.
  static const nullableType =
      $FileUtils$CheckFileWritePermissionTask$NullableType();
  static const type = $FileUtils$CheckFileWritePermissionTask$Type();
  static final _id_new$ = _class.constructorId(
    r'(Lorg/maplibre/android/utils/FileUtils$OnCheckFileWritePermissionListener;)V',
  );

  static final _new$ =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_NewObject')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `public void <init>(org.maplibre.android.utils.FileUtils$OnCheckFileWritePermissionListener onCheckFileWritePermissionListener)`
  /// The returned object must be released after use, by calling the [release] method.
  factory FileUtils$CheckFileWritePermissionTask(
    FileUtils$OnCheckFileWritePermissionListener
    onCheckFileWritePermissionListener,
  ) {
    final _$onCheckFileWritePermissionListener =
        onCheckFileWritePermissionListener.reference;
    return FileUtils$CheckFileWritePermissionTask.fromReference(
      _new$(
        _class.reference.pointer,
        _id_new$ as jni$_.JMethodIDPtr,
        _$onCheckFileWritePermissionListener.pointer,
      ).reference,
    );
  }
}

final class $FileUtils$CheckFileWritePermissionTask$NullableType
    extends jni$_.JObjType<FileUtils$CheckFileWritePermissionTask?> {
  @jni$_.internal
  const $FileUtils$CheckFileWritePermissionTask$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/utils/FileUtils$CheckFileWritePermissionTask;';

  @jni$_.internal
  @core$_.override
  FileUtils$CheckFileWritePermissionTask? fromReference(
    jni$_.JReference reference,
  ) =>
      reference.isNull
          ? null
          : FileUtils$CheckFileWritePermissionTask.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<FileUtils$CheckFileWritePermissionTask?> get nullableType =>
      this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode =>
      ($FileUtils$CheckFileWritePermissionTask$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($FileUtils$CheckFileWritePermissionTask$NullableType) &&
        other is $FileUtils$CheckFileWritePermissionTask$NullableType;
  }
}

final class $FileUtils$CheckFileWritePermissionTask$Type
    extends jni$_.JObjType<FileUtils$CheckFileWritePermissionTask> {
  @jni$_.internal
  const $FileUtils$CheckFileWritePermissionTask$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/utils/FileUtils$CheckFileWritePermissionTask;';

  @jni$_.internal
  @core$_.override
  FileUtils$CheckFileWritePermissionTask fromReference(
    jni$_.JReference reference,
  ) => FileUtils$CheckFileWritePermissionTask.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<FileUtils$CheckFileWritePermissionTask?> get nullableType =>
      const $FileUtils$CheckFileWritePermissionTask$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($FileUtils$CheckFileWritePermissionTask$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($FileUtils$CheckFileWritePermissionTask$Type) &&
        other is $FileUtils$CheckFileWritePermissionTask$Type;
  }
}

/// from: `org.maplibre.android.utils.FileUtils$OnCheckFileReadPermissionListener`
class FileUtils$OnCheckFileReadPermissionListener extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<FileUtils$OnCheckFileReadPermissionListener> $type;

  @jni$_.internal
  FileUtils$OnCheckFileReadPermissionListener.fromReference(
    jni$_.JReference reference,
  ) : $type = type,
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
    r'org/maplibre/android/utils/FileUtils$OnCheckFileReadPermissionListener',
  );

  /// The type which includes information such as the signature of this class.
  static const nullableType =
      $FileUtils$OnCheckFileReadPermissionListener$NullableType();
  static const type = $FileUtils$OnCheckFileReadPermissionListener$Type();
  static final _id_onReadPermissionGranted = _class.instanceMethodId(
    r'onReadPermissionGranted',
    r'()V',
  );

  static final _onReadPermissionGranted =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public abstract void onReadPermissionGranted()`
  void onReadPermissionGranted() {
    _onReadPermissionGranted(
      reference.pointer,
      _id_onReadPermissionGranted as jni$_.JMethodIDPtr,
    ).check();
  }

  static final _id_onError = _class.instanceMethodId(r'onError', r'()V');

  static final _onError =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public abstract void onError()`
  void onError() {
    _onError(reference.pointer, _id_onError as jni$_.JMethodIDPtr).check();
  }

  /// Maps a specific port to the implemented interface.
  static final core$_.Map<int, $FileUtils$OnCheckFileReadPermissionListener>
  _$impls = {};
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
      if ($d == r'onReadPermissionGranted()V') {
        _$impls[$p]!.onReadPermissionGranted();
        return jni$_.nullptr;
      }
      if ($d == r'onError()V') {
        _$impls[$p]!.onError();
        return jni$_.nullptr;
      }
    } catch (e) {
      return jni$_.ProtectedJniExtensions.newDartException(e);
    }
    return jni$_.nullptr;
  }

  static void implementIn(
    jni$_.JImplementer implementer,
    $FileUtils$OnCheckFileReadPermissionListener $impl,
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
      r'org.maplibre.android.utils.FileUtils$OnCheckFileReadPermissionListener',
      $p,
      _$invokePointer,
      [
        if ($impl.onReadPermissionGranted$async) r'onReadPermissionGranted()V',
        if ($impl.onError$async) r'onError()V',
      ],
    );
    final $a = $p.sendPort.nativePort;
    _$impls[$a] = $impl;
  }

  factory FileUtils$OnCheckFileReadPermissionListener.implement(
    $FileUtils$OnCheckFileReadPermissionListener $impl,
  ) {
    final $i = jni$_.JImplementer();
    implementIn($i, $impl);
    return FileUtils$OnCheckFileReadPermissionListener.fromReference(
      $i.implementReference(),
    );
  }
}

abstract base mixin class $FileUtils$OnCheckFileReadPermissionListener {
  factory $FileUtils$OnCheckFileReadPermissionListener({
    required void Function() onReadPermissionGranted,
    bool onReadPermissionGranted$async,
    required void Function() onError,
    bool onError$async,
  }) = _$FileUtils$OnCheckFileReadPermissionListener;

  void onReadPermissionGranted();
  bool get onReadPermissionGranted$async => false;
  void onError();
  bool get onError$async => false;
}

final class _$FileUtils$OnCheckFileReadPermissionListener
    with $FileUtils$OnCheckFileReadPermissionListener {
  _$FileUtils$OnCheckFileReadPermissionListener({
    required void Function() onReadPermissionGranted,
    this.onReadPermissionGranted$async = false,
    required void Function() onError,
    this.onError$async = false,
  }) : _onReadPermissionGranted = onReadPermissionGranted,
       _onError = onError;

  final void Function() _onReadPermissionGranted;
  final bool onReadPermissionGranted$async;
  final void Function() _onError;
  final bool onError$async;

  void onReadPermissionGranted() {
    return _onReadPermissionGranted();
  }

  void onError() {
    return _onError();
  }
}

final class $FileUtils$OnCheckFileReadPermissionListener$NullableType
    extends jni$_.JObjType<FileUtils$OnCheckFileReadPermissionListener?> {
  @jni$_.internal
  const $FileUtils$OnCheckFileReadPermissionListener$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/utils/FileUtils$OnCheckFileReadPermissionListener;';

  @jni$_.internal
  @core$_.override
  FileUtils$OnCheckFileReadPermissionListener? fromReference(
    jni$_.JReference reference,
  ) =>
      reference.isNull
          ? null
          : FileUtils$OnCheckFileReadPermissionListener.fromReference(
            reference,
          );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<FileUtils$OnCheckFileReadPermissionListener?>
  get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode =>
      ($FileUtils$OnCheckFileReadPermissionListener$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($FileUtils$OnCheckFileReadPermissionListener$NullableType) &&
        other is $FileUtils$OnCheckFileReadPermissionListener$NullableType;
  }
}

final class $FileUtils$OnCheckFileReadPermissionListener$Type
    extends jni$_.JObjType<FileUtils$OnCheckFileReadPermissionListener> {
  @jni$_.internal
  const $FileUtils$OnCheckFileReadPermissionListener$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/utils/FileUtils$OnCheckFileReadPermissionListener;';

  @jni$_.internal
  @core$_.override
  FileUtils$OnCheckFileReadPermissionListener fromReference(
    jni$_.JReference reference,
  ) => FileUtils$OnCheckFileReadPermissionListener.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<FileUtils$OnCheckFileReadPermissionListener?>
  get nullableType =>
      const $FileUtils$OnCheckFileReadPermissionListener$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode =>
      ($FileUtils$OnCheckFileReadPermissionListener$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($FileUtils$OnCheckFileReadPermissionListener$Type) &&
        other is $FileUtils$OnCheckFileReadPermissionListener$Type;
  }
}

/// from: `org.maplibre.android.utils.FileUtils$OnCheckFileWritePermissionListener`
class FileUtils$OnCheckFileWritePermissionListener extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<FileUtils$OnCheckFileWritePermissionListener> $type;

  @jni$_.internal
  FileUtils$OnCheckFileWritePermissionListener.fromReference(
    jni$_.JReference reference,
  ) : $type = type,
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
    r'org/maplibre/android/utils/FileUtils$OnCheckFileWritePermissionListener',
  );

  /// The type which includes information such as the signature of this class.
  static const nullableType =
      $FileUtils$OnCheckFileWritePermissionListener$NullableType();
  static const type = $FileUtils$OnCheckFileWritePermissionListener$Type();
  static final _id_onWritePermissionGranted = _class.instanceMethodId(
    r'onWritePermissionGranted',
    r'()V',
  );

  static final _onWritePermissionGranted =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public abstract void onWritePermissionGranted()`
  void onWritePermissionGranted() {
    _onWritePermissionGranted(
      reference.pointer,
      _id_onWritePermissionGranted as jni$_.JMethodIDPtr,
    ).check();
  }

  static final _id_onError = _class.instanceMethodId(r'onError', r'()V');

  static final _onError =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public abstract void onError()`
  void onError() {
    _onError(reference.pointer, _id_onError as jni$_.JMethodIDPtr).check();
  }

  /// Maps a specific port to the implemented interface.
  static final core$_.Map<int, $FileUtils$OnCheckFileWritePermissionListener>
  _$impls = {};
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
      if ($d == r'onWritePermissionGranted()V') {
        _$impls[$p]!.onWritePermissionGranted();
        return jni$_.nullptr;
      }
      if ($d == r'onError()V') {
        _$impls[$p]!.onError();
        return jni$_.nullptr;
      }
    } catch (e) {
      return jni$_.ProtectedJniExtensions.newDartException(e);
    }
    return jni$_.nullptr;
  }

  static void implementIn(
    jni$_.JImplementer implementer,
    $FileUtils$OnCheckFileWritePermissionListener $impl,
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
      r'org.maplibre.android.utils.FileUtils$OnCheckFileWritePermissionListener',
      $p,
      _$invokePointer,
      [
        if ($impl.onWritePermissionGranted$async)
          r'onWritePermissionGranted()V',
        if ($impl.onError$async) r'onError()V',
      ],
    );
    final $a = $p.sendPort.nativePort;
    _$impls[$a] = $impl;
  }

  factory FileUtils$OnCheckFileWritePermissionListener.implement(
    $FileUtils$OnCheckFileWritePermissionListener $impl,
  ) {
    final $i = jni$_.JImplementer();
    implementIn($i, $impl);
    return FileUtils$OnCheckFileWritePermissionListener.fromReference(
      $i.implementReference(),
    );
  }
}

abstract base mixin class $FileUtils$OnCheckFileWritePermissionListener {
  factory $FileUtils$OnCheckFileWritePermissionListener({
    required void Function() onWritePermissionGranted,
    bool onWritePermissionGranted$async,
    required void Function() onError,
    bool onError$async,
  }) = _$FileUtils$OnCheckFileWritePermissionListener;

  void onWritePermissionGranted();
  bool get onWritePermissionGranted$async => false;
  void onError();
  bool get onError$async => false;
}

final class _$FileUtils$OnCheckFileWritePermissionListener
    with $FileUtils$OnCheckFileWritePermissionListener {
  _$FileUtils$OnCheckFileWritePermissionListener({
    required void Function() onWritePermissionGranted,
    this.onWritePermissionGranted$async = false,
    required void Function() onError,
    this.onError$async = false,
  }) : _onWritePermissionGranted = onWritePermissionGranted,
       _onError = onError;

  final void Function() _onWritePermissionGranted;
  final bool onWritePermissionGranted$async;
  final void Function() _onError;
  final bool onError$async;

  void onWritePermissionGranted() {
    return _onWritePermissionGranted();
  }

  void onError() {
    return _onError();
  }
}

final class $FileUtils$OnCheckFileWritePermissionListener$NullableType
    extends jni$_.JObjType<FileUtils$OnCheckFileWritePermissionListener?> {
  @jni$_.internal
  const $FileUtils$OnCheckFileWritePermissionListener$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/utils/FileUtils$OnCheckFileWritePermissionListener;';

  @jni$_.internal
  @core$_.override
  FileUtils$OnCheckFileWritePermissionListener? fromReference(
    jni$_.JReference reference,
  ) =>
      reference.isNull
          ? null
          : FileUtils$OnCheckFileWritePermissionListener.fromReference(
            reference,
          );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<FileUtils$OnCheckFileWritePermissionListener?>
  get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode =>
      ($FileUtils$OnCheckFileWritePermissionListener$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($FileUtils$OnCheckFileWritePermissionListener$NullableType) &&
        other is $FileUtils$OnCheckFileWritePermissionListener$NullableType;
  }
}

final class $FileUtils$OnCheckFileWritePermissionListener$Type
    extends jni$_.JObjType<FileUtils$OnCheckFileWritePermissionListener> {
  @jni$_.internal
  const $FileUtils$OnCheckFileWritePermissionListener$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/utils/FileUtils$OnCheckFileWritePermissionListener;';

  @jni$_.internal
  @core$_.override
  FileUtils$OnCheckFileWritePermissionListener fromReference(
    jni$_.JReference reference,
  ) => FileUtils$OnCheckFileWritePermissionListener.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<FileUtils$OnCheckFileWritePermissionListener?>
  get nullableType =>
      const $FileUtils$OnCheckFileWritePermissionListener$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode =>
      ($FileUtils$OnCheckFileWritePermissionListener$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($FileUtils$OnCheckFileWritePermissionListener$Type) &&
        other is $FileUtils$OnCheckFileWritePermissionListener$Type;
  }
}

/// from: `org.maplibre.android.utils.FileUtils`
class FileUtils extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<FileUtils> $type;

  @jni$_.internal
  FileUtils.fromReference(jni$_.JReference reference)
    : $type = type,
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
    r'org/maplibre/android/utils/FileUtils',
  );

  /// The type which includes information such as the signature of this class.
  static const nullableType = $FileUtils$NullableType();
  static const type = $FileUtils$Type();
  static final _id_new$ = _class.constructorId(r'()V');

  static final _new$ =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_NewObject')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  /// from: `public void <init>()`
  /// The returned object must be released after use, by calling the [release] method.
  factory FileUtils() {
    return FileUtils.fromReference(
      _new$(_class.reference.pointer, _id_new$ as jni$_.JMethodIDPtr).reference,
    );
  }

  static final _id_deleteFile = _class.staticMethodId(
    r'deleteFile',
    r'(Ljava/lang/String;)V',
  );

  static final _deleteFile =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_CallStaticVoidMethod')
          .asFunction<
            jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  /// from: `static public void deleteFile(java.lang.String string)`
  static void deleteFile(jni$_.JString string) {
    final _$string = string.reference;
    _deleteFile(
      _class.reference.pointer,
      _id_deleteFile as jni$_.JMethodIDPtr,
      _$string.pointer,
    ).check();
  }
}

final class $FileUtils$NullableType extends jni$_.JObjType<FileUtils?> {
  @jni$_.internal
  const $FileUtils$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/utils/FileUtils;';

  @jni$_.internal
  @core$_.override
  FileUtils? fromReference(jni$_.JReference reference) =>
      reference.isNull ? null : FileUtils.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<FileUtils?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($FileUtils$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($FileUtils$NullableType) &&
        other is $FileUtils$NullableType;
  }
}

final class $FileUtils$Type extends jni$_.JObjType<FileUtils> {
  @jni$_.internal
  const $FileUtils$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/utils/FileUtils;';

  @jni$_.internal
  @core$_.override
  FileUtils fromReference(jni$_.JReference reference) =>
      FileUtils.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<FileUtils?> get nullableType =>
      const $FileUtils$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($FileUtils$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($FileUtils$Type) && other is $FileUtils$Type;
  }
}
