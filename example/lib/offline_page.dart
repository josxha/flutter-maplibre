import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class OfflinePage extends StatefulWidget {
  const OfflinePage({super.key});

  static const location = '/offline';

  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  final _offlineManager = OfflineManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offline Map')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('mergeOfflineRegions'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('getOfflineRegion'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('setOfflineTileCountLimit'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('setMaximumAmbientCacheSize'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('clearAmbientCache'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('invalidateAmbientCache'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('listOfflineRegions'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('packDatabase'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('resetDatabase'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('runPackDatabaseAutomatically'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('downloadRegion'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _offlineManager.dispose();
    super.dispose();
  }
}
