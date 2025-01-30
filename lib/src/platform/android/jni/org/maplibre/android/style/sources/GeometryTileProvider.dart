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

import '../../geometry/LatLngBounds.dart' as latlngbounds$_;

/// from: `org.maplibre.android.style.sources.GeometryTileProvider`
class GeometryTileProvider extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<GeometryTileProvider> $type;

  @jni$_.internal
  GeometryTileProvider.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
      r'org/maplibre/android/style/sources/GeometryTileProvider');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $GeometryTileProvider$NullableType();
  static const type = $GeometryTileProvider$Type();
  static final _id_getFeaturesForBounds = _class.instanceMethodId(
    r'getFeaturesForBounds',
    r'(Lorg/maplibre/android/geometry/LatLngBounds;I)Lorg/maplibre/geojson/FeatureCollection;',
  );

  static final _getFeaturesForBounds = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_
                          .VarArgs<(jni$_.Pointer<jni$_.Void>, jni$_.Int32)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>, int)>();

  /// from: `public abstract org.maplibre.geojson.FeatureCollection getFeaturesForBounds(org.maplibre.android.geometry.LatLngBounds latLngBounds, int i)`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JObject getFeaturesForBounds(
    latlngbounds$_.LatLngBounds latLngBounds,
    int i,
  ) {
    final _$latLngBounds = latLngBounds.reference;
    return _getFeaturesForBounds(
            reference.pointer,
            _id_getFeaturesForBounds as jni$_.JMethodIDPtr,
            _$latLngBounds.pointer,
            i)
        .object<jni$_.JObject>(const jni$_.JObjectType());
  }

  /// Maps a specific port to the implemented interface.
  static final core$_.Map<int, $GeometryTileProvider> _$impls = {};
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
          r'getFeaturesForBounds(Lorg/maplibre/android/geometry/LatLngBounds;I)Lorg/maplibre/geojson/FeatureCollection;') {
        final $r = _$impls[$p]!.getFeaturesForBounds(
          $a![0]!.as(const latlngbounds$_.$LatLngBounds$Type(),
              releaseOriginal: true),
          $a![1]!
              .as(const jni$_.JIntegerType(), releaseOriginal: true)
              .intValue(releaseOriginal: true),
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
    $GeometryTileProvider $impl,
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
      r'org.maplibre.android.style.sources.GeometryTileProvider',
      $p,
      _$invokePointer,
      [],
    );
    final $a = $p.sendPort.nativePort;
    _$impls[$a] = $impl;
  }

  factory GeometryTileProvider.implement(
    $GeometryTileProvider $impl,
  ) {
    final $i = jni$_.JImplementer();
    implementIn($i, $impl);
    return GeometryTileProvider.fromReference(
      $i.implementReference(),
    );
  }
}

abstract base mixin class $GeometryTileProvider {
  factory $GeometryTileProvider({
    required jni$_.JObject Function(
            latlngbounds$_.LatLngBounds latLngBounds, int i)
        getFeaturesForBounds,
  }) = _$GeometryTileProvider;

  jni$_.JObject getFeaturesForBounds(
      latlngbounds$_.LatLngBounds latLngBounds, int i);
}

final class _$GeometryTileProvider with $GeometryTileProvider {
  _$GeometryTileProvider({
    required jni$_.JObject Function(
            latlngbounds$_.LatLngBounds latLngBounds, int i)
        getFeaturesForBounds,
  }) : _getFeaturesForBounds = getFeaturesForBounds;

  final jni$_.JObject Function(latlngbounds$_.LatLngBounds latLngBounds, int i)
      _getFeaturesForBounds;

  jni$_.JObject getFeaturesForBounds(
      latlngbounds$_.LatLngBounds latLngBounds, int i) {
    return _getFeaturesForBounds(latLngBounds, i);
  }
}

final class $GeometryTileProvider$NullableType
    extends jni$_.JObjType<GeometryTileProvider?> {
  @jni$_.internal
  const $GeometryTileProvider$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/style/sources/GeometryTileProvider;';

  @jni$_.internal
  @core$_.override
  GeometryTileProvider? fromReference(jni$_.JReference reference) =>
      reference.isNull
          ? null
          : GeometryTileProvider.fromReference(
              reference,
            );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<GeometryTileProvider?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($GeometryTileProvider$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($GeometryTileProvider$NullableType) &&
        other is $GeometryTileProvider$NullableType;
  }
}

final class $GeometryTileProvider$Type
    extends jni$_.JObjType<GeometryTileProvider> {
  @jni$_.internal
  const $GeometryTileProvider$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/style/sources/GeometryTileProvider;';

  @jni$_.internal
  @core$_.override
  GeometryTileProvider fromReference(jni$_.JReference reference) =>
      GeometryTileProvider.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<GeometryTileProvider?> get nullableType =>
      const $GeometryTileProvider$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($GeometryTileProvider$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($GeometryTileProvider$Type) &&
        other is $GeometryTileProvider$Type;
  }
}
