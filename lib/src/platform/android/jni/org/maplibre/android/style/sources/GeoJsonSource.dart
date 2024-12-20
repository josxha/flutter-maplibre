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

import '../../../../../java/net/URI.dart' as uri_;

import '../../../../../java/net/URL.dart' as url_;

import '../../../geojson/Feature.dart' as feature_;

import 'GeoJsonOptions.dart' as geojsonoptions_;

import 'Source.dart' as source_;

/// from: `org.maplibre.android.style.sources.GeoJsonSource`
class GeoJsonSource extends source_.Source {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<GeoJsonSource> $type;

  @_$jni.internal
  GeoJsonSource.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      _$jni.JClass.forName(r'org/maplibre/android/style/sources/GeoJsonSource');

  /// The type which includes information such as the signature of this class.
  static const type = $GeoJsonSource$Type();
  static final _id_new$ = _class.constructorId(
    r'(J)V',
  );

  static final _new$ = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<(_$jni.Int64,)>)>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, int)>();

  /// from: `public void <init>(long j)`
  /// The returned object must be released after use, by calling the [release] method.
  factory GeoJsonSource(
    int j,
  ) {
    return GeoJsonSource.fromReference(
        _new$(_class.reference.pointer, _id_new$ as _$jni.JMethodIDPtr, j)
            .reference);
  }

  static final _id_new$1 = _class.constructorId(
    r'(Ljava/lang/String;)V',
  );

  static final _new$1 = _$jni.ProtectedJniExtensions.lookup<
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
  factory GeoJsonSource.new$1(
    _$jni.JString string,
  ) {
    return GeoJsonSource.fromReference(_new$1(_class.reference.pointer,
            _id_new$1 as _$jni.JMethodIDPtr, string.reference.pointer)
        .reference);
  }

  static final _id_new$2 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/android/style/sources/GeoJsonOptions;)V',
  );

  static final _new$2 = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public void <init>(java.lang.String string, org.maplibre.android.style.sources.GeoJsonOptions geoJsonOptions)`
  /// The returned object must be released after use, by calling the [release] method.
  factory GeoJsonSource.new$2(
    _$jni.JString string,
    geojsonoptions_.GeoJsonOptions geoJsonOptions,
  ) {
    return GeoJsonSource.fromReference(_new$2(
            _class.reference.pointer,
            _id_new$2 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            geoJsonOptions.reference.pointer)
        .reference);
  }

  static final _id_new$3 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/String;)V',
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

  /// from: `public void <init>(java.lang.String string, java.lang.String string1)`
  /// The returned object must be released after use, by calling the [release] method.
  factory GeoJsonSource.new$3(
    _$jni.JString string,
    _$jni.JString string1,
  ) {
    return GeoJsonSource.fromReference(_new$3(
            _class.reference.pointer,
            _id_new$3 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            string1.reference.pointer)
        .reference);
  }

  static final _id_new$4 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/String;Lorg/maplibre/android/style/sources/GeoJsonOptions;)V',
  );

  static final _new$4 = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public void <init>(java.lang.String string, java.lang.String string1, org.maplibre.android.style.sources.GeoJsonOptions geoJsonOptions)`
  /// The returned object must be released after use, by calling the [release] method.
  factory GeoJsonSource.new$4(
    _$jni.JString string,
    _$jni.JString string1,
    geojsonoptions_.GeoJsonOptions geoJsonOptions,
  ) {
    return GeoJsonSource.fromReference(_new$4(
            _class.reference.pointer,
            _id_new$4 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            string1.reference.pointer,
            geoJsonOptions.reference.pointer)
        .reference);
  }

  static final _id_new$5 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/net/URL;)V',
  );

  static final _new$5 = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public void <init>(java.lang.String string, java.net.URL uRL)`
  /// The returned object must be released after use, by calling the [release] method.
  factory GeoJsonSource.new$5(
    _$jni.JString string,
    url_.URL uRL,
  ) {
    return GeoJsonSource.fromReference(_new$5(
            _class.reference.pointer,
            _id_new$5 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            uRL.reference.pointer)
        .reference);
  }

  static final _id_new$6 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/net/URL;Lorg/maplibre/android/style/sources/GeoJsonOptions;)V',
  );

  static final _new$6 = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public void <init>(java.lang.String string, java.net.URL uRL, org.maplibre.android.style.sources.GeoJsonOptions geoJsonOptions)`
  /// The returned object must be released after use, by calling the [release] method.
  factory GeoJsonSource.new$6(
    _$jni.JString string,
    url_.URL uRL,
    geojsonoptions_.GeoJsonOptions geoJsonOptions,
  ) {
    return GeoJsonSource.fromReference(_new$6(
            _class.reference.pointer,
            _id_new$6 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            uRL.reference.pointer,
            geoJsonOptions.reference.pointer)
        .reference);
  }

  static final _id_new$7 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/net/URI;)V',
  );

  static final _new$7 = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public void <init>(java.lang.String string, java.net.URI uRI)`
  /// The returned object must be released after use, by calling the [release] method.
  factory GeoJsonSource.new$7(
    _$jni.JString string,
    uri_.URI uRI,
  ) {
    return GeoJsonSource.fromReference(_new$7(
            _class.reference.pointer,
            _id_new$7 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            uRI.reference.pointer)
        .reference);
  }

  static final _id_new$8 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/net/URI;Lorg/maplibre/android/style/sources/GeoJsonOptions;)V',
  );

  static final _new$8 = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public void <init>(java.lang.String string, java.net.URI uRI, org.maplibre.android.style.sources.GeoJsonOptions geoJsonOptions)`
  /// The returned object must be released after use, by calling the [release] method.
  factory GeoJsonSource.new$8(
    _$jni.JString string,
    uri_.URI uRI,
    geojsonoptions_.GeoJsonOptions geoJsonOptions,
  ) {
    return GeoJsonSource.fromReference(_new$8(
            _class.reference.pointer,
            _id_new$8 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            uRI.reference.pointer,
            geoJsonOptions.reference.pointer)
        .reference);
  }

  static final _id_new$9 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/geojson/FeatureCollection;)V',
  );

  static final _new$9 = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public void <init>(java.lang.String string, org.maplibre.geojson.FeatureCollection featureCollection)`
  /// The returned object must be released after use, by calling the [release] method.
  factory GeoJsonSource.new$9(
    _$jni.JString string,
    _$jni.JObject featureCollection,
  ) {
    return GeoJsonSource.fromReference(_new$9(
            _class.reference.pointer,
            _id_new$9 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            featureCollection.reference.pointer)
        .reference);
  }

  static final _id_new$10 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/geojson/FeatureCollection;Lorg/maplibre/android/style/sources/GeoJsonOptions;)V',
  );

  static final _new$10 = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public void <init>(java.lang.String string, org.maplibre.geojson.FeatureCollection featureCollection, org.maplibre.android.style.sources.GeoJsonOptions geoJsonOptions)`
  /// The returned object must be released after use, by calling the [release] method.
  factory GeoJsonSource.new$10(
    _$jni.JString string,
    _$jni.JObject featureCollection,
    geojsonoptions_.GeoJsonOptions geoJsonOptions,
  ) {
    return GeoJsonSource.fromReference(_new$10(
            _class.reference.pointer,
            _id_new$10 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            featureCollection.reference.pointer,
            geoJsonOptions.reference.pointer)
        .reference);
  }

  static final _id_new$11 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/geojson/Feature;)V',
  );

  static final _new$11 = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public void <init>(java.lang.String string, org.maplibre.geojson.Feature feature)`
  /// The returned object must be released after use, by calling the [release] method.
  factory GeoJsonSource.new$11(
    _$jni.JString string,
    feature_.Feature feature,
  ) {
    return GeoJsonSource.fromReference(_new$11(
            _class.reference.pointer,
            _id_new$11 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            feature.reference.pointer)
        .reference);
  }

  static final _id_new$12 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/geojson/Feature;Lorg/maplibre/android/style/sources/GeoJsonOptions;)V',
  );

  static final _new$12 = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public void <init>(java.lang.String string, org.maplibre.geojson.Feature feature, org.maplibre.android.style.sources.GeoJsonOptions geoJsonOptions)`
  /// The returned object must be released after use, by calling the [release] method.
  factory GeoJsonSource.new$12(
    _$jni.JString string,
    feature_.Feature feature,
    geojsonoptions_.GeoJsonOptions geoJsonOptions,
  ) {
    return GeoJsonSource.fromReference(_new$12(
            _class.reference.pointer,
            _id_new$12 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            feature.reference.pointer,
            geoJsonOptions.reference.pointer)
        .reference);
  }

  static final _id_new$13 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/geojson/Geometry;)V',
  );

  static final _new$13 = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public void <init>(java.lang.String string, org.maplibre.geojson.Geometry geometry)`
  /// The returned object must be released after use, by calling the [release] method.
  factory GeoJsonSource.new$13(
    _$jni.JString string,
    _$jni.JObject geometry,
  ) {
    return GeoJsonSource.fromReference(_new$13(
            _class.reference.pointer,
            _id_new$13 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            geometry.reference.pointer)
        .reference);
  }

  static final _id_new$14 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/geojson/Geometry;Lorg/maplibre/android/style/sources/GeoJsonOptions;)V',
  );

  static final _new$14 = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public void <init>(java.lang.String string, org.maplibre.geojson.Geometry geometry, org.maplibre.android.style.sources.GeoJsonOptions geoJsonOptions)`
  /// The returned object must be released after use, by calling the [release] method.
  factory GeoJsonSource.new$14(
    _$jni.JString string,
    _$jni.JObject geometry,
    geojsonoptions_.GeoJsonOptions geoJsonOptions,
  ) {
    return GeoJsonSource.fromReference(_new$14(
            _class.reference.pointer,
            _id_new$14 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            geometry.reference.pointer,
            geoJsonOptions.reference.pointer)
        .reference);
  }

  static final _id_setGeoJson = _class.instanceMethodId(
    r'setGeoJson',
    r'(Lorg/maplibre/geojson/Feature;)V',
  );

  static final _setGeoJson = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final void setGeoJson(org.maplibre.geojson.Feature feature)`
  void setGeoJson(
    feature_.Feature feature,
  ) {
    _setGeoJson(reference.pointer, _id_setGeoJson as _$jni.JMethodIDPtr,
            feature.reference.pointer)
        .check();
  }

  static final _id_setGeoJson$1 = _class.instanceMethodId(
    r'setGeoJson',
    r'(Lorg/maplibre/geojson/Geometry;)V',
  );

  static final _setGeoJson$1 = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final void setGeoJson(org.maplibre.geojson.Geometry geometry)`
  void setGeoJson$1(
    _$jni.JObject geometry,
  ) {
    _setGeoJson$1(reference.pointer, _id_setGeoJson$1 as _$jni.JMethodIDPtr,
            geometry.reference.pointer)
        .check();
  }

  static final _id_setGeoJson$2 = _class.instanceMethodId(
    r'setGeoJson',
    r'(Lorg/maplibre/geojson/FeatureCollection;)V',
  );

  static final _setGeoJson$2 = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final void setGeoJson(org.maplibre.geojson.FeatureCollection featureCollection)`
  void setGeoJson$2(
    _$jni.JObject featureCollection,
  ) {
    _setGeoJson$2(reference.pointer, _id_setGeoJson$2 as _$jni.JMethodIDPtr,
            featureCollection.reference.pointer)
        .check();
  }

  static final _id_setGeoJson$3 = _class.instanceMethodId(
    r'setGeoJson',
    r'(Ljava/lang/String;)V',
  );

  static final _setGeoJson$3 = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final void setGeoJson(java.lang.String string)`
  void setGeoJson$3(
    _$jni.JString string,
  ) {
    _setGeoJson$3(reference.pointer, _id_setGeoJson$3 as _$jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_setUrl = _class.instanceMethodId(
    r'setUrl',
    r'(Ljava/net/URL;)V',
  );

  static final _setUrl = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final void setUrl(java.net.URL uRL)`
  void setUrl(
    url_.URL uRL,
  ) {
    _setUrl(reference.pointer, _id_setUrl as _$jni.JMethodIDPtr,
            uRL.reference.pointer)
        .check();
  }

  static final _id_setUri = _class.instanceMethodId(
    r'setUri',
    r'(Ljava/net/URI;)V',
  );

  static final _setUri = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final void setUri(java.net.URI uRI)`
  void setUri(
    uri_.URI uRI,
  ) {
    _setUri(reference.pointer, _id_setUri as _$jni.JMethodIDPtr,
            uRI.reference.pointer)
        .check();
  }

  static final _id_setUri$1 = _class.instanceMethodId(
    r'setUri',
    r'(Ljava/lang/String;)V',
  );

  static final _setUri$1 = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final void setUri(java.lang.String string)`
  void setUri$1(
    _$jni.JString string,
  ) {
    _setUri$1(reference.pointer, _id_setUri$1 as _$jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_getUrl = _class.instanceMethodId(
    r'getUrl',
    r'()Ljava/lang/String;',
  );

  static final _getUrl = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public final java.lang.String getUrl()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JString getUrl() {
    return _getUrl(reference.pointer, _id_getUrl as _$jni.JMethodIDPtr)
        .object(const _$jni.JStringType());
  }

  static final _id_setUrl$1 = _class.instanceMethodId(
    r'setUrl',
    r'(Ljava/lang/String;)V',
  );

  static final _setUrl$1 = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final void setUrl(java.lang.String string)`
  void setUrl$1(
    _$jni.JString string,
  ) {
    _setUrl$1(reference.pointer, _id_setUrl$1 as _$jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_getUri = _class.instanceMethodId(
    r'getUri',
    r'()Ljava/lang/String;',
  );

  static final _getUri = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public final java.lang.String getUri()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JString getUri() {
    return _getUri(reference.pointer, _id_getUri as _$jni.JMethodIDPtr)
        .object(const _$jni.JStringType());
  }

  static final _id_querySourceFeatures = _class.instanceMethodId(
    r'querySourceFeatures',
    r'(Lorg/maplibre/android/style/expressions/Expression;)Ljava/util/List;',
  );

  static final _querySourceFeatures = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final java.util.List querySourceFeatures(org.maplibre.android.style.expressions.Expression expression)`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JList<feature_.Feature> querySourceFeatures(
    _$jni.JObject expression,
  ) {
    return _querySourceFeatures(
            reference.pointer,
            _id_querySourceFeatures as _$jni.JMethodIDPtr,
            expression.reference.pointer)
        .object(const _$jni.JListType(feature_.$Feature$Type()));
  }

  static final _id_getClusterChildren = _class.instanceMethodId(
    r'getClusterChildren',
    r'(Lorg/maplibre/geojson/Feature;)Lorg/maplibre/geojson/FeatureCollection;',
  );

  static final _getClusterChildren = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final org.maplibre.geojson.FeatureCollection getClusterChildren(org.maplibre.geojson.Feature feature)`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JObject getClusterChildren(
    feature_.Feature feature,
  ) {
    return _getClusterChildren(
            reference.pointer,
            _id_getClusterChildren as _$jni.JMethodIDPtr,
            feature.reference.pointer)
        .object(const _$jni.JObjectType());
  }

  static final _id_getClusterLeaves = _class.instanceMethodId(
    r'getClusterLeaves',
    r'(Lorg/maplibre/geojson/Feature;JJ)Lorg/maplibre/geojson/FeatureCollection;',
  );

  static final _getClusterLeaves = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Int64,
                        _$jni.Int64
                      )>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>, int, int)>();

  /// from: `public final org.maplibre.geojson.FeatureCollection getClusterLeaves(org.maplibre.geojson.Feature feature, long j, long j1)`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JObject getClusterLeaves(
    feature_.Feature feature,
    int j,
    int j1,
  ) {
    return _getClusterLeaves(
            reference.pointer,
            _id_getClusterLeaves as _$jni.JMethodIDPtr,
            feature.reference.pointer,
            j,
            j1)
        .object(const _$jni.JObjectType());
  }

  static final _id_getClusterExpansionZoom = _class.instanceMethodId(
    r'getClusterExpansionZoom',
    r'(Lorg/maplibre/geojson/Feature;)I',
  );

  static final _getClusterExpansionZoom = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallIntMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final int getClusterExpansionZoom(org.maplibre.geojson.Feature feature)`
  int getClusterExpansionZoom(
    feature_.Feature feature,
  ) {
    return _getClusterExpansionZoom(
            reference.pointer,
            _id_getClusterExpansionZoom as _$jni.JMethodIDPtr,
            feature.reference.pointer)
        .integer;
  }
}

final class $GeoJsonSource$Type extends _$jni.JObjType<GeoJsonSource> {
  @_$jni.internal
  const $GeoJsonSource$Type();

  @_$jni.internal
  @_$core.override
  String get signature => r'Lorg/maplibre/android/style/sources/GeoJsonSource;';

  @_$jni.internal
  @_$core.override
  GeoJsonSource fromReference(_$jni.JReference reference) =>
      GeoJsonSource.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const source_.$Source$Type();

  @_$jni.internal
  @_$core.override
  final superCount = 2;

  @_$core.override
  int get hashCode => ($GeoJsonSource$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($GeoJsonSource$Type) &&
        other is $GeoJsonSource$Type;
  }
}
