#import <Foundation/Foundation.h>
#import "MapLibreRegistry.h"

@implementation MapLibreRegistry

static NSMutableDictionary<NSNumber *, MLNMapView *> *mapRegistry;
static id _activity;
static id _context;

// Initialize the static map registry
+ (void)initialize {
    if (self == [MapLibreRegistry class]) {
        mapRegistry = [NSMutableDictionary dictionary];
    }
}

// Method to get the map for a given viewId
+ (nullable MLNMapView *)getMapWithViewId:(int64_t)viewId {
    return mapRegistry[@(viewId)];
}

// Method to add a map to the registry
+ (void)addMapWithViewId:(int64_t)viewId map:(MLNMapView *)map {
    mapRegistry[@(viewId)] = map;
}

// Getter and Setter for activity
+ (id)activity {
    return _activity;
}

+ (void)setActivity:(id)activity {
    _activity = activity;
}

// Getter and Setter for context
+ (id)context {
    return _context;
}

+ (void)setContext:(id)context {
    _context = context;
}

@end
