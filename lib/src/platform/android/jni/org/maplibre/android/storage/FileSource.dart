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

import '../util/TileServerOptions.dart' as tileserveroptions_;

/// from: `org.maplibre.android.storage.FileSource$ResourceTransformCallback`
class FileSource_ResourceTransformCallback extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<FileSource_ResourceTransformCallback> $type;

  @_$jni.internal
  FileSource_ResourceTransformCallback.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = _$jni.JClass.forName(
      r'org/maplibre/android/storage/FileSource$ResourceTransformCallback');

  /// The type which includes information such as the signature of this class.
  static const type = $FileSource_ResourceTransformCallback$Type();
  static final _id_onURL = _class.instanceMethodId(
    r'onURL',
    r'(ILjava/lang/String;)Ljava/lang/String;',
  );

  static final _onURL = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni
                          .VarArgs<(_$jni.Int32, _$jni.Pointer<_$jni.Void>)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, int, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public abstract java.lang.String onURL(int i, java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JString onURL(
    int i,
    _$jni.JString string,
  ) {
    return _onURL(reference.pointer, _id_onURL as _$jni.JMethodIDPtr, i,
            string.reference.pointer)
        .object(const _$jni.JStringType());
  }

  /// Maps a specific port to the implemented interface.
  static final _$core.Map<int, $FileSource_ResourceTransformCallback> _$impls =
      {};
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
      if ($d == r'onURL(ILjava/lang/String;)Ljava/lang/String;') {
        final $r = _$impls[$p]!.onURL(
          $a[0]
              .as(const _$jni.JIntegerType(), releaseOriginal: true)
              .intValue(releaseOriginal: true),
          $a[1].as(const _$jni.JStringType(), releaseOriginal: true),
        );
        return ($r as _$jni.JObject)
            .as(const _$jni.JObjectType())
            .reference
            .toPointer();
      }
    } catch (e) {
      return _$jni.ProtectedJniExtensions.newDartException(e);
    }
    return _$jni.nullptr;
  }

  static void implementIn(
    _$jni.JImplementer implementer,
    $FileSource_ResourceTransformCallback $impl,
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
      r'org.maplibre.android.storage.FileSource$ResourceTransformCallback',
      $p,
      _$invokePointer,
      [],
    );
    final $a = $p.sendPort.nativePort;
    _$impls[$a] = $impl;
  }

  factory FileSource_ResourceTransformCallback.implement(
    $FileSource_ResourceTransformCallback $impl,
  ) {
    final $i = _$jni.JImplementer();
    implementIn($i, $impl);
    return FileSource_ResourceTransformCallback.fromReference(
      $i.implementReference(),
    );
  }
}

abstract base mixin class $FileSource_ResourceTransformCallback {
  factory $FileSource_ResourceTransformCallback({
    required _$jni.JString Function(int i, _$jni.JString string) onURL,
  }) = _$FileSource_ResourceTransformCallback;

  _$jni.JString onURL(int i, _$jni.JString string);
}

final class _$FileSource_ResourceTransformCallback
    with $FileSource_ResourceTransformCallback {
  _$FileSource_ResourceTransformCallback({
    required _$jni.JString Function(int i, _$jni.JString string) onURL,
  }) : _onURL = onURL;

  final _$jni.JString Function(int i, _$jni.JString string) _onURL;

  _$jni.JString onURL(int i, _$jni.JString string) {
    return _onURL(i, string);
  }
}

final class $FileSource_ResourceTransformCallback$Type
    extends _$jni.JObjType<FileSource_ResourceTransformCallback> {
  @_$jni.internal
  const $FileSource_ResourceTransformCallback$Type();

  @_$jni.internal
  @_$core.override
  String get signature =>
      r'Lorg/maplibre/android/storage/FileSource$ResourceTransformCallback;';

  @_$jni.internal
  @_$core.override
  FileSource_ResourceTransformCallback fromReference(
          _$jni.JReference reference) =>
      FileSource_ResourceTransformCallback.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode => ($FileSource_ResourceTransformCallback$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($FileSource_ResourceTransformCallback$Type) &&
        other is $FileSource_ResourceTransformCallback$Type;
  }
}

/// from: `org.maplibre.android.storage.FileSource$ResourcesCachePathChangeCallback`
class FileSource_ResourcesCachePathChangeCallback extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<FileSource_ResourcesCachePathChangeCallback> $type;

  @_$jni.internal
  FileSource_ResourcesCachePathChangeCallback.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = _$jni.JClass.forName(
      r'org/maplibre/android/storage/FileSource$ResourcesCachePathChangeCallback');

  /// The type which includes information such as the signature of this class.
  static const type = $FileSource_ResourcesCachePathChangeCallback$Type();
  static final _id_onSuccess = _class.instanceMethodId(
    r'onSuccess',
    r'(Ljava/lang/String;)V',
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

  /// from: `public abstract void onSuccess(java.lang.String string)`
  void onSuccess(
    _$jni.JString string,
  ) {
    _onSuccess(reference.pointer, _id_onSuccess as _$jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_onError = _class.instanceMethodId(
    r'onError',
    r'(Ljava/lang/String;)V',
  );

  static final _onError = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public abstract void onError(java.lang.String string)`
  void onError(
    _$jni.JString string,
  ) {
    _onError(reference.pointer, _id_onError as _$jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  /// Maps a specific port to the implemented interface.
  static final _$core.Map<int, $FileSource_ResourcesCachePathChangeCallback>
      _$impls = {};
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
      if ($d == r'onSuccess(Ljava/lang/String;)V') {
        _$impls[$p]!.onSuccess(
          $a[0].as(const _$jni.JStringType(), releaseOriginal: true),
        );
        return _$jni.nullptr;
      }
      if ($d == r'onError(Ljava/lang/String;)V') {
        _$impls[$p]!.onError(
          $a[0].as(const _$jni.JStringType(), releaseOriginal: true),
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
    $FileSource_ResourcesCachePathChangeCallback $impl,
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
      r'org.maplibre.android.storage.FileSource$ResourcesCachePathChangeCallback',
      $p,
      _$invokePointer,
      [
        if ($impl.onSuccess$async) r'onSuccess(Ljava/lang/String;)V',
        if ($impl.onError$async) r'onError(Ljava/lang/String;)V',
      ],
    );
    final $a = $p.sendPort.nativePort;
    _$impls[$a] = $impl;
  }

  factory FileSource_ResourcesCachePathChangeCallback.implement(
    $FileSource_ResourcesCachePathChangeCallback $impl,
  ) {
    final $i = _$jni.JImplementer();
    implementIn($i, $impl);
    return FileSource_ResourcesCachePathChangeCallback.fromReference(
      $i.implementReference(),
    );
  }
}

abstract base mixin class $FileSource_ResourcesCachePathChangeCallback {
  factory $FileSource_ResourcesCachePathChangeCallback({
    required void Function(_$jni.JString string) onSuccess,
    bool onSuccess$async,
    required void Function(_$jni.JString string) onError,
    bool onError$async,
  }) = _$FileSource_ResourcesCachePathChangeCallback;

  void onSuccess(_$jni.JString string);
  bool get onSuccess$async => false;
  void onError(_$jni.JString string);
  bool get onError$async => false;
}

final class _$FileSource_ResourcesCachePathChangeCallback
    with $FileSource_ResourcesCachePathChangeCallback {
  _$FileSource_ResourcesCachePathChangeCallback({
    required void Function(_$jni.JString string) onSuccess,
    this.onSuccess$async = false,
    required void Function(_$jni.JString string) onError,
    this.onError$async = false,
  })  : _onSuccess = onSuccess,
        _onError = onError;

  final void Function(_$jni.JString string) _onSuccess;
  final bool onSuccess$async;
  final void Function(_$jni.JString string) _onError;
  final bool onError$async;

  void onSuccess(_$jni.JString string) {
    return _onSuccess(string);
  }

  void onError(_$jni.JString string) {
    return _onError(string);
  }
}

final class $FileSource_ResourcesCachePathChangeCallback$Type
    extends _$jni.JObjType<FileSource_ResourcesCachePathChangeCallback> {
  @_$jni.internal
  const $FileSource_ResourcesCachePathChangeCallback$Type();

  @_$jni.internal
  @_$core.override
  String get signature =>
      r'Lorg/maplibre/android/storage/FileSource$ResourcesCachePathChangeCallback;';

  @_$jni.internal
  @_$core.override
  FileSource_ResourcesCachePathChangeCallback fromReference(
          _$jni.JReference reference) =>
      FileSource_ResourcesCachePathChangeCallback.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode =>
      ($FileSource_ResourcesCachePathChangeCallback$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType ==
            ($FileSource_ResourcesCachePathChangeCallback$Type) &&
        other is $FileSource_ResourcesCachePathChangeCallback$Type;
  }
}

/// from: `org.maplibre.android.storage.FileSource`
class FileSource extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<FileSource> $type;

  @_$jni.internal
  FileSource.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      _$jni.JClass.forName(r'org/maplibre/android/storage/FileSource');

  /// The type which includes information such as the signature of this class.
  static const type = $FileSource$Type();
  static final _id_getInstance = _class.staticMethodId(
    r'getInstance',
    r'(Landroid/content/Context;)Lorg/maplibre/android/storage/FileSource;',
  );

  static final _getInstance = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `static public org.maplibre.android.storage.FileSource getInstance(android.content.Context context)`
  /// The returned object must be released after use, by calling the [release] method.
  static FileSource getInstance(
    _$jni.JObject context,
  ) {
    return _getInstance(_class.reference.pointer,
            _id_getInstance as _$jni.JMethodIDPtr, context.reference.pointer)
        .object(const $FileSource$Type());
  }

  static final _id_isExternalStorageReadable = _class.staticMethodId(
    r'isExternalStorageReadable',
    r'()Z',
  );

  static final _isExternalStorageReadable = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallStaticBooleanMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `static public boolean isExternalStorageReadable()`
  static bool isExternalStorageReadable() {
    return _isExternalStorageReadable(_class.reference.pointer,
            _id_isExternalStorageReadable as _$jni.JMethodIDPtr)
        .boolean;
  }

  static final _id_initializeFileDirsPaths = _class.staticMethodId(
    r'initializeFileDirsPaths',
    r'(Landroid/content/Context;)V',
  );

  static final _initializeFileDirsPaths = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallStaticVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `static public void initializeFileDirsPaths(android.content.Context context)`
  static void initializeFileDirsPaths(
    _$jni.JObject context,
  ) {
    _initializeFileDirsPaths(
            _class.reference.pointer,
            _id_initializeFileDirsPaths as _$jni.JMethodIDPtr,
            context.reference.pointer)
        .check();
  }

  static final _id_getResourcesCachePath = _class.staticMethodId(
    r'getResourcesCachePath',
    r'(Landroid/content/Context;)Ljava/lang/String;',
  );

  static final _getResourcesCachePath = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `static public java.lang.String getResourcesCachePath(android.content.Context context)`
  /// The returned object must be released after use, by calling the [release] method.
  static _$jni.JString getResourcesCachePath(
    _$jni.JObject context,
  ) {
    return _getResourcesCachePath(
            _class.reference.pointer,
            _id_getResourcesCachePath as _$jni.JMethodIDPtr,
            context.reference.pointer)
        .object(const _$jni.JStringType());
  }

  static final _id_getInternalCachePath = _class.staticMethodId(
    r'getInternalCachePath',
    r'(Landroid/content/Context;)Ljava/lang/String;',
  );

  static final _getInternalCachePath = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `static public java.lang.String getInternalCachePath(android.content.Context context)`
  /// The returned object must be released after use, by calling the [release] method.
  static _$jni.JString getInternalCachePath(
    _$jni.JObject context,
  ) {
    return _getInternalCachePath(
            _class.reference.pointer,
            _id_getInternalCachePath as _$jni.JMethodIDPtr,
            context.reference.pointer)
        .object(const _$jni.JStringType());
  }

  static final _id_setResourcesCachePath = _class.staticMethodId(
    r'setResourcesCachePath',
    r'(Landroid/content/Context;Ljava/lang/String;Lorg/maplibre/android/storage/FileSource$ResourcesCachePathChangeCallback;)V',
  );

  static final _setResourcesCachePath = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JThrowablePtr Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_CallStaticVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `static public void setResourcesCachePath(android.content.Context context, java.lang.String string, org.maplibre.android.storage.FileSource$ResourcesCachePathChangeCallback resourcesCachePathChangeCallback)`
  static void setResourcesCachePath(
    _$jni.JObject context,
    _$jni.JString string,
    FileSource_ResourcesCachePathChangeCallback
        resourcesCachePathChangeCallback,
  ) {
    _setResourcesCachePath(
            _class.reference.pointer,
            _id_setResourcesCachePath as _$jni.JMethodIDPtr,
            context.reference.pointer,
            string.reference.pointer,
            resourcesCachePathChangeCallback.reference.pointer)
        .check();
  }

  static final _id_setResourcesCachePath$1 = _class.staticMethodId(
    r'setResourcesCachePath',
    r'(Ljava/lang/String;Lorg/maplibre/android/storage/FileSource$ResourcesCachePathChangeCallback;)V',
  );

  static final _setResourcesCachePath$1 = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JThrowablePtr Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_CallStaticVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `static public void setResourcesCachePath(java.lang.String string, org.maplibre.android.storage.FileSource$ResourcesCachePathChangeCallback resourcesCachePathChangeCallback)`
  static void setResourcesCachePath$1(
    _$jni.JString string,
    FileSource_ResourcesCachePathChangeCallback
        resourcesCachePathChangeCallback,
  ) {
    _setResourcesCachePath$1(
            _class.reference.pointer,
            _id_setResourcesCachePath$1 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            resourcesCachePathChangeCallback.reference.pointer)
        .check();
  }

  static final _id_setTileServerOptions = _class.instanceMethodId(
    r'setTileServerOptions',
    r'(Lorg/maplibre/android/util/TileServerOptions;)V',
  );

  static final _setTileServerOptions = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public native void setTileServerOptions(org.maplibre.android.util.TileServerOptions tileServerOptions)`
  void setTileServerOptions(
    tileserveroptions_.TileServerOptions tileServerOptions,
  ) {
    _setTileServerOptions(
            reference.pointer,
            _id_setTileServerOptions as _$jni.JMethodIDPtr,
            tileServerOptions.reference.pointer)
        .check();
  }

  static final _id_isActivated = _class.instanceMethodId(
    r'isActivated',
    r'()Z',
  );

  static final _isActivated = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallBooleanMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public native boolean isActivated()`
  bool isActivated() {
    return _isActivated(
            reference.pointer, _id_isActivated as _$jni.JMethodIDPtr)
        .boolean;
  }

  static final _id_activate = _class.instanceMethodId(
    r'activate',
    r'()V',
  );

  static final _activate = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JThrowablePtr Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public native void activate()`
  void activate() {
    _activate(reference.pointer, _id_activate as _$jni.JMethodIDPtr).check();
  }

  static final _id_deactivate = _class.instanceMethodId(
    r'deactivate',
    r'()V',
  );

  static final _deactivate = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JThrowablePtr Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public native void deactivate()`
  void deactivate() {
    _deactivate(reference.pointer, _id_deactivate as _$jni.JMethodIDPtr)
        .check();
  }

  static final _id_setApiKey = _class.instanceMethodId(
    r'setApiKey',
    r'(Ljava/lang/String;)V',
  );

  static final _setApiKey = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public native void setApiKey(java.lang.String string)`
  void setApiKey(
    _$jni.JString string,
  ) {
    _setApiKey(reference.pointer, _id_setApiKey as _$jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_getApiKey = _class.instanceMethodId(
    r'getApiKey',
    r'()Ljava/lang/String;',
  );

  static final _getApiKey = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public native java.lang.String getApiKey()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JString getApiKey() {
    return _getApiKey(reference.pointer, _id_getApiKey as _$jni.JMethodIDPtr)
        .object(const _$jni.JStringType());
  }

  static final _id_setApiBaseUrl = _class.instanceMethodId(
    r'setApiBaseUrl',
    r'(Ljava/lang/String;)V',
  );

  static final _setApiBaseUrl = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public native void setApiBaseUrl(java.lang.String string)`
  void setApiBaseUrl(
    _$jni.JString string,
  ) {
    _setApiBaseUrl(reference.pointer, _id_setApiBaseUrl as _$jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_getApiBaseUrl = _class.instanceMethodId(
    r'getApiBaseUrl',
    r'()Ljava/lang/String;',
  );

  static final _getApiBaseUrl = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public native java.lang.String getApiBaseUrl()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JString getApiBaseUrl() {
    return _getApiBaseUrl(
            reference.pointer, _id_getApiBaseUrl as _$jni.JMethodIDPtr)
        .object(const _$jni.JStringType());
  }

  static final _id_setResourceTransform = _class.instanceMethodId(
    r'setResourceTransform',
    r'(Lorg/maplibre/android/storage/FileSource$ResourceTransformCallback;)V',
  );

  static final _setResourceTransform = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public native void setResourceTransform(org.maplibre.android.storage.FileSource$ResourceTransformCallback resourceTransformCallback)`
  void setResourceTransform(
    FileSource_ResourceTransformCallback resourceTransformCallback,
  ) {
    _setResourceTransform(
            reference.pointer,
            _id_setResourceTransform as _$jni.JMethodIDPtr,
            resourceTransformCallback.reference.pointer)
        .check();
  }
}

final class $FileSource$Type extends _$jni.JObjType<FileSource> {
  @_$jni.internal
  const $FileSource$Type();

  @_$jni.internal
  @_$core.override
  String get signature => r'Lorg/maplibre/android/storage/FileSource;';

  @_$jni.internal
  @_$core.override
  FileSource fromReference(_$jni.JReference reference) =>
      FileSource.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode => ($FileSource$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($FileSource$Type) && other is $FileSource$Type;
  }
}
