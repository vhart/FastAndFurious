# FastAndFurious

An obj-c app, with some swift components, meant to be used as an obj-c primer for Access Code 3.2.

## At your own pace
- Refactor the `FFRaceable` protocol so that it includes `generateNewDistance` method.
- Consider adding a `traveledDistance` property to `FFRaceable`.
- Move the distance generating out of `RaceTrack` and have the `FFRacecar` be responsible for generating distances and tracking distances.
- The generating of new distances could go in a `swift extension` of `FFRacecar`
- If the `FFRacecar` contains the running total for distance travelled, then the `RaceTrack` can pass back `[FFRaceable]` rather than a `[String: Float]` dictionary.
- The view controller can then drop its `[String: FFRacecar]` dictionary.
- Move the finish line view to its own subclass of `UIView` (in obj-c)
- Place a `START` label behind the starting line and rotate it 90 degrees. 
- The views use auto-layout and only allow the app to run in landscape.
