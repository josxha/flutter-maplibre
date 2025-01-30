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

import '../maps/MapLibreMap.dart' as maplibremap$_;

import 'CameraPosition.dart' as cameraposition$_;

/// from: `org.maplibre.android.camera.CameraUpdate`
class CameraUpdate extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<CameraUpdate> $type;

  @jni$_.internal
  CameraUpdate.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/camera/CameraUpdate');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $CameraUpdate$NullableType();
  static const type = $CameraUpdate$Type();
  static final _id_getCameraPosition = _class.instanceMethodId(
    r'getCameraPosition',
    r'(Lorg/maplibre/android/maps/MapLibreMap;)Lorg/maplibre/android/camera/CameraPosition;',
  );

  static final _getCameraPosition = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public abstract org.maplibre.android.camera.CameraPosition getCameraPosition(org.maplibre.android.maps.MapLibreMap mapLibreMap)`
  /// The returned object must be released after use, by calling the [release] method.
  cameraposition$_.CameraPosition? getCameraPosition(
    maplibremap$_.MapLibreMap mapLibreMap,
  ) {
    final _$mapLibreMap = mapLibreMap.reference;
    return _getCameraPosition(reference.pointer,
            _id_getCameraPosition as jni$_.JMethodIDPtr, _$mapLibreMap.pointer)
        .object<cameraposition$_.CameraPosition?>(
            const cameraposition$_.$CameraPosition$NullableType());
  }

  /// Maps a specific port to the implemented interface.
  static final core$_.Map<int, $CameraUpdate> _$impls = {};
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
      if ($d ==
          r'getCameraPosition(Lorg/maplibre/android/maps/MapLibreMap;)Lorg/maplibre/android/camera/CameraPosition;') {
        final $r = _$impls[$p]!.getCameraPosition(
          $a![0]!.as(const maplibremap$_.$MapLibreMap$Type(),
              releaseOriginal: true),
        );
        return ($r as jni$_.JObject?)
                ?.as(const jni$_.JObjectType())
                .reference
                .toPointer() ??
            jni$_.nullptr;
      }
    } catch (e) {
      return jni$_.ProtectedJniExtensions.newDartException(e);
    }
    return jni$_.nullptr;
  }

  static void implementIn(
    jni$_.JImplementer implementer,
    $CameraUpdate $impl,
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
      r'org.maplibre.android.camera.CameraUpdate',
      $p,
      _$invokePointer,
      [],
    );
    final $a = $p.sendPort.nativePort;
    _$impls[$a] = $impl;
  }

  factory CameraUpdate.implement(
    $CameraUpdate $impl,
  ) {
    final $i = jni$_.JImplementer();
    implementIn($i, $impl);
    return CameraUpdate.fromReference(
      $i.implementReference(),
    );
  }
}

abstract base mixin class $CameraUpdate {
  factory $CameraUpdate({
    required cameraposition$_.CameraPosition? Function(
            maplibremap$_.MapLibreMap mapLibreMap)
        getCameraPosition,
  }) = _$CameraUpdate;

  cameraposition$_.CameraPosition? getCameraPosition(
      maplibremap$_.MapLibreMap mapLibreMap);
}

final class _$CameraUpdate with $CameraUpdate {
  _$CameraUpdate({
    required cameraposition$_.CameraPosition? Function(
            maplibremap$_.MapLibreMap mapLibreMap)
        getCameraPosition,
  }) : _getCameraPosition = getCameraPosition;

  final cameraposition$_.CameraPosition? Function(
      maplibremap$_.MapLibreMap mapLibreMap) _getCameraPosition;

  cameraposition$_.CameraPosition? getCameraPosition(
      maplibremap$_.MapLibreMap mapLibreMap) {
    return _getCameraPosition(mapLibreMap);
  }
}

final class $CameraUpdate$NullableType extends jni$_.JObjType<CameraUpdate?> {
  @jni$_.internal
  const $CameraUpdate$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/camera/CameraUpdate;';

  @jni$_.internal
  @core$_.override
  CameraUpdate? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : CameraUpdate.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<CameraUpdate?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($CameraUpdate$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($CameraUpdate$NullableType) &&
        other is $CameraUpdate$NullableType;
  }
}

final class $CameraUpdate$Type extends jni$_.JObjType<CameraUpdate> {
  @jni$_.internal
  const $CameraUpdate$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/camera/CameraUpdate;';

  @jni$_.internal
  @core$_.override
  CameraUpdate fromReference(jni$_.JReference reference) =>
      CameraUpdate.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<CameraUpdate?> get nullableType =>
      const $CameraUpdate$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($CameraUpdate$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($CameraUpdate$Type) &&
        other is $CameraUpdate$Type;
  }
}
