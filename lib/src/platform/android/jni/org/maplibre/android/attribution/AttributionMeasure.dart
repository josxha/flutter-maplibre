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

import 'AttributionLayout.dart' as attributionlayout$_;

/// from: `org.maplibre.android.attribution.AttributionMeasure$Builder`
class AttributionMeasure$Builder extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<AttributionMeasure$Builder> $type;

  @jni$_.internal
  AttributionMeasure$Builder.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
      r'org/maplibre/android/attribution/AttributionMeasure$Builder');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $AttributionMeasure$Builder$NullableType();
  static const type = $AttributionMeasure$Builder$Type();
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
  factory AttributionMeasure$Builder() {
    return AttributionMeasure$Builder.fromReference(
        _new$(_class.reference.pointer, _id_new$ as jni$_.JMethodIDPtr)
            .reference);
  }

  static final _id_setSnapshot = _class.instanceMethodId(
    r'setSnapshot',
    r'(Landroid/graphics/Bitmap;)Lorg/maplibre/android/attribution/AttributionMeasure$Builder;',
  );

  static final _setSnapshot = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public org.maplibre.android.attribution.AttributionMeasure$Builder setSnapshot(android.graphics.Bitmap bitmap)`
  /// The returned object must be released after use, by calling the [release] method.
  AttributionMeasure$Builder setSnapshot(
    jni$_.JObject? bitmap,
  ) {
    final _$bitmap = bitmap?.reference ?? jni$_.jNullReference;
    return _setSnapshot(reference.pointer,
            _id_setSnapshot as jni$_.JMethodIDPtr, _$bitmap.pointer)
        .object<AttributionMeasure$Builder>(
            const $AttributionMeasure$Builder$Type());
  }

  static final _id_setLogo = _class.instanceMethodId(
    r'setLogo',
    r'(Landroid/graphics/Bitmap;)Lorg/maplibre/android/attribution/AttributionMeasure$Builder;',
  );

  static final _setLogo = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public org.maplibre.android.attribution.AttributionMeasure$Builder setLogo(android.graphics.Bitmap bitmap)`
  /// The returned object must be released after use, by calling the [release] method.
  AttributionMeasure$Builder setLogo(
    jni$_.JObject? bitmap,
  ) {
    final _$bitmap = bitmap?.reference ?? jni$_.jNullReference;
    return _setLogo(reference.pointer, _id_setLogo as jni$_.JMethodIDPtr,
            _$bitmap.pointer)
        .object<AttributionMeasure$Builder>(
            const $AttributionMeasure$Builder$Type());
  }

  static final _id_setLogoSmall = _class.instanceMethodId(
    r'setLogoSmall',
    r'(Landroid/graphics/Bitmap;)Lorg/maplibre/android/attribution/AttributionMeasure$Builder;',
  );

  static final _setLogoSmall = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public org.maplibre.android.attribution.AttributionMeasure$Builder setLogoSmall(android.graphics.Bitmap bitmap)`
  /// The returned object must be released after use, by calling the [release] method.
  AttributionMeasure$Builder setLogoSmall(
    jni$_.JObject? bitmap,
  ) {
    final _$bitmap = bitmap?.reference ?? jni$_.jNullReference;
    return _setLogoSmall(reference.pointer,
            _id_setLogoSmall as jni$_.JMethodIDPtr, _$bitmap.pointer)
        .object<AttributionMeasure$Builder>(
            const $AttributionMeasure$Builder$Type());
  }

  static final _id_setTextView = _class.instanceMethodId(
    r'setTextView',
    r'(Landroid/widget/TextView;)Lorg/maplibre/android/attribution/AttributionMeasure$Builder;',
  );

  static final _setTextView = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public org.maplibre.android.attribution.AttributionMeasure$Builder setTextView(android.widget.TextView textView)`
  /// The returned object must be released after use, by calling the [release] method.
  AttributionMeasure$Builder setTextView(
    jni$_.JObject? textView,
  ) {
    final _$textView = textView?.reference ?? jni$_.jNullReference;
    return _setTextView(reference.pointer,
            _id_setTextView as jni$_.JMethodIDPtr, _$textView.pointer)
        .object<AttributionMeasure$Builder>(
            const $AttributionMeasure$Builder$Type());
  }

  static final _id_setTextViewShort = _class.instanceMethodId(
    r'setTextViewShort',
    r'(Landroid/widget/TextView;)Lorg/maplibre/android/attribution/AttributionMeasure$Builder;',
  );

  static final _setTextViewShort = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public org.maplibre.android.attribution.AttributionMeasure$Builder setTextViewShort(android.widget.TextView textView)`
  /// The returned object must be released after use, by calling the [release] method.
  AttributionMeasure$Builder setTextViewShort(
    jni$_.JObject? textView,
  ) {
    final _$textView = textView?.reference ?? jni$_.jNullReference;
    return _setTextViewShort(reference.pointer,
            _id_setTextViewShort as jni$_.JMethodIDPtr, _$textView.pointer)
        .object<AttributionMeasure$Builder>(
            const $AttributionMeasure$Builder$Type());
  }

  static final _id_setMarginPadding = _class.instanceMethodId(
    r'setMarginPadding',
    r'(F)Lorg/maplibre/android/attribution/AttributionMeasure$Builder;',
  );

  static final _setMarginPadding = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_
                      .VarArgs<(jni$_.Double,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, double)>();

  /// from: `public org.maplibre.android.attribution.AttributionMeasure$Builder setMarginPadding(float f)`
  /// The returned object must be released after use, by calling the [release] method.
  AttributionMeasure$Builder setMarginPadding(
    double f,
  ) {
    return _setMarginPadding(
            reference.pointer, _id_setMarginPadding as jni$_.JMethodIDPtr, f)
        .object<AttributionMeasure$Builder>(
            const $AttributionMeasure$Builder$Type());
  }

  static final _id_build = _class.instanceMethodId(
    r'build',
    r'()Lorg/maplibre/android/attribution/AttributionMeasure;',
  );

  static final _build = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public org.maplibre.android.attribution.AttributionMeasure build()`
  /// The returned object must be released after use, by calling the [release] method.
  AttributionMeasure build() {
    return _build(reference.pointer, _id_build as jni$_.JMethodIDPtr)
        .object<AttributionMeasure>(const $AttributionMeasure$Type());
  }
}

final class $AttributionMeasure$Builder$NullableType
    extends jni$_.JObjType<AttributionMeasure$Builder?> {
  @jni$_.internal
  const $AttributionMeasure$Builder$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/attribution/AttributionMeasure$Builder;';

  @jni$_.internal
  @core$_.override
  AttributionMeasure$Builder? fromReference(jni$_.JReference reference) =>
      reference.isNull
          ? null
          : AttributionMeasure$Builder.fromReference(
              reference,
            );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<AttributionMeasure$Builder?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($AttributionMeasure$Builder$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($AttributionMeasure$Builder$NullableType) &&
        other is $AttributionMeasure$Builder$NullableType;
  }
}

final class $AttributionMeasure$Builder$Type
    extends jni$_.JObjType<AttributionMeasure$Builder> {
  @jni$_.internal
  const $AttributionMeasure$Builder$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/attribution/AttributionMeasure$Builder;';

  @jni$_.internal
  @core$_.override
  AttributionMeasure$Builder fromReference(jni$_.JReference reference) =>
      AttributionMeasure$Builder.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<AttributionMeasure$Builder?> get nullableType =>
      const $AttributionMeasure$Builder$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($AttributionMeasure$Builder$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($AttributionMeasure$Builder$Type) &&
        other is $AttributionMeasure$Builder$Type;
  }
}

/// from: `org.maplibre.android.attribution.AttributionMeasure$Command`
class AttributionMeasure$Command extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<AttributionMeasure$Command> $type;

  @jni$_.internal
  AttributionMeasure$Command.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
      r'org/maplibre/android/attribution/AttributionMeasure$Command');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $AttributionMeasure$Command$NullableType();
  static const type = $AttributionMeasure$Command$Type();
  static final _id_execute = _class.instanceMethodId(
    r'execute',
    r'(Lorg/maplibre/android/attribution/AttributionMeasure;)Lorg/maplibre/android/attribution/AttributionLayout;',
  );

  static final _execute = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public abstract org.maplibre.android.attribution.AttributionLayout execute(org.maplibre.android.attribution.AttributionMeasure attributionMeasure)`
  /// The returned object must be released after use, by calling the [release] method.
  attributionlayout$_.AttributionLayout? execute(
    AttributionMeasure? attributionMeasure,
  ) {
    final _$attributionMeasure =
        attributionMeasure?.reference ?? jni$_.jNullReference;
    return _execute(reference.pointer, _id_execute as jni$_.JMethodIDPtr,
            _$attributionMeasure.pointer)
        .object<attributionlayout$_.AttributionLayout?>(
            const attributionlayout$_.$AttributionLayout$NullableType());
  }

  /// Maps a specific port to the implemented interface.
  static final core$_.Map<int, $AttributionMeasure$Command> _$impls = {};
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
          r'execute(Lorg/maplibre/android/attribution/AttributionMeasure;)Lorg/maplibre/android/attribution/AttributionLayout;') {
        final $r = _$impls[$p]!.execute(
          $a![0]?.as(const $AttributionMeasure$Type(), releaseOriginal: true),
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
    $AttributionMeasure$Command $impl,
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
      r'org.maplibre.android.attribution.AttributionMeasure$Command',
      $p,
      _$invokePointer,
      [],
    );
    final $a = $p.sendPort.nativePort;
    _$impls[$a] = $impl;
  }

  factory AttributionMeasure$Command.implement(
    $AttributionMeasure$Command $impl,
  ) {
    final $i = jni$_.JImplementer();
    implementIn($i, $impl);
    return AttributionMeasure$Command.fromReference(
      $i.implementReference(),
    );
  }
}

abstract base mixin class $AttributionMeasure$Command {
  factory $AttributionMeasure$Command({
    required attributionlayout$_.AttributionLayout? Function(
            AttributionMeasure? attributionMeasure)
        execute,
  }) = _$AttributionMeasure$Command;

  attributionlayout$_.AttributionLayout? execute(
      AttributionMeasure? attributionMeasure);
}

final class _$AttributionMeasure$Command with $AttributionMeasure$Command {
  _$AttributionMeasure$Command({
    required attributionlayout$_.AttributionLayout? Function(
            AttributionMeasure? attributionMeasure)
        execute,
  }) : _execute = execute;

  final attributionlayout$_.AttributionLayout? Function(
      AttributionMeasure? attributionMeasure) _execute;

  attributionlayout$_.AttributionLayout? execute(
      AttributionMeasure? attributionMeasure) {
    return _execute(attributionMeasure);
  }
}

final class $AttributionMeasure$Command$NullableType
    extends jni$_.JObjType<AttributionMeasure$Command?> {
  @jni$_.internal
  const $AttributionMeasure$Command$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/attribution/AttributionMeasure$Command;';

  @jni$_.internal
  @core$_.override
  AttributionMeasure$Command? fromReference(jni$_.JReference reference) =>
      reference.isNull
          ? null
          : AttributionMeasure$Command.fromReference(
              reference,
            );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<AttributionMeasure$Command?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($AttributionMeasure$Command$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($AttributionMeasure$Command$NullableType) &&
        other is $AttributionMeasure$Command$NullableType;
  }
}

final class $AttributionMeasure$Command$Type
    extends jni$_.JObjType<AttributionMeasure$Command> {
  @jni$_.internal
  const $AttributionMeasure$Command$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/attribution/AttributionMeasure$Command;';

  @jni$_.internal
  @core$_.override
  AttributionMeasure$Command fromReference(jni$_.JReference reference) =>
      AttributionMeasure$Command.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<AttributionMeasure$Command?> get nullableType =>
      const $AttributionMeasure$Command$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($AttributionMeasure$Command$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($AttributionMeasure$Command$Type) &&
        other is $AttributionMeasure$Command$Type;
  }
}

/// from: `org.maplibre.android.attribution.AttributionMeasure`
class AttributionMeasure extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<AttributionMeasure> $type;

  @jni$_.internal
  AttributionMeasure.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
      r'org/maplibre/android/attribution/AttributionMeasure');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $AttributionMeasure$NullableType();
  static const type = $AttributionMeasure$Type();
  static final _id_measure = _class.instanceMethodId(
    r'measure',
    r'()Lorg/maplibre/android/attribution/AttributionLayout;',
  );

  static final _measure = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public org.maplibre.android.attribution.AttributionLayout measure()`
  /// The returned object must be released after use, by calling the [release] method.
  attributionlayout$_.AttributionLayout? measure() {
    return _measure(reference.pointer, _id_measure as jni$_.JMethodIDPtr)
        .object<attributionlayout$_.AttributionLayout?>(
            const attributionlayout$_.$AttributionLayout$NullableType());
  }

  static final _id_getTextView = _class.instanceMethodId(
    r'getTextView',
    r'()Landroid/widget/TextView;',
  );

  static final _getTextView = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public android.widget.TextView getTextView()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JObject? getTextView() {
    return _getTextView(
            reference.pointer, _id_getTextView as jni$_.JMethodIDPtr)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }
}

final class $AttributionMeasure$NullableType
    extends jni$_.JObjType<AttributionMeasure?> {
  @jni$_.internal
  const $AttributionMeasure$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/attribution/AttributionMeasure;';

  @jni$_.internal
  @core$_.override
  AttributionMeasure? fromReference(jni$_.JReference reference) =>
      reference.isNull
          ? null
          : AttributionMeasure.fromReference(
              reference,
            );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<AttributionMeasure?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($AttributionMeasure$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($AttributionMeasure$NullableType) &&
        other is $AttributionMeasure$NullableType;
  }
}

final class $AttributionMeasure$Type
    extends jni$_.JObjType<AttributionMeasure> {
  @jni$_.internal
  const $AttributionMeasure$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/attribution/AttributionMeasure;';

  @jni$_.internal
  @core$_.override
  AttributionMeasure fromReference(jni$_.JReference reference) =>
      AttributionMeasure.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<AttributionMeasure?> get nullableType =>
      const $AttributionMeasure$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($AttributionMeasure$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($AttributionMeasure$Type) &&
        other is $AttributionMeasure$Type;
  }
}
