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

/// from: `org.maplibre.android.style.types.FormattedSection`
class FormattedSection extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<FormattedSection> $type;

  @_$jni.internal
  FormattedSection.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = _$jni.JClass.forName(
      r'org/maplibre/android/style/types/FormattedSection');

  /// The type which includes information such as the signature of this class.
  static const type = $FormattedSection$Type();
  static final _id_new$ = _class.constructorId(
    r'(Ljava/lang/String;)V',
  );

  static final _new$ = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void <init>(java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  factory FormattedSection(
    _$jni.JString string,
  ) {
    return FormattedSection.fromReference(_new$(_class.reference.pointer,
            _id_new$ as _$jni.JMethodIDPtr, string.reference.pointer)
        .reference);
  }

  static final _id_new$1 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/Number;[Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _new$1 = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void <init>(java.lang.String string, java.lang.Number number, java.lang.String[] strings, java.lang.String string1)`
  /// The returned object must be released after use, by calling the [release] method.
  factory FormattedSection.new$1(
    _$jni.JString string,
    _$jni.JNumber number,
    _$jni.JArray<_$jni.JString> strings,
    _$jni.JString string1,
  ) {
    return FormattedSection.fromReference(_new$1(
            _class.reference.pointer,
            _id_new$1 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            number.reference.pointer,
            strings.reference.pointer,
            string1.reference.pointer)
        .reference);
  }

  static final _id_new$2 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/Number;[Ljava/lang/String;)V',
  );

  static final _new$2 = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void <init>(java.lang.String string, java.lang.Number number, java.lang.String[] strings)`
  /// The returned object must be released after use, by calling the [release] method.
  factory FormattedSection.new$2(
    _$jni.JString string,
    _$jni.JNumber number,
    _$jni.JArray<_$jni.JString> strings,
  ) {
    return FormattedSection.fromReference(_new$2(
            _class.reference.pointer,
            _id_new$2 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            number.reference.pointer,
            strings.reference.pointer)
        .reference);
  }

  static final _id_new$3 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/Number;)V',
  );

  static final _new$3 = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void <init>(java.lang.String string, java.lang.Number number)`
  /// The returned object must be released after use, by calling the [release] method.
  factory FormattedSection.new$3(
    _$jni.JString string,
    _$jni.JNumber number,
  ) {
    return FormattedSection.fromReference(_new$3(
            _class.reference.pointer,
            _id_new$3 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            number.reference.pointer)
        .reference);
  }

  static final _id_new$4 = _class.constructorId(
    r'(Ljava/lang/String;[Ljava/lang/String;)V',
  );

  static final _new$4 = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void <init>(java.lang.String string, java.lang.String[] strings)`
  /// The returned object must be released after use, by calling the [release] method.
  factory FormattedSection.new$4(
    _$jni.JString string,
    _$jni.JArray<_$jni.JString> strings,
  ) {
    return FormattedSection.fromReference(_new$4(
            _class.reference.pointer,
            _id_new$4 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            strings.reference.pointer)
        .reference);
  }

  static final _id_getText = _class.instanceMethodId(
    r'getText',
    r'()Ljava/lang/String;',
  );

  static final _getText = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getText()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JString getText() {
    return _getText(reference.pointer, _id_getText as _$jni.JMethodIDPtr)
        .object(const _$jni.JStringType());
  }

  static final _id_getFontScale = _class.instanceMethodId(
    r'getFontScale',
    r'()Ljava/lang/Number;',
  );

  static final _getFontScale = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.Number getFontScale()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JNumber getFontScale() {
    return _getFontScale(
            reference.pointer, _id_getFontScale as _$jni.JMethodIDPtr)
        .object(const _$jni.JNumberType());
  }

  static final _id_getFontStack = _class.instanceMethodId(
    r'getFontStack',
    r'()[Ljava/lang/String;',
  );

  static final _getFontStack = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String[] getFontStack()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JArray<_$jni.JString> getFontStack() {
    return _getFontStack(
            reference.pointer, _id_getFontStack as _$jni.JMethodIDPtr)
        .object(const _$jni.JArrayType(_$jni.JStringType()));
  }

  static final _id_getTextColor = _class.instanceMethodId(
    r'getTextColor',
    r'()Ljava/lang/String;',
  );

  static final _getTextColor = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String getTextColor()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JString getTextColor() {
    return _getTextColor(
            reference.pointer, _id_getTextColor as _$jni.JMethodIDPtr)
        .object(const _$jni.JStringType());
  }

  static final _id_setFontScale = _class.instanceMethodId(
    r'setFontScale',
    r'(Ljava/lang/Number;)V',
  );

  static final _setFontScale = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void setFontScale(java.lang.Number number)`
  void setFontScale(
    _$jni.JNumber number,
  ) {
    _setFontScale(reference.pointer, _id_setFontScale as _$jni.JMethodIDPtr,
            number.reference.pointer)
        .check();
  }

  static final _id_setFontStack = _class.instanceMethodId(
    r'setFontStack',
    r'([Ljava/lang/String;)V',
  );

  static final _setFontStack = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void setFontStack(java.lang.String[] strings)`
  void setFontStack(
    _$jni.JArray<_$jni.JString> strings,
  ) {
    _setFontStack(reference.pointer, _id_setFontStack as _$jni.JMethodIDPtr,
            strings.reference.pointer)
        .check();
  }

  static final _id_setTextColor = _class.instanceMethodId(
    r'setTextColor',
    r'(Ljava/lang/String;)V',
  );

  static final _setTextColor = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void setTextColor(java.lang.String string)`
  void setTextColor(
    _$jni.JString string,
  ) {
    _setTextColor(reference.pointer, _id_setTextColor as _$jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_setTextColor$1 = _class.instanceMethodId(
    r'setTextColor',
    r'(I)V',
  );

  static final _setTextColor$1 = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JThrowablePtr Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<(_$jni.Int32,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(
              _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, int)>();

  /// from: `public void setTextColor(int i)`
  void setTextColor$1(
    int i,
  ) {
    _setTextColor$1(
            reference.pointer, _id_setTextColor$1 as _$jni.JMethodIDPtr, i)
        .check();
  }

  static final _id_equals = _class.instanceMethodId(
    r'equals',
    r'(Ljava/lang/Object;)Z',
  );

  static final _equals = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallBooleanMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public boolean equals(java.lang.Object object)`
  bool equals(
    _$jni.JObject object,
  ) {
    return _equals(reference.pointer, _id_equals as _$jni.JMethodIDPtr,
            object.reference.pointer)
        .boolean;
  }

  static final _id_hashCode$1 = _class.instanceMethodId(
    r'hashCode',
    r'()I',
  );

  static final _hashCode$1 = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallIntMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public int hashCode()`
  int hashCode$1() {
    return _hashCode$1(reference.pointer, _id_hashCode$1 as _$jni.JMethodIDPtr)
        .integer;
  }

  static final _id_toString$1 = _class.instanceMethodId(
    r'toString',
    r'()Ljava/lang/String;',
  );

  static final _toString$1 = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String toString()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JString toString$1() {
    return _toString$1(reference.pointer, _id_toString$1 as _$jni.JMethodIDPtr)
        .object(const _$jni.JStringType());
  }
}

final class $FormattedSection$Type extends _$jni.JObjType<FormattedSection> {
  @_$jni.internal
  const $FormattedSection$Type();

  @_$jni.internal
  @_$core.override
  String get signature =>
      r'Lorg/maplibre/android/style/types/FormattedSection;';

  @_$jni.internal
  @_$core.override
  FormattedSection fromReference(_$jni.JReference reference) =>
      FormattedSection.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode => ($FormattedSection$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($FormattedSection$Type) &&
        other is $FormattedSection$Type;
  }
}
