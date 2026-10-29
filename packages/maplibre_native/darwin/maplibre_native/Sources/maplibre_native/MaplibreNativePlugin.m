#import "MaplibreNativePlugin.h"

#import <CoreVideo/CoreVideo.h>
#import <Metal/Metal.h>
#import <os/lock.h>

#include <string.h>

/// The deepest ring the C API takes.
enum { kMaxSlots = 3 };

/// Writes |message| into the caller's |error| buffer, when there is one.
static void WriteError(NSString *message, char *error, size_t error_size) {
  if (error == NULL || error_size == 0) return;
  strlcpy(error, message.UTF8String ?: "unknown error", error_size);
}

/// Runs |block| on the main thread and waits for it. Dart's UI thread is the
/// main thread when the platform and UI threads are merged, and then this runs
/// inline.
static void RunOnMain(dispatch_block_t block) {
  if (NSThread.isMainThread) {
    block();
  } else {
    dispatch_sync(dispatch_get_main_queue(), block);
  }
}

/// One ring of IOSurface-backed BGRA8 pixel buffers and the Metal textures
/// that MapLibre renders into them.
@interface MLNRing : NSObject

@property(nonatomic, readonly) NSArray<id<MTLTexture>> *textures;

- (nullable instancetype)initWithCache:(CVMetalTextureCacheRef)cache
                                 width:(uint32_t)width
                                height:(uint32_t)height
                                 count:(uint32_t)count
                                 error:(NSString *_Nullable *_Nonnull)error;

- (CVPixelBufferRef)bufferAt:(uint32_t)slot;

@end

@implementation MLNRing {
  CVPixelBufferRef _buffers[kMaxSlots];
  CVMetalTextureRef _bufferTextures[kMaxSlots];
  uint32_t _count;
}

- (nullable instancetype)initWithCache:(CVMetalTextureCacheRef)cache
                                 width:(uint32_t)width
                                height:(uint32_t)height
                                 count:(uint32_t)count
                                 error:(NSString *_Nullable *_Nonnull)error {
  if ((self = [super init])) {
    // BGRA8 is the layout of Flutter's pixel buffer textures, so Flutter
    // samples the frames as MapLibre rendered them.
    NSDictionary *attributes = @{
      (id)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA),
      (id)kCVPixelBufferWidthKey : @(width),
      (id)kCVPixelBufferHeightKey : @(height),
      (id)kCVPixelBufferIOSurfacePropertiesKey : @{},
      (id)kCVPixelBufferMetalCompatibilityKey : @YES,
    };
    // MapLibre renders into the textures, and Flutter samples them.
    NSDictionary *textureAttributes = @{
      (id)kCVMetalTextureUsage : @(MTLTextureUsageRenderTarget | MTLTextureUsageShaderRead),
    };
    NSMutableArray<id<MTLTexture>> *textures = [NSMutableArray arrayWithCapacity:count];
    for (uint32_t i = 0; i < count; i++) {
      CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, width, height,
                                            kCVPixelFormatType_32BGRA,
                                            (__bridge CFDictionaryRef)attributes, &_buffers[i]);
      if (status != kCVReturnSuccess) {
        *error = [NSString stringWithFormat:@"CVPixelBufferCreate failed (%d)", status];
        return nil;
      }
      _count = i + 1;
      status = CVMetalTextureCacheCreateTextureFromImage(
          kCFAllocatorDefault, cache, _buffers[i], (__bridge CFDictionaryRef)textureAttributes,
          MTLPixelFormatBGRA8Unorm, width, height, 0, &_bufferTextures[i]);
      if (status != kCVReturnSuccess) {
        *error = [NSString
            stringWithFormat:@"CVMetalTextureCacheCreateTextureFromImage failed (%d)", status];
        return nil;
      }
      [textures addObject:CVMetalTextureGetTexture(_bufferTextures[i])];
    }
    _textures = textures;
  }
  return self;
}

- (void)dealloc {
  for (uint32_t i = 0; i < _count; i++) {
    if (_bufferTextures[i] != NULL) CFRelease(_bufferTextures[i]);
    CVPixelBufferRelease(_buffers[i]);
  }
}

- (CVPixelBufferRef)bufferAt:(uint32_t)slot {
  return _buffers[slot];
}

@end

/// A Flutter texture fed by a ring of IOSurface-backed Metal textures that
/// MapLibre renders into. Flutter samples the slot of the presented frame
/// directly, without a copy: Dart keeps that frame acquired, so MapLibre
/// renders into the other slots, and releases a frame it replaced once
/// -isSlotInUse: reports that Flutter no longer samples its slot.
@interface MLNGpuTexture : NSObject <FlutterTexture>

@property(nonatomic) int64_t textureId;
@property(nonatomic, readonly) NSArray<id<MTLTexture>> *slots;

- (nullable instancetype)initWithDevice:(id<MTLDevice>)device
                                  width:(uint32_t)width
                                 height:(uint32_t)height
                             slotCount:(uint32_t)slotCount
                                  error:(NSString *_Nullable *_Nonnull)error;

/// Replaces the ring with one of the new size. The old ring stays alive until
/// -releaseRetiredSlots, and its buffers as long as Flutter holds them.
- (BOOL)resizeToWidth:(uint32_t)width
               height:(uint32_t)height
                error:(NSString *_Nullable *_Nonnull)error;

- (void)releaseRetiredSlots;

/// Makes the finished frame in |slot| the one Flutter shows next.
- (BOOL)presentSlot:(uint32_t)slot error:(NSString *_Nullable *_Nonnull)error;

/// Whether Flutter may still sample |slot|: it is the presented slot, or one
/// of the last two that Flutter took.
- (BOOL)isSlotInUse:(uint32_t)slot;

@end

@implementation MLNGpuTexture {
  CVMetalTextureCacheRef _cache;
  NSMutableArray<MLNRing *> *_retired;
  MLNRing *_ring;
  /// Guard the fields below, which Flutter's raster thread reads.
  os_unfair_lock _lock;
  /// The buffer of the presented frame, retained, and its slot, or -1.
  CVPixelBufferRef _latest;
  int64_t _latestSlot;
  /// The slot that Flutter took last, whose buffer it holds until it takes
  /// the next one, and the slot it took before, which a frame still on the
  /// GPU may read. Neither IOSurfaceIsInUse nor the use count see Flutter's
  /// reads: the ring's own buffer and texture keep the surface in use, and
  /// Flutter's texture adds nothing.
  int64_t _takenSlot;
  int64_t _previousTakenSlot;
}

- (nullable instancetype)initWithDevice:(id<MTLDevice>)device
                                  width:(uint32_t)width
                                 height:(uint32_t)height
                             slotCount:(uint32_t)slotCount
                                  error:(NSString *_Nullable *_Nonnull)error {
  if ((self = [super init])) {
    _retired = [NSMutableArray array];
    _lock = OS_UNFAIR_LOCK_INIT;
    _latestSlot = -1;
    _takenSlot = -1;
    _previousTakenSlot = -1;
    CVReturn status = CVMetalTextureCacheCreate(kCFAllocatorDefault, nil, device, nil, &_cache);
    if (status != kCVReturnSuccess) {
      *error = [NSString stringWithFormat:@"CVMetalTextureCacheCreate failed (%d)", status];
      return nil;
    }
    _ring = [[MLNRing alloc] initWithCache:_cache
                                     width:width
                                    height:height
                                     count:slotCount
                                     error:error];
    if (_ring == nil) return nil;
  }
  return self;
}

- (void)dealloc {
  if (_latest != NULL) CVPixelBufferRelease(_latest);
  if (_cache != NULL) CFRelease(_cache);
}

- (NSArray<id<MTLTexture>> *)slots {
  return _ring.textures;
}

- (BOOL)resizeToWidth:(uint32_t)width
               height:(uint32_t)height
                error:(NSString *_Nullable *_Nonnull)error {
  MLNRing *ring = [[MLNRing alloc] initWithCache:_cache
                                           width:width
                                          height:height
                                           count:(uint32_t)_ring.textures.count
                                           error:error];
  if (ring == nil) return NO;
  [_retired addObject:_ring];
  os_unfair_lock_lock(&_lock);
  _ring = ring;
  // Slots of the new ring: Flutter keeps showing the old ring's buffer,
  // which it retains, until a frame of the new ring is presented.
  _latestSlot = -1;
  _takenSlot = -1;
  _previousTakenSlot = -1;
  os_unfair_lock_unlock(&_lock);
  return YES;
}

- (void)releaseRetiredSlots {
  // Command buffers retain the textures they use, and Flutter the buffer it
  // shows, so work in flight keeps them alive.
  [_retired removeAllObjects];
  CVMetalTextureCacheFlush(_cache, 0);
}

- (BOOL)presentSlot:(uint32_t)slot error:(NSString *_Nullable *_Nonnull)error {
  if (slot >= _ring.textures.count) {
    *error = [NSString stringWithFormat:@"Slot %u is not in the ring", slot];
    return NO;
  }
  // The frame's GPU writes completed before it became acquirable.
  CVPixelBufferRef buffer = CVPixelBufferRetain([_ring bufferAt:slot]);
  os_unfair_lock_lock(&_lock);
  CVPixelBufferRef previous = _latest;
  _latest = buffer;
  _latestSlot = slot;
  os_unfair_lock_unlock(&_lock);
  if (previous != NULL) CVPixelBufferRelease(previous);
  return YES;
}

- (BOOL)isSlotInUse:(uint32_t)slot {
  if (slot >= _ring.textures.count) return NO;
  os_unfair_lock_lock(&_lock);
  const BOOL held = slot == _latestSlot || slot == _takenSlot || slot == _previousTakenSlot;
  os_unfair_lock_unlock(&_lock);
  return held;
}

// Runs on Flutter's raster thread. Flutter keeps the buffer it gets until it
// takes the next one.
- (CVPixelBufferRef _Nullable)copyPixelBuffer {
  os_unfair_lock_lock(&_lock);
  CVPixelBufferRef buffer = _latest;
  if (buffer != NULL) CVPixelBufferRetain(buffer);
  if (_latestSlot != _takenSlot) {
    _previousTakenSlot = _takenSlot;
    _takenSlot = _latestSlot;
  }
  os_unfair_lock_unlock(&_lock);
  return buffer;
}

@end

// State shared by the C API, guarded by gLock. Dart calls the API on its UI
// thread, and the plugin registers on the main thread.
static NSLock *gLock;
static __weak NSObject<FlutterTextureRegistry> *gRegistry;
static id<MTLDevice> gDevice;
static NSMutableDictionary<NSNumber *, MLNGpuTexture *> *gTextures;

/// The registry and the device, created on first use, or nil with |error|.
static NSObject<FlutterTextureRegistry> *_Nullable AcquireRegistry(char *error,
                                                                   size_t error_size) {
  NSObject<FlutterTextureRegistry> *registry = gRegistry;
  if (registry == nil) {
    WriteError(@"The maplibre_native plugin is not registered.", error, error_size);
    return nil;
  }
  if (gDevice == nil) {
    gDevice = MTLCreateSystemDefaultDevice();
    if (gDevice == nil) {
      WriteError(@"Metal is unavailable.", error, error_size);
      return nil;
    }
  }
  return registry;
}

static MLNGpuTexture *_Nullable FindTexture(int64_t texture_id, char *error, size_t error_size) {
  MLNGpuTexture *texture = gTextures[@(texture_id)];
  if (texture == nil) {
    WriteError([NSString stringWithFormat:@"No texture %lld", (long long)texture_id], error,
               error_size);
  }
  return texture;
}

static void WriteSlots(MLNGpuTexture *texture, uint64_t *out_slots, uint32_t slot_capacity) {
  NSArray<id<MTLTexture>> *slots = texture.slots;
  for (NSUInteger i = 0; i < slots.count && i < slot_capacity; i++) {
    out_slots[i] = (uint64_t)(uintptr_t)(__bridge void *)slots[i];
  }
}

int64_t maplibre_native_create_gpu_texture(uint32_t width, uint32_t height, uint32_t slot_count,
                                           uint64_t *out_slots, uint32_t slot_capacity,
                                           char *error, size_t error_size) {
  if (slot_count == 0 || slot_count > kMaxSlots || slot_count > slot_capacity) {
    WriteError(@"The ring holds one to three textures.", error, error_size);
    return -1;
  }
  [gLock lock];
  NSObject<FlutterTextureRegistry> *registry = AcquireRegistry(error, error_size);
  MLNGpuTexture *texture = nil;
  NSString *message = nil;
  if (registry != nil) {
    texture = [[MLNGpuTexture alloc] initWithDevice:gDevice
                                              width:width
                                             height:height
                                          slotCount:slot_count
                                              error:&message];
  }
  [gLock unlock];
  if (registry == nil) return -1;
  if (texture == nil) {
    WriteError(message, error, error_size);
    return -1;
  }

  // Outside the lock, which the main thread may wait for.
  __block int64_t texture_id = -1;
  RunOnMain(^{
    texture_id = [registry registerTexture:texture];
  });
  texture.textureId = texture_id;

  [gLock lock];
  gTextures[@(texture_id)] = texture;
  [gLock unlock];
  WriteSlots(texture, out_slots, slot_capacity);
  return texture_id;
}

bool maplibre_native_resize_gpu_texture(int64_t texture_id, uint32_t width, uint32_t height,
                                        uint64_t *out_slots, uint32_t slot_capacity,
                                        char *error, size_t error_size) {
  [gLock lock];
  MLNGpuTexture *texture = FindTexture(texture_id, error, error_size);
  NSString *message = nil;
  const BOOL resized =
      texture != nil && [texture resizeToWidth:width height:height error:&message];
  [gLock unlock];
  if (!resized) {
    if (message != nil) WriteError(message, error, error_size);
    return false;
  }
  WriteSlots(texture, out_slots, slot_capacity);
  return true;
}

void maplibre_native_release_retired_slots(int64_t texture_id) {
  [gLock lock];
  [gTextures[@(texture_id)] releaseRetiredSlots];
  [gLock unlock];
}

bool maplibre_native_present_gpu_texture(int64_t texture_id, uint32_t slot, char *error,
                                         size_t error_size) {
  [gLock lock];
  MLNGpuTexture *texture = FindTexture(texture_id, error, error_size);
  NSString *message = nil;
  const BOOL presented = texture != nil && [texture presentSlot:slot error:&message];
  NSObject<FlutterTextureRegistry> *registry = gRegistry;
  [gLock unlock];
  if (!presented) {
    if (message != nil) WriteError(message, error, error_size);
    return false;
  }
  // The engine only marks the texture dirty and schedules a frame, which is
  // safe from any thread.
  [registry textureFrameAvailable:texture_id];
  return true;
}

bool maplibre_native_gpu_texture_slot_in_use(int64_t texture_id, uint32_t slot) {
  [gLock lock];
  MLNGpuTexture *texture = gTextures[@(texture_id)];
  const BOOL inUse = texture != nil && [texture isSlotInUse:slot];
  [gLock unlock];
  return inUse;
}

void maplibre_native_dispose_texture(int64_t texture_id) {
  [gLock lock];
  MLNGpuTexture *texture = gTextures[@(texture_id)];
  [gTextures removeObjectForKey:@(texture_id)];
  NSObject<FlutterTextureRegistry> *registry = gRegistry;
  [gLock unlock];
  if (texture == nil) return;
  // The registry keeps the texture alive while Flutter may still copy it.
  RunOnMain(^{
    [registry unregisterTexture:texture_id];
  });
}

static const MaplibreNativeSymbol kSymbols[] = {
    {"maplibre_native_create_gpu_texture", (void *)&maplibre_native_create_gpu_texture},
    {"maplibre_native_resize_gpu_texture", (void *)&maplibre_native_resize_gpu_texture},
    {"maplibre_native_release_retired_slots", (void *)&maplibre_native_release_retired_slots},
    {"maplibre_native_present_gpu_texture", (void *)&maplibre_native_present_gpu_texture},
    {"maplibre_native_gpu_texture_slot_in_use",
     (void *)&maplibre_native_gpu_texture_slot_in_use},
    {"maplibre_native_dispose_texture", (void *)&maplibre_native_dispose_texture},
    {NULL, NULL},
};

@implementation MaplibreNativePlugin

+ (void)initialize {
  if (self == [MaplibreNativePlugin class]) {
    gLock = [[NSLock alloc] init];
    gTextures = [NSMutableDictionary dictionary];
  }
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  [gLock lock];
  gRegistry = [registrar textures];
  [gLock unlock];
}

+ (const MaplibreNativeSymbol *)symbols {
  return kSymbols;
}

@end
