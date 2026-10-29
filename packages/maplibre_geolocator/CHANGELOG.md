## Unreleased

- `geolocatorUserLocations` starts with the current position, so a device
  that does not move shows its location on Windows, where geolocator reports
  only changed positions.

## 0.1.0

- `geolocatorUserLocations` and `Position.toUserLocation` turn `geolocator`
  positions into the `UserLocation`s of a `UserLocationLayer`.
