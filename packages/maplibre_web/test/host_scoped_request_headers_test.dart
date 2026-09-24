import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_web/src/host_scoped_request_headers.dart';

void main() {
  const host = 'maps.example.com';

  tearDown(() {
    HostScopedRequestHeaders.clear(host);
  });

  test('returns headers only for the exact URL host', () {
    HostScopedRequestHeaders.replace(host, {'Authorization': 'token'});

    expect(
      HostScopedRequestHeaders.forUrl('https://maps.example.com/tile.pbf'),
      {'Authorization': 'token'},
    );
    expect(
      HostScopedRequestHeaders.forUrl('https://cdn.maps.example.com/tile.pbf'),
      isNull,
    );
    expect(
      HostScopedRequestHeaders.forUrl('https://example.com/tile.pbf'),
      isNull,
    );
  });

  test('replacement removes stale headers', () {
    HostScopedRequestHeaders.replace(host, {
      'Authorization': 'old',
      'X-Old': 'remove',
    });
    HostScopedRequestHeaders.replace(host, {'Authorization': 'new'});

    expect(
      HostScopedRequestHeaders.forUrl('https://maps.example.com/tile.pbf'),
      {'Authorization': 'new'},
    );
  });

  test('clear removes configured headers', () {
    HostScopedRequestHeaders.replace(host, {'Authorization': 'token'});
    HostScopedRequestHeaders.clear(host);

    expect(
      HostScopedRequestHeaders.forUrl('https://maps.example.com/tile.pbf'),
      isNull,
    );
  });
}
