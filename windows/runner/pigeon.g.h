// swiftformat:disable all
// Autogenerated from Pigeon (v25.2.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#ifndef PIGEON_PIGEON_G_H_
#define PIGEON_PIGEON_G_H_
#include <flutter/basic_message_channel.h>
#include <flutter/binary_messenger.h>
#include <flutter/encodable_value.h>
#include <flutter/standard_message_codec.h>

#include <map>
#include <optional>
#include <string>

namespace pigeon_maplibre {


// Generated class from Pigeon.

class FlutterError {
 public:
  explicit FlutterError(const std::string& code)
    : code_(code) {}
  explicit FlutterError(const std::string& code, const std::string& message)
    : code_(code), message_(message) {}
  explicit FlutterError(const std::string& code, const std::string& message, const flutter::EncodableValue& details)
    : code_(code), message_(message), details_(details) {}

  const std::string& code() const { return code_; }
  const std::string& message() const { return message_; }
  const flutter::EncodableValue& details() const { return details_; }

 private:
  std::string code_;
  std::string message_;
  flutter::EncodableValue details_;
};

template<class T> class ErrorOr {
 public:
  ErrorOr(const T& rhs) : v_(rhs) {}
  ErrorOr(const T&& rhs) : v_(std::move(rhs)) {}
  ErrorOr(const FlutterError& rhs) : v_(rhs) {}
  ErrorOr(const FlutterError&& rhs) : v_(std::move(rhs)) {}

  bool has_error() const { return std::holds_alternative<FlutterError>(v_); }
  const T& value() const { return std::get<T>(v_); };
  const FlutterError& error() const { return std::get<FlutterError>(v_); };

 private:
  friend class MapLibreHostApi;
  friend class MapLibreFlutterApi;
  friend class PermissionManagerHostApi;
  friend class OfflineManagerHostApi;
  ErrorOr() = default;
  T TakeValue() && { return std::get<T>(std::move(v_)); }

  std::variant<T, FlutterError> v_;
};


// Influences the y direction of the tile coordinates.
enum class TileScheme {
  // Slippy map tilenames scheme.
  kXyz = 0,
  // OSGeo spec scheme.
  kTms = 1
};

// The encoding used by this source. Mapbox Terrain RGB is used by default.
enum class RasterDemEncoding {
  // Terrarium format PNG tiles.
  kTerrarium = 0,
  // Mapbox Terrain RGB tiles.
  kMapbox = 1,
  // Decodes tiles using the redFactor, blueFactor, greenFactor, baseShift
  // parameters.
  kCustom = 2
};

// The reason the camera is changing.
enum class CameraChangeReason {
  // Developer animation.
  kDeveloperAnimation = 0,
  // API animation.
  kApiAnimation = 1,
  // API gesture
  kApiGesture = 2
};


// The map options define initial values for the MapLibre map.
//
// Generated class from Pigeon that represents data sent in messages.
class MapOptions {
 public:
  // Constructs an object setting all non-nullable fields.
  explicit MapOptions(
    const std::string& style,
    double zoom,
    double pitch,
    double bearing,
    double min_zoom,
    double max_zoom,
    double min_pitch,
    double max_pitch,
    const MapGestures& gestures,
    bool android_texture_mode);

  // Constructs an object setting all fields.
  explicit MapOptions(
    const std::string& style,
    double zoom,
    double pitch,
    double bearing,
    const LngLat* center,
    const LngLatBounds* max_bounds,
    double min_zoom,
    double max_zoom,
    double min_pitch,
    double max_pitch,
    const MapGestures& gestures,
    bool android_texture_mode);

  ~MapOptions() = default;
  MapOptions(const MapOptions& other);
  MapOptions& operator=(const MapOptions& other);
  MapOptions(MapOptions&& other) = default;
  MapOptions& operator=(MapOptions&& other) noexcept = default;
  // The URL of the used map style.
  const std::string& style() const;
  void set_style(std::string_view value_arg);

  // The initial zoom level of the map.
  double zoom() const;
  void set_zoom(double value_arg);

  // The initial pitch / tilt of the map.
  double pitch() const;
  void set_pitch(double value_arg);

  // The initial bearing of the map.
  double bearing() const;
  void set_bearing(double value_arg);

  // The initial center coordinates of the map.
  const LngLat* center() const;
  void set_center(const LngLat* value_arg);
  void set_center(const LngLat& value_arg);

  // The maximum bounding box of the map camera.
  const LngLatBounds* max_bounds() const;
  void set_max_bounds(const LngLatBounds* value_arg);
  void set_max_bounds(const LngLatBounds& value_arg);

  // The minimum zoom level of the map.
  double min_zoom() const;
  void set_min_zoom(double value_arg);

  // The maximum zoom level of the map.
  double max_zoom() const;
  void set_max_zoom(double value_arg);

  // The minimum pitch / tilt of the map.
  double min_pitch() const;
  void set_min_pitch(double value_arg);

  // The maximum pitch / tilt of the map.
  double max_pitch() const;
  void set_max_pitch(double value_arg);

  // The map gestures.
  const MapGestures& gestures() const;
  void set_gestures(const MapGestures& value_arg);

  // Toggle the texture mode on android.
  bool android_texture_mode() const;
  void set_android_texture_mode(bool value_arg);

 private:
  static MapOptions FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;
  friend class MapLibreHostApi;
  friend class MapLibreFlutterApi;
  friend class PermissionManagerHostApi;
  friend class OfflineManagerHostApi;
  friend class PigeonInternalCodecSerializer;
  std::string style_;
  double zoom_;
  double pitch_;
  double bearing_;
  std::unique_ptr<LngLat> center_;
  std::unique_ptr<LngLatBounds> max_bounds_;
  double min_zoom_;
  double max_zoom_;
  double min_pitch_;
  double max_pitch_;
  std::unique_ptr<MapGestures> gestures_;
  bool android_texture_mode_;
};


// Map gestures
//
// Generated class from Pigeon that represents data sent in messages.
class MapGestures {
 public:
  // Constructs an object setting all fields.
  explicit MapGestures(
    bool rotate,
    bool pan,
    bool zoom,
    bool tilt);

  // Rotate the map bearing.
  bool rotate() const;
  void set_rotate(bool value_arg);

  // Move the center of the map around.
  bool pan() const;
  void set_pan(bool value_arg);

  // Zoom the map in and out.
  bool zoom() const;
  void set_zoom(bool value_arg);

  // Tilt (pitch) the map camera.
  bool tilt() const;
  void set_tilt(bool value_arg);

 private:
  static MapGestures FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;
  friend class MapOptions;
  friend class MapLibreHostApi;
  friend class MapLibreFlutterApi;
  friend class PermissionManagerHostApi;
  friend class OfflineManagerHostApi;
  friend class PigeonInternalCodecSerializer;
  bool rotate_;
  bool pan_;
  bool zoom_;
  bool tilt_;
};


// A longitude/latitude coordinate object.
//
// Generated class from Pigeon that represents data sent in messages.
class LngLat {
 public:
  // Constructs an object setting all fields.
  explicit LngLat(
    double lng,
    double lat);

  // The longitude
  double lng() const;
  void set_lng(double value_arg);

  // The latitude
  double lat() const;
  void set_lat(double value_arg);

 private:
  static LngLat FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;
  friend class MapOptions;
  friend class MapCamera;
  friend class MapLibreHostApi;
  friend class MapLibreFlutterApi;
  friend class PermissionManagerHostApi;
  friend class OfflineManagerHostApi;
  friend class PigeonInternalCodecSerializer;
  double lng_;
  double lat_;
};


// A pixel location / location on the device screen.
//
// Generated class from Pigeon that represents data sent in messages.
class Offset {
 public:
  // Constructs an object setting all fields.
  explicit Offset(
    double x,
    double y);

  // The x coordinate
  double x() const;
  void set_x(double value_arg);

  // The y coordinate
  double y() const;
  void set_y(double value_arg);

 private:
  static Offset FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;
  friend class MapLibreHostApi;
  friend class MapLibreFlutterApi;
  friend class PermissionManagerHostApi;
  friend class OfflineManagerHostApi;
  friend class PigeonInternalCodecSerializer;
  double x_;
  double y_;
};


// Camera Padding
//
// Generated class from Pigeon that represents data sent in messages.
class Padding {
 public:
  // Constructs an object setting all fields.
  explicit Padding(
    int64_t top,
    int64_t bottom,
    int64_t left,
    int64_t right);

  int64_t top() const;
  void set_top(int64_t value_arg);

  int64_t bottom() const;
  void set_bottom(int64_t value_arg);

  int64_t left() const;
  void set_left(int64_t value_arg);

  int64_t right() const;
  void set_right(int64_t value_arg);

 private:
  static Padding FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;
  friend class MapLibreHostApi;
  friend class MapLibreFlutterApi;
  friend class PermissionManagerHostApi;
  friend class OfflineManagerHostApi;
  friend class PigeonInternalCodecSerializer;
  int64_t top_;
  int64_t bottom_;
  int64_t left_;
  int64_t right_;
};


// The current position of the map camera.
//
// Generated class from Pigeon that represents data sent in messages.
class MapCamera {
 public:
  // Constructs an object setting all fields.
  explicit MapCamera(
    const LngLat& center,
    double zoom,
    double pitch,
    double bearing);

  ~MapCamera() = default;
  MapCamera(const MapCamera& other);
  MapCamera& operator=(const MapCamera& other);
  MapCamera(MapCamera&& other) = default;
  MapCamera& operator=(MapCamera&& other) noexcept = default;
  const LngLat& center() const;
  void set_center(const LngLat& value_arg);

  double zoom() const;
  void set_zoom(double value_arg);

  double pitch() const;
  void set_pitch(double value_arg);

  double bearing() const;
  void set_bearing(double value_arg);

 private:
  static MapCamera FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;
  friend class MapLibreHostApi;
  friend class MapLibreFlutterApi;
  friend class PermissionManagerHostApi;
  friend class OfflineManagerHostApi;
  friend class PigeonInternalCodecSerializer;
  std::unique_ptr<LngLat> center_;
  double zoom_;
  double pitch_;
  double bearing_;
};


// LatLng bound object
//
// Generated class from Pigeon that represents data sent in messages.
class LngLatBounds {
 public:
  // Constructs an object setting all fields.
  explicit LngLatBounds(
    double longitude_west,
    double longitude_east,
    double latitude_south,
    double latitude_north);

  double longitude_west() const;
  void set_longitude_west(double value_arg);

  double longitude_east() const;
  void set_longitude_east(double value_arg);

  double latitude_south() const;
  void set_latitude_south(double value_arg);

  double latitude_north() const;
  void set_latitude_north(double value_arg);

 private:
  static LngLatBounds FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;
  friend class MapOptions;
  friend class OfflineRegion;
  friend class MapLibreHostApi;
  friend class MapLibreFlutterApi;
  friend class PermissionManagerHostApi;
  friend class OfflineManagerHostApi;
  friend class PigeonInternalCodecSerializer;
  double longitude_west_;
  double longitude_east_;
  double latitude_south_;
  double latitude_north_;
};


// Model that describes an offline map region.
//
// Generated class from Pigeon that represents data sent in messages.
class OfflineRegion {
 public:
  // Constructs an object setting all fields.
  explicit OfflineRegion(
    int64_t id,
    const LngLatBounds& bounds,
    double min_zoom,
    double max_zoom,
    double pixel_ratio,
    const std::string& style_url);

  ~OfflineRegion() = default;
  OfflineRegion(const OfflineRegion& other);
  OfflineRegion& operator=(const OfflineRegion& other);
  OfflineRegion(OfflineRegion&& other) = default;
  OfflineRegion& operator=(OfflineRegion&& other) noexcept = default;
  int64_t id() const;
  void set_id(int64_t value_arg);

  const LngLatBounds& bounds() const;
  void set_bounds(const LngLatBounds& value_arg);

  double min_zoom() const;
  void set_min_zoom(double value_arg);

  double max_zoom() const;
  void set_max_zoom(double value_arg);

  double pixel_ratio() const;
  void set_pixel_ratio(double value_arg);

  const std::string& style_url() const;
  void set_style_url(std::string_view value_arg);

 private:
  static OfflineRegion FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;
  friend class MapLibreHostApi;
  friend class MapLibreFlutterApi;
  friend class PermissionManagerHostApi;
  friend class OfflineManagerHostApi;
  friend class PigeonInternalCodecSerializer;
  int64_t id_;
  std::unique_ptr<LngLatBounds> bounds_;
  double min_zoom_;
  double max_zoom_;
  double pixel_ratio_;
  std::string style_url_;
};


class PigeonInternalCodecSerializer : public flutter::StandardCodecSerializer {
 public:
  PigeonInternalCodecSerializer();
  inline static PigeonInternalCodecSerializer& GetInstance() {
    static PigeonInternalCodecSerializer sInstance;
    return sInstance;
  }

  void WriteValue(
    const flutter::EncodableValue& value,
    flutter::ByteStreamWriter* stream) const override;
 protected:
  flutter::EncodableValue ReadValueOfType(
    uint8_t type,
    flutter::ByteStreamReader* stream) const override;
};

// Generated interface from Pigeon that represents a handler of messages from Flutter.
class MapLibreHostApi {
 public:
  MapLibreHostApi(const MapLibreHostApi&) = delete;
  MapLibreHostApi& operator=(const MapLibreHostApi&) = delete;
  virtual ~MapLibreHostApi() {}
  virtual std::optional<FlutterError> Dispose() = 0;
  // Add a fill layer to the map style.
  virtual void AddFillLayer(
    const std::string& id,
    const std::string& source_id,
    const flutter::EncodableMap& layout,
    const flutter::EncodableMap& paint,
    const std::string* below_layer_id,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  // Add a circle layer to the map style.
  virtual void AddCircleLayer(
    const std::string& id,
    const std::string& source_id,
    const flutter::EncodableMap& layout,
    const flutter::EncodableMap& paint,
    const std::string* below_layer_id,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  // Add a background layer to the map style.
  virtual void AddBackgroundLayer(
    const std::string& id,
    const flutter::EncodableMap& layout,
    const flutter::EncodableMap& paint,
    const std::string* below_layer_id,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  // Add a fill extrusion layer to the map style.
  virtual void AddFillExtrusionLayer(
    const std::string& id,
    const std::string& source_id,
    const flutter::EncodableMap& layout,
    const flutter::EncodableMap& paint,
    const std::string* below_layer_id,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  // Add a heatmap layer to the map style.
  virtual void AddHeatmapLayer(
    const std::string& id,
    const std::string& source_id,
    const flutter::EncodableMap& layout,
    const flutter::EncodableMap& paint,
    const std::string* below_layer_id,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  // Add a hillshade layer to the map style.
  virtual void AddHillshadeLayer(
    const std::string& id,
    const std::string& source_id,
    const flutter::EncodableMap& layout,
    const flutter::EncodableMap& paint,
    const std::string* below_layer_id,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  // Add a line layer to the map style.
  virtual void AddLineLayer(
    const std::string& id,
    const std::string& source_id,
    const flutter::EncodableMap& layout,
    const flutter::EncodableMap& paint,
    const std::string* below_layer_id,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  // Add a raster layer to the map style.
  virtual void AddRasterLayer(
    const std::string& id,
    const std::string& source_id,
    const flutter::EncodableMap& layout,
    const flutter::EncodableMap& paint,
    const std::string* below_layer_id,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  // Add a symbol layer to the map style.
  virtual void AddSymbolLayer(
    const std::string& id,
    const std::string& source_id,
    const flutter::EncodableMap& layout,
    const flutter::EncodableMap& paint,
    const std::string* below_layer_id,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  // Loads an image to the map. An image needs to be loaded before it can
  // get used.
  virtual void LoadImage(
    const std::string& url,
    std::function<void(ErrorOr<std::vector<uint8_t>> reply)> result) = 0;
  // Add an image to the map.
  virtual void AddImage(
    const std::string& id,
    const std::vector<uint8_t>& bytes,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;

  // The codec used by MapLibreHostApi.
  static const flutter::StandardMessageCodec& GetCodec();
  // Sets up an instance of `MapLibreHostApi` to handle messages through the `binary_messenger`.
  static void SetUp(
    flutter::BinaryMessenger* binary_messenger,
    MapLibreHostApi* api);
  static void SetUp(
    flutter::BinaryMessenger* binary_messenger,
    MapLibreHostApi* api,
    const std::string& message_channel_suffix);
  static flutter::EncodableValue WrapError(std::string_view error_message);
  static flutter::EncodableValue WrapError(const FlutterError& error);
 protected:
  MapLibreHostApi() = default;
};
// Generated class from Pigeon that represents Flutter messages that can be called from C++.
class MapLibreFlutterApi {
 public:
  MapLibreFlutterApi(flutter::BinaryMessenger* binary_messenger);
  MapLibreFlutterApi(
    flutter::BinaryMessenger* binary_messenger,
    const std::string& message_channel_suffix);
  static const flutter::StandardMessageCodec& GetCodec();
  // Get the map options from dart.
  void GetOptions(
    std::function<void(const MapOptions&)>&& on_success,
    std::function<void(const FlutterError&)>&& on_error);
  // Callback for when the style has been loaded.
  void OnStyleLoaded(
    std::function<void(void)>&& on_success,
    std::function<void(const FlutterError&)>&& on_error);
  // Callback for when the map is ready and can be used.
  void OnMapReady(
    std::function<void(void)>&& on_success,
    std::function<void(const FlutterError&)>&& on_error);
  // Callback when the user clicks on the map.
  void OnClick(
    const LngLat& point,
    std::function<void(void)>&& on_success,
    std::function<void(const FlutterError&)>&& on_error);
  // Callback when the map idles.
  void OnIdle(
    std::function<void(void)>&& on_success,
    std::function<void(const FlutterError&)>&& on_error);
  // Callback when the map camera idles.
  void OnCameraIdle(
    std::function<void(void)>&& on_success,
    std::function<void(const FlutterError&)>&& on_error);
  // Callback when the user performs a secondary click on the map
  // (e.g. by default a click with the right mouse button).
  void OnSecondaryClick(
    const LngLat& point,
    std::function<void(void)>&& on_success,
    std::function<void(const FlutterError&)>&& on_error);
  // Callback when the user performs a double click on the map.
  void OnDoubleClick(
    const LngLat& point,
    std::function<void(void)>&& on_success,
    std::function<void(const FlutterError&)>&& on_error);
  // Callback when the user performs a long lasting click on the map.
  void OnLongClick(
    const LngLat& point,
    std::function<void(void)>&& on_success,
    std::function<void(const FlutterError&)>&& on_error);
  // Callback when the map camera changes.
  void OnMoveCamera(
    const MapCamera& camera,
    std::function<void(void)>&& on_success,
    std::function<void(const FlutterError&)>&& on_error);
  // Callback when the map camera starts changing.
  void OnStartMoveCamera(
    const CameraChangeReason& reason,
    std::function<void(void)>&& on_success,
    std::function<void(const FlutterError&)>&& on_error);
 private:
  flutter::BinaryMessenger* binary_messenger_;
  std::string message_channel_suffix_;
};

// Generated interface from Pigeon that represents a handler of messages from Flutter.
class PermissionManagerHostApi {
 public:
  PermissionManagerHostApi(const PermissionManagerHostApi&) = delete;
  PermissionManagerHostApi& operator=(const PermissionManagerHostApi&) = delete;
  virtual ~PermissionManagerHostApi() {}
  // Request location permissions.
  virtual void RequestLocationPermissions(
    const std::string& explanation,
    std::function<void(ErrorOr<bool> reply)> result) = 0;

  // The codec used by PermissionManagerHostApi.
  static const flutter::StandardMessageCodec& GetCodec();
  // Sets up an instance of `PermissionManagerHostApi` to handle messages through the `binary_messenger`.
  static void SetUp(
    flutter::BinaryMessenger* binary_messenger,
    PermissionManagerHostApi* api);
  static void SetUp(
    flutter::BinaryMessenger* binary_messenger,
    PermissionManagerHostApi* api,
    const std::string& message_channel_suffix);
  static flutter::EncodableValue WrapError(std::string_view error_message);
  static flutter::EncodableValue WrapError(const FlutterError& error);
 protected:
  PermissionManagerHostApi() = default;
};
// Generated interface from Pigeon that represents a handler of messages from Flutter.
class OfflineManagerHostApi {
 public:
  OfflineManagerHostApi(const OfflineManagerHostApi&) = delete;
  OfflineManagerHostApi& operator=(const OfflineManagerHostApi&) = delete;
  virtual ~OfflineManagerHostApi() {}
  // Clear the ambient cache.
  virtual void ClearAmbientCache(std::function<void(std::optional<FlutterError> reply)> result) = 0;
  // Invalidate the ambient cache.
  virtual void InvalidateAmbientCache(std::function<void(std::optional<FlutterError> reply)> result) = 0;
  // Reset database.
  virtual void ResetDatabase(std::function<void(std::optional<FlutterError> reply)> result) = 0;
  // Set maximum ambient cache size.
  virtual void SetMaximumAmbientCacheSize(
    int64_t bytes,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  // Download a map region.
  virtual void DownloadRegion(
    const std::string& map_style_url,
    const LngLatBounds& bounds,
    double min_zoom,
    double max_zoom,
    double pixel_density,
    const std::string& metadata,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;

  // The codec used by OfflineManagerHostApi.
  static const flutter::StandardMessageCodec& GetCodec();
  // Sets up an instance of `OfflineManagerHostApi` to handle messages through the `binary_messenger`.
  static void SetUp(
    flutter::BinaryMessenger* binary_messenger,
    OfflineManagerHostApi* api);
  static void SetUp(
    flutter::BinaryMessenger* binary_messenger,
    OfflineManagerHostApi* api,
    const std::string& message_channel_suffix);
  static flutter::EncodableValue WrapError(std::string_view error_message);
  static flutter::EncodableValue WrapError(const FlutterError& error);
 protected:
  OfflineManagerHostApi() = default;
};
}  // namespace pigeon_maplibre
#endif  // PIGEON_PIGEON_G_H_
