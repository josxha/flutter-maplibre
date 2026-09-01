import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_native/maplibre_native.dart';
import 'package:maplibre_native/maplibre_native_platform_interface.dart';
import 'package:maplibre_native/maplibre_native_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMaplibreNativePlatform
    with MockPlatformInterfaceMixin
    implements MaplibreNativePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MaplibreNativePlatform initialPlatform = MaplibreNativePlatform.instance;

  test('$MethodChannelMaplibreNative is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMaplibreNative>());
  });

  test('getPlatformVersion', () async {
    MaplibreNative maplibreNativePlugin = MaplibreNative();
    MockMaplibreNativePlatform fakePlatform = MockMaplibreNativePlatform();
    MaplibreNativePlatform.instance = fakePlatform;

    expect(await maplibreNativePlugin.getPlatformVersion(), '42');
  });
}
