import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/pigeon.g.dart',
    dartOptions: DartOptions(),
    dartPackageName: 'maplibre',

    cppOptions: CppOptions(namespace: 'pigeon_maplibre'),
    cppHeaderOut: 'windows/runner/pigeon.g.h',
    cppSourceOut: 'windows/runner/pigeon.g.cpp',

    kotlinOut: 'android/src/main/kotlin/com/github/josxha/maplibre/Pigeon.g.kt',
    kotlinOptions: KotlinOptions(),

    swiftOut: 'ios/Classes/Pigeon.g.swift',
    swiftOptions: SwiftOptions(),
  ),
)
enum Code { one, two }

class MessageData {
  MessageData({required this.code, required this.data});

  String? name;
  String? description;
  Code code;
  Map<String?, String?> data;
}

@HostApi()
abstract interface class ExampleHostApi {
  String getHostLanguage();

  // These annotations create more idiomatic naming of methods in Objc and Swift.
  @ObjCSelector('addNumber:toNumber:')
  @SwiftFunction('add(_:to:)')
  int add(int a, int b);

  @async
  bool sendMessage(MessageData message);
}
