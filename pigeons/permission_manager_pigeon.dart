import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/native/permission_manager_pigeon.g.dart',
    dartOptions: DartOptions(),
    dartPackageName: 'maplibre',
    // android
    kotlinOut:
        'android/src/main/kotlin/com/github/josxha/maplibre/PermissionManagerPigeon.g.kt',
    kotlinOptions: KotlinOptions(),
  ),
)
@HostApi()
// ignore: one_member_abstracts
abstract interface class PermissionManagerHostApi {
  /// Request location permissions.
  @async
  bool requestLocationPermissions({
    required String explanation,
  });
}
