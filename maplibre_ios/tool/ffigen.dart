import 'dart:io';

import 'package:ffigen/ffigen.dart';

void main(List<String> args) {
  final packageRoot = Platform.script.resolve('../');
  // final frameworkPath = packageRoot.resolve('.dart_tool/maplibre_xcframework/MapLibre.xcframework/ios-arm64/');
  final mlHeadersPath = packageRoot.resolve(
    'ios/.build/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/',
  );
  final generator = FfiGenerator(
    output: Output(
      dartFile: packageRoot.resolve('lib/maplibre_ffi.g.dart'),
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
        mlHeadersPath.resolve('MLNMapProjection.h'),
        mlHeadersPath.resolve('MLNStyle.h'),
        mlHeadersPath.resolve('MLNSource.h'),
        mlHeadersPath.resolve('MLNVectorTileSource.h'),
        mlHeadersPath.resolve('MLNShapeSource.h'),
        mlHeadersPath.resolve('MLNImageSource.h'),
        mlHeadersPath.resolve('MLNRasterTileSource.h'),
        mlHeadersPath.resolve('MLNRasterDEMSource.h'),
        mlHeadersPath.resolve('MLNBackgroundStyleLayer.h'),
        mlHeadersPath.resolve('MLNCircleStyleLayer.h'),
        mlHeadersPath.resolve('MLNFillExtrusionStyleLayer.h'),
        mlHeadersPath.resolve('MLNFillStyleLayer.h'),
        mlHeadersPath.resolve('MLNHeatmapStyleLayer.h'),
        mlHeadersPath.resolve('MLNHillshadeStyleLayer.h'),
        mlHeadersPath.resolve('MLNLineStyleLayer.h'),
        mlHeadersPath.resolve('MLNRasterStyleLayer.h'),
        mlHeadersPath.resolve('MLNSymbolStyleLayer.h'),
        mlHeadersPath.resolve('MLNVectorStyleLayer.h'),
        mlHeadersPath.resolve('MLNAttributionInfo.h'),
        mlHeadersPath.resolve('NSExpression+MLNAdditions.h'),
        mlHeadersPath.resolve('MLNOfflineStorage.h'),
        mlHeadersPath.resolve('MLNOfflinePack.h'),
        mlHeadersPath.resolve('MLNOfflineRegion.h'),
        mlHeadersPath.resolve('MLNTilePyramidOfflineRegion.h'),
        mlHeadersPath.resolve('MLNFeature.h'),
      ],
      compilerOptions: [
        // TODO cannot use the headers from SPM, maybe because of missing debug symbols
        // '-F$frameworkPath',
        // '-I${frameworkPath}MapLibre.framework/Headers',
        '-Fios/.build/MapLibre.xcframework/ios-arm64/',
        '-Iios/.build/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers',
        '-isysroot',
        '/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk',
      ],
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
          };
          if (include.contains(decl.originalName)) return true;
          return decl.originalName.startsWith('MLN');
        },
      ),
      protocols: Protocols(
        include: (decl) {
          return decl.originalName.startsWith('MLN');
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
      '../ios/.build/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/',
      '',
    ),
  );
}
