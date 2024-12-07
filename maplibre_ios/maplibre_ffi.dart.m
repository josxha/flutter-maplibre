#include <stdint.h>
#import <AVFAudio/AVAudioPlayer.h>

#if !__has_feature(objc_arc)
#error "This file must be compiled with ARC enabled"
#endif

id objc_retain(id);
id objc_retainBlock(id);

typedef void  (^_ListenerTrampoline)();
_ListenerTrampoline _MapLibreFFi_wrapListenerBlock_1pl9qdv(_ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void() {
    objc_retainBlock(block);
    block();
  };
}

typedef void  (^_ListenerTrampoline1)(struct __CFRunLoopObserver * arg0, CFRunLoopActivity arg1);
_ListenerTrampoline1 _MapLibreFFi_wrapListenerBlock_tg5tbv(_ListenerTrampoline1 block) NS_RETURNS_RETAINED {
  return ^void(struct __CFRunLoopObserver * arg0, CFRunLoopActivity arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_ListenerTrampoline2)(struct __CFRunLoopTimer * arg0);
_ListenerTrampoline2 _MapLibreFFi_wrapListenerBlock_1dqvvol(_ListenerTrampoline2 block) NS_RETURNS_RETAINED {
  return ^void(struct __CFRunLoopTimer * arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_ListenerTrampoline3)(void * arg0);
_ListenerTrampoline3 _MapLibreFFi_wrapListenerBlock_ovsamd(_ListenerTrampoline3 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

Protocol* _MapLibreFFi_NSObject() { return @protocol(NSObject); }

Protocol* _MapLibreFFi_OS_os_workgroup_interval() { return @protocol(OS_os_workgroup_interval); }

Protocol* _MapLibreFFi_OS_os_workgroup_parallel() { return @protocol(OS_os_workgroup_parallel); }

Protocol* _MapLibreFFi_OS_dispatch_object() { return @protocol(OS_dispatch_object); }

Protocol* _MapLibreFFi_OS_dispatch_queue() { return @protocol(OS_dispatch_queue); }

Protocol* _MapLibreFFi_OS_dispatch_queue_global() { return @protocol(OS_dispatch_queue_global); }

Protocol* _MapLibreFFi_OS_dispatch_queue_serial_executor() { return @protocol(OS_dispatch_queue_serial_executor); }

Protocol* _MapLibreFFi_OS_dispatch_queue_serial() { return @protocol(OS_dispatch_queue_serial); }

Protocol* _MapLibreFFi_OS_dispatch_queue_main() { return @protocol(OS_dispatch_queue_main); }

Protocol* _MapLibreFFi_OS_dispatch_queue_concurrent() { return @protocol(OS_dispatch_queue_concurrent); }

typedef void  (^_ListenerTrampoline4)(size_t arg0);
_ListenerTrampoline4 _MapLibreFFi_wrapListenerBlock_6enxqz(_ListenerTrampoline4 block) NS_RETURNS_RETAINED {
  return ^void(size_t arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

Protocol* _MapLibreFFi_OS_dispatch_queue_attr() { return @protocol(OS_dispatch_queue_attr); }

Protocol* _MapLibreFFi_OS_dispatch_source() { return @protocol(OS_dispatch_source); }

Protocol* _MapLibreFFi_OS_dispatch_group() { return @protocol(OS_dispatch_group); }

Protocol* _MapLibreFFi_OS_dispatch_semaphore() { return @protocol(OS_dispatch_semaphore); }

Protocol* _MapLibreFFi_OS_dispatch_data() { return @protocol(OS_dispatch_data); }

typedef void  (^_ListenerTrampoline5)(id arg0, int arg1);
_ListenerTrampoline5 _MapLibreFFi_wrapListenerBlock_qxvyq2(_ListenerTrampoline5 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, int arg1) {
    objc_retainBlock(block);
    block(objc_retain(arg0), arg1);
  };
}

Protocol* _MapLibreFFi_OS_dispatch_io() { return @protocol(OS_dispatch_io); }

typedef void  (^_ListenerTrampoline6)(int arg0);
_ListenerTrampoline6 _MapLibreFFi_wrapListenerBlock_9o8504(_ListenerTrampoline6 block) NS_RETURNS_RETAINED {
  return ^void(int arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_ListenerTrampoline7)(BOOL arg0, id arg1, int arg2);
_ListenerTrampoline7 _MapLibreFFi_wrapListenerBlock_12a4qua(_ListenerTrampoline7 block) NS_RETURNS_RETAINED {
  return ^void(BOOL arg0, id arg1, int arg2) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), arg2);
  };
}

Protocol* _MapLibreFFi_OS_dispatch_workloop() { return @protocol(OS_dispatch_workloop); }

Protocol* _MapLibreFFi_NSCopying() { return @protocol(NSCopying); }

Protocol* _MapLibreFFi_NSMutableCopying() { return @protocol(NSMutableCopying); }

typedef void  (^_ListenerTrampoline8)(void * arg0, id arg1);
_ListenerTrampoline8 _MapLibreFFi_wrapListenerBlock_wjovn7(_ListenerTrampoline8 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1));
  };
}

Protocol* _MapLibreFFi_NSCoding() { return @protocol(NSCoding); }

Protocol* _MapLibreFFi_NSSecureCoding() { return @protocol(NSSecureCoding); }

Protocol* _MapLibreFFi_NSDiscardableContent() { return @protocol(NSDiscardableContent); }

Protocol* _MapLibreFFi_NSFastEnumeration() { return @protocol(NSFastEnumeration); }

typedef void  (^_ListenerTrampoline9)(id arg0, unsigned long arg1, BOOL * arg2);
_ListenerTrampoline9 _MapLibreFFi_wrapListenerBlock_16ko9u(_ListenerTrampoline9 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, unsigned long arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void  (^_ListenerTrampoline10)(id arg0, id arg1);
_ListenerTrampoline10 _MapLibreFFi_wrapListenerBlock_wjvic9(_ListenerTrampoline10 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

Protocol* _MapLibreFFi_NSItemProviderWriting() { return @protocol(NSItemProviderWriting); }

Protocol* _MapLibreFFi_NSItemProviderReading() { return @protocol(NSItemProviderReading); }

typedef void  (^_ListenerTrampoline11)(id arg0, id arg1, id arg2);
_ListenerTrampoline11 _MapLibreFFi_wrapListenerBlock_1j2nt86(_ListenerTrampoline11 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(objc_retainBlock(arg0), objc_retain(arg1), objc_retain(arg2));
  };
}

typedef void  (^_ListenerTrampoline12)(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3);
_ListenerTrampoline12 _MapLibreFFi_wrapListenerBlock_8wbg7l(_ListenerTrampoline12 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3) {
    objc_retainBlock(block);
    block(objc_retain(arg0), arg1, arg2, arg3);
  };
}

typedef void  (^_ListenerTrampoline13)(id arg0, BOOL * arg1);
_ListenerTrampoline13 _MapLibreFFi_wrapListenerBlock_148br51(_ListenerTrampoline13 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL * arg1) {
    objc_retainBlock(block);
    block(objc_retain(arg0), arg1);
  };
}

typedef void  (^_ListenerTrampoline14)(unsigned short * arg0, unsigned long arg1);
_ListenerTrampoline14 _MapLibreFFi_wrapListenerBlock_vhbh5h(_ListenerTrampoline14 block) NS_RETURNS_RETAINED {
  return ^void(unsigned short * arg0, unsigned long arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_ListenerTrampoline15)(void * arg0, unsigned long arg1);
_ListenerTrampoline15 _MapLibreFFi_wrapListenerBlock_zuf90e(_ListenerTrampoline15 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, unsigned long arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_ListenerTrampoline16)(id arg0, id arg1, BOOL * arg2);
_ListenerTrampoline16 _MapLibreFFi_wrapListenerBlock_1krhfwz(_ListenerTrampoline16 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block(objc_retain(arg0), objc_retain(arg1), arg2);
  };
}

Protocol* _MapLibreFFi_NSProgressReporting() { return @protocol(NSProgressReporting); }

typedef void  (^_ListenerTrampoline17)(id arg0);
_ListenerTrampoline17 _MapLibreFFi_wrapListenerBlock_1jdvcbf(_ListenerTrampoline17 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block(objc_retain(arg0));
  };
}

typedef void  (^_ListenerTrampoline18)(id arg0, struct _NSRange arg1, BOOL * arg2);
_ListenerTrampoline18 _MapLibreFFi_wrapListenerBlock_6m62q3(_ListenerTrampoline18 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void  (^_ListenerTrampoline19)(BOOL arg0);
_ListenerTrampoline19 _MapLibreFFi_wrapListenerBlock_1s56lr9(_ListenerTrampoline19 block) NS_RETURNS_RETAINED {
  return ^void(BOOL arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_ListenerTrampoline20)(id arg0, BOOL arg1, BOOL * arg2);
_ListenerTrampoline20 _MapLibreFFi_wrapListenerBlock_1oof6ap(_ListenerTrampoline20 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void  (^_ListenerTrampoline21)(void * arg0, struct _NSRange arg1, BOOL * arg2);
_ListenerTrampoline21 _MapLibreFFi_wrapListenerBlock_1q8ia8l(_ListenerTrampoline21 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct _NSRange arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

Protocol* _MapLibreFFi_NSDecimalNumberBehaviors() { return @protocol(NSDecimalNumberBehaviors); }

typedef void  (^_ListenerTrampoline22)(void * arg0, id arg1, id arg2);
_ListenerTrampoline22 _MapLibreFFi_wrapListenerBlock_ao4xm9(_ListenerTrampoline22 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), objc_retain(arg2));
  };
}

Protocol* _MapLibreFFi_NSURLHandleClient() { return @protocol(NSURLHandleClient); }

Protocol* _MapLibreFFi_NSFileManagerDelegate() { return @protocol(NSFileManagerDelegate); }

Protocol* _MapLibreFFi_NSXPCProxyCreating() { return @protocol(NSXPCProxyCreating); }

typedef void  (^_ListenerTrampoline23)(void * arg0, id arg1, id arg2, id arg3);
_ListenerTrampoline23 _MapLibreFFi_wrapListenerBlock_1r3kn8f(_ListenerTrampoline23 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), objc_retain(arg2), objc_retain(arg3));
  };
}

Protocol* _MapLibreFFi_NSKeyedArchiverDelegate() { return @protocol(NSKeyedArchiverDelegate); }

Protocol* _MapLibreFFi_NSKeyedUnarchiverDelegate() { return @protocol(NSKeyedUnarchiverDelegate); }

Protocol* _MapLibreFFi_NSLocking() { return @protocol(NSLocking); }

Protocol* _MapLibreFFi_NSPortDelegate() { return @protocol(NSPortDelegate); }

typedef void  (^_ListenerTrampoline24)(void * arg0, void * arg1);
_ListenerTrampoline24 _MapLibreFFi_wrapListenerBlock_1037nh9(_ListenerTrampoline24 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, void * arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

Protocol* _MapLibreFFi_NSMachPortDelegate() { return @protocol(NSMachPortDelegate); }

typedef void  (^_ListenerTrampoline25)(id arg0, NSMatchingFlags arg1, BOOL * arg2);
_ListenerTrampoline25 _MapLibreFFi_wrapListenerBlock_udmuxq(_ListenerTrampoline25 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, NSMatchingFlags arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block(objc_retain(arg0), arg1, arg2);
  };
}

Protocol* _MapLibreFFi_NSURLAuthenticationChallengeSender() { return @protocol(NSURLAuthenticationChallengeSender); }

typedef void  (^_ListenerTrampoline26)(id arg0, id arg1, id arg2);
_ListenerTrampoline26 _MapLibreFFi_wrapListenerBlock_1hcfngn(_ListenerTrampoline26 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(objc_retain(arg0), objc_retain(arg1), objc_retain(arg2));
  };
}

Protocol* _MapLibreFFi_NSURLConnectionDelegate() { return @protocol(NSURLConnectionDelegate); }

typedef void  (^_ListenerTrampoline27)(void * arg0, id arg1, long arg2, long arg3, long arg4);
_ListenerTrampoline27 _MapLibreFFi_wrapListenerBlock_aqltch(_ListenerTrampoline27 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long arg2, long arg3, long arg4) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), arg2, arg3, arg4);
  };
}

Protocol* _MapLibreFFi_NSURLConnectionDataDelegate() { return @protocol(NSURLConnectionDataDelegate); }

typedef void  (^_ListenerTrampoline28)(void * arg0, id arg1, long long arg2, long long arg3, long long arg4);
_ListenerTrampoline28 _MapLibreFFi_wrapListenerBlock_1hy7lel(_ListenerTrampoline28 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long long arg2, long long arg3, long long arg4) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_ListenerTrampoline29)(void * arg0, id arg1, long long arg2, long long arg3);
_ListenerTrampoline29 _MapLibreFFi_wrapListenerBlock_1ryfp43(_ListenerTrampoline29 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long long arg2, long long arg3) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), arg2, arg3);
  };
}

Protocol* _MapLibreFFi_NSURLConnectionDownloadDelegate() { return @protocol(NSURLConnectionDownloadDelegate); }

typedef void  (^_ListenerTrampoline30)(struct __SecKey * arg0, struct __SecKey * arg1, struct __CFError * arg2);
_ListenerTrampoline30 _MapLibreFFi_wrapListenerBlock_1rz4y3(_ListenerTrampoline30 block) NS_RETURNS_RETAINED {
  return ^void(struct __SecKey * arg0, struct __SecKey * arg1, struct __CFError * arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_ListenerTrampoline31)(struct __SecTrust * arg0, SecTrustResultType arg1);
_ListenerTrampoline31 _MapLibreFFi_wrapListenerBlock_gwxhxt(_ListenerTrampoline31 block) NS_RETURNS_RETAINED {
  return ^void(struct __SecTrust * arg0, SecTrustResultType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_ListenerTrampoline32)(struct __SecTrust * arg0, BOOL arg1, struct __CFError * arg2);
_ListenerTrampoline32 _MapLibreFFi_wrapListenerBlock_k73ff5(_ListenerTrampoline32 block) NS_RETURNS_RETAINED {
  return ^void(struct __SecTrust * arg0, BOOL arg1, struct __CFError * arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_ListenerTrampoline33)(struct __CFError * arg0);
_ListenerTrampoline33 _MapLibreFFi_wrapListenerBlock_1kwz7d1(_ListenerTrampoline33 block) NS_RETURNS_RETAINED {
  return ^void(struct __CFError * arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_ListenerTrampoline34)(struct __CFArray * arg0, struct __CFError * arg1);
_ListenerTrampoline34 _MapLibreFFi_wrapListenerBlock_15ghdzk(_ListenerTrampoline34 block) NS_RETURNS_RETAINED {
  return ^void(struct __CFArray * arg0, struct __CFError * arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

Protocol* _MapLibreFFi_OS_sec_object() { return @protocol(OS_sec_object); }

Protocol* _MapLibreFFi_OS_sec_trust() { return @protocol(OS_sec_trust); }

Protocol* _MapLibreFFi_OS_sec_identity() { return @protocol(OS_sec_identity); }

Protocol* _MapLibreFFi_OS_sec_certificate() { return @protocol(OS_sec_certificate); }

Protocol* _MapLibreFFi_OS_sec_protocol_metadata() { return @protocol(OS_sec_protocol_metadata); }

typedef void  (^_ListenerTrampoline35)(uint16_t arg0);
_ListenerTrampoline35 _MapLibreFFi_wrapListenerBlock_15f11yh(_ListenerTrampoline35 block) NS_RETURNS_RETAINED {
  return ^void(uint16_t arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

Protocol* _MapLibreFFi_OS_sec_protocol_options() { return @protocol(OS_sec_protocol_options); }

typedef void  (^_ListenerTrampoline36)(id arg0, id arg1, id arg2);
_ListenerTrampoline36 _MapLibreFFi_wrapListenerBlock_91c9gi(_ListenerTrampoline36 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(objc_retain(arg0), objc_retain(arg1), objc_retainBlock(arg2));
  };
}

typedef void  (^_ListenerTrampoline37)(id arg0, id arg1);
_ListenerTrampoline37 _MapLibreFFi_wrapListenerBlock_14pxqbs(_ListenerTrampoline37 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block(objc_retain(arg0), objc_retainBlock(arg1));
  };
}

typedef void  (^_ListenerTrampoline38)(int arg0, AuthorizationItemSet * arg1);
_ListenerTrampoline38 _MapLibreFFi_wrapListenerBlock_l3f29g(_ListenerTrampoline38 block) NS_RETURNS_RETAINED {
  return ^void(int arg0, AuthorizationItemSet * arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

Protocol* _MapLibreFFi_OS_xpc_object() { return @protocol(OS_xpc_object); }

Protocol* _MapLibreFFi_OS_xpc_session() { return @protocol(OS_xpc_session); }

Protocol* _MapLibreFFi_OS_xpc_listener() { return @protocol(OS_xpc_listener); }

typedef void  (^_ListenerTrampoline39)(void * arg0, struct __CFError * arg1, unsigned char arg2);
_ListenerTrampoline39 _MapLibreFFi_wrapListenerBlock_b3tf6o(_ListenerTrampoline39 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct __CFError * arg1, unsigned char arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_ListenerTrampoline40)(unsigned char arg0, unsigned long long arg1, struct __CFError * arg2);
_ListenerTrampoline40 _MapLibreFFi_wrapListenerBlock_115kkcp(_ListenerTrampoline40 block) NS_RETURNS_RETAINED {
  return ^void(unsigned char arg0, unsigned long long arg1, struct __CFError * arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_ListenerTrampoline41)(void * arg0, id arg1, id arg2, NSURLCacheStoragePolicy arg3);
_ListenerTrampoline41 _MapLibreFFi_wrapListenerBlock_6gs82k(_ListenerTrampoline41 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, NSURLCacheStoragePolicy arg3) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), objc_retain(arg2), arg3);
  };
}

Protocol* _MapLibreFFi_NSURLProtocolClient() { return @protocol(NSURLProtocolClient); }

typedef void  (^_ListenerTrampoline42)(void * arg0, id arg1, id arg2, id arg3, id arg4);
_ListenerTrampoline42 _MapLibreFFi_wrapListenerBlock_62mtml(_ListenerTrampoline42 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), objc_retain(arg2), objc_retain(arg3), objc_retain(arg4));
  };
}

typedef void  (^_ListenerTrampoline43)(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
_ListenerTrampoline43 _MapLibreFFi_wrapListenerBlock_aigx7v(_ListenerTrampoline43 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), objc_retain(arg2), objc_retain(arg3), objc_retain(arg4), objc_retain(arg5));
  };
}

Protocol* _MapLibreFFi_NSXMLParserDelegate() { return @protocol(NSXMLParserDelegate); }

Protocol* _MapLibreFFi_NSXPCListenerDelegate() { return @protocol(NSXPCListenerDelegate); }

Protocol* _MapLibreFFi_NSCacheDelegate() { return @protocol(NSCacheDelegate); }

Protocol* _MapLibreFFi_NSExtensionRequestHandling() { return @protocol(NSExtensionRequestHandling); }

typedef void  (^_ListenerTrampoline44)(id arg0);
_ListenerTrampoline44 _MapLibreFFi_wrapListenerBlock_f167m6(_ListenerTrampoline44 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block(objc_retainBlock(arg0));
  };
}

typedef void  (^_ListenerTrampoline45)(void * arg0, id arg1);
_ListenerTrampoline45 _MapLibreFFi_wrapListenerBlock_1l4hxwm(_ListenerTrampoline45 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, objc_retainBlock(arg1));
  };
}

typedef void  (^_ListenerTrampoline46)(void * arg0, id arg1, id arg2);
_ListenerTrampoline46 _MapLibreFFi_wrapListenerBlock_15qx22o(_ListenerTrampoline46 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), objc_retainBlock(arg2));
  };
}

Protocol* _MapLibreFFi_NSFilePresenter() { return @protocol(NSFilePresenter); }

Protocol* _MapLibreFFi_NSMetadataQueryDelegate() { return @protocol(NSMetadataQueryDelegate); }

Protocol* _MapLibreFFi_NSNetServiceDelegate() { return @protocol(NSNetServiceDelegate); }

typedef void  (^_ListenerTrampoline47)(void * arg0, id arg1, id arg2, BOOL arg3);
_ListenerTrampoline47 _MapLibreFFi_wrapListenerBlock_10cj955(_ListenerTrampoline47 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, BOOL arg3) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), objc_retain(arg2), arg3);
  };
}

Protocol* _MapLibreFFi_NSNetServiceBrowserDelegate() { return @protocol(NSNetServiceBrowserDelegate); }

typedef void  (^_ListenerTrampoline48)(id arg0, BOOL arg1, id arg2);
_ListenerTrampoline48 _MapLibreFFi_wrapListenerBlock_1u2lqz9(_ListenerTrampoline48 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1, id arg2) {
    objc_retainBlock(block);
    block(objc_retain(arg0), arg1, objc_retain(arg2));
  };
}

typedef void  (^_ListenerTrampoline49)(NSURLSessionAuthChallengeDisposition arg0, id arg1);
_ListenerTrampoline49 _MapLibreFFi_wrapListenerBlock_37btrl(_ListenerTrampoline49 block) NS_RETURNS_RETAINED {
  return ^void(NSURLSessionAuthChallengeDisposition arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1));
  };
}

typedef void  (^_ListenerTrampoline50)(void * arg0, id arg1, id arg2, id arg3);
_ListenerTrampoline50 _MapLibreFFi_wrapListenerBlock_12nszru(_ListenerTrampoline50 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), objc_retain(arg2), objc_retainBlock(arg3));
  };
}

Protocol* _MapLibreFFi_NSURLSessionDelegate() { return @protocol(NSURLSessionDelegate); }

typedef void  (^_ListenerTrampoline51)(NSURLSessionDelayedRequestDisposition arg0, id arg1);
_ListenerTrampoline51 _MapLibreFFi_wrapListenerBlock_mn1xu3(_ListenerTrampoline51 block) NS_RETURNS_RETAINED {
  return ^void(NSURLSessionDelayedRequestDisposition arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1));
  };
}

typedef void  (^_ListenerTrampoline52)(void * arg0, id arg1, id arg2, id arg3, id arg4);
_ListenerTrampoline52 _MapLibreFFi_wrapListenerBlock_1f43wec(_ListenerTrampoline52 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), objc_retain(arg2), objc_retain(arg3), objc_retainBlock(arg4));
  };
}

typedef void  (^_ListenerTrampoline53)(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
_ListenerTrampoline53 _MapLibreFFi_wrapListenerBlock_13vswqm(_ListenerTrampoline53 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), objc_retain(arg2), objc_retain(arg3), objc_retain(arg4), objc_retainBlock(arg5));
  };
}

typedef void  (^_ListenerTrampoline54)(void * arg0, id arg1, id arg2, int64_t arg3, id arg4);
_ListenerTrampoline54 _MapLibreFFi_wrapListenerBlock_qm01og(_ListenerTrampoline54 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, int64_t arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), objc_retain(arg2), arg3, objc_retainBlock(arg4));
  };
}

typedef void  (^_ListenerTrampoline55)(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5);
_ListenerTrampoline55 _MapLibreFFi_wrapListenerBlock_1uuez7b(_ListenerTrampoline55 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), objc_retain(arg2), arg3, arg4, arg5);
  };
}

Protocol* _MapLibreFFi_NSURLSessionTaskDelegate() { return @protocol(NSURLSessionTaskDelegate); }

typedef void  (^_ListenerTrampoline56)(NSURLSessionResponseDisposition arg0);
_ListenerTrampoline56 _MapLibreFFi_wrapListenerBlock_16sve1d(_ListenerTrampoline56 block) NS_RETURNS_RETAINED {
  return ^void(NSURLSessionResponseDisposition arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

Protocol* _MapLibreFFi_NSURLSessionDataDelegate() { return @protocol(NSURLSessionDataDelegate); }

typedef void  (^_ListenerTrampoline57)(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4);
_ListenerTrampoline57 _MapLibreFFi_wrapListenerBlock_9qxjkl(_ListenerTrampoline57 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), objc_retain(arg2), arg3, arg4);
  };
}

Protocol* _MapLibreFFi_NSURLSessionDownloadDelegate() { return @protocol(NSURLSessionDownloadDelegate); }

Protocol* _MapLibreFFi_NSURLSessionStreamDelegate() { return @protocol(NSURLSessionStreamDelegate); }

typedef void  (^_ListenerTrampoline58)(void * arg0, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4);
_ListenerTrampoline58 _MapLibreFFi_wrapListenerBlock_3lo3bb(_ListenerTrampoline58 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), objc_retain(arg2), arg3, objc_retain(arg4));
  };
}

Protocol* _MapLibreFFi_NSURLSessionWebSocketDelegate() { return @protocol(NSURLSessionWebSocketDelegate); }

Protocol* _MapLibreFFi_NSUserActivityDelegate() { return @protocol(NSUserActivityDelegate); }

typedef void  (^_ListenerTrampoline59)(NSBackgroundActivityResult arg0);
_ListenerTrampoline59 _MapLibreFFi_wrapListenerBlock_10ssdng(_ListenerTrampoline59 block) NS_RETURNS_RETAINED {
  return ^void(NSBackgroundActivityResult arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

Protocol* _MapLibreFFi_NSConnectionDelegate() { return @protocol(NSConnectionDelegate); }

typedef void  (^_ListenerTrampoline60)(void * arg0, id arg1, id arg2, long long arg3);
_ListenerTrampoline60 _MapLibreFFi_wrapListenerBlock_19fjbcn(_ListenerTrampoline60 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, long long arg3) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), objc_retain(arg2), arg3);
  };
}

typedef void  (^_ListenerTrampoline61)(void * arg0, id arg1, unsigned long arg2);
_ListenerTrampoline61 _MapLibreFFi_wrapListenerBlock_1e4ttx8(_ListenerTrampoline61 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), arg2);
  };
}

Protocol* _MapLibreFFi_NSURLDownloadDelegate() { return @protocol(NSURLDownloadDelegate); }

typedef void  (^_ListenerTrampoline62)(void * arg0, id arg1, unsigned long arg2, id arg3, id arg4, id arg5);
_ListenerTrampoline62 _MapLibreFFi_wrapListenerBlock_5aw8mg(_ListenerTrampoline62 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2, id arg3, id arg4, id arg5) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), arg2, objc_retain(arg3), objc_retain(arg4), objc_retain(arg5));
  };
}

Protocol* _MapLibreFFi_NSSpellServerDelegate() { return @protocol(NSSpellServerDelegate); }

Protocol* _MapLibreFFi_NSUserNotificationCenterDelegate() { return @protocol(NSUserNotificationCenterDelegate); }

typedef void  (^_ListenerTrampoline63)(struct CGPathElement * arg0);
_ListenerTrampoline63 _MapLibreFFi_wrapListenerBlock_1ctgxtl(_ListenerTrampoline63 block) NS_RETURNS_RETAINED {
  return ^void(struct CGPathElement * arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_ListenerTrampoline64)(CGDisplayStreamFrameStatus arg0, uint64_t arg1, struct __IOSurface * arg2, struct CGDisplayStreamUpdate * arg3);
_ListenerTrampoline64 _MapLibreFFi_wrapListenerBlock_du1izn(_ListenerTrampoline64 block) NS_RETURNS_RETAINED {
  return ^void(CGDisplayStreamFrameStatus arg0, uint64_t arg1, struct __IOSurface * arg2, struct CGDisplayStreamUpdate * arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3);
  };
}

typedef void  (^_ListenerTrampoline65)(struct __CFArray * arg0);
_ListenerTrampoline65 _MapLibreFFi_wrapListenerBlock_9fms3g(_ListenerTrampoline65 block) NS_RETURNS_RETAINED {
  return ^void(struct __CFArray * arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_ListenerTrampoline66)(double arg0, long arg1, BOOL arg2, BOOL * arg3);
_ListenerTrampoline66 _MapLibreFFi_wrapListenerBlock_132rcs6(_ListenerTrampoline66 block) NS_RETURNS_RETAINED {
  return ^void(double arg0, long arg1, BOOL arg2, BOOL * arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3);
  };
}

Protocol* _MapLibreFFi_CTAdaptiveImageProviding() { return @protocol(CTAdaptiveImageProviding); }

typedef void  (^_ListenerTrampoline67)(size_t arg0, struct CGImage * arg1, BOOL * arg2);
_ListenerTrampoline67 _MapLibreFFi_wrapListenerBlock_11t2oft(_ListenerTrampoline67 block) NS_RETURNS_RETAINED {
  return ^void(size_t arg0, struct CGImage * arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

Protocol* _MapLibreFFi_PDEPlugIn() { return @protocol(PDEPlugIn); }

typedef void  (^_ListenerTrampoline68)(void * arg0, BOOL arg1);
_ListenerTrampoline68 _MapLibreFFi_wrapListenerBlock_10lndml(_ListenerTrampoline68 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, BOOL arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

Protocol* _MapLibreFFi_PDEPanel() { return @protocol(PDEPanel); }

Protocol* _MapLibreFFi_PDEPlugInCallbackProtocol() { return @protocol(PDEPlugInCallbackProtocol); }

typedef void  (^_ListenerTrampoline69)(BOOL arg0, id arg1);
_ListenerTrampoline69 _MapLibreFFi_wrapListenerBlock_nfe7yr(_ListenerTrampoline69 block) NS_RETURNS_RETAINED {
  return ^void(BOOL arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1));
  };
}

Protocol* _MapLibreFFi_AVAudioSessionDelegate() { return @protocol(AVAudioSessionDelegate); }

typedef void  (^_ListenerTrampoline70)(void * arg0, id arg1, BOOL arg2);
_ListenerTrampoline70 _MapLibreFFi_wrapListenerBlock_viyv67(_ListenerTrampoline70 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, BOOL arg2) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1), arg2);
  };
}

Protocol* _MapLibreFFi_AVAudioPlayerDelegate() { return @protocol(AVAudioPlayerDelegate); }
