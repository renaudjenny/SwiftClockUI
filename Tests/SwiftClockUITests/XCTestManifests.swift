import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        ("ClockTests", ClockTests),
        ("ArmTests", ArmTests),
        ("ClockFaceTests", ClockFaceTests),
        ("EyeTests", EyeTests),
        ("MouthTests", MouthTests),
        // TODO: Add tests for extensions. Could copy them from telltime project
    ]
}
#endif
