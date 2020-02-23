import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        ("ClockTests", ClockTests),
    ]
}
#endif

// TODO: Import all Clock related tests from telltime
