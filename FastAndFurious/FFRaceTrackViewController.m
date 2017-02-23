#import "FFRaceTrackViewController.h"
#import "FFRaceCar.h"

/*
 Constants
*/

@interface FFRaceTrackViewController () <RaceTrackObservable>

@property (nonatomic, strong) RaceTrack *raceTrack;
@property (nonatomic, strong) NSDictionary<NSString *, FFRacecar *> *racecarsForIdentifiers;
@property (nonatomic, strong) NSDictionary<NSString *, UIView *> *viewsForIdentifiers;

@end

@implementation FFRaceTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

// set up race track


// set up race cars for identifiers with: (FFRacecars)

- (void)setUpStartingLine {
    NSInteger numberOfCars = self.racecarsForIdentifiers.count;
    float lineLength = carLength * numberOfCars + (numberOfCars - 1) * laneSpacer;
    UIView *line = [[UIView alloc] initWithFrame:
                    CGRectMake(carLength, startingYValue, startingLineWidth, lineLength)];
    [line setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:line];
}

// Set Up Finish line

- (void)setUpRacecarViews {
    float currentY = startingYValue;
    NSMutableDictionary<NSString *, UIView *> *viewsForIdentifiers = [NSMutableDictionary new];

    for (NSString *identifier in self.racecarsForIdentifiers.allKeys) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, currentY, carLength, carLength)];
        [view setBackgroundColor:[UIColor redColor]];
        viewsForIdentifiers[identifier] = view;
        [self.view addSubview:view];

        currentY += (carLength + laneSpacer);
    }

    self.viewsForIdentifiers = viewsForIdentifiers.copy;
}

- (void)removeRacecarViews {
    for (UIView *view in self.viewsForIdentifiers.allValues) {
        [view removeFromSuperview];
    }
    self.viewsForIdentifiers = nil;
}

// MARK: RaceTrackObservable

@end
