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

import '../maps/MapLibreMap.dart' as maplibremap_;

import 'CameraPosition.dart' as cameraposition_;

/// from: `org.maplibre.android.camera.CameraUpdate`
class CameraUpdate extends jni.JObject {
  @override
  late final jni.JObjType<CameraUpdate> $type = type;

  CameraUpdate.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/camera/CameraUpdate');

  /// The type which includes information such as the signature of this class.
  static const type = $CameraUpdateType();
  static final _id_getCameraPosition = _class.instanceMethodId(
    r'getCameraPosition',
    r'(Lorg/maplibre/android/maps/MapLibreMap;)Lorg/maplibre/android/camera/CameraPosition;',
  );

  static final _getCameraPosition = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public abstract org.maplibre.android.camera.CameraPosition getCameraPosition(org.maplibre.android.maps.MapLibreMap mapLibreMap)`
  /// The returned object must be released after use, by calling the [release] method.
  cameraposition_.CameraPosition getCameraPosition(
    maplibremap_.MapLibreMap mapLibreMap,
  ) {
    return _getCameraPosition(
            reference.pointer,
            _id_getCameraPosition as jni.JMethodIDPtr,
            mapLibreMap.reference.pointer)
        .object(const cameraposition_.$CameraPositionType());
  }

  /// Maps a specific port to the implemented interface.
  static final Map<int, $CameraUpdateImpl> _$impls = {};
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
          r'getCameraPosition(Lorg/maplibre/android/maps/MapLibreMap;)Lorg/maplibre/android/camera/CameraPosition;') {
        final $r = _$impls[$p]!.getCameraPosition(
          $a[0].castTo(const maplibremap_.$MapLibreMapType(),
              releaseOriginal: true),
        );
        return ($r as jni.JObject)
            .castTo(const jni.JObjectType())
            .reference
            .toPointer();
      }
    } catch (e) {
      return ProtectedJniExtensions.newDartException(e);
    }
    return jni.nullptr;
  }

  factory CameraUpdate.implement(
    $CameraUpdateImpl $impl,
  ) {
    final $p = ReceivePort();
    final $x = CameraUpdate.fromReference(
      ProtectedJniExtensions.newPortProxy(
        r'org.maplibre.android.camera.CameraUpdate',
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

abstract interface class $CameraUpdateImpl {
  factory $CameraUpdateImpl({
    required cameraposition_.CameraPosition Function(
            maplibremap_.MapLibreMap mapLibreMap)
        getCameraPosition,
  }) = _$CameraUpdateImpl;

  cameraposition_.CameraPosition getCameraPosition(
      maplibremap_.MapLibreMap mapLibreMap);
}

class _$CameraUpdateImpl implements $CameraUpdateImpl {
  _$CameraUpdateImpl({
    required cameraposition_.CameraPosition Function(
            maplibremap_.MapLibreMap mapLibreMap)
        getCameraPosition,
  }) : _getCameraPosition = getCameraPosition;

  final cameraposition_.CameraPosition Function(
      maplibremap_.MapLibreMap mapLibreMap) _getCameraPosition;

  cameraposition_.CameraPosition getCameraPosition(
      maplibremap_.MapLibreMap mapLibreMap) {
    return _getCameraPosition(mapLibreMap);
  }
}

final class $CameraUpdateType extends jni.JObjType<CameraUpdate> {
  const $CameraUpdateType();

  @override
  String get signature => r'Lorg/maplibre/android/camera/CameraUpdate;';

  @override
  CameraUpdate fromReference(jni.JReference reference) =>
      CameraUpdate.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($CameraUpdateType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($CameraUpdateType) &&
        other is $CameraUpdateType;
  }
}
