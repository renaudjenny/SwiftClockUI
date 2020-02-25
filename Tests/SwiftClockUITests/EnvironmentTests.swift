import XCTest
@testable import SwiftClockUI

class EnvironmentTests: XCTestCase {
    func testClockStyleDescription() {
        XCTAssertEqual(ClockStyle.classic.description, "Classic")
        XCTAssertEqual(ClockStyle.artNouveau.description, "Art Nouveau")
        XCTAssertEqual(ClockStyle.drawing.description, "Drawing")
    }

    func testClockStyleIdentifier() {
        XCTAssertEqual(ClockStyle.classic.id, 0)
        XCTAssertEqual(ClockStyle.artNouveau.id, 1)
        XCTAssertEqual(ClockStyle.drawing.id, 2)
    }
}
