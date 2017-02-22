#import "FFRaceTrackViewController.h"
#import "FFRaceCar.h"
#import "FastAndFurious-Swift.h"

float const trackLength = 200;

@interface FFRaceTrackViewController () <RaceTrackObservable>

@property (nonatomic, strong) RaceTrack *raceTrack;
@property (nonatomic, strong) NSArray<NSString *> *racecarIdentifiers;
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
    [self setUpRacecarIdentifiersWithCars:raceCars];
    self.raceTrack = [[RaceTrack alloc] initWithRaceCars:raceCars
                                                      observer:self];
}

- (void)setUpRacecarIdentifiersWithCars:(NSArray <FFRacecar *> *)cars {
    NSMutableArray <NSString *> *identifiers = [NSMutableArray new];
    for (FFRacecar *car in cars) {
        [identifiers addObject:car.racecarID];
    }
    self.racecarIdentifiers = identifiers.copy;
}

- (void)setUpRacecarViews {
    float currentY = 20;
    NSMutableDictionary<NSString *, UIView *> *viewsForIdentifiers = [NSMutableDictionary new];

    for (NSString *identifier in self.racecarIdentifiers) {
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
        }
    }];

}

@end
