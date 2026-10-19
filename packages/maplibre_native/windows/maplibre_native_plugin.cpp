#include "maplibre_native_plugin.h"

#include <dxgi.h>
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <cstring>
#include <memory>
#include <variant>

namespace maplibre_native {

using flutter::EncodableList;
using flutter::EncodableMap;
using flutter::EncodableValue;
using Microsoft::WRL::ComPtr;

namespace {

template <typename T>
const T* GetArgument(const EncodableMap& arguments, const char* key) {
  const auto it = arguments.find(EncodableValue(key));
  if (it == arguments.end()) {
    return nullptr;
  }
  return std::get_if<T>(&it->second);
}

int64_t GetInteger(const EncodableMap& arguments, const char* key) {
  const auto it = arguments.find(EncodableValue(key));
  if (it == arguments.end()) {
    return -1;
  }
  return it->second.LongValue();
}

EncodableValue Handle(const void* handle) {
  return EncodableValue(static_cast<int64_t>(reinterpret_cast<intptr_t>(handle)));
}

EncodableValue Handle(uint64_t handle) {
  return EncodableValue(static_cast<int64_t>(handle));
}

EncodableValue SlotList(const std::vector<SharedSlot>& slots) {
  EncodableList list;
  for (const auto& slot : slots) {
    list.push_back(EncodableValue(EncodableList{
        Handle(reinterpret_cast<uint64_t>(slot.image)),
        Handle(reinterpret_cast<uint64_t>(slot.view)),
    }));
  }
  return EncodableValue(list);
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

// static
void PixelTexture::Dispose(std::unique_ptr<PixelTexture> texture) {
  PixelTexture* raw = texture.release();
  // Flutter may copy the buffer until unregistration completes.
  raw->registrar_->UnregisterTexture(raw->id_, [raw] { delete raw; });
}

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
  auto channel = std::make_unique<flutter::MethodChannel<EncodableValue>>(
      registrar->messenger(), "maplibre_native",
      &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<MaplibreNativePlugin>(registrar);

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto& call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

MaplibreNativePlugin::MaplibreNativePlugin(
    flutter::PluginRegistrarWindows* registrar)
    : registrar_(registrar), textures_(registrar->texture_registrar()) {
  ComPtr<IDXGIAdapter> adapter;
  if (registrar_->GetGraphicsAdapter(&adapter) && adapter) {
    DXGI_ADAPTER_DESC desc{};
    if (SUCCEEDED(adapter->GetDesc(&desc))) {
      adapter_luid_ = desc.AdapterLuid;
      has_adapter_luid_ = true;
    }
  }
}

MaplibreNativePlugin::~MaplibreNativePlugin() {
  for (auto& [id, texture] : pixel_textures_) {
    PixelTexture::Dispose(std::move(texture));
  }
  for (auto& [id, texture] : gpu_textures_) {
    GpuTexture::Dispose(std::move(texture));
  }
}

VulkanDevice* MaplibreNativePlugin::GetVulkan(std::string* error) {
  return VulkanDevice::Get(has_adapter_luid_ ? &adapter_luid_ : nullptr, error);
}

ID3D11Device* MaplibreNativePlugin::GetD3D11(std::string* error) {
  if (d3d_) return d3d_.Get();
  ComPtr<IDXGIAdapter> adapter;
  if (!registrar_->GetGraphicsAdapter(&adapter) || !adapter) {
    *error = "Flutter does not render through a DXGI adapter.";
    return nullptr;
  }
  const D3D_FEATURE_LEVEL levels[] = {D3D_FEATURE_LEVEL_11_1,
                                      D3D_FEATURE_LEVEL_11_0};
  HRESULT result = D3D11CreateDevice(
      adapter.Get(), D3D_DRIVER_TYPE_UNKNOWN, nullptr, 0, levels,
      static_cast<UINT>(std::size(levels)), D3D11_SDK_VERSION, &d3d_, nullptr,
      nullptr);
  if (FAILED(result)) {
    *error = "D3D11CreateDevice failed.";
    return nullptr;
  }
  return d3d_.Get();
}

void MaplibreNativePlugin::HandleMethodCall(
    const flutter::MethodCall<EncodableValue>& method_call,
    std::unique_ptr<flutter::MethodResult<EncodableValue>> result) {
  const auto& method = method_call.method_name();

  if (method == "vulkanContext") {
    std::string error;
    VulkanDevice* vulkan = GetVulkan(&error);
    if (vulkan == nullptr) {
      result->Error("vulkan-unavailable", error);
      return;
    }
    result->Success(EncodableValue(EncodableMap{
        {EncodableValue("instance"), Handle(vulkan->instance())},
        {EncodableValue("physicalDevice"), Handle(vulkan->physical_device())},
        {EncodableValue("device"), Handle(vulkan->device())},
        {EncodableValue("queue"), Handle(vulkan->queue())},
        {EncodableValue("queueFamilyIndex"),
         EncodableValue(static_cast<int64_t>(vulkan->queue_family_index()))},
        {EncodableValue("getInstanceProcAddr"),
         Handle(reinterpret_cast<void*>(vulkan->get_instance_proc_addr()))},
        {EncodableValue("getDeviceProcAddr"),
         Handle(reinterpret_cast<void*>(vulkan->get_device_proc_addr()))},
    }));
    return;
  }

  if (method == "createTexture") {
    auto texture = std::make_unique<PixelTexture>(textures_);
    const int64_t id = texture->id();
    pixel_textures_.emplace(id, std::move(texture));
    result->Success(EncodableValue(id));
    return;
  }

  const auto* arguments =
      std::get_if<EncodableMap>(method_call.arguments());
  if (arguments == nullptr) {
    result->Error("bad-arguments", "Expected a map of arguments.");
    return;
  }

  if (method == "createGpuTexture") {
    std::string error;
    VulkanDevice* vulkan = GetVulkan(&error);
    ID3D11Device* d3d = vulkan == nullptr ? nullptr : GetD3D11(&error);
    std::unique_ptr<GpuTexture> texture;
    // Lets the CPU readback path be tested on hardware that shares textures.
    char disable[2] = {};
    if (GetEnvironmentVariableA("MAPLIBRE_NATIVE_DISABLE_ZERO_COPY", disable,
                                sizeof(disable)) > 0) {
      d3d = nullptr;
      error = "MAPLIBRE_NATIVE_DISABLE_ZERO_COPY is set.";
    }
    if (d3d != nullptr) {
      texture = GpuTexture::Create(
          textures_, vulkan, d3d,
          static_cast<uint32_t>(GetInteger(*arguments, "width")),
          static_cast<uint32_t>(GetInteger(*arguments, "height")),
          static_cast<uint32_t>(GetInteger(*arguments, "slotCount")), &error);
    }
    if (!texture) {
      // Dart falls back to the pixel buffer path.
      result->Success(EncodableValue(EncodableMap{
          {EncodableValue("error"), EncodableValue(error)},
      }));
      return;
    }
    const int64_t id = texture->id();
    EncodableValue slots = SlotList(texture->slots());
    gpu_textures_.emplace(id, std::move(texture));
    result->Success(EncodableValue(EncodableMap{
        {EncodableValue("textureId"), EncodableValue(id)},
        {EncodableValue("format"),
         EncodableValue(static_cast<int64_t>(GpuTexture::kVulkanFormat))},
        {EncodableValue("slots"), slots},
    }));
    return;
  }

  const int64_t texture_id = GetInteger(*arguments, "textureId");
  const auto gpu = gpu_textures_.find(texture_id);
  const auto pixel = pixel_textures_.find(texture_id);
  if (gpu == gpu_textures_.end() && pixel == pixel_textures_.end()) {
    result->Error("unknown-texture", "No texture with this id.");
    return;
  }

  if (method == "presentGpuTexture" && gpu != gpu_textures_.end()) {
    std::string error;
    if (!gpu->second->Present(
            static_cast<uint32_t>(GetInteger(*arguments, "slot")), &error)) {
      result->Error("present-failed", error);
      return;
    }
    result->Success();
  } else if (method == "resizeGpuTexture" && gpu != gpu_textures_.end()) {
    std::string error;
    if (!gpu->second->Resize(
            static_cast<uint32_t>(GetInteger(*arguments, "width")),
            static_cast<uint32_t>(GetInteger(*arguments, "height")),
            &error)) {
      result->Error("resize-failed", error);
      return;
    }
    result->Success(SlotList(gpu->second->slots()));
  } else if (method == "releaseRetiredSlots" && gpu != gpu_textures_.end()) {
    gpu->second->ReleaseRetiredSlots();
    result->Success();
  } else if (method == "updateTexture" && pixel != pixel_textures_.end()) {
    const auto* pixels = GetArgument<std::vector<uint8_t>>(*arguments, "pixels");
    const int64_t width = GetInteger(*arguments, "width");
    const int64_t height = GetInteger(*arguments, "height");
    const int64_t stride = GetInteger(*arguments, "stride");
    if (pixels == nullptr || width <= 0 || height <= 0 || stride < width * 4 ||
        pixels->size() <
            static_cast<size_t>(stride * (height - 1) + width * 4)) {
      result->Error("bad-arguments", "Pixel data does not match its size.");
      return;
    }
    pixel->second->Update(static_cast<size_t>(width),
                          static_cast<size_t>(height), pixels->data(),
                          static_cast<size_t>(stride));
    result->Success();
  } else if (method == "disposeTexture") {
    if (gpu != gpu_textures_.end()) {
      GpuTexture::Dispose(std::move(gpu->second));
      gpu_textures_.erase(gpu);
    } else {
      PixelTexture::Dispose(std::move(pixel->second));
      pixel_textures_.erase(pixel);
    }
    result->Success();
  } else {
    result->NotImplemented();
  }
}

}  // namespace maplibre_native
