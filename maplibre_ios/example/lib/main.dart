import 'package:flutter/material.dart';
import 'package:maplibre_ios/maplibre_ffi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Column(
          children: [
            OutlinedButton(
              onPressed: () {
                final store = MLNOfflineStorage.getSharedOfflineStorage();
                store.invalidateAmbientCacheWithCompletionHandler_(
                  ObjCBlock_ffiVoid_NSError.listener((error) {
                    debugPrint('invalidate ambient cache finished, $error');
                  }),
                );
              },
              child: const Text('Test Callback'),
            ),
          ],
        ),
      ),
    );
  }
}
