#import <Foundation/Foundation.h>

@protocol FFRaceable <NSObject>

@property (nonatomic, readonly) float topSpeed;
@property (nonatomic, readonly) float durability;
@property (nonatomic, readonly) NSString *racecarID;

@end
