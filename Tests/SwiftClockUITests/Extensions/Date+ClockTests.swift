import XCTest
@testable import SwiftClockUI
import SwiftUI

class DateExtensionClockTests: XCTestCase {
    func testDateHourAngle() {
        let date = Date(hour: 2, minute: 0, calendar: .test)
        XCTAssertEqual(Angle(degrees: 60), date.hourAngle(calendar: .test))
    }

    func testDateHourAngleWithSomeMinutes() {
        let date = Date(hour: 2, minute: 10, calendar: .test)
        XCTAssertEqual(Angle(degrees: 65), date.hourAngle(calendar: .test))
    }

    func testDateMinuteAngle() {
        let date = Date(hour: 0, minute: 10, calendar: .test)
        XCTAssertEqual(Angle(degrees: 60), date.minuteAngle(calendar: .test))
    }

    func testDateMinuteWithLargeAngle() {
        let date = Date(hour: 10, minute: 45, calendar: .test)
        XCTAssertEqual(Angle(degrees: 270), date.minuteAngle(calendar: .test))
    }

    func testSetDateHour() {
        var date = Date(hour: 10, minute: 10, calendar: .test)
        date.setHour(angle: Angle(degrees: 30), calendar: .test)

        let calendar: Calendar = .test
        XCTAssertEqual(1, calendar.component(.hour, from: date))
    }

    func testSetDateMinute() {
        var date = Date(hour: 10, minute: 10, calendar: .test)
        date.setMinute(angle: Angle(degrees: 18), calendar: .test)

        let calendar: Calendar = .test
        XCTAssertEqual(3, calendar.component(.minute, from: date))
    }

    func testInitDateWithHourAndMinute() {
        let date = Date(hour: 1, minute: 11, calendar: .test)
        let expectedDate = Date(timeIntervalSince1970: 4300)

        let calendar: Calendar = .test
        let expectedHour = calendar.component(.hour, from: expectedDate)
        let expectedMinute = calendar.component(.minute, from: expectedDate)

        XCTAssertEqual(expectedHour, calendar.component(.hour, from: date))
        XCTAssertEqual(expectedMinute, calendar.component(.minute, from: date))
    }
}
