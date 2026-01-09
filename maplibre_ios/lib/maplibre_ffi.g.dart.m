#include <stdint.h>
#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "../ios/maplibre_ios/Sources/maplibre_ios/MapLibreIos.h"
#import "../ios/.build/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MapLibre.h"

#if !__has_feature(objc_arc)
#error "This file must be compiled with ARC enabled"
#endif

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

typedef struct {
  int64_t version;
  void* (*newWaiter)(void);
  void (*awaitWaiter)(void*);
  void* (*currentIsolate)(void);
  void (*enterIsolate)(void*);
  void (*exitIsolate)(void);
  int64_t (*getMainPortId)(void);
  bool (*getCurrentThreadOwnsIsolate)(int64_t);
} DOBJC_Context;

id objc_retainBlock(id);

#define BLOCKING_BLOCK_IMPL(ctx, BLOCK_SIG, INVOKE_DIRECT, INVOKE_LISTENER)    \
  assert(ctx->version >= 1);                                                   \
  void* targetIsolate = ctx->currentIsolate();                                 \
  int64_t targetPort = ctx->getMainPortId == NULL ? 0 : ctx->getMainPortId();  \
  return BLOCK_SIG {                                                           \
    void* currentIsolate = ctx->currentIsolate();                              \
    bool mayEnterIsolate =                                                     \
        currentIsolate == NULL &&                                              \
        ctx->getCurrentThreadOwnsIsolate != NULL &&                            \
        ctx->getCurrentThreadOwnsIsolate(targetPort);                          \
    if (currentIsolate == targetIsolate || mayEnterIsolate) {                  \
      if (mayEnterIsolate) {                                                   \
        ctx->enterIsolate(targetIsolate);                                      \
      }                                                                        \
      INVOKE_DIRECT;                                                           \
      if (mayEnterIsolate) {                                                   \
        ctx->exitIsolate();                                                    \
      }                                                                        \
    } else {                                                                   \
      void* waiter = ctx->newWaiter();                                         \
      INVOKE_LISTENER;                                                         \
      ctx->awaitWaiter(waiter);                                                \
    }                                                                          \
  };


typedef id  (^_ProtocolTrampoline)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _NativeLibrary_protocolTrampoline_xr62hr(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_1)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _NativeLibrary_protocolTrampoline_e3qsqz(id target, void * sel) {
  return ((_ProtocolTrampoline_1)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _NativeLibrary_wrapListenerBlock_18v1jvf(_ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _NativeLibrary_wrapBlockingBlock_18v1jvf(
    _BlockingTrampoline block, _BlockingTrampoline listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_2)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _NativeLibrary_protocolTrampoline_18v1jvf(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_2)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CLLocationCoordinate2D  (^_ProtocolTrampoline_3)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CLLocationCoordinate2D  _NativeLibrary_protocolTrampoline_neuenc(id target, void * sel) {
  return ((_ProtocolTrampoline_3)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_4)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
id  _NativeLibrary_protocolTrampoline_1mbt9g9(id target, void * sel) {
  return ((_ProtocolTrampoline_4)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

Protocol* _NativeLibrary_MLNAnnotation(void) { return @protocol(MLNAnnotation); }

typedef unsigned long  (^_ProtocolTrampoline_5)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _NativeLibrary_protocolTrampoline_1ckyi24(id target, void * sel) {
  return ((_ProtocolTrampoline_5)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

Protocol* _NativeLibrary_MLNFeature(void) { return @protocol(MLNFeature); }

Protocol* _NativeLibrary_MLNCluster(void) { return @protocol(MLNCluster); }

typedef struct MLNCoordinateBounds  (^_ProtocolTrampoline_6)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct MLNCoordinateBounds  _NativeLibrary_protocolTrampoline_1fkc0ji(id target, void * sel) {
  return ((_ProtocolTrampoline_6)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_7)(void * sel, struct MLNCoordinateBounds arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _NativeLibrary_protocolTrampoline_krbldm(id target, void * sel, struct MLNCoordinateBounds arg1) {
  return ((_ProtocolTrampoline_7)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

Protocol* _NativeLibrary_MLNOverlay(void) { return @protocol(MLNOverlay); }

typedef void  (^_ListenerTrampoline_1)(id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _NativeLibrary_wrapListenerBlock_xtuoz7(_ListenerTrampoline_1 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0));
  };
}

typedef void  (^_BlockingTrampoline_1)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _NativeLibrary_wrapBlockingBlock_xtuoz7(
    _BlockingTrampoline_1 block, _BlockingTrampoline_1 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0));
  });
}

Protocol* _NativeLibrary_MLNStylable(void) { return @protocol(MLNStylable); }

typedef void  (^_ListenerTrampoline_2)(void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _NativeLibrary_wrapListenerBlock_10lndml(_ListenerTrampoline_2 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, BOOL arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_2)(void * waiter, void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _NativeLibrary_wrapBlockingBlock_10lndml(
    _BlockingTrampoline_2 block, _BlockingTrampoline_2 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, BOOL arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_8)(void * sel, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _NativeLibrary_protocolTrampoline_10lndml(id target, void * sel, BOOL arg1) {
  return ((_ProtocolTrampoline_8)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

Protocol* _NativeLibrary_MLNOfflineRegion(void) { return @protocol(MLNOfflineRegion); }

typedef void  (^_ListenerTrampoline_3)(id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _NativeLibrary_wrapListenerBlock_pfv6jd(_ListenerTrampoline_3 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_3)(void * waiter, id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _NativeLibrary_wrapBlockingBlock_pfv6jd(
    _BlockingTrampoline_3 block, _BlockingTrampoline_3 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_4)(id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _NativeLibrary_wrapListenerBlock_r8gdi7(_ListenerTrampoline_4 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_4)(void * waiter, id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _NativeLibrary_wrapBlockingBlock_r8gdi7(
    _BlockingTrampoline_4 block, _BlockingTrampoline_4 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef id  (^_ProtocolTrampoline_9)(void * sel, id arg1, MLNResourceKind arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _NativeLibrary_protocolTrampoline_1fy0zqa(id target, void * sel, id arg1, MLNResourceKind arg2, id arg3) {
  return ((_ProtocolTrampoline_9)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

Protocol* _NativeLibrary_MLNOfflineStorageDelegate(void) { return @protocol(MLNOfflineStorageDelegate); }

typedef id  (^_ProtocolTrampoline_10)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _NativeLibrary_protocolTrampoline_zi5eed(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_10)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGPoint  (^_ProtocolTrampoline_11)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _NativeLibrary_protocolTrampoline_7ohnx8(id target, void * sel) {
  return ((_ProtocolTrampoline_11)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_5)(void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _NativeLibrary_wrapListenerBlock_1bktu2(_ListenerTrampoline_5 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGPoint arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_5)(void * waiter, void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _NativeLibrary_wrapBlockingBlock_1bktu2(
    _BlockingTrampoline_5 block, _BlockingTrampoline_5 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGPoint arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_12)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _NativeLibrary_protocolTrampoline_1bktu2(id target, void * sel, struct CGPoint arg1) {
  return ((_ProtocolTrampoline_12)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGRect  (^_ProtocolTrampoline_13)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _NativeLibrary_protocolTrampoline_1c3uc0w(id target, void * sel) {
  return ((_ProtocolTrampoline_13)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGAffineTransform  (^_ProtocolTrampoline_14)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGAffineTransform  _NativeLibrary_protocolTrampoline_8o6he9(id target, void * sel) {
  return ((_ProtocolTrampoline_14)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_6)(void * arg0, struct CGAffineTransform arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _NativeLibrary_wrapListenerBlock_1lznlw3(_ListenerTrampoline_6 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGAffineTransform arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_6)(void * waiter, void * arg0, struct CGAffineTransform arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _NativeLibrary_wrapBlockingBlock_1lznlw3(
    _BlockingTrampoline_6 block, _BlockingTrampoline_6 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGAffineTransform arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_15)(void * sel, struct CGAffineTransform arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _NativeLibrary_protocolTrampoline_1lznlw3(id target, void * sel, struct CGAffineTransform arg1) {
  return ((_ProtocolTrampoline_15)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef UIDynamicItemCollisionBoundsType  (^_ProtocolTrampoline_16)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIDynamicItemCollisionBoundsType  _NativeLibrary_protocolTrampoline_ku69ws(id target, void * sel) {
  return ((_ProtocolTrampoline_16)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGPoint  (^_ProtocolTrampoline_17)(void * sel, struct CGPoint arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _NativeLibrary_protocolTrampoline_17ipln5(id target, void * sel, struct CGPoint arg1, id arg2) {
  return ((_ProtocolTrampoline_17)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGRect  (^_ProtocolTrampoline_18)(void * sel, struct CGRect arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _NativeLibrary_protocolTrampoline_1sh7l9z(id target, void * sel, struct CGRect arg1, id arg2) {
  return ((_ProtocolTrampoline_18)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UIFocusItemDeferralMode  (^_ProtocolTrampoline_19)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIFocusItemDeferralMode  _NativeLibrary_protocolTrampoline_1qeotwu(id target, void * sel) {
  return ((_ProtocolTrampoline_19)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_7)(void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _NativeLibrary_wrapListenerBlock_ovsamd(_ListenerTrampoline_7 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_7)(void * waiter, void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _NativeLibrary_wrapBlockingBlock_ovsamd(
    _BlockingTrampoline_7 block, _BlockingTrampoline_7 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ProtocolTrampoline_20)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
void  _NativeLibrary_protocolTrampoline_ovsamd(id target, void * sel) {
  return ((_ProtocolTrampoline_20)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_21)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _NativeLibrary_protocolTrampoline_3su7tt(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_21)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_8)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _NativeLibrary_wrapListenerBlock_fjrv01(_ListenerTrampoline_8 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_8)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _NativeLibrary_wrapBlockingBlock_fjrv01(
    _BlockingTrampoline_8 block, _BlockingTrampoline_8 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_22)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _NativeLibrary_protocolTrampoline_fjrv01(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_22)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_23)(void * sel, struct CGRect arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _NativeLibrary_protocolTrampoline_12thpau(id target, void * sel, struct CGRect arg1) {
  return ((_ProtocolTrampoline_23)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_9)(void * arg0, id arg1, struct CGContext * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _NativeLibrary_wrapListenerBlock_qvcerx(_ListenerTrampoline_9 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct CGContext * arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_9)(void * waiter, void * arg0, id arg1, struct CGContext * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _NativeLibrary_wrapBlockingBlock_qvcerx(
    _BlockingTrampoline_9 block, _BlockingTrampoline_9 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct CGContext * arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_24)(void * sel, id arg1, struct CGContext * arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _NativeLibrary_protocolTrampoline_qvcerx(id target, void * sel, id arg1, struct CGContext * arg2) {
  return ((_ProtocolTrampoline_24)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_10)(id arg0, id arg1, MTLLogLevel arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _NativeLibrary_wrapListenerBlock_xbkiks(_ListenerTrampoline_10 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, MTLLogLevel arg2, id arg3) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_10)(void * waiter, id arg0, id arg1, MTLLogLevel arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _NativeLibrary_wrapBlockingBlock_xbkiks(
    _BlockingTrampoline_10 block, _BlockingTrampoline_10 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, MTLLogLevel arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ListenerTrampoline_11)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _NativeLibrary_wrapListenerBlock_1l4hxwm(_ListenerTrampoline_11 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, objc_retainBlock(arg1));
  };
}

typedef void  (^_BlockingTrampoline_11)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _NativeLibrary_wrapBlockingBlock_1l4hxwm(
    _BlockingTrampoline_11 block, _BlockingTrampoline_11 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, objc_retainBlock(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, objc_retainBlock(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_25)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _NativeLibrary_protocolTrampoline_1l4hxwm(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_25)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef double  (^_ProtocolTrampoline_26)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
double  _NativeLibrary_protocolTrampoline_tfvuzk(id target, void * sel) {
  return ((_ProtocolTrampoline_26)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_12)(void * arg0, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _NativeLibrary_wrapListenerBlock_18sfmo2(_ListenerTrampoline_12 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, double arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_12)(void * waiter, void * arg0, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _NativeLibrary_wrapBlockingBlock_18sfmo2(
    _BlockingTrampoline_12 block, _BlockingTrampoline_12 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, double arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_27)(void * sel, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _NativeLibrary_protocolTrampoline_18sfmo2(id target, void * sel, double arg1) {
  return ((_ProtocolTrampoline_27)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef CLAccuracyAuthorization  (^_ProtocolTrampoline_28)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
CLAccuracyAuthorization  _NativeLibrary_protocolTrampoline_1uba46g(id target, void * sel) {
  return ((_ProtocolTrampoline_28)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef CLActivityType  (^_ProtocolTrampoline_29)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
CLActivityType  _NativeLibrary_protocolTrampoline_1o071ut(id target, void * sel) {
  return ((_ProtocolTrampoline_29)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_13)(void * arg0, CLActivityType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _NativeLibrary_wrapListenerBlock_x6heiz(_ListenerTrampoline_13 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, CLActivityType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_13)(void * waiter, void * arg0, CLActivityType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _NativeLibrary_wrapBlockingBlock_x6heiz(
    _BlockingTrampoline_13 block, _BlockingTrampoline_13 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, CLActivityType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_30)(void * sel, CLActivityType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _NativeLibrary_protocolTrampoline_x6heiz(id target, void * sel, CLActivityType arg1) {
  return ((_ProtocolTrampoline_30)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

Protocol* _NativeLibrary_MLNLocationManagerDelegate(void) { return @protocol(MLNLocationManagerDelegate); }

typedef CLAuthorizationStatus  (^_ProtocolTrampoline_31)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
CLAuthorizationStatus  _NativeLibrary_protocolTrampoline_1i9j02r(id target, void * sel) {
  return ((_ProtocolTrampoline_31)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef CLDeviceOrientation  (^_ProtocolTrampoline_32)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
CLDeviceOrientation  _NativeLibrary_protocolTrampoline_1yzsy8m(id target, void * sel) {
  return ((_ProtocolTrampoline_32)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_14)(void * arg0, CLDeviceOrientation arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _NativeLibrary_wrapListenerBlock_gh6c6w(_ListenerTrampoline_14 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, CLDeviceOrientation arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_14)(void * waiter, void * arg0, CLDeviceOrientation arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _NativeLibrary_wrapBlockingBlock_gh6c6w(
    _BlockingTrampoline_14 block, _BlockingTrampoline_14 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, CLDeviceOrientation arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_33)(void * sel, CLDeviceOrientation arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _NativeLibrary_protocolTrampoline_gh6c6w(id target, void * sel, CLDeviceOrientation arg1) {
  return ((_ProtocolTrampoline_33)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

Protocol* _NativeLibrary_MLNLocationManager(void) { return @protocol(MLNLocationManager); }

typedef void  (^_ListenerTrampoline_15)(void);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _NativeLibrary_wrapListenerBlock_1pl9qdv(_ListenerTrampoline_15 block) NS_RETURNS_RETAINED {
  return ^void() {
    objc_retainBlock(block);
    block();
  };
}

typedef void  (^_BlockingTrampoline_15)(void * waiter);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _NativeLibrary_wrapBlockingBlock_1pl9qdv(
    _BlockingTrampoline_15 block, _BlockingTrampoline_15 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(), {
    objc_retainBlock(block);
    block(nil);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter);
  });
}
#undef BLOCKING_BLOCK_IMPL

#pragma clang diagnostic pop
