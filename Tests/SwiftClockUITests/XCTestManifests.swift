import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    [
        ("ClockTests", ClockTests),
        ("ArmTests", ArmTests),
        ("ClockFaceTests", ClockFaceTests),
        ("EyeTests", EyeTests),
        ("MouthTests", MouthTests),
        ("EnvironmentTests", EnvironmentTests),
        ("CGPointExtensionCircleTests", CGPointExtensionCircleTests),
        ("DateExtensionClockTests", DateExtensionClockTests),
    ]
}
#endif
