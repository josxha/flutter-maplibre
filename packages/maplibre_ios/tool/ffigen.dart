import 'dart:io';

import 'package:ffigen/ffigen.dart';

void main(List<String> args) {
  final packageRoot = Platform.script.resolve('../');
  // final frameworkPath = packageRoot.resolve('.dart_tool/maplibre_xcframework/MapLibre.xcframework/ios-arm64/');
  final generator = FfiGenerator(
    output: Output(
      dartFile: packageRoot.resolve('lib/src/maplibre_ffi.g.dart'),
      preamble: '''
// ignore_for_file: type=lint, unused_element, unused_field
// dart format off
''',
    ),
    headers: Headers(
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
        const include = <String>{
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
        for (final path in include) {
          if (header.path.contains(path)) return true;
        }
        return false;
      },
    ),
    objectiveC: ObjectiveC(
      interfaces: Interfaces(
        includeMember: (decl, member) {
          return true;
        },
        include: (decl) {
          const include = {
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
            'MLNShapeSource',
            'MLNShape',
            'MLNTileSource',
            'MLNOfflinePack',
            'MLNStyle',
            'MLNRasterDEMSource',
            'MLNVectorTileSource',
            'MLNBackgroundStyleLayer',
            'MLNImageSource',
            'MLNCoordinateQuad',
            'UITapGestureRecognizer',
          };
          return include.contains(decl.originalName);
        },
      ),
      protocols: Protocols(
        include: (decl) {
          const include = {'MLNMapViewDelegate', 'MLNFeature', 'FlutterApi'};
          return include.contains(decl.originalName);
        },
        includeMember: (declaration, member) => true,
      ),
    ),
    enums: Enums(style: (decl, suggestedStyle) => EnumStyle.intConstants),
  );

  generator.generate();

  // workaround because we use a local MapLibre build during codegen
  final mFile = File('${generator.output.dartFile.toFilePath()}.m');
  final mContent = mFile.readAsStringSync();
  mFile.writeAsStringSync(
    mContent.replaceAll(
      '../../ios/.build/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/',
      '',
    ),
  );
}
