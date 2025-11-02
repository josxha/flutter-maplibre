#include <stdint.h>
#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "../ios/maplibre_ios/Sources/maplibre_ios/MapLibreIos.h"
#import "../MapLibre.h"

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


typedef id  (^_ProtocolTrampoline)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_1mbt9g9(id target, void * sel) {
  return ((_ProtocolTrampoline)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_1)(void * sel, id arg1, id arg2, id * arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_10z9f5k(id target, void * sel, id arg1, id arg2, id * arg3) {
  return ((_ProtocolTrampoline_1)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef NSItemProviderRepresentationVisibility  (^_ProtocolTrampoline_2)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSItemProviderRepresentationVisibility  _MapLibreFFi_protocolTrampoline_1ldqghh(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_2)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline)(id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _MapLibreFFi_wrapListenerBlock_pfv6jd(_ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline)(void * waiter, id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _MapLibreFFi_wrapBlockingBlock_pfv6jd(
    _BlockingTrampoline block, _BlockingTrampoline listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef id  (^_ProtocolTrampoline_3)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_1q0i84(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_3)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

Protocol* _MapLibreFFi_NSProgressReporting(void) { return @protocol(NSProgressReporting); }

typedef void  (^_ListenerTrampoline_1)(id arg0, struct _NSRange arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _MapLibreFFi_wrapListenerBlock_1a22wz(_ListenerTrampoline_1 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_1)(void * waiter, id arg0, struct _NSRange arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _MapLibreFFi_wrapBlockingBlock_1a22wz(
    _BlockingTrampoline_1 block, _BlockingTrampoline_1 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, struct _NSRange arg1, BOOL * arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef id  (^_ProtocolTrampoline_4)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_xr62hr(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_4)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_5)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _MapLibreFFi_protocolTrampoline_e3qsqz(id target, void * sel) {
  return ((_ProtocolTrampoline_5)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_2)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _MapLibreFFi_wrapListenerBlock_18v1jvf(_ListenerTrampoline_2 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_2)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _MapLibreFFi_wrapBlockingBlock_18v1jvf(
    _BlockingTrampoline_2 block, _BlockingTrampoline_2 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_6)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_18v1jvf(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_6)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_3)(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _MapLibreFFi_wrapListenerBlock_lmc3p5(_ListenerTrampoline_3 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_3)(void * waiter, id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _MapLibreFFi_wrapBlockingBlock_lmc3p5(
    _BlockingTrampoline_3 block, _BlockingTrampoline_3 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
  });
}

Protocol* _MapLibreFFi_NSTextAttachmentLayout(void) { return @protocol(NSTextAttachmentLayout); }

Protocol* _MapLibreFFi_CAMediaTiming(void) { return @protocol(CAMediaTiming); }

Protocol* _MapLibreFFi_CAAction(void) { return @protocol(CAAction); }

Protocol* _MapLibreFFi_CALayerDelegate(void) { return @protocol(CALayerDelegate); }

Protocol* _MapLibreFFi_UIAccessibilityIdentification(void) { return @protocol(UIAccessibilityIdentification); }

Protocol* _MapLibreFFi_UIMenuLeaf(void) { return @protocol(UIMenuLeaf); }

Protocol* _MapLibreFFi_UIPasteConfigurationSupporting(void) { return @protocol(UIPasteConfigurationSupporting); }

Protocol* _MapLibreFFi_UIUserActivityRestoring(void) { return @protocol(UIUserActivityRestoring); }

Protocol* _MapLibreFFi_UIResponderStandardEditActions(void) { return @protocol(UIResponderStandardEditActions); }

Protocol* _MapLibreFFi_UIMenuBuilder(void) { return @protocol(UIMenuBuilder); }

typedef void  (^_ListenerTrampoline_4)(id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _MapLibreFFi_wrapListenerBlock_xtuoz7(_ListenerTrampoline_4 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0));
  };
}

typedef void  (^_BlockingTrampoline_4)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _MapLibreFFi_wrapBlockingBlock_xtuoz7(
    _BlockingTrampoline_4 block, _BlockingTrampoline_4 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0));
  });
}

typedef void  (^_ListenerTrampoline_5)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _MapLibreFFi_wrapListenerBlock_1l4hxwm(_ListenerTrampoline_5 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, objc_retainBlock(arg1));
  };
}

typedef void  (^_BlockingTrampoline_5)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _MapLibreFFi_wrapBlockingBlock_1l4hxwm(
    _BlockingTrampoline_5 block, _BlockingTrampoline_5 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, objc_retainBlock(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, objc_retainBlock(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_7)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_1l4hxwm(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_7)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

Protocol* _MapLibreFFi_UIAppearanceContainer(void) { return @protocol(UIAppearanceContainer); }

typedef id  (^_ProtocolTrampoline_8)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_zi5eed(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_8)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGPoint  (^_ProtocolTrampoline_9)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _MapLibreFFi_protocolTrampoline_7ohnx8(id target, void * sel) {
  return ((_ProtocolTrampoline_9)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_6)(void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _MapLibreFFi_wrapListenerBlock_1bktu2(_ListenerTrampoline_6 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGPoint arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_6)(void * waiter, void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _MapLibreFFi_wrapBlockingBlock_1bktu2(
    _BlockingTrampoline_6 block, _BlockingTrampoline_6 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGPoint arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_10)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_1bktu2(id target, void * sel, struct CGPoint arg1) {
  return ((_ProtocolTrampoline_10)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGRect  (^_ProtocolTrampoline_11)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _MapLibreFFi_protocolTrampoline_1c3uc0w(id target, void * sel) {
  return ((_ProtocolTrampoline_11)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGAffineTransform  (^_ProtocolTrampoline_12)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGAffineTransform  _MapLibreFFi_protocolTrampoline_8o6he9(id target, void * sel) {
  return ((_ProtocolTrampoline_12)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_7)(void * arg0, struct CGAffineTransform arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _MapLibreFFi_wrapListenerBlock_1lznlw3(_ListenerTrampoline_7 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGAffineTransform arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_7)(void * waiter, void * arg0, struct CGAffineTransform arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _MapLibreFFi_wrapBlockingBlock_1lznlw3(
    _BlockingTrampoline_7 block, _BlockingTrampoline_7 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGAffineTransform arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_13)(void * sel, struct CGAffineTransform arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_1lznlw3(id target, void * sel, struct CGAffineTransform arg1) {
  return ((_ProtocolTrampoline_13)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef UIDynamicItemCollisionBoundsType  (^_ProtocolTrampoline_14)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIDynamicItemCollisionBoundsType  _MapLibreFFi_protocolTrampoline_ku69ws(id target, void * sel) {
  return ((_ProtocolTrampoline_14)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

Protocol* _MapLibreFFi_UICoordinateSpace(void) { return @protocol(UICoordinateSpace); }

typedef struct CGPoint  (^_ProtocolTrampoline_15)(void * sel, struct CGPoint arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _MapLibreFFi_protocolTrampoline_17ipln5(id target, void * sel, struct CGPoint arg1, id arg2) {
  return ((_ProtocolTrampoline_15)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGRect  (^_ProtocolTrampoline_16)(void * sel, struct CGRect arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _MapLibreFFi_protocolTrampoline_1sh7l9z(id target, void * sel, struct CGRect arg1, id arg2) {
  return ((_ProtocolTrampoline_16)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UIFocusItemDeferralMode  (^_ProtocolTrampoline_17)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIFocusItemDeferralMode  _MapLibreFFi_protocolTrampoline_1qeotwu(id target, void * sel) {
  return ((_ProtocolTrampoline_17)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

Protocol* _MapLibreFFi_UIFocusEnvironment(void) { return @protocol(UIFocusEnvironment); }

Protocol* _MapLibreFFi_UIFocusItemContainer(void) { return @protocol(UIFocusItemContainer); }

typedef void  (^_ListenerTrampoline_8)(void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _MapLibreFFi_wrapListenerBlock_ovsamd(_ListenerTrampoline_8 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_8)(void * waiter, void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _MapLibreFFi_wrapBlockingBlock_ovsamd(
    _BlockingTrampoline_8 block, _BlockingTrampoline_8 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ProtocolTrampoline_18)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_ovsamd(id target, void * sel) {
  return ((_ProtocolTrampoline_18)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_19)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _MapLibreFFi_protocolTrampoline_3su7tt(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_19)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_9)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _MapLibreFFi_wrapListenerBlock_fjrv01(_ListenerTrampoline_9 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_9)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _MapLibreFFi_wrapBlockingBlock_fjrv01(
    _BlockingTrampoline_9 block, _BlockingTrampoline_9 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_20)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_fjrv01(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_20)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_21)(void * sel, struct CGRect arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_12thpau(id target, void * sel, struct CGRect arg1) {
  return ((_ProtocolTrampoline_21)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_10)(void * arg0, id arg1, struct CGContext * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _MapLibreFFi_wrapListenerBlock_qvcerx(_ListenerTrampoline_10 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct CGContext * arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_10)(void * waiter, void * arg0, id arg1, struct CGContext * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _MapLibreFFi_wrapBlockingBlock_qvcerx(
    _BlockingTrampoline_10 block, _BlockingTrampoline_10 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct CGContext * arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_22)(void * sel, id arg1, struct CGContext * arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_qvcerx(id target, void * sel, id arg1, struct CGContext * arg2) {
  return ((_ProtocolTrampoline_22)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

Protocol* _MapLibreFFi_UITraitOverrides(void) { return @protocol(UITraitOverrides); }

typedef void  (^_ListenerTrampoline_11)();
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _MapLibreFFi_wrapListenerBlock_1pl9qdv(_ListenerTrampoline_11 block) NS_RETURNS_RETAINED {
  return ^void() {
    objc_retainBlock(block);
    block();
  };
}

typedef void  (^_BlockingTrampoline_11)(void * waiter);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _MapLibreFFi_wrapBlockingBlock_1pl9qdv(
    _BlockingTrampoline_11 block, _BlockingTrampoline_11 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(), {
    objc_retainBlock(block);
    block(nil);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter);
  });
}

typedef void  (^_ListenerTrampoline_12)(BOOL arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _MapLibreFFi_wrapListenerBlock_1s56lr9(_ListenerTrampoline_12 block) NS_RETURNS_RETAINED {
  return ^void(BOOL arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_12)(void * waiter, BOOL arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _MapLibreFFi_wrapBlockingBlock_1s56lr9(
    _BlockingTrampoline_12 block, _BlockingTrampoline_12 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(BOOL arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

Protocol* _MapLibreFFi_UITraitChangeObservable(void) { return @protocol(UITraitChangeObservable); }

Protocol* _MapLibreFFi_UIInteraction(void) { return @protocol(UIInteraction); }

typedef struct UIEdgeInsets  (^_ProtocolTrampoline_23)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct UIEdgeInsets  _MapLibreFFi_protocolTrampoline_1rtilx3(id target, void * sel) {
  return ((_ProtocolTrampoline_23)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

Protocol* _MapLibreFFi_UILargeContentViewerItem(void) { return @protocol(UILargeContentViewerItem); }

Protocol* _MapLibreFFi_UIHoverEffect(void) { return @protocol(UIHoverEffect); }

typedef struct CGRect  (^_ProtocolTrampoline_24)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _MapLibreFFi_protocolTrampoline_szn7s6(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_24)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

Protocol* _MapLibreFFi_UIPopoverPresentationControllerSourceItem(void) { return @protocol(UIPopoverPresentationControllerSourceItem); }

Protocol* _MapLibreFFi_UIAppearance(void) { return @protocol(UIAppearance); }

Protocol* _MapLibreFFi_UIDynamicItem(void) { return @protocol(UIDynamicItem); }

Protocol* _MapLibreFFi_UITraitEnvironment(void) { return @protocol(UITraitEnvironment); }

Protocol* _MapLibreFFi_UIFocusItem(void) { return @protocol(UIFocusItem); }

Protocol* _MapLibreFFi_UIActivityItemsConfigurationReading(void) { return @protocol(UIActivityItemsConfigurationReading); }

Protocol* _MapLibreFFi_UIActivityItemsConfigurationProviding(void) { return @protocol(UIActivityItemsConfigurationProviding); }

Protocol* _MapLibreFFi_UIMutableTraits(void) { return @protocol(UIMutableTraits); }

typedef UIMenuElementAttributes  (^_ProtocolTrampoline_25)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIMenuElementAttributes  _MapLibreFFi_protocolTrampoline_1tmn9mr(id target, void * sel) {
  return ((_ProtocolTrampoline_25)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_13)(void * arg0, UIMenuElementAttributes arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _MapLibreFFi_wrapListenerBlock_1lmpkp(_ListenerTrampoline_13 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIMenuElementAttributes arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_13)(void * waiter, void * arg0, UIMenuElementAttributes arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _MapLibreFFi_wrapBlockingBlock_1lmpkp(
    _BlockingTrampoline_13 block, _BlockingTrampoline_13 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIMenuElementAttributes arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_26)(void * sel, UIMenuElementAttributes arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_1lmpkp(id target, void * sel, UIMenuElementAttributes arg1) {
  return ((_ProtocolTrampoline_26)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef UIMenuElementState  (^_ProtocolTrampoline_27)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIMenuElementState  _MapLibreFFi_protocolTrampoline_gvl1rz(id target, void * sel) {
  return ((_ProtocolTrampoline_27)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_14)(void * arg0, UIMenuElementState arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _MapLibreFFi_wrapListenerBlock_1mm4s9d(_ListenerTrampoline_14 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIMenuElementState arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_14)(void * waiter, void * arg0, UIMenuElementState arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _MapLibreFFi_wrapBlockingBlock_1mm4s9d(
    _BlockingTrampoline_14 block, _BlockingTrampoline_14 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIMenuElementState arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_28)(void * sel, UIMenuElementState arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_1mm4s9d(id target, void * sel, UIMenuElementState arg1) {
  return ((_ProtocolTrampoline_28)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

Protocol* _MapLibreFFi_UITextInputDelegate(void) { return @protocol(UITextInputDelegate); }

Protocol* _MapLibreFFi_UIContentSizeCategoryAdjusting(void) { return @protocol(UIContentSizeCategoryAdjusting); }

Protocol* _MapLibreFFi_UILetterformAwareAdjusting(void) { return @protocol(UILetterformAwareAdjusting); }

Protocol* _MapLibreFFi_UIContentContainer(void) { return @protocol(UIContentContainer); }

typedef void  (^_ListenerTrampoline_15)(void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _MapLibreFFi_wrapListenerBlock_10lndml(_ListenerTrampoline_15 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, BOOL arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_15)(void * waiter, void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _MapLibreFFi_wrapBlockingBlock_10lndml(
    _BlockingTrampoline_15 block, _BlockingTrampoline_15 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, BOOL arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_29)(void * sel, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_10lndml(id target, void * sel, BOOL arg1) {
  return ((_ProtocolTrampoline_29)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

Protocol* _MapLibreFFi_UIAccessibilityContentSizeCategoryImageAdjusting(void) { return @protocol(UIAccessibilityContentSizeCategoryImageAdjusting); }

Protocol* _MapLibreFFi_UIGestureRecognizerDelegate(void) { return @protocol(UIGestureRecognizerDelegate); }

Protocol* _MapLibreFFi_UIConfigurationState(void) { return @protocol(UIConfigurationState); }

Protocol* _MapLibreFFi_UIContentConfiguration(void) { return @protocol(UIContentConfiguration); }

typedef BOOL  (^_ProtocolTrampoline_30)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _MapLibreFFi_protocolTrampoline_2n06mv(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_30)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

Protocol* _MapLibreFFi_UIShapeProvider(void) { return @protocol(UIShapeProvider); }

Protocol* _MapLibreFFi_CTAdaptiveImageProviding(void) { return @protocol(CTAdaptiveImageProviding); }

typedef void  (^_ListenerTrampoline_16)(id arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _MapLibreFFi_wrapListenerBlock_6p7ndb(_ListenerTrampoline_16 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1);
  };
}

typedef void  (^_BlockingTrampoline_16)(void * waiter, id arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _MapLibreFFi_wrapBlockingBlock_6p7ndb(
    _BlockingTrampoline_16 block, _BlockingTrampoline_16 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, BOOL arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  });
}

typedef void  (^_ListenerTrampoline_17)(id arg0, BOOL arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _MapLibreFFi_wrapListenerBlock_13x5jor(_ListenerTrampoline_17 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_17)(void * waiter, id arg0, BOOL arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _MapLibreFFi_wrapBlockingBlock_13x5jor(
    _BlockingTrampoline_17 block, _BlockingTrampoline_17 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, BOOL arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  });
}

Protocol* _MapLibreFFi_MLNStylable(void) { return @protocol(MLNStylable); }

Protocol* _MapLibreFFi_MLNMapViewDelegate(void) { return @protocol(MLNMapViewDelegate); }

Protocol* _MapLibreFFi_MLNLocationManager(void) { return @protocol(MLNLocationManager); }

typedef struct CLLocationCoordinate2D  (^_ProtocolTrampoline_31)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CLLocationCoordinate2D  _MapLibreFFi_protocolTrampoline_neuenc(id target, void * sel) {
  return ((_ProtocolTrampoline_31)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

Protocol* _MapLibreFFi_MLNAnnotation(void) { return @protocol(MLNAnnotation); }

typedef struct MLNCoordinateBounds  (^_ProtocolTrampoline_32)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct MLNCoordinateBounds  _MapLibreFFi_protocolTrampoline_1fkc0ji(id target, void * sel) {
  return ((_ProtocolTrampoline_32)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_33)(void * sel, struct MLNCoordinateBounds arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _MapLibreFFi_protocolTrampoline_krbldm(id target, void * sel, struct MLNCoordinateBounds arg1) {
  return ((_ProtocolTrampoline_33)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

Protocol* _MapLibreFFi_MLNOverlay(void) { return @protocol(MLNOverlay); }

typedef unsigned long  (^_ProtocolTrampoline_34)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _MapLibreFFi_protocolTrampoline_1ckyi24(id target, void * sel) {
  return ((_ProtocolTrampoline_34)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

Protocol* _MapLibreFFi_MLNFeature(void) { return @protocol(MLNFeature); }

Protocol* _MapLibreFFi_MLNCluster(void) { return @protocol(MLNCluster); }

typedef id  (^_ProtocolTrampoline_35)(void * sel, unsigned long arg1, unsigned long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_fclj7c(id target, void * sel, unsigned long arg1, unsigned long arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_35)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_36)(void * sel, struct MLNCoordinateBounds arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_129i16p(id target, void * sel, struct MLNCoordinateBounds arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_36)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

Protocol* _MapLibreFFi_MLNComputedShapeSourceDataSource(void) { return @protocol(MLNComputedShapeSourceDataSource); }

Protocol* _MapLibreFFi_MLNOfflineRegion(void) { return @protocol(MLNOfflineRegion); }

typedef void  (^_ListenerTrampoline_18)(id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _MapLibreFFi_wrapListenerBlock_r8gdi7(_ListenerTrampoline_18 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_18)(void * waiter, id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _MapLibreFFi_wrapBlockingBlock_r8gdi7(
    _BlockingTrampoline_18 block, _BlockingTrampoline_18 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef id  (^_ProtocolTrampoline_37)(void * sel, id arg1, MLNResourceKind arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_1fy0zqa(id target, void * sel, id arg1, MLNResourceKind arg2, id arg3) {
  return ((_ProtocolTrampoline_37)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

Protocol* _MapLibreFFi_MLNOfflineStorageDelegate(void) { return @protocol(MLNOfflineStorageDelegate); }
#undef BLOCKING_BLOCK_IMPL

#pragma clang diagnostic pop
