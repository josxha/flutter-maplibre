/*
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/maplibre_method_channel.dart';
import 'package:maplibre/maplibre_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMaplibrePlatform
    with MockPlatformInterfaceMixin
    implements MaplibrePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final initialPlatform = MaplibrePlatform.instance;

  test('$MethodChannelMaplibre is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMaplibre>());
  });

  test('getPlatformVersion', () async {
    final maplibrePlugin = Maplibre();
    final fakePlatform = MockMaplibrePlatform();
    MaplibrePlatform.instance = fakePlatform;

    expect(await maplibrePlugin.getPlatformVersion(), '42');
  });
}
*/
