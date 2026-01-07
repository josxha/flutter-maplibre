import 'dart:io';

import 'package:ffigen/ffigen.dart';

void main(List<String> args) {
  final packageRoot = Platform.script.resolve('../');
  // final frameworkPath = packageRoot.resolve('.dart_tool/maplibre_xcframework/MapLibre.xcframework/ios-arm64/');
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
        packageRoot.resolve('MapLibre.h'),
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
        include: (decl) {
          const set = {
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
            'MLN.*',
          };
          if (set.contains(decl.originalName)) return true;
          return decl.originalName.startsWith('MLN');
        },
      ),
      protocols: Protocols(
        include: (decl) => decl.originalName.startsWith('MLN'),
        module: (decl) => const {
          'MapLibreRegistry': 'maplibre_ios',
          'Helpers': 'maplibre_ios',
          'Extensions': 'maplibre_ios',
          'MLNMapView': 'MapLibre',
          'MLNMapCamera': 'MapLibre',
          'MLNVectorTileSource': 'MapLibre',
          'MLNSymbolStyleLayer': 'MapLibre',
          'MLNOfflinePack': 'MapLibre',
          'MLNOfflineRegion': 'MapLibre',
          'UIImage': 'UIKit',
          'UIScreen': 'UIKit',
        }[decl.originalName],
        includeMember: (declaration, member) => true,
      ),
    ),
    enums: Enums(style: (decl, suggestedStyle) => EnumStyle.intConstants),
  );

  generator.generate();
}
