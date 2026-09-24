import 'dart:io';

import 'package:ffigen/ffigen.dart';

const includedInterfaces = <String>{
  'NSString',
  'CLLocationCoordinate2D',
  'NSAttributedString',
  'UIImage',
  'UIScreen',
  'UIAction',
  'UIMenu',
  'UIPointerEffect',
  'UIPointerShape',
  'UIPointerStyle',
  'UITableViewCell',
  'UICellConfigurationState',
  'UITableViewHeaderFooterView',
  'UIViewConfigurationState',
  'NSExpression',
  'Helpers',
  'HostScopedRequestHeaders',
  'MapLibreRegistry',
  'Extensions',
  'MLNMapView',
  'MLNMapCamera',
  'MLNStyleLayer',
  'MLNCircleStyleLayer',
  'MLNFillExtrusionStyleLayer',
  'MLNFillStyleLayer',
  'MLNHeatmapStyleLayer',
  'MLNHillshadeStyleLayer',
  'MLNLineStyleLayer',
  'MLNRasterStyleLayer',
  'MLNSymbolStyleLayer',
  'MLNVectorStyleLayer',
  'MLNSource',
  'MLNOfflineStorage',
  'MLNTilePyramidOfflineRegion',
  'MLNCoordinateBounds',
  'MLNShapeSource',
  'MLNShape',
  'MLNTileSource',
  'MLNOfflinePackUserInfoKey',
  'MLNOfflinePack',
  'MLNStyle',
  'MLNRasterDEMSource',
  'MLNVectorTileSource',
  'MLNBackgroundStyleLayer',
  'MLNImageSource',
  'MLNRasterTileSource',
  'MLNCoordinateQuad',
  'UITapGestureRecognizer',
};
const includedProtocols = <String>{
  'MLNMapViewDelegate',
  'MLNFeature',
  'FlutterApi',
  'OfflinePackProgressCallbacks',
};
const includedHeaders = <String>{
  'MapLibreIos.h',
  'MLNMapProjection.h',
  'MLNStyle.h',
  'MLNSource.h',
  'MLNVectorTileSource.h',
  'MLNShapeSource.h',
  'MLNImageSource.h',
  'MLNRasterTileSource.h',
  'MLNRasterDEMSource.h',
  'MLNBackgroundStyleLayer.h',
  'MLNCircleStyleLayer.h',
  'MLNFillExtrusionStyleLayer.h',
  'MLNFillStyleLayer.h',
  'MLNHeatmapStyleLayer.h',
  'MLNHillshadeStyleLayer.h',
  'MLNLineStyleLayer.h',
  'MLNRasterStyleLayer.h',
  'MLNSymbolStyleLayer.h',
  'MLNVectorStyleLayer.h',
  'MLNAttributionInfo.h',
  'NSExpression+MLNAdditions.h',
  'MLNOfflineStorage.h',
  'MLNOfflinePack.h',
  'MLNOfflineRegion.h',
  'MLNTilePyramidOfflineRegion.h',
  'MLNFeature.h',
};

Future<void> main(List<String> args) async {
  final packageRoot = Platform.script.resolve('../');
  // final frameworkPath = packageRoot.resolve('.dart_tool/maplibre_xcframework/MapLibre.xcframework/ios-arm64/');

  final generator = FfiGenerator(
    output: Output(
      dart: DartOutput(
        path: packageRoot.resolve('lib/src/maplibre_ffi.g.dart'),
      ),
      preamble: '''
// ignore_for_file: type=lint, unused_element, unused_field
// dart format off
''',
    ),
    visitors: [
      Visitor(
        objCInterface: (decl) {
          decl.isIncluded = includedInterfaces.contains(decl.originalName);
        },
        objCProtocol: (decl) {
          decl.isIncluded = includedProtocols.contains(decl.originalName);
        },
        objCMethod: (method) {
          method.isIncluded = true;
        },
      ),
    ],
    input: Input(
      entryPoints: [
        packageRoot.resolve(
          'ios/maplibre_ios/Sources/maplibre_ios/MapLibreIos.h',
        ),
        packageRoot.resolve(
          'ios/.build/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MapLibre.h',
        ),
      ],
      compilerOptions: [
        // TODO cannot use the headers from SPM, because of missing debug symbols
        // https://github.com/maplibre/maplibre-native/issues/3155
        // '-F$frameworkPath', '-I${frameworkPath}MapLibre.framework/Headers',
        '-Fios/.build/MapLibre.xcframework/ios-arm64/',
        '-Iios/.build/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers',
        '-isysroot',
        '/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk',
      ],
      include: (header) {
        return includedHeaders.any((path) => header.path.contains(path));
      },
    ),
  );

  await generator.generate();

  // workaround because we use a local MapLibre build during codegen
  final mFile = File('${generator.output.dart.path.toFilePath()}.m');
  final mContent = mFile.readAsStringSync();
  mFile.writeAsStringSync(
    mContent.replaceAll(
      '../../ios/.build/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/',
      '',
    ),
  );
}
