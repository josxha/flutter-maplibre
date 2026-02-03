#include <stdint.h>
#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "../../ios/maplibre_ios/Sources/maplibre_ios/MapLibreIos.h"
#import "MapLibre.h"

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


Protocol* _6admjt_FlutterApi(void) { return @protocol(FlutterApi); }

Protocol* _6admjt_MLNFeature(void) { return @protocol(MLNFeature); }

Protocol* _6admjt_MLNMapViewDelegate(void) { return @protocol(MLNMapViewDelegate); }

typedef double  (^_ProtocolTrampoline)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
double  _6admjt_protocolTrampoline_1kspct0(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGPoint  (^_ProtocolTrampoline_1)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _6admjt_protocolTrampoline_1hsw88y(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_1)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CLLocationCoordinate2D  (^_ProtocolTrampoline_2)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CLLocationCoordinate2D  _6admjt_protocolTrampoline_neuenc(id target, void * sel) {
  return ((_ProtocolTrampoline_2)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_3)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _6admjt_protocolTrampoline_zi5eed(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_3)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_4)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _6admjt_protocolTrampoline_xr62hr(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_4)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_5)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
id  _6admjt_protocolTrampoline_1mbt9g9(id target, void * sel) {
  return ((_ProtocolTrampoline_5)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_6)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _6admjt_protocolTrampoline_jk8du5(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_6)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_7)(void * sel, id arg1, id arg2, id arg3, MLNCameraChangeReason arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _6admjt_protocolTrampoline_1wu22tl(id target, void * sel, id arg1, id arg2, id arg3, MLNCameraChangeReason arg4) {
  return ((_ProtocolTrampoline_7)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_8)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _6admjt_protocolTrampoline_2n06mv(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_8)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline)(void);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _6admjt_wrapListenerBlock_1pl9qdv(_ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void() {
    objc_retainBlock(block);
    block();
  };
}

typedef void  (^_BlockingTrampoline)(void * waiter);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _6admjt_wrapBlockingBlock_1pl9qdv(
    _BlockingTrampoline block, _BlockingTrampoline listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(), {
    objc_retainBlock(block);
    block(nil);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter);
  });
}

typedef void  (^_ListenerTrampoline_1)(id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _6admjt_wrapListenerBlock_pfv6jd(_ListenerTrampoline_1 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_1)(void * waiter, id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _6admjt_wrapBlockingBlock_pfv6jd(
    _BlockingTrampoline_1 block, _BlockingTrampoline_1 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_2)(id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _6admjt_wrapListenerBlock_xtuoz7(_ListenerTrampoline_2 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0));
  };
}

typedef void  (^_BlockingTrampoline_2)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _6admjt_wrapBlockingBlock_xtuoz7(
    _BlockingTrampoline_2 block, _BlockingTrampoline_2 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0));
  });
}

typedef void  (^_ListenerTrampoline_3)(id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _6admjt_wrapListenerBlock_r8gdi7(_ListenerTrampoline_3 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_3)(void * waiter, id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _6admjt_wrapBlockingBlock_r8gdi7(
    _BlockingTrampoline_3 block, _BlockingTrampoline_3 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ListenerTrampoline_4)(void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _6admjt_wrapListenerBlock_1bktu2(_ListenerTrampoline_4 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGPoint arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_4)(void * waiter, void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _6admjt_wrapBlockingBlock_1bktu2(
    _BlockingTrampoline_4 block, _BlockingTrampoline_4 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGPoint arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_9)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_1bktu2(id target, void * sel, struct CGPoint arg1) {
  return ((_ProtocolTrampoline_9)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_5)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _6admjt_wrapListenerBlock_18v1jvf(_ListenerTrampoline_5 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_5)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _6admjt_wrapBlockingBlock_18v1jvf(
    _BlockingTrampoline_5 block, _BlockingTrampoline_5 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_10)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_18v1jvf(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_10)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_6)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _6admjt_wrapListenerBlock_fjrv01(_ListenerTrampoline_6 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_6)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _6admjt_wrapBlockingBlock_fjrv01(
    _BlockingTrampoline_6 block, _BlockingTrampoline_6 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_11)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_fjrv01(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_11)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_7)(void * arg0, id arg1, MLNCameraChangeReason arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _6admjt_wrapListenerBlock_1yu368z(_ListenerTrampoline_7 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, MLNCameraChangeReason arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_7)(void * waiter, void * arg0, id arg1, MLNCameraChangeReason arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _6admjt_wrapBlockingBlock_1yu368z(
    _BlockingTrampoline_7 block, _BlockingTrampoline_7 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, MLNCameraChangeReason arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_12)(void * sel, id arg1, MLNCameraChangeReason arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_1yu368z(id target, void * sel, id arg1, MLNCameraChangeReason arg2) {
  return ((_ProtocolTrampoline_12)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_8)(void * arg0, id arg1, MLNCameraChangeReason arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _6admjt_wrapListenerBlock_1f1ebb3(_ListenerTrampoline_8 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, MLNCameraChangeReason arg2, BOOL arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_8)(void * waiter, void * arg0, id arg1, MLNCameraChangeReason arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _6admjt_wrapBlockingBlock_1f1ebb3(
    _BlockingTrampoline_8 block, _BlockingTrampoline_8 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, MLNCameraChangeReason arg2, BOOL arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_13)(void * sel, id arg1, MLNCameraChangeReason arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_1f1ebb3(id target, void * sel, id arg1, MLNCameraChangeReason arg2, BOOL arg3) {
  return ((_ProtocolTrampoline_13)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_9)(void * arg0, id arg1, MLNTileOperation arg2, long arg3, long arg4, long arg5, long arg6, long arg7, id arg8);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _6admjt_wrapListenerBlock_epgd2t(_ListenerTrampoline_9 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, MLNTileOperation arg2, long arg3, long arg4, long arg5, long arg6, long arg7, id arg8) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, arg6, arg7, (__bridge id)(__bridge_retained void*)(arg8));
  };
}

typedef void  (^_BlockingTrampoline_9)(void * waiter, void * arg0, id arg1, MLNTileOperation arg2, long arg3, long arg4, long arg5, long arg6, long arg7, id arg8);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _6admjt_wrapBlockingBlock_epgd2t(
    _BlockingTrampoline_9 block, _BlockingTrampoline_9 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, MLNTileOperation arg2, long arg3, long arg4, long arg5, long arg6, long arg7, id arg8), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, arg6, arg7, (__bridge id)(__bridge_retained void*)(arg8));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, arg6, arg7, (__bridge id)(__bridge_retained void*)(arg8));
  });
}

typedef void  (^_ProtocolTrampoline_14)(void * sel, id arg1, MLNTileOperation arg2, long arg3, long arg4, long arg5, long arg6, long arg7, id arg8);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_epgd2t(id target, void * sel, id arg1, MLNTileOperation arg2, long arg3, long arg4, long arg5, long arg6, long arg7, id arg8) {
  return ((_ProtocolTrampoline_14)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
}

typedef void  (^_ListenerTrampoline_10)(void * arg0, id arg1, MLNUserTrackingMode arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _6admjt_wrapListenerBlock_gl3jxl(_ListenerTrampoline_10 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, MLNUserTrackingMode arg2, BOOL arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_10)(void * waiter, void * arg0, id arg1, MLNUserTrackingMode arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _6admjt_wrapBlockingBlock_gl3jxl(
    _BlockingTrampoline_10 block, _BlockingTrampoline_10 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, MLNUserTrackingMode arg2, BOOL arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_15)(void * sel, id arg1, MLNUserTrackingMode arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_gl3jxl(id target, void * sel, id arg1, MLNUserTrackingMode arg2, BOOL arg3) {
  return ((_ProtocolTrampoline_15)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_11)(void * arg0, id arg1, id arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _6admjt_wrapListenerBlock_rgxx3r(_ListenerTrampoline_11 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, struct _NSRange arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_11)(void * waiter, void * arg0, id arg1, id arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _6admjt_wrapBlockingBlock_rgxx3r(
    _BlockingTrampoline_11 block, _BlockingTrampoline_11 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, struct _NSRange arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_16)(void * sel, id arg1, id arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_rgxx3r(id target, void * sel, id arg1, id arg2, struct _NSRange arg3) {
  return ((_ProtocolTrampoline_16)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_12)(void * arg0, id arg1, long arg2, long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _6admjt_wrapListenerBlock_g6us7l(_ListenerTrampoline_12 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long arg2, long arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_12)(void * waiter, void * arg0, id arg1, long arg2, long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _6admjt_wrapBlockingBlock_g6us7l(
    _BlockingTrampoline_12 block, _BlockingTrampoline_12 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long arg2, long arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_17)(void * sel, id arg1, long arg2, long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_g6us7l(id target, void * sel, id arg1, long arg2, long arg3, id arg4) {
  return ((_ProtocolTrampoline_17)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_13)(void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _6admjt_wrapListenerBlock_1tz5yf(_ListenerTrampoline_13 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_13)(void * waiter, void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _6admjt_wrapBlockingBlock_1tz5yf(
    _BlockingTrampoline_13 block, _BlockingTrampoline_13 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_18)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_1tz5yf(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_18)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_14)(void * arg0, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _6admjt_wrapListenerBlock_zzthnb(_ListenerTrampoline_14 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, BOOL arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_14)(void * waiter, void * arg0, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _6admjt_wrapBlockingBlock_zzthnb(
    _BlockingTrampoline_14 block, _BlockingTrampoline_14 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, BOOL arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_19)(void * sel, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_zzthnb(id target, void * sel, id arg1, BOOL arg2) {
  return ((_ProtocolTrampoline_19)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_15)(void * arg0, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _6admjt_wrapListenerBlock_1llhjbh(_ListenerTrampoline_15 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, BOOL arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_15)(void * waiter, void * arg0, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _6admjt_wrapBlockingBlock_1llhjbh(
    _BlockingTrampoline_15 block, _BlockingTrampoline_15 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, BOOL arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_20)(void * sel, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_1llhjbh(id target, void * sel, id arg1, BOOL arg2, id arg3) {
  return ((_ProtocolTrampoline_20)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_16)(void * arg0, id arg1, BOOL arg2, double arg3, double arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _6admjt_wrapListenerBlock_1v8di4v(_ListenerTrampoline_16 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, BOOL arg2, double arg3, double arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_16)(void * waiter, void * arg0, id arg1, BOOL arg2, double arg3, double arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _6admjt_wrapBlockingBlock_1v8di4v(
    _BlockingTrampoline_16 block, _BlockingTrampoline_16 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, BOOL arg2, double arg3, double arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_21)(void * sel, id arg1, BOOL arg2, double arg3, double arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_1v8di4v(id target, void * sel, id arg1, BOOL arg2, double arg3, double arg4) {
  return ((_ProtocolTrampoline_21)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}
#undef BLOCKING_BLOCK_IMPL

#pragma clang diagnostic pop
