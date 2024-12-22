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

/// from: `org.maplibre.android.storage.Resource$Kind`
class Resource$Kind extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<Resource$Kind> $type;

  @jni$_.internal
  Resource$Kind.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/storage/Resource$Kind');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $Resource$Kind$NullableType();
  static const type = $Resource$Kind$Type();

  /// Maps a specific port to the implemented interface.
  static final core$_.Map<int, $Resource$Kind> _$impls = {};
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
    $Resource$Kind $impl,
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
      r'org.maplibre.android.storage.Resource$Kind',
      $p,
      _$invokePointer,
      [],
    );
    final $a = $p.sendPort.nativePort;
    _$impls[$a] = $impl;
  }

  factory Resource$Kind.implement(
    $Resource$Kind $impl,
  ) {
    final $i = jni$_.JImplementer();
    implementIn($i, $impl);
    return Resource$Kind.fromReference(
      $i.implementReference(),
    );
  }
}

abstract base mixin class $Resource$Kind {
  factory $Resource$Kind() = _$Resource$Kind;
}

final class _$Resource$Kind with $Resource$Kind {
  _$Resource$Kind();
}

final class $Resource$Kind$NullableType extends jni$_.JObjType<Resource$Kind?> {
  @jni$_.internal
  const $Resource$Kind$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/storage/Resource$Kind;';

  @jni$_.internal
  @core$_.override
  Resource$Kind? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : Resource$Kind.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Resource$Kind?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Resource$Kind$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Resource$Kind$NullableType) &&
        other is $Resource$Kind$NullableType;
  }
}

final class $Resource$Kind$Type extends jni$_.JObjType<Resource$Kind> {
  @jni$_.internal
  const $Resource$Kind$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/storage/Resource$Kind;';

  @jni$_.internal
  @core$_.override
  Resource$Kind fromReference(jni$_.JReference reference) =>
      Resource$Kind.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Resource$Kind?> get nullableType =>
      const $Resource$Kind$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Resource$Kind$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Resource$Kind$Type) &&
        other is $Resource$Kind$Type;
  }
}

/// from: `org.maplibre.android.storage.Resource`
class Resource extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<Resource> $type;

  @jni$_.internal
  Resource.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/storage/Resource');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $Resource$NullableType();
  static const type = $Resource$Type();

  /// from: `static public final int UNKNOWN`
  static const UNKNOWN = 0;

  /// from: `static public final int STYLE`
  static const STYLE = 1;

  /// from: `static public final int SOURCE`
  static const SOURCE = 2;

  /// from: `static public final int TILE`
  static const TILE = 3;

  /// from: `static public final int GLYPHS`
  static const GLYPHS = 4;

  /// from: `static public final int SPRITE_IMAGE`
  static const SPRITE_IMAGE = 5;

  /// from: `static public final int SPRITE_JSON`
  static const SPRITE_JSON = 6;
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
  factory Resource() {
    return Resource.fromReference(
        _new$(_class.reference.pointer, _id_new$ as jni$_.JMethodIDPtr)
            .reference);
  }
}

final class $Resource$NullableType extends jni$_.JObjType<Resource?> {
  @jni$_.internal
  const $Resource$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/storage/Resource;';

  @jni$_.internal
  @core$_.override
  Resource? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : Resource.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Resource?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Resource$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Resource$NullableType) &&
        other is $Resource$NullableType;
  }
}

final class $Resource$Type extends jni$_.JObjType<Resource> {
  @jni$_.internal
  const $Resource$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/storage/Resource;';

  @jni$_.internal
  @core$_.override
  Resource fromReference(jni$_.JReference reference) => Resource.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Resource?> get nullableType => const $Resource$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Resource$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Resource$Type) && other is $Resource$Type;
  }
}
