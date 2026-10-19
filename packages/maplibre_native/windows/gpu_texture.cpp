#include "gpu_texture.h"

#include <dxgi1_2.h>

#include <utility>

namespace maplibre_native {

using Microsoft::WRL::ComPtr;

namespace {

constexpr VkExternalMemoryHandleTypeFlagBits kHandleType =
    VK_EXTERNAL_MEMORY_HANDLE_TYPE_D3D11_TEXTURE_BIT;

std::string HResultError(const char* what, HRESULT result) {
  char buffer[64];
  snprintf(buffer, sizeof(buffer), " failed with HRESULT 0x%08lx.",
           static_cast<unsigned long>(result));
  return std::string(what) + buffer;
}

}  // namespace

// static
std::unique_ptr<GpuTexture> GpuTexture::Create(
    flutter::TextureRegistrar* registrar, VulkanDevice* vulkan,
    ID3D11Device* d3d, uint32_t width, uint32_t height, uint32_t slot_count,
    std::string* error) {
  if (!vulkan->imports_d3d11_textures()) {
    *error = "The Vulkan device cannot import D3D11 textures.";
    return nullptr;
  }
  if (!vulkan->matches_adapter()) {
    *error = "The Vulkan device runs on another GPU than Flutter.";
    return nullptr;
  }
  std::unique_ptr<GpuTexture> texture(new GpuTexture(registrar, vulkan, d3d));
  D3D11_QUERY_DESC query_desc{D3D11_QUERY_EVENT, 0};
  HRESULT result = d3d->CreateQuery(&query_desc, &texture->query_);
  if (FAILED(result)) {
    *error = HResultError("ID3D11Device::CreateQuery", result);
    return nullptr;
  }
  if (!texture->CreateSlots(width, height, slot_count, &texture->slots_,
                            error) ||
      !texture->CreatePresentTextures(width, height, error)) {
    return nullptr;
  }
  texture->width_ = width;
  texture->height_ = height;

  GpuTexture* raw = texture.get();
  texture->texture_ =
      std::make_unique<flutter::TextureVariant>(flutter::GpuSurfaceTexture(
          kFlutterDesktopGpuSurfaceTypeDxgiSharedHandle,
          [raw](size_t width, size_t height) {
            return raw->Descriptor(width, height);
          }));
  texture->id_ = registrar->RegisterTexture(texture->texture_.get());
  return texture;
}

GpuTexture::GpuTexture(flutter::TextureRegistrar* registrar,
                       VulkanDevice* vulkan, ID3D11Device* d3d)
    : registrar_(registrar), vulkan_(vulkan), d3d_(d3d) {
  d3d_->GetImmediateContext(&context_);
  descriptor_.struct_size = sizeof(FlutterDesktopGpuSurfaceDescriptor);
  descriptor_.format = kFlutterDesktopPixelFormatBGRA8888;
}

// static
void GpuTexture::Dispose(std::unique_ptr<GpuTexture> texture) {
  GpuTexture* raw = texture.release();
  // Flutter may call Descriptor until unregistration completes, so the
  // texture lives until then.
  raw->registrar_->UnregisterTexture(raw->id_, [raw] { delete raw; });
}

GpuTexture::~GpuTexture() {
  // The session that rendered into the slots released them before the
  // texture was disposed. Present textures hold legacy shared handles, which
  // are not closed.
  for (auto& slot : slots_) DestroySlot(&slot);
  ReleaseRetiredSlots();
}

bool GpuTexture::CreateSlots(uint32_t width, uint32_t height, uint32_t count,
                             std::vector<SharedSlot>* slots,
                             std::string* error) {
  slots->resize(count);
  for (auto& slot : *slots) {
    if (!CreateSlot(width, height, &slot, error)) {
      for (auto& created : *slots) DestroySlot(&created);
      slots->clear();
      return false;
    }
  }
  return true;
}

bool GpuTexture::CreateSlot(uint32_t width, uint32_t height, SharedSlot* slot,
                            std::string* error) {
  D3D11_TEXTURE2D_DESC desc{};
  desc.Width = width;
  desc.Height = height;
  desc.MipLevels = 1;
  desc.ArraySize = 1;
  desc.Format = kDxgiFormat;
  desc.SampleDesc.Count = 1;
  desc.Usage = D3D11_USAGE_DEFAULT;
  desc.BindFlags = D3D11_BIND_RENDER_TARGET | D3D11_BIND_SHADER_RESOURCE;
  desc.MiscFlags =
      D3D11_RESOURCE_MISC_SHARED | D3D11_RESOURCE_MISC_SHARED_NTHANDLE;
  HRESULT result = d3d_->CreateTexture2D(&desc, nullptr, &slot->texture);
  if (FAILED(result)) {
    *error = HResultError("Creating a shared D3D11 texture", result);
    return false;
  }
  ComPtr<IDXGIResource1> resource;
  result = slot->texture.As(&resource);
  if (SUCCEEDED(result)) {
    result = resource->CreateSharedHandle(
        nullptr, DXGI_SHARED_RESOURCE_READ | DXGI_SHARED_RESOURCE_WRITE,
        nullptr, &slot->handle);
  }
  if (FAILED(result)) {
    *error = HResultError("IDXGIResource1::CreateSharedHandle", result);
    return false;
  }

  VkDevice device = vulkan_->device();
  VkExternalMemoryImageCreateInfo external{
      VK_STRUCTURE_TYPE_EXTERNAL_MEMORY_IMAGE_CREATE_INFO};
  external.handleTypes = kHandleType;
  VkImageCreateInfo image_info{VK_STRUCTURE_TYPE_IMAGE_CREATE_INFO};
  image_info.pNext = &external;
  image_info.imageType = VK_IMAGE_TYPE_2D;
  image_info.format = kVulkanFormat;
  image_info.extent = {width, height, 1};
  image_info.mipLevels = 1;
  image_info.arrayLayers = 1;
  image_info.samples = VK_SAMPLE_COUNT_1_BIT;
  image_info.tiling = VK_IMAGE_TILING_OPTIMAL;
  image_info.usage = VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT |
                     VK_IMAGE_USAGE_SAMPLED_BIT |
                     VK_IMAGE_USAGE_TRANSFER_SRC_BIT |
                     VK_IMAGE_USAGE_TRANSFER_DST_BIT;
  image_info.sharingMode = VK_SHARING_MODE_EXCLUSIVE;
  image_info.initialLayout = VK_IMAGE_LAYOUT_UNDEFINED;
  if (vulkan_->vkCreateImage(device, &image_info, nullptr, &slot->image) !=
      VK_SUCCESS) {
    *error = "vkCreateImage for a D3D11-backed image failed.";
    return false;
  }

  VkMemoryRequirements requirements{};
  vulkan_->vkGetImageMemoryRequirements(device, slot->image, &requirements);
  VkMemoryWin32HandlePropertiesKHR handle_properties{
      VK_STRUCTURE_TYPE_MEMORY_WIN32_HANDLE_PROPERTIES_KHR};
  if (vulkan_->vkGetMemoryWin32HandlePropertiesKHR(
          device, kHandleType, slot->handle, &handle_properties) !=
      VK_SUCCESS) {
    *error = "vkGetMemoryWin32HandlePropertiesKHR failed.";
    return false;
  }
  VkPhysicalDeviceMemoryProperties memory_properties{};
  vulkan_->vkGetPhysicalDeviceMemoryProperties(vulkan_->physical_device(),
                                               &memory_properties);
  const uint32_t candidates =
      requirements.memoryTypeBits & handle_properties.memoryTypeBits;
  uint32_t memory_type = UINT32_MAX;
  for (uint32_t i = 0; i < memory_properties.memoryTypeCount; ++i) {
    if ((candidates & (1u << i)) == 0) continue;
    if (memory_type == UINT32_MAX ||
        (memory_properties.memoryTypes[i].propertyFlags &
         VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT) != 0) {
      memory_type = i;
      if ((memory_properties.memoryTypes[i].propertyFlags &
           VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT) != 0) {
        break;
      }
    }
  }
  if (memory_type == UINT32_MAX) {
    *error = "No Vulkan memory type can import the D3D11 texture.";
    return false;
  }

  VkMemoryDedicatedAllocateInfo dedicated{
      VK_STRUCTURE_TYPE_MEMORY_DEDICATED_ALLOCATE_INFO};
  dedicated.image = slot->image;
  VkImportMemoryWin32HandleInfoKHR import{
      VK_STRUCTURE_TYPE_IMPORT_MEMORY_WIN32_HANDLE_INFO_KHR};
  import.pNext = &dedicated;
  import.handleType = kHandleType;
  import.handle = slot->handle;
  VkMemoryAllocateInfo allocate{VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO};
  allocate.pNext = &import;
  allocate.allocationSize = requirements.size;
  allocate.memoryTypeIndex = memory_type;
  if (vulkan_->vkAllocateMemory(device, &allocate, nullptr, &slot->memory) !=
          VK_SUCCESS ||
      vulkan_->vkBindImageMemory(device, slot->image, slot->memory, 0) !=
          VK_SUCCESS) {
    *error = "Importing the D3D11 texture into Vulkan memory failed.";
    return false;
  }

  VkImageViewCreateInfo view_info{VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO};
  view_info.image = slot->image;
  view_info.viewType = VK_IMAGE_VIEW_TYPE_2D;
  view_info.format = kVulkanFormat;
  view_info.subresourceRange = {VK_IMAGE_ASPECT_COLOR_BIT, 0, 1, 0, 1};
  if (vulkan_->vkCreateImageView(device, &view_info, nullptr, &slot->view) !=
      VK_SUCCESS) {
    *error = "vkCreateImageView for a D3D11-backed image failed.";
    return false;
  }
  return true;
}

void GpuTexture::DestroySlot(SharedSlot* slot) {
  VkDevice device = vulkan_->device();
  if (slot->view != VK_NULL_HANDLE) {
    vulkan_->vkDestroyImageView(device, slot->view, nullptr);
  }
  if (slot->image != VK_NULL_HANDLE) {
    vulkan_->vkDestroyImage(device, slot->image, nullptr);
  }
  if (slot->memory != VK_NULL_HANDLE) {
    vulkan_->vkFreeMemory(device, slot->memory, nullptr);
  }
  if (slot->handle != nullptr) CloseHandle(slot->handle);
  *slot = SharedSlot{};
}

bool GpuTexture::CreatePresentTextures(uint32_t width, uint32_t height,
                                       std::string* error) {
  PresentTexture created[2];
  for (auto& present : created) {
    D3D11_TEXTURE2D_DESC desc{};
    desc.Width = width;
    desc.Height = height;
    desc.MipLevels = 1;
    desc.ArraySize = 1;
    desc.Format = kDxgiFormat;
    desc.SampleDesc.Count = 1;
    desc.Usage = D3D11_USAGE_DEFAULT;
    desc.BindFlags = D3D11_BIND_RENDER_TARGET | D3D11_BIND_SHADER_RESOURCE;
    // Flutter opens the texture through ANGLE, which takes a legacy shared
    // handle.
    desc.MiscFlags = D3D11_RESOURCE_MISC_SHARED;
    HRESULT result = d3d_->CreateTexture2D(&desc, nullptr, &present.texture);
    ComPtr<IDXGIResource> resource;
    if (SUCCEEDED(result)) result = present.texture.As(&resource);
    if (SUCCEEDED(result)) result = resource->GetSharedHandle(&present.handle);
    if (FAILED(result)) {
      *error = HResultError("Creating the Flutter texture", result);
      return false;
    }
  }
  std::lock_guard<std::mutex> lock(mutex_);
  for (int i = 0; i < 2; ++i) {
    if (present_[i].texture) {
      retired_present_.emplace_back(0, std::move(present_[i]));
    }
    present_[i] = std::move(created[i]);
  }
  front_ = -1;
  return true;
}

bool GpuTexture::Resize(uint32_t width, uint32_t height, std::string* error) {
  std::vector<SharedSlot> slots;
  if (!CreateSlots(width, height, static_cast<uint32_t>(slots_.size()), &slots,
                   error) ||
      !CreatePresentTextures(width, height, error)) {
    for (auto& slot : slots) DestroySlot(&slot);
    return false;
  }
  retired_slots_.push_back(std::move(slots_));
  slots_ = std::move(slots);
  width_ = width;
  height_ = height;
  return true;
}

void GpuTexture::ReleaseRetiredSlots() {
  for (auto& slots : retired_slots_) {
    for (auto& slot : slots) DestroySlot(&slot);
  }
  retired_slots_.clear();
}

bool GpuTexture::Present(uint32_t slot, std::string* error) {
  if (slot >= slots_.size()) {
    *error = "The slot does not exist.";
    return false;
  }
  int back;
  {
    std::lock_guard<std::mutex> lock(mutex_);
    back = front_ == 0 ? 1 : 0;
  }
  context_->CopyResource(present_[back].texture.Get(),
                         slots_[slot].texture.Get());
  context_->End(query_.Get());
  context_->Flush();
  // Flutter's device reads the texture without a keyed mutex, so the copy
  // completes before the frame is offered.
  BOOL done = FALSE;
  while (context_->GetData(query_.Get(), &done, sizeof(done), 0) == S_FALSE) {
    SwitchToThread();
  }
  {
    std::lock_guard<std::mutex> lock(mutex_);
    front_ = back;
    // Two presents after a resize, Flutter shows the new textures.
    for (auto& retired : retired_present_) retired.first++;
    while (!retired_present_.empty() && retired_present_.front().first > 2) {
      retired_present_.pop_front();
    }
  }
  registrar_->MarkTextureFrameAvailable(id_);
  return true;
}

const FlutterDesktopGpuSurfaceDescriptor* GpuTexture::Descriptor(
    size_t width, size_t height) {
  std::lock_guard<std::mutex> lock(mutex_);
  if (front_ < 0) return nullptr;
  D3D11_TEXTURE2D_DESC desc{};
  present_[front_].texture->GetDesc(&desc);
  descriptor_.handle = present_[front_].handle;
  descriptor_.width = descriptor_.visible_width = desc.Width;
  descriptor_.height = descriptor_.visible_height = desc.Height;
  descriptor_.release_callback = nullptr;
  descriptor_.release_context = nullptr;
  return &descriptor_;
}

}  // namespace maplibre_native
