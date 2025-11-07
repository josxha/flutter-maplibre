import 'dart:io';

import 'package:jnigen/jnigen.dart';

void main(List<String> args) {
  final packageRoot = Platform.script.resolve('../');
  generateJniBindings(
    Config(
      outputConfig: OutputConfig(
        dartConfig: DartCodeOutputConfig(
          path: packageRoot.resolve('lib/src/platform/android/jni.g.dart'),
          structure: OutputStructure.singleFile,
        ),
      ),
      preamble: '// ignore_for_file: type=lint',
      mavenDownloads: MavenDownloads(
        sourceDeps: ['org.maplibre.gl:android-sdk-geojson:6.0.1'],
      ),
      androidSdkConfig: AndroidSdkConfig(
        addGradleDeps: true,
        androidExample: '../example',
      ),
      sourcePath: [packageRoot.resolve('android/src/main')],
      classes: [
        // https://github.com/maplibre/maplibre-native/tree/main/platform/android/MapLibreAndroid/src/main/java/org/maplibre/android
        'android.app.Activity',
        'android.content.Context',
        'android.graphics.BitmapFactory',
        'android.graphics.PointF',
        'android.graphics.RectF',
        'android.location.Location',
        'android.widget.FrameLayout',
        'android.view.ViewGroup',
        'com.github.josxha.maplibre.FlutterApi',
        'com.github.josxha.maplibre.MapLibreRegistry',
        'java.net.URI',
        'java.net.URL',
        'io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding',
        'io.flutter.plugin.common.PluginRegistry',
        'io.flutter.plugin.platform.PlatformView',
        'io.flutter.plugin.platform.PlatformViewFactory',
        'org.maplibre.android.MapLibre',
        'org.maplibre.android.camera',
        'org.maplibre.android.exceptions',
        'org.maplibre.android.geometry',
        'org.maplibre.android.location.permissions',
        'org.maplibre.android.location.modes',
        'org.maplibre.android.location.engine.LocationEngineRequest',
        'org.maplibre.android.location.LocationComponent',
        'org.maplibre.android.location.LocationComponentActivationOptions',
        'org.maplibre.android.location.LocationComponentOptions',
        'org.maplibre.android.log.Logger',
        'org.maplibre.android.maps',
        'org.maplibre.android.offline.OfflineGeometryRegionDefinition',
        'org.maplibre.android.offline.OfflineManager',
        'org.maplibre.android.offline.OfflineRegion',
        'org.maplibre.android.offline.OfflineRegionDefinition',
        'org.maplibre.android.offline.OfflineRegionError',
        'org.maplibre.android.offline.OfflineRegionStatus',
        'org.maplibre.android.offline.OfflineTilePyramidRegionDefinition',
        'org.maplibre.android.style.layers',
        'org.maplibre.android.style.sources',
        'org.maplibre.geojson.Feature',
        'com.google.gson.Gson',
        'com.google.gson.JsonObject',
      ],
    ),
  );
}
