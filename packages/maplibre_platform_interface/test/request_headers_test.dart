import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

void main() {
  late MapLibrePlatform originalPlatform;
  late _RecordingPlatform platform;

  setUp(() {
    originalPlatform = MapLibrePlatform.instance;
    platform = _RecordingPlatform();
    MapLibrePlatform.instance = platform;
  });

  tearDown(() {
    MapLibrePlatform.instance = originalPlatform;
  });

  test('setHeaders normalizes host and copies replacement headers', () async {
    final headers = {'X-Firebase-AppCheck': 'first-token'};

    await MapLibreRequestHeaders.setHeaders(' MAPS.Example.COM ', headers);
    headers['X-Firebase-AppCheck'] = 'mutated-token';

    expect(platform.host, 'maps.example.com');
    expect(platform.headers, {'X-Firebase-AppCheck': 'first-token'});
  });

  test('setHeaders replaces the complete host configuration', () async {
    await MapLibreRequestHeaders.setHeaders('maps.example.com', {
      'Authorization': 'old',
      'X-Old': 'remove-me',
    });
    await MapLibreRequestHeaders.setHeaders('maps.example.com', {
      'Authorization': 'new',
    });

    expect(platform.headers, {'Authorization': 'new'});
    expect(platform.setCalls, 2);
  });

  test('clearHeaders normalizes and forwards one exact host', () async {
    await MapLibreRequestHeaders.clearHeaders('MAPS.EXAMPLE.COM');

    expect(platform.clearedHost, 'maps.example.com');
    expect(platform.clearCalls, 1);
  });

  test('rejects hosts that are not exact host names', () {
    for (final host in [
      '',
      'https://maps.example.com',
      'maps.example.com:443',
      'maps.example.com/tiles',
      'maps.example.com?token=value',
      'user@maps.example.com',
      'münchen.de',
    ]) {
      expect(
        () => MapLibreRequestHeaders.clearHeaders(host),
        throwsArgumentError,
        reason: host,
      );
    }
    expect(platform.clearCalls, 0);
  });

  test('accepts a punycode host', () async {
    await MapLibreRequestHeaders.setHeaders('XN--mnchen-3ya.de', {
      'X-Token': 'token',
    });

    expect(platform.host, 'xn--mnchen-3ya.de');
  });

  test('rejects unsafe header names and values', () {
    expect(
      () => MapLibreRequestHeaders.setHeaders('maps.example.com', {
        'Bad Header': 'value',
      }),
      throwsArgumentError,
    );
    expect(
      () => MapLibreRequestHeaders.setHeaders('maps.example.com', {
        'Authorization': 'value\r\nInjected: yes',
      }),
      throwsArgumentError,
    );
    expect(
      () => MapLibreRequestHeaders.setHeaders('maps.example.com', {
        'X-Token': 'token\u0001value',
      }),
      throwsArgumentError,
    );
    expect(
      () => MapLibreRequestHeaders.setHeaders('maps.example.com', {
        'X-Token': 'café',
      }),
      throwsArgumentError,
    );
    expect(platform.setCalls, 0);
  });

  test('accepts tab and printable ASCII header values', () async {
    await MapLibreRequestHeaders.setHeaders('maps.example.com', {
      'X-Token': 'tab\t and spaces',
    });

    expect(platform.headers, {'X-Token': 'tab\t and spaces'});
  });
}

final class _RecordingPlatform extends MapLibrePlatform {
  String? host;
  Map<String, String>? headers;
  String? clearedHost;
  int setCalls = 0;
  int clearCalls = 0;

  @override
  Future<void> setRequestHeaders(
    String host,
    Map<String, String> headers,
  ) async {
    this.host = host;
    this.headers = headers;
    setCalls++;
  }

  @override
  Future<void> clearRequestHeaders(String host) async {
    clearedHost = host;
    clearCalls++;
  }
}
