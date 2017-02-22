#import "FFRaceTrackViewController.h"
#import "FFRaceCar.h"
#import "FastAndFurious-Swift.h"

float const trackLength = 100;

@interface FFRaceTrackViewController () <RaceTrackObservable>

@property (nonatomic, strong) RaceTrack *raceTrack;
@property (nonatomic, strong) NSDictionary<NSString *, FFRacecar *> *racecarsForIdentifiers;
@property (nonatomic, strong) NSDictionary<NSString *, UIView *> *viewsForIdentifiers;

@end

@implementation FFRaceTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpRaceTrack];
    [self setUpRacecarViews];
    [self.raceTrack startRace];
}

- (void)setUpRaceTrack {
    NSArray <FFRacecar *> *raceCars = @[
                                       [[FFRacecar alloc] initWithTopSpeed:130 durability:75],
                                       [[FFRacecar alloc] initWithTopSpeed:150 durability:60],
                                       [[FFRacecar alloc] initWithTopSpeed:140 durability:80]
                                       ];
    [self setUpRacecarsForIdentifiersWithCars:raceCars];
    self.raceTrack = [[RaceTrack alloc] initWithRaceCars:raceCars
                                                      observer:self];
}

- (void)setUpRacecarsForIdentifiersWithCars:(NSArray <FFRacecar *> *)cars {
    NSMutableDictionary <NSString *, FFRacecar *> *carsForId = [NSMutableDictionary new];
    for (FFRacecar *car in cars) {
        carsForId[car.racecarID] = car;
    }
    self.racecarsForIdentifiers = carsForId.copy;
}

- (void)setUpRacecarViews {
    float currentY = 100;
    NSMutableDictionary<NSString *, UIView *> *viewsForIdentifiers = [NSMutableDictionary new];

    for (NSString *identifier in self.racecarsForIdentifiers.allKeys) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, currentY, 50, 50)];
        [view setBackgroundColor:[UIColor redColor]];
        viewsForIdentifiers[identifier] = view;
        [self.view addSubview:view];

        currentY += 60;
    }

    self.viewsForIdentifiers = viewsForIdentifiers.copy;
}

// MARK: RaceTrackObservable
- (void)raceCarsDidMoveWithDistancesForIdentifiers:(NSDictionary<NSString *,NSNumber *> *)distancesForIdentifiers {

    [UIView animateWithDuration:.2 animations:^{
        for (NSString *identifier in distancesForIdentifiers.allKeys) {
            UIView *view = self.viewsForIdentifiers[identifier];
            float distanceTraveled = distancesForIdentifiers[identifier].floatValue;
            float xIncrease = distanceTraveled / trackLength * self.view.frame.size.width;
            CGPoint newOrigin = CGPointMake(view.frame.origin.x + xIncrease,
                                            view.frame.origin.y);
            view.frame = CGRectMake(newOrigin.x
                                    ,newOrigin.y,
                                    view.frame.size.width,
                                    view.frame.size.height);

        }
    } completion:^(BOOL finished) {
        NSString *tentativeWinner = [self idForWinner];
        if (tentativeWinner) {
            [self.raceTrack endRace];
        }
    }];
}

- (NSString *)idForWinner {
    NSString *idOfFurthest;
    float furthestX = 0;
    for (NSString *identifier in self.viewsForIdentifiers.allKeys) {
        UIView *view = self.viewsForIdentifiers[identifier];
        float x = view.frame.origin.x;
        float finishLineXValue = self.view.frame.size.width - view.frame.size.width;
        if (x >= finishLineXValue && x >= furthestX) {
            idOfFurthest = identifier;
            furthestX = x;
        }
    }

    return idOfFurthest;
}

@end
