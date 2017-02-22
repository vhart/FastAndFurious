#import <Foundation/Foundation.h>

@protocol FFRaceable

@property (nonatomic, readonly) float topSpeed;
@property (nonatomic, readonly) float durability;
@property (nonatomic, readonly) NSString *racecarID;

@end

@interface FFRacecar : NSObject <FFRaceable>

- (instancetype)initWithTopSpeed:(float)topSpeed
                      durability:(float)durablility;

@end
