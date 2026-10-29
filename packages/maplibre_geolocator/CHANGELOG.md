## Unreleased

- `geolocatorUserLocations` asks for the location permission and starts with
  the current position, so the user location shows on Windows. It reports a
  `PermissionDeniedException` or `LocationServiceDisabledException` instead
  of staying silent.

## 0.1.0

- `geolocatorUserLocations` and `Position.toUserLocation` turn `geolocator`
  positions into the `UserLocation`s of a `UserLocationLayer`.
