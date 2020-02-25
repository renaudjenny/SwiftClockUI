import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        ("ClockTests", ClockTests),
        ("ArmTests", ArmTests),
        ("ClockFaceTests", ClockFaceTests),
        ("EyeTests", EyeTests),
        ("MouthTests", MouthTests),
    ]
}
#endif
