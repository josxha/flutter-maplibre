#include "maplibre_native_plugin.h"

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <cstring>
#include <memory>
#include <variant>

namespace maplibre_native {

namespace {

template <typename T>
const T* GetArgument(const flutter::EncodableMap& arguments, const char* key) {
  const auto it = arguments.find(flutter::EncodableValue(key));
  if (it == arguments.end()) {
    return nullptr;
  }
  return std::get_if<T>(&it->second);
}

int64_t GetInteger(const flutter::EncodableMap& arguments, const char* key) {
  const auto it = arguments.find(flutter::EncodableValue(key));
  if (it == arguments.end()) {
    return -1;
  }
  return it->second.LongValue();
}

}  // namespace

PixelTexture::PixelTexture(flutter::TextureRegistrar* registrar)
    : registrar_(registrar) {
  texture_ = std::make_unique<flutter::TextureVariant>(
      flutter::PixelBufferTexture([this](size_t width, size_t height) {
        return CopyPixelBuffer(width, height);
      }));
  id_ = registrar_->RegisterTexture(texture_.get());
}

PixelTexture::~PixelTexture() { registrar_->UnregisterTexture(id_, nullptr); }

void PixelTexture::Update(size_t width, size_t height, const uint8_t* pixels,
                          size_t stride) {
  {
    std::lock_guard<std::mutex> lock(mutex_);
    const size_t row_bytes = width * 4;
    pixels_.resize(row_bytes * height);
    if (stride == row_bytes) {
      std::memcpy(pixels_.data(), pixels, pixels_.size());
    } else {
      for (size_t row = 0; row < height; ++row) {
        std::memcpy(pixels_.data() + row * row_bytes, pixels + row * stride,
                    row_bytes);
      }
    }
    buffer_.width = width;
    buffer_.height = height;
  }
  registrar_->MarkTextureFrameAvailable(id_);
}

// Runs on the raster thread. The mutex stays held until Flutter calls
// release_callback, so Update cannot replace the bytes during the upload.
const FlutterDesktopPixelBuffer* PixelTexture::CopyPixelBuffer(size_t width,
                                                               size_t height) {
  mutex_.lock();
  if (pixels_.empty()) {
    mutex_.unlock();
    return nullptr;
  }
  buffer_.buffer = pixels_.data();
  buffer_.release_context = &mutex_;
  buffer_.release_callback = [](void* context) {
    static_cast<std::mutex*>(context)->unlock();
  };
  return &buffer_;
}

// static
void MaplibreNativePlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows* registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "maplibre_native",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin =
      std::make_unique<MaplibreNativePlugin>(registrar->texture_registrar());

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto& call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

MaplibreNativePlugin::MaplibreNativePlugin(flutter::TextureRegistrar* textures)
    : textures_(textures) {}

MaplibreNativePlugin::~MaplibreNativePlugin() = default;

void MaplibreNativePlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue>& method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  const auto& method = method_call.method_name();

  if (method == "createTexture") {
    auto texture = std::make_unique<PixelTexture>(textures_);
    const int64_t id = texture->id();
    pixel_textures_.emplace(id, std::move(texture));
    result->Success(flutter::EncodableValue(id));
    return;
  }

  const auto* arguments =
      std::get_if<flutter::EncodableMap>(method_call.arguments());
  if (arguments == nullptr) {
    result->Error("bad-arguments", "Expected a map of arguments.");
    return;
  }
  const auto texture = pixel_textures_.find(GetInteger(*arguments, "textureId"));
  if (texture == pixel_textures_.end()) {
    result->Error("unknown-texture", "No texture with this id.");
    return;
  }

  if (method == "updateTexture") {
    const auto* pixels = GetArgument<std::vector<uint8_t>>(*arguments, "pixels");
    const int64_t width = GetInteger(*arguments, "width");
    const int64_t height = GetInteger(*arguments, "height");
    const int64_t stride = GetInteger(*arguments, "stride");
    if (pixels == nullptr || width <= 0 || height <= 0 || stride < width * 4 ||
        pixels->size() < static_cast<size_t>(stride * (height - 1) + width * 4)) {
      result->Error("bad-arguments", "Pixel data does not match its size.");
      return;
    }
    texture->second->Update(static_cast<size_t>(width),
                            static_cast<size_t>(height), pixels->data(),
                            static_cast<size_t>(stride));
    result->Success();
  } else if (method == "disposeTexture") {
    pixel_textures_.erase(texture);
    result->Success();
  } else {
    result->NotImplemented();
  }
}

}  // namespace maplibre_native
