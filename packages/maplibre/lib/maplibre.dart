// We export the geobase package here so that users don't have to add
// the dependency themselves.
// TODO only export the parts of geobase that we use, to avoid polluting the namespace.
export 'package:geobase/geobase.dart';
export 'package:maplibre_platform_interface/maplibre_platform_interface.dart'
    show
        BackgroundStyleLayer,
        CameraChangeReason,
        CircleStyleLayer,
        ColorExtension,
        DownloadProgress,
        FillExtrusionStyleLayer,
        FillStyleLayer,
        GeoJsonSource,
        HeatmapStyleLayer,
        HillshadeStyleLayer,
        ImageSource,
        Layer,
        LineStyleLayer,
        LineStyleLayerController,
        LngLatBounds,
        LngLatQuad,
        MapCamera,
        MapController,
        MapCreatedCallback,
        MapEvent,
        MapEventCallback,
        MapEventCameraIdle,
        MapEventClick,
        MapEventDoubleClick,
        MapEventIdle,
        MapEventLongClick,
        MapEventMapCreated,
        MapEventMoveCamera,
        MapEventRenderingChanged,
        MapEventSecondaryClick,
        MapEventStartMoveCamera,
        MapEventStyleLoaded,
        MapEventUserInput,
        MapGestures,
        MapLibreMap,
        MapLibreMapState,
        MapOptions,
        MapProjection,
        OfflineDownloadException,
        OfflineGeometryRegionDefinition,
        OfflineManager,
        OfflineRegion,
        OfflineRegionDefinition,
        OfflineRegionDownloadState,
        OfflineRegionStatus,
        OfflineResourceErrorReason,
        OfflineResourceException,
        OfflineTileCountLimitException,
        OfflineTilePyramidRegionDefinition,
        RasterDemCustomEncoding,
        RasterDemEncoding,
        RasterDemMapboxEncoding,
        RasterDemSource,
        RasterDemTerrariumEncoding,
        RasterSource,
        RasterStyleLayer,
        RenderedFeature,
        Source,
        StyleController,
        StyleLayer,
        StyleLayerWithSource,
        StyleLoadedCallback,
        SymbolStyleLayer,
        TileScheme,
        VectorSource,
        VideoSource,
        degree2Radian,
        earthCircumferenceWgs84,
        htmlColorNames;

export 'src/layer/circle_layer.dart' show CircleLayer;
export 'src/layer/marker_layer.dart' show IconAnchor, MarkerLayer;
export 'src/layer/polygon_layer.dart' show PolygonLayer;
export 'src/layer/polyline_layer.dart' show PolylineLayer;
export 'src/location/user_location.dart'
    show UserLocation, UserLocationTracking;
export 'src/location/user_location_layer.dart' show UserLocationLayer;
export 'src/ui/map_compass.dart' show MapCompass;
export 'src/ui/map_control_buttons.dart' show MapControlButtons;
export 'src/ui/map_scalebar.dart' show MapScalebar, ScaleBarUnit;
export 'src/ui/source_attribution.dart' show SourceAttribution;
export 'src/widget_layer.dart' show Marker, WidgetLayer;
