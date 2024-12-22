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

/// from: `org.maplibre.android.constants.MapLibreConstants`
class MapLibreConstants extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<MapLibreConstants> $type;

  @jni$_.internal
  MapLibreConstants.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/constants/MapLibreConstants');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $MapLibreConstants$NullableType();
  static const type = $MapLibreConstants$Type();
  static final _id_MAPLIBRE_LOCALE = _class.staticFieldId(
    r'MAPLIBRE_LOCALE',
    r'Ljava/util/Locale;',
  );

  /// from: `static public final java.util.Locale MAPLIBRE_LOCALE`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JObject? get MAPLIBRE_LOCALE =>
      _id_MAPLIBRE_LOCALE.get(_class, const jni$_.JObjectNullableType());

  static final _id_MAPLIBRE_SHARED_PREFERENCES = _class.staticFieldId(
    r'MAPLIBRE_SHARED_PREFERENCES',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String MAPLIBRE_SHARED_PREFERENCES`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get MAPLIBRE_SHARED_PREFERENCES =>
      _id_MAPLIBRE_SHARED_PREFERENCES.get(
          _class, const jni$_.JStringNullableType());

  static final _id_KEY_META_DATA_SET_STORAGE_EXTERNAL = _class.staticFieldId(
    r'KEY_META_DATA_SET_STORAGE_EXTERNAL',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String KEY_META_DATA_SET_STORAGE_EXTERNAL`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get KEY_META_DATA_SET_STORAGE_EXTERNAL =>
      _id_KEY_META_DATA_SET_STORAGE_EXTERNAL.get(
          _class, const jni$_.JStringNullableType());

  /// from: `static public final boolean DEFAULT_SET_STORAGE_EXTERNAL`
  static const DEFAULT_SET_STORAGE_EXTERNAL = 0;
  static final _id_KEY_META_DATA_MEASURE_TILE_DOWNLOAD_ON =
      _class.staticFieldId(
    r'KEY_META_DATA_MEASURE_TILE_DOWNLOAD_ON',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String KEY_META_DATA_MEASURE_TILE_DOWNLOAD_ON`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get KEY_META_DATA_MEASURE_TILE_DOWNLOAD_ON =>
      _id_KEY_META_DATA_MEASURE_TILE_DOWNLOAD_ON.get(
          _class, const jni$_.JStringNullableType());

  /// from: `static public final boolean DEFAULT_MEASURE_TILE_DOWNLOAD_ON`
  static const DEFAULT_MEASURE_TILE_DOWNLOAD_ON = 0;
  static final _id_DEFAULT_FONT = _class.staticFieldId(
    r'DEFAULT_FONT',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String DEFAULT_FONT`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get DEFAULT_FONT =>
      _id_DEFAULT_FONT.get(_class, const jni$_.JStringNullableType());

  /// from: `static public final float UNMEASURED`
  static const UNMEASURED = -1.0;

  /// from: `static public final int ANIMATION_DURATION`
  static const ANIMATION_DURATION = 300;

  /// from: `static public final int ANIMATION_DURATION_SHORT`
  static const ANIMATION_DURATION_SHORT = 150;

  /// from: `static public final long ANIMATION_DURATION_FLING_BASE`
  static const ANIMATION_DURATION_FLING_BASE = 150;

  /// from: `static public final long VELOCITY_THRESHOLD_IGNORE_FLING`
  static const VELOCITY_THRESHOLD_IGNORE_FLING = 1000;

  /// from: `static public final long ANGLE_THRESHOLD_IGNORE_VERTICAL_FLING`
  static const ANGLE_THRESHOLD_IGNORE_VERTICAL_FLING = 75;

  /// from: `static public final float ROTATION_THRESHOLD_INCREASE_WHEN_SCALING`
  static const ROTATION_THRESHOLD_INCREASE_WHEN_SCALING = 25.0;

  /// from: `static public final double MAX_ABSOLUTE_SCALE_VELOCITY_CHANGE`
  static const MAX_ABSOLUTE_SCALE_VELOCITY_CHANGE = 2.5;

  /// from: `static public final double QUICK_ZOOM_MAX_ZOOM_CHANGE`
  static const QUICK_ZOOM_MAX_ZOOM_CHANGE = 4.0;

  /// from: `static public final double SCALE_VELOCITY_ANIMATION_DURATION_MULTIPLIER`
  static const SCALE_VELOCITY_ANIMATION_DURATION_MULTIPLIER = 150.0;

  /// from: `static public final float MINIMUM_ANGULAR_VELOCITY`
  static const MINIMUM_ANGULAR_VELOCITY = 1.5;

  /// from: `static public final double SCALE_VELOCITY_RATIO_THRESHOLD`
  static const SCALE_VELOCITY_RATIO_THRESHOLD = 0.004;

  /// from: `static public final double ROTATE_VELOCITY_RATIO_THRESHOLD`
  static const ROTATE_VELOCITY_RATIO_THRESHOLD = 0.00022000000000000003;

  /// from: `static public final long SCHEDULED_ANIMATION_TIMEOUT`
  static const SCHEDULED_ANIMATION_TIMEOUT = 150;

  /// from: `static public final float MAXIMUM_ANGULAR_VELOCITY`
  static const MAXIMUM_ANGULAR_VELOCITY = 30.0;

  /// from: `static public final float SHOVE_PIXEL_CHANGE_FACTOR`
  static const SHOVE_PIXEL_CHANGE_FACTOR = 0.1;

  /// from: `static public final float MINIMUM_ZOOM`
  static const MINIMUM_ZOOM = 0.0;

  /// from: `static public final float MAXIMUM_ZOOM`
  static const MAXIMUM_ZOOM = 25.5;

  /// from: `static public final float MINIMUM_PITCH`
  static const MINIMUM_PITCH = 0.0;

  /// from: `static public final float MAXIMUM_PITCH`
  static const MAXIMUM_PITCH = 60.0;

  /// from: `static public final double MAXIMUM_TILT`
  static const MAXIMUM_TILT = 60.0;

  /// from: `static public final double MINIMUM_TILT`
  static const MINIMUM_TILT = 0.0;

  /// from: `static public final double MAXIMUM_DIRECTION`
  static const MAXIMUM_DIRECTION = 360.0;

  /// from: `static public final double MINIMUM_DIRECTION`
  static const MINIMUM_DIRECTION = 0.0;

  /// from: `static public final float MINIMUM_SCALE_FACTOR_CLAMP`
  static const MINIMUM_SCALE_FACTOR_CLAMP = 0.0;

  /// from: `static public final float MAXIMUM_SCALE_FACTOR_CLAMP`
  static const MAXIMUM_SCALE_FACTOR_CLAMP = 0.15;

  /// from: `static public final float ZOOM_RATE`
  static const ZOOM_RATE = 0.65;
  static final _id_FRAG_ARG_MAPLIBREMAPOPTIONS = _class.staticFieldId(
    r'FRAG_ARG_MAPLIBREMAPOPTIONS',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String FRAG_ARG_MAPLIBREMAPOPTIONS`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get FRAG_ARG_MAPLIBREMAPOPTIONS =>
      _id_FRAG_ARG_MAPLIBREMAPOPTIONS.get(
          _class, const jni$_.JStringNullableType());

  static final _id_LAYER_ID_ANNOTATIONS = _class.staticFieldId(
    r'LAYER_ID_ANNOTATIONS',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String LAYER_ID_ANNOTATIONS`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get LAYER_ID_ANNOTATIONS =>
      _id_LAYER_ID_ANNOTATIONS.get(_class, const jni$_.JStringNullableType());

  static final _id_STATE_HAS_SAVED_STATE = _class.staticFieldId(
    r'STATE_HAS_SAVED_STATE',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_HAS_SAVED_STATE`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_HAS_SAVED_STATE =>
      _id_STATE_HAS_SAVED_STATE.get(_class, const jni$_.JStringNullableType());

  static final _id_STATE_CAMERA_POSITION = _class.staticFieldId(
    r'STATE_CAMERA_POSITION',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_CAMERA_POSITION`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_CAMERA_POSITION =>
      _id_STATE_CAMERA_POSITION.get(_class, const jni$_.JStringNullableType());

  static final _id_STATE_ZOOM_ENABLED = _class.staticFieldId(
    r'STATE_ZOOM_ENABLED',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_ZOOM_ENABLED`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_ZOOM_ENABLED =>
      _id_STATE_ZOOM_ENABLED.get(_class, const jni$_.JStringNullableType());

  static final _id_STATE_SCROLL_ENABLED = _class.staticFieldId(
    r'STATE_SCROLL_ENABLED',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_SCROLL_ENABLED`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_SCROLL_ENABLED =>
      _id_STATE_SCROLL_ENABLED.get(_class, const jni$_.JStringNullableType());

  static final _id_STATE_HORIZONAL_SCROLL_ENABLED = _class.staticFieldId(
    r'STATE_HORIZONAL_SCROLL_ENABLED',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_HORIZONAL_SCROLL_ENABLED`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_HORIZONAL_SCROLL_ENABLED =>
      _id_STATE_HORIZONAL_SCROLL_ENABLED.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_ROTATE_ENABLED = _class.staticFieldId(
    r'STATE_ROTATE_ENABLED',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_ROTATE_ENABLED`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_ROTATE_ENABLED =>
      _id_STATE_ROTATE_ENABLED.get(_class, const jni$_.JStringNullableType());

  static final _id_STATE_TILT_ENABLED = _class.staticFieldId(
    r'STATE_TILT_ENABLED',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_TILT_ENABLED`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_TILT_ENABLED =>
      _id_STATE_TILT_ENABLED.get(_class, const jni$_.JStringNullableType());

  static final _id_STATE_DOUBLE_TAP_ENABLED = _class.staticFieldId(
    r'STATE_DOUBLE_TAP_ENABLED',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_DOUBLE_TAP_ENABLED`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_DOUBLE_TAP_ENABLED =>
      _id_STATE_DOUBLE_TAP_ENABLED.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_QUICK_ZOOM_ENABLED = _class.staticFieldId(
    r'STATE_QUICK_ZOOM_ENABLED',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_QUICK_ZOOM_ENABLED`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_QUICK_ZOOM_ENABLED =>
      _id_STATE_QUICK_ZOOM_ENABLED.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_ZOOM_RATE = _class.staticFieldId(
    r'STATE_ZOOM_RATE',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_ZOOM_RATE`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_ZOOM_RATE =>
      _id_STATE_ZOOM_RATE.get(_class, const jni$_.JStringNullableType());

  static final _id_STATE_DEBUG_ACTIVE = _class.staticFieldId(
    r'STATE_DEBUG_ACTIVE',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_DEBUG_ACTIVE`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_DEBUG_ACTIVE =>
      _id_STATE_DEBUG_ACTIVE.get(_class, const jni$_.JStringNullableType());

  static final _id_STATE_COMPASS_ENABLED = _class.staticFieldId(
    r'STATE_COMPASS_ENABLED',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_COMPASS_ENABLED`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_COMPASS_ENABLED =>
      _id_STATE_COMPASS_ENABLED.get(_class, const jni$_.JStringNullableType());

  static final _id_STATE_COMPASS_GRAVITY = _class.staticFieldId(
    r'STATE_COMPASS_GRAVITY',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_COMPASS_GRAVITY`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_COMPASS_GRAVITY =>
      _id_STATE_COMPASS_GRAVITY.get(_class, const jni$_.JStringNullableType());

  static final _id_STATE_COMPASS_MARGIN_LEFT = _class.staticFieldId(
    r'STATE_COMPASS_MARGIN_LEFT',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_COMPASS_MARGIN_LEFT`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_COMPASS_MARGIN_LEFT =>
      _id_STATE_COMPASS_MARGIN_LEFT.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_COMPASS_MARGIN_TOP = _class.staticFieldId(
    r'STATE_COMPASS_MARGIN_TOP',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_COMPASS_MARGIN_TOP`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_COMPASS_MARGIN_TOP =>
      _id_STATE_COMPASS_MARGIN_TOP.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_COMPASS_MARGIN_RIGHT = _class.staticFieldId(
    r'STATE_COMPASS_MARGIN_RIGHT',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_COMPASS_MARGIN_RIGHT`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_COMPASS_MARGIN_RIGHT =>
      _id_STATE_COMPASS_MARGIN_RIGHT.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_COMPASS_MARGIN_BOTTOM = _class.staticFieldId(
    r'STATE_COMPASS_MARGIN_BOTTOM',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_COMPASS_MARGIN_BOTTOM`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_COMPASS_MARGIN_BOTTOM =>
      _id_STATE_COMPASS_MARGIN_BOTTOM.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_COMPASS_FADE_WHEN_FACING_NORTH = _class.staticFieldId(
    r'STATE_COMPASS_FADE_WHEN_FACING_NORTH',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_COMPASS_FADE_WHEN_FACING_NORTH`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_COMPASS_FADE_WHEN_FACING_NORTH =>
      _id_STATE_COMPASS_FADE_WHEN_FACING_NORTH.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_COMPASS_IMAGE_BITMAP = _class.staticFieldId(
    r'STATE_COMPASS_IMAGE_BITMAP',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_COMPASS_IMAGE_BITMAP`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_COMPASS_IMAGE_BITMAP =>
      _id_STATE_COMPASS_IMAGE_BITMAP.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_LOGO_GRAVITY = _class.staticFieldId(
    r'STATE_LOGO_GRAVITY',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_LOGO_GRAVITY`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_LOGO_GRAVITY =>
      _id_STATE_LOGO_GRAVITY.get(_class, const jni$_.JStringNullableType());

  static final _id_STATE_LOGO_MARGIN_LEFT = _class.staticFieldId(
    r'STATE_LOGO_MARGIN_LEFT',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_LOGO_MARGIN_LEFT`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_LOGO_MARGIN_LEFT =>
      _id_STATE_LOGO_MARGIN_LEFT.get(_class, const jni$_.JStringNullableType());

  static final _id_STATE_LOGO_MARGIN_TOP = _class.staticFieldId(
    r'STATE_LOGO_MARGIN_TOP',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_LOGO_MARGIN_TOP`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_LOGO_MARGIN_TOP =>
      _id_STATE_LOGO_MARGIN_TOP.get(_class, const jni$_.JStringNullableType());

  static final _id_STATE_LOGO_MARGIN_RIGHT = _class.staticFieldId(
    r'STATE_LOGO_MARGIN_RIGHT',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_LOGO_MARGIN_RIGHT`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_LOGO_MARGIN_RIGHT =>
      _id_STATE_LOGO_MARGIN_RIGHT.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_LOGO_MARGIN_BOTTOM = _class.staticFieldId(
    r'STATE_LOGO_MARGIN_BOTTOM',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_LOGO_MARGIN_BOTTOM`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_LOGO_MARGIN_BOTTOM =>
      _id_STATE_LOGO_MARGIN_BOTTOM.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_LOGO_ENABLED = _class.staticFieldId(
    r'STATE_LOGO_ENABLED',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_LOGO_ENABLED`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_LOGO_ENABLED =>
      _id_STATE_LOGO_ENABLED.get(_class, const jni$_.JStringNullableType());

  static final _id_STATE_ATTRIBUTION_GRAVITY = _class.staticFieldId(
    r'STATE_ATTRIBUTION_GRAVITY',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_ATTRIBUTION_GRAVITY`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_ATTRIBUTION_GRAVITY =>
      _id_STATE_ATTRIBUTION_GRAVITY.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_ATTRIBUTION_MARGIN_LEFT = _class.staticFieldId(
    r'STATE_ATTRIBUTION_MARGIN_LEFT',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_ATTRIBUTION_MARGIN_LEFT`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_ATTRIBUTION_MARGIN_LEFT =>
      _id_STATE_ATTRIBUTION_MARGIN_LEFT.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_ATTRIBUTION_MARGIN_TOP = _class.staticFieldId(
    r'STATE_ATTRIBUTION_MARGIN_TOP',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_ATTRIBUTION_MARGIN_TOP`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_ATTRIBUTION_MARGIN_TOP =>
      _id_STATE_ATTRIBUTION_MARGIN_TOP.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_ATTRIBUTION_MARGIN_RIGHT = _class.staticFieldId(
    r'STATE_ATTRIBUTION_MARGIN_RIGHT',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_ATTRIBUTION_MARGIN_RIGHT`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_ATTRIBUTION_MARGIN_RIGHT =>
      _id_STATE_ATTRIBUTION_MARGIN_RIGHT.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_ATTRIBUTION_MARGIN_BOTTOM = _class.staticFieldId(
    r'STATE_ATTRIBUTION_MARGIN_BOTTOM',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_ATTRIBUTION_MARGIN_BOTTOM`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_ATTRIBUTION_MARGIN_BOTTOM =>
      _id_STATE_ATTRIBUTION_MARGIN_BOTTOM.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_ATTRIBUTION_ENABLED = _class.staticFieldId(
    r'STATE_ATTRIBUTION_ENABLED',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_ATTRIBUTION_ENABLED`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_ATTRIBUTION_ENABLED =>
      _id_STATE_ATTRIBUTION_ENABLED.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_DESELECT_MARKER_ON_TAP = _class.staticFieldId(
    r'STATE_DESELECT_MARKER_ON_TAP',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_DESELECT_MARKER_ON_TAP`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_DESELECT_MARKER_ON_TAP =>
      _id_STATE_DESELECT_MARKER_ON_TAP.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_USER_FOCAL_POINT = _class.staticFieldId(
    r'STATE_USER_FOCAL_POINT',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_USER_FOCAL_POINT`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_USER_FOCAL_POINT =>
      _id_STATE_USER_FOCAL_POINT.get(_class, const jni$_.JStringNullableType());

  static final _id_STATE_SCALE_ANIMATION_ENABLED = _class.staticFieldId(
    r'STATE_SCALE_ANIMATION_ENABLED',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_SCALE_ANIMATION_ENABLED`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_SCALE_ANIMATION_ENABLED =>
      _id_STATE_SCALE_ANIMATION_ENABLED.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_ROTATE_ANIMATION_ENABLED = _class.staticFieldId(
    r'STATE_ROTATE_ANIMATION_ENABLED',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_ROTATE_ANIMATION_ENABLED`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_ROTATE_ANIMATION_ENABLED =>
      _id_STATE_ROTATE_ANIMATION_ENABLED.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_FLING_ANIMATION_ENABLED = _class.staticFieldId(
    r'STATE_FLING_ANIMATION_ENABLED',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_FLING_ANIMATION_ENABLED`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_FLING_ANIMATION_ENABLED =>
      _id_STATE_FLING_ANIMATION_ENABLED.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_INCREASE_ROTATE_THRESHOLD = _class.staticFieldId(
    r'STATE_INCREASE_ROTATE_THRESHOLD',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_INCREASE_ROTATE_THRESHOLD`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_INCREASE_ROTATE_THRESHOLD =>
      _id_STATE_INCREASE_ROTATE_THRESHOLD.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_DISABLE_ROTATE_WHEN_SCALING = _class.staticFieldId(
    r'STATE_DISABLE_ROTATE_WHEN_SCALING',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_DISABLE_ROTATE_WHEN_SCALING`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_DISABLE_ROTATE_WHEN_SCALING =>
      _id_STATE_DISABLE_ROTATE_WHEN_SCALING.get(
          _class, const jni$_.JStringNullableType());

  static final _id_STATE_INCREASE_SCALE_THRESHOLD = _class.staticFieldId(
    r'STATE_INCREASE_SCALE_THRESHOLD',
    r'Ljava/lang/String;',
  );

  /// from: `static public final java.lang.String STATE_INCREASE_SCALE_THRESHOLD`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JString? get STATE_INCREASE_SCALE_THRESHOLD =>
      _id_STATE_INCREASE_SCALE_THRESHOLD.get(
          _class, const jni$_.JStringNullableType());

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
  factory MapLibreConstants() {
    return MapLibreConstants.fromReference(
        _new$(_class.reference.pointer, _id_new$ as jni$_.JMethodIDPtr)
            .reference);
  }
}

final class $MapLibreConstants$NullableType
    extends jni$_.JObjType<MapLibreConstants?> {
  @jni$_.internal
  const $MapLibreConstants$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/constants/MapLibreConstants;';

  @jni$_.internal
  @core$_.override
  MapLibreConstants? fromReference(jni$_.JReference reference) =>
      reference.isNull
          ? null
          : MapLibreConstants.fromReference(
              reference,
            );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MapLibreConstants?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($MapLibreConstants$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapLibreConstants$NullableType) &&
        other is $MapLibreConstants$NullableType;
  }
}

final class $MapLibreConstants$Type extends jni$_.JObjType<MapLibreConstants> {
  @jni$_.internal
  const $MapLibreConstants$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/constants/MapLibreConstants;';

  @jni$_.internal
  @core$_.override
  MapLibreConstants fromReference(jni$_.JReference reference) =>
      MapLibreConstants.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MapLibreConstants?> get nullableType =>
      const $MapLibreConstants$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($MapLibreConstants$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapLibreConstants$Type) &&
        other is $MapLibreConstants$Type;
  }
}
