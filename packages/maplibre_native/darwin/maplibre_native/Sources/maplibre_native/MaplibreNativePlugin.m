#import "MaplibreNativePlugin.h"

#import <CoreVideo/CoreVideo.h>
#import <Metal/Metal.h>
#import <os/lock.h>

#include <string.h>

/// The deepest ring the C API takes.
static const uint32_t kMaxSlots = 3;

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

/// A Flutter texture fed by a ring of Metal textures that MapLibre renders
/// into. Each presented frame is copied on the GPU into an IOSurface-backed
/// pixel buffer, which Flutter samples without a CPU copy. The copy keeps the
/// ring free for MapLibre while Flutter still shows the previous frame.
@interface MLNGpuTexture : NSObject <FlutterTexture>

@property(nonatomic) int64_t textureId;
@property(nonatomic, readonly) NSArray<id<MTLTexture>> *slots;

- (nullable instancetype)initWithDevice:(id<MTLDevice>)device
                                  queue:(id<MTLCommandQueue>)queue
                                  width:(uint32_t)width
                                 height:(uint32_t)height
                              slotCount:(uint32_t)slotCount
                                  error:(NSString *_Nullable *_Nonnull)error;

/// Replaces the ring and the pixel buffers with ones of the new size. The old
/// ring stays alive until -releaseRetiredSlots.
- (BOOL)resizeToWidth:(uint32_t)width
               height:(uint32_t)height
                error:(NSString *_Nullable *_Nonnull)error;

- (void)releaseRetiredSlots;

/// Copies the frame in |slot| into a new pixel buffer, waits for the copy, and
/// makes the buffer the one Flutter shows next.
- (BOOL)presentSlot:(uint32_t)slot error:(NSString *_Nullable *_Nonnull)error;

@end

@implementation MLNGpuTexture {
  id<MTLDevice> _device;
  id<MTLCommandQueue> _queue;
  NSMutableArray<NSArray<id<MTLTexture>> *> *_retired;
  CVPixelBufferPoolRef _pool;
  CVMetalTextureCacheRef _cache;
  /// Guards _latest, which Flutter's raster thread reads.
  os_unfair_lock _lock;
  CVPixelBufferRef _latest;
}

- (nullable instancetype)initWithDevice:(id<MTLDevice>)device
                                  queue:(id<MTLCommandQueue>)queue
                                  width:(uint32_t)width
                                 height:(uint32_t)height
                              slotCount:(uint32_t)slotCount
                                  error:(NSString *_Nullable *_Nonnull)error {
  if ((self = [super init])) {
    _device = device;
    _queue = queue;
    _retired = [NSMutableArray array];
    _lock = OS_UNFAIR_LOCK_INIT;
    CVReturn status = CVMetalTextureCacheCreate(kCFAllocatorDefault, nil, device, nil, &_cache);
    if (status != kCVReturnSuccess) {
      *error = [NSString stringWithFormat:@"CVMetalTextureCacheCreate failed (%d)", status];
      return nil;
    }
    NSArray<id<MTLTexture>> *slots = [self makeRingOfWidth:width
                                                    height:height
                                                     count:slotCount
                                                     error:error];
    if (slots == nil || ![self makePoolOfWidth:width height:height error:error]) return nil;
    _slots = slots;
  }
  return self;
}

- (void)dealloc {
  if (_latest != NULL) CVPixelBufferRelease(_latest);
  if (_pool != NULL) CVPixelBufferPoolRelease(_pool);
  if (_cache != NULL) CFRelease(_cache);
}

- (nullable NSArray<id<MTLTexture>> *)makeRingOfWidth:(uint32_t)width
                                               height:(uint32_t)height
                                                count:(uint32_t)count
                                                error:(NSString *_Nullable *_Nonnull)error {
  // BGRA8 is the layout of Flutter's pixel buffer textures, so the frames copy
  // into them without a conversion.
  MTLTextureDescriptor *descriptor =
      [MTLTextureDescriptor texture2DDescriptorWithPixelFormat:MTLPixelFormatBGRA8Unorm
                                                         width:width
                                                        height:height
                                                     mipmapped:NO];
  descriptor.usage = MTLTextureUsageRenderTarget | MTLTextureUsageShaderRead;
  descriptor.storageMode = MTLStorageModePrivate;
  NSMutableArray<id<MTLTexture>> *slots = [NSMutableArray arrayWithCapacity:count];
  for (uint32_t i = 0; i < count; i++) {
    id<MTLTexture> texture = [_device newTextureWithDescriptor:descriptor];
    if (texture == nil) {
      *error = [NSString stringWithFormat:@"Could not create a %ux%u Metal texture", width, height];
      return nil;
    }
    [slots addObject:texture];
  }
  return slots;
}

- (BOOL)makePoolOfWidth:(uint32_t)width
                 height:(uint32_t)height
                  error:(NSString *_Nullable *_Nonnull)error {
  NSDictionary *poolAttributes = @{(id)kCVPixelBufferPoolMinimumBufferCountKey : @(kMaxSlots)};
  NSDictionary *bufferAttributes = @{
    (id)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA),
    (id)kCVPixelBufferWidthKey : @(width),
    (id)kCVPixelBufferHeightKey : @(height),
    (id)kCVPixelBufferIOSurfacePropertiesKey : @{},
    (id)kCVPixelBufferMetalCompatibilityKey : @YES,
  };
  CVPixelBufferPoolRef pool = NULL;
  CVReturn status =
      CVPixelBufferPoolCreate(kCFAllocatorDefault, (__bridge CFDictionaryRef)poolAttributes,
                              (__bridge CFDictionaryRef)bufferAttributes, &pool);
  if (status != kCVReturnSuccess) {
    *error = [NSString stringWithFormat:@"CVPixelBufferPoolCreate failed (%d)", status];
    return NO;
  }
  // Buffers of the old pool that Flutter still holds stay valid; the pool
  // only stops handing them out.
  if (_pool != NULL) CVPixelBufferPoolRelease(_pool);
  _pool = pool;
  return YES;
}

- (BOOL)resizeToWidth:(uint32_t)width
               height:(uint32_t)height
                error:(NSString *_Nullable *_Nonnull)error {
  NSArray<id<MTLTexture>> *slots = [self makeRingOfWidth:width
                                                  height:height
                                                   count:(uint32_t)_slots.count
                                                   error:error];
  if (slots == nil || ![self makePoolOfWidth:width height:height error:error]) return NO;
  [_retired addObject:_slots];
  _slots = slots;
  return YES;
}

- (void)releaseRetiredSlots {
  // Command buffers retain the textures they use, so work in flight keeps
  // them alive.
  [_retired removeAllObjects];
}

- (BOOL)presentSlot:(uint32_t)slot error:(NSString *_Nullable *_Nonnull)error {
  if (slot >= _slots.count) {
    *error = [NSString stringWithFormat:@"Slot %u is not in the ring", slot];
    return NO;
  }
  id<MTLTexture> source = _slots[slot];

  CVPixelBufferRef buffer = NULL;
  CVReturn status = CVPixelBufferPoolCreatePixelBuffer(kCFAllocatorDefault, _pool, &buffer);
  if (status != kCVReturnSuccess) {
    *error = [NSString stringWithFormat:@"CVPixelBufferPoolCreatePixelBuffer failed (%d)", status];
    return NO;
  }
  const size_t width = CVPixelBufferGetWidth(buffer);
  const size_t height = CVPixelBufferGetHeight(buffer);
  CVMetalTextureRef bufferTexture = NULL;
  status = CVMetalTextureCacheCreateTextureFromImage(kCFAllocatorDefault, _cache, buffer, nil,
                                                     MTLPixelFormatBGRA8Unorm, width, height, 0,
                                                     &bufferTexture);
  if (status != kCVReturnSuccess) {
    CVPixelBufferRelease(buffer);
    *error = [NSString
        stringWithFormat:@"CVMetalTextureCacheCreateTextureFromImage failed (%d)", status];
    return NO;
  }
  id<MTLTexture> target = CVMetalTextureGetTexture(bufferTexture);

  id<MTLCommandBuffer> commands = [_queue commandBuffer];
  id<MTLBlitCommandEncoder> blit = [commands blitCommandEncoder];
  [blit copyFromTexture:source
            sourceSlice:0
            sourceLevel:0
           sourceOrigin:MTLOriginMake(0, 0, 0)
             sourceSize:MTLSizeMake(MIN(source.width, width), MIN(source.height, height), 1)
              toTexture:target
       destinationSlice:0
       destinationLevel:0
      destinationOrigin:MTLOriginMake(0, 0, 0)];
  [blit endEncoding];
  [commands commit];
  // MapLibre may render into the slot again once its frame is released.
  [commands waitUntilCompleted];
  CFRelease(bufferTexture);
  CVMetalTextureCacheFlush(_cache, 0);

  if (commands.status == MTLCommandBufferStatusError) {
    CVPixelBufferRelease(buffer);
    *error = [NSString stringWithFormat:@"The frame copy failed: %@", commands.error];
    return NO;
  }

  os_unfair_lock_lock(&_lock);
  CVPixelBufferRef previous = _latest;
  _latest = buffer;
  os_unfair_lock_unlock(&_lock);
  if (previous != NULL) CVPixelBufferRelease(previous);
  return YES;
}

// Runs on Flutter's raster thread. Flutter keeps the buffer it gets until it
// takes the next one, and the pool doesn't hand out a buffer while anyone
// still retains it.
- (CVPixelBufferRef _Nullable)copyPixelBuffer {
  os_unfair_lock_lock(&_lock);
  CVPixelBufferRef buffer = _latest;
  if (buffer != NULL) CVPixelBufferRetain(buffer);
  os_unfair_lock_unlock(&_lock);
  return buffer;
}

@end

// State shared by the C API, guarded by gLock. Dart calls the API on its UI
// thread, and the plugin registers on the main thread.
static NSLock *gLock;
static __weak NSObject<FlutterTextureRegistry> *gRegistry;
static id<MTLDevice> gDevice;
static id<MTLCommandQueue> gQueue;
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
    gQueue = [gDevice newCommandQueue];
    if (gDevice == nil || gQueue == nil) {
      gDevice = nil;
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
                                              queue:gQueue
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
