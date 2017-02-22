@objc protocol RaceTrackObservable {
    func raceCarsDidMove(distancesForIdentifiers: [String: Float])
}

class RaceTrack: NSObject {

    enum RaceStatus {
        case unstarted
        case started
        case ended
    }

    let raceCars: [FFRaceable]
    let trackLength: Float
    weak var observer: RaceTrackObservable?
    fileprivate var timer: Timer?
    fileprivate var distancesForIdentifiers: [String: Float] = [:]
    fileprivate var status: RaceStatus = .unstarted

    init(raceCars: [FFRacecar], trackLength: Float, observer: RaceTrackObservable) {
        self.raceCars = raceCars
        self.trackLength = trackLength
        self.observer = observer
        super.init()
        reset()
    }

    func startRace() {
        timer = Timer.scheduledTimer(timeInterval: 0.15,
                                     target: self,
                                     selector: #selector(updateDistances),
                                     userInfo: nil,
                                     repeats: true)
        status = .started
    }

    func endRace() {
        status = .ended
        timer?.invalidate()
        timer = nil
    }

    var winnerExists: Bool {
        return !distancesForIdentifiers.values
            .filter { $0 >= self.trackLength }
            .isEmpty
    }

    var winnersIdentifier: String? {
        guard winnerExists else { return nil }
        return distancesForIdentifiers.map { $0 }
            .filter { $0.value >= self.trackLength }
            .sorted { $0.1 < $1.1 }
            .first?
            .key
    }

    @objc fileprivate func updateDistances() {
        guard status != .ended else { return }

        for car in raceCars {
            guard let currentDistance = distancesForIdentifiers[car.racecarID]
                else { fatalError("Distances should exist for all cars") }
            distancesForIdentifiers[car.racecarID] = generateNewDistance(for: car) + currentDistance
        }

        if winnerExists {
            endRace()
        }

        observer?.raceCarsDidMove(distancesForIdentifiers: distancesForIdentifiers)
    }

    func reset() {
        if status == .started {
            endRace()
        }
        status = .unstarted

        distancesForIdentifiers.removeAll(keepingCapacity: true)
        for car in raceCars {
            distancesForIdentifiers[car.racecarID] = 0
        }
    }

    fileprivate func generateNewDistance(for car: FFRaceable) -> Float {

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
