import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:maplibre_ios/maplibre_ffi.dart';
import 'package:maplibre_ios/maplibre_ios.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _maplibreIosPlugin = MaplibreIos();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await _maplibreIosPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Column(
          children: [
            Text('Running on: $_platformVersion\n'),
            OutlinedButton(
              onPressed: () {
                final store = MLNOfflineStorage.getSharedOfflineStorage();
                store.invalidateAmbientCacheWithCompletionHandler_(
                    ObjCBlock_ffiVoid_NSError.listener((error) {
                  debugPrint('invalidate ambient cache finished, $error');
                }));
              },
              child: const Text('Test Callback'),
            ),
          ],
        ),
      ),
    );
  }
}
