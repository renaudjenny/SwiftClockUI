import XCTest
@testable import SwiftClockUI
import SwiftUI

class CGPointExtensionCircleTests: XCTestCase {
    func testCGPointExtensionPointInCircleFromAngleZero() {
        let diameter: CGFloat = 100
        let angle = Angle(degrees: 0)
        let expectedPoint = CGPoint(x: diameter/2, y: 0)

        let pointInCircleFromAngle: CGPoint = .pointInCircle(from: angle, diameter: diameter)
        XCTAssertEqual(expectedPoint.x, pointInCircleFromAngle.x, accuracy: 0.01)
        XCTAssertEqual(expectedPoint.y, pointInCircleFromAngle.y, accuracy: 0.01)
    }

    func testCGPointExtensionPointInCircleFromAngleNinetyDegrees() {
        let diameter: CGFloat = 100
        let angle = Angle(degrees: 90)
        let expectedPoint = CGPoint(x: diameter, y: diameter/2)

        let pointInCircleFromAngle: CGPoint = .pointInCircle(from: angle, diameter: diameter)
        XCTAssertEqual(expectedPoint.x, pointInCircleFromAngle.x, accuracy: 0.01)
        XCTAssertEqual(expectedPoint.y, pointInCircleFromAngle.y, accuracy: 0.01)
    }

    func testCGPointExtensionPointInCircleFromAngleTwoHundredSeventyDegrees() {
        let diameter: CGFloat = 100
        let angle = Angle(degrees: 270)
        let expectedPoint = CGPoint(x: 0, y: diameter/2)

        let pointInCircleFromAngle: CGPoint = .pointInCircle(from: angle, diameter: diameter)
        XCTAssertEqual(expectedPoint.x, pointInCircleFromAngle.x, accuracy: 0.01)
        XCTAssertEqual(expectedPoint.y, pointInCircleFromAngle.y, accuracy: 0.01)
    }

    func testCGPointExtensionPointInCircleFromAngleFortyFiveDegrees() {
        let diameter: CGFloat = 100
        let angle = Angle(degrees: 45)

        // https://stackoverflow.com/questions/839899/how-do-i-calculate-a-point-on-a-circle-s-circumference
        // The parametric equation for a circle is
        // https://en.wikipedia.org/wiki/Circle#Equations
        // x = originX + radius * cos(angle)
        // y = originY + radius * sin(angle)
        let originX = 50.0
        let originY = 50.0

        let radius = 50.0

        let cosAngle = cos(angle.radians - Double.pi/2)
        let sinAngle = sin(angle.radians - Double.pi/2)

        let expectedPoint = CGPoint(
            x: originX + radius * cosAngle,
            y: originY + radius * sinAngle
        )

        let pointInCircleFromAngle: CGPoint = .pointInCircle(from: angle, diameter: diameter)
        XCTAssertEqual(expectedPoint.x, pointInCircleFromAngle.x, accuracy: 0.01)
        XCTAssertEqual(expectedPoint.y, pointInCircleFromAngle.y, accuracy: 0.01)
    }

    func testCGPointExtensionPointInCircleFromAngleFortyFiveDegreesWithMargin() {
        let diameter: CGFloat = 100
        let margin: CGFloat = 15.0
        let angle = Angle(degrees: 45)

        // https://stackoverflow.com/questions/839899/how-do-i-calculate-a-point-on-a-circle-s-circumference
        // The parametric equation for a circle is
        // https://en.wikipedia.org/wiki/Circle#Equations
        // x = originX + radius * cos(angle)
        // y = originY + radius * sin(angle)
        let originX = 50.0
        let originY = 50.0

        let radius = 50.0 - Double(margin)

        let cosAngle = cos(angle.radians - Double.pi/2)
        let sinAngle = sin(angle.radians - Double.pi/2)

        let expectedPoint = CGPoint(
            x: originX + radius * cosAngle,
            y: originY + radius * sinAngle
        )

        let pointInCircleFromAngle: CGPoint = .pointInCircle(from: angle, diameter: diameter, margin: margin)
        XCTAssertEqual(expectedPoint.x, pointInCircleFromAngle.x, accuracy: 0.01)
        XCTAssertEqual(expectedPoint.y, pointInCircleFromAngle.y, accuracy: 0.01)
    }
}
