@objc protocol RaceTrackObservable {
    func raceCarsDidMove(distancesForIdentifiers: [String: Float])
}

class RaceTrack: NSObject {

    let raceCars: [FFRacecar]
    weak var observer: RaceTrackObservable?
    fileprivate var timer: Timer?

    init(raceCars: [FFRacecar], observer: RaceTrackObservable) {
        self.raceCars = raceCars
        self.observer = observer
    }

    func startRace() {
        timer = Timer(timeInterval: 1.0,
                      target: self,
                      selector: #selector(updateDistances),
                      userInfo: nil,
                      repeats: true)
        timer?.fire()
    }

    func endRace() {
        timer?.invalidate()
        timer = nil
    }

    @objc fileprivate func updateDistances() {
        var distancesForIdentifiers = [String: Float]()
        for car in raceCars {
            distancesForIdentifiers[car.racecarID] = generateNewDistance(for: car)
        }
        observer?.raceCarsDidMove(distancesForIdentifiers: distancesForIdentifiers)
    }

    fileprivate func generateNewDistance(for car: FFRacecar) -> Float {

        enum VariabilityLevel: Float {
            case low = 0.9
            case med = 0.8
            case high = 0.7

            static func randomVariability() -> VariabilityLevel {
                switch arc4random_uniform(10) {
                case 0...3: return .high
                case 4...7: return .med
                case 8...9: return .low
                default: return .high
                }
            }
        }

        return car.topSpeed / 10
            * car.durability / 100
            * VariabilityLevel.randomVariability().rawValue
    }
}
