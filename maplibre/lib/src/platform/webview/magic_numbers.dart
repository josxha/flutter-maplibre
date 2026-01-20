import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/webview/map_state.dart';
import 'package:maplibre/src/platform/webview/style_controller.dart';

/// Action type for [MapLibreMapStateWebView._test].
const actionTest = 0;

/// Action type for [MapLibreMapStateWebView.moveCamera].
const actionMoveCamera = 1;

/// Action type for [MapLibreMapStateWebView.animateCamera].
const actionAnimateCamera = 2;

/// Action type for [MapLibreMapStateWebView.fitBounds].
const actionFitBounds = 3;

/// Action type for [StyleControllerWebView.addImage].
const actionAddImage = 4;

/// Event type for [MapLibreMapStateWebView._test].
const eventTest = 0;

/// Action type for [MapEventMoveCamera].
const eventMove = 1;

/// Action type for [MapEventStartMoveCamera].
const eventMoveStart = 2;

/// Action type for [MapEventCameraIdle].
const eventMoveEnd = 3;

/// Action type for [MapEventStyleLoaded].
const eventLoad = 4;

/// Action type for [MapEventStyleLoaded].
const eventStyleLoad = 5;

/// Action type for [MapEventClick].
const eventClick = 6;

/// Action type for [MapEventDoubleClick].
const eventDblClick = 7;

/// Action type for [MapEventSecondaryClick].
const eventContextMenu = 8;