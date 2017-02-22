#import "FFRacecar.h"

@implementation FFRacecar

@synthesize topSpeed = _topSpeed;
@synthesize durability = _durability;
@synthesize racecarID = _racecarID;

- (instancetype)initWithTopSpeed:(float)topSpeed durability:(float)durablility {

    self = [super init];
    if (self) {
        _topSpeed = topSpeed;
        _durability = durablility;
        _racecarID = [NSUUID UUID].UUIDString;
    }
    return self;
}

- (float)getTopSpeed
{
    return _topSpeed;
}

- (float)getDurability
{
    return _durability;
}

- (NSString *)getRacecarID
{
    return _racecarID;
}

@end
