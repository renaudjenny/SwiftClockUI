import XCTest
@testable import SwiftClockUI
import SwiftUI

class ArmTypeTests: XCTestCase {
    func testSetHourAngle() {
        var date = Date(timeIntervalSince1970: 4300)
        XCTAssertEqual(1, Calendar.test.component(.hour, from: date))

        let angle = Angle(degrees: .hourInDegree * 4)

        ArmType.hour.setAngle(angle, date: &date, calendar: .test)

        XCTAssertEqual(4, Calendar.test.component(.hour, from: date))
    }

    func testSetMinuteAngle() {
        var date = Date(timeIntervalSince1970: 4300)
        XCTAssertEqual(11, Calendar.test.component(.minute, from: date))

        let angle = Angle(degrees: .minuteInDegree * 25)

        ArmType.minute.setAngle(angle, date: &date, calendar: .test)

        XCTAssertEqual(25, Calendar.test.component(.minute, from: date))
    }
}
