#import <Foundation/Foundation.h>
#import <MapLibre/MapLibre.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapLibreRegistry : NSObject

// Method to get the map for a given viewId
+ (nullable MLNMapView *)getMapWithViewId:(int64_t)viewId;

// Method to add a map to the registry
+ (void)addMapWithViewId:(int64_t)viewId map:(MLNMapView *)map;

// Warning: Storing Activity in a static field may lead to memory leaks.
@property (class, nonatomic, strong, nullable) id activity;

// Warning: Storing Context in a static field may lead to memory leaks.
@property (class, nonatomic, strong, nullable) id context;

@end

NS_ASSUME_NONNULL_END
