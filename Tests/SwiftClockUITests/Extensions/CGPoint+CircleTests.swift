import XCTest
@testable import SwiftClockUI
import SwiftUI

class CGPointExtensionCircleTests: XCTestCase {
    func testCGPointExtensionPointInCircleFromAngleZero() {
        let circle = CGRect.circle(center: .zero, radius: 50)
        let angle = Angle(degrees: 0)
        let expectedPoint = CGPoint(x: circle.midX, y: circle.minY)

        let pointInCircleFromAngle = CGPoint.inCircle(circle, for: angle)
        XCTAssertEqual(expectedPoint.x, pointInCircleFromAngle.x, accuracy: 0.01)
        XCTAssertEqual(expectedPoint.y, pointInCircleFromAngle.y, accuracy: 0.01)
    }

    func testCGPointExtensionPointInCircleFromAngleNinetyDegrees() {
        let circle = CGRect.circle(center: .zero, radius: 50)
        let angle = Angle(degrees: 90)
        let expectedPoint = CGPoint(x: circle.maxX, y: circle.midY)

        let pointInCircleFromAngle = CGPoint.inCircle(circle, for: angle)
        XCTAssertEqual(expectedPoint.x, pointInCircleFromAngle.x, accuracy: 0.01)
        XCTAssertEqual(expectedPoint.y, pointInCircleFromAngle.y, accuracy: 0.01)
    }

    func testCGPointExtensionPointInCircleFromAngleTwoHundredSeventyDegrees() {
        let circle = CGRect.circle(center: .zero, radius: 50)
        let angle = Angle(degrees: 270)
        let expectedPoint = CGPoint(x: circle.minX, y: circle.midY)

        let pointInCircleFromAngle = CGPoint.inCircle(circle, for: angle)
        XCTAssertEqual(expectedPoint.x, pointInCircleFromAngle.x, accuracy: 0.01)
        XCTAssertEqual(expectedPoint.y, pointInCircleFromAngle.y, accuracy: 0.01)
    }

    func testCGPointExtensionPointInCircleFromAngleFortyFiveDegrees() {
        let circle = CGRect.circle(center: .zero, radius: 50)
        let angle = Angle(degrees: 45)

        // https://stackoverflow.com/questions/839899/how-do-i-calculate-a-point-on-a-circle-s-circumference
        // The parametric equation for a circle is
        // https://en.wikipedia.org/wiki/Circle#Equations
        // x = originX + radius * cos(angle)
        // y = originY + radius * sin(angle)

        let radians = CGFloat(angle.radians)  - .pi/2
        let cosAngle = cos(radians)
        let sinAngle = sin(radians)

        let expectedPoint = CGPoint(
            x: circle.midX + circle.radius * cosAngle,
            y: circle.midY + circle.radius * sinAngle
        )

        let pointInCircleFromAngle = CGPoint.inCircle(circle, for: angle)
        XCTAssertEqual(expectedPoint.x, pointInCircleFromAngle.x, accuracy: 0.01)
        XCTAssertEqual(expectedPoint.y, pointInCircleFromAngle.y, accuracy: 0.01)
    }

    func testCGPointExtensionPointInCircleFromAngleFortyFiveDegreesWithMargin() {
        let circle = CGRect.circle(center: .zero, radius: 50)
        let margin: CGFloat = 15.0
        let angle = Angle(degrees: 45)

        // https://stackoverflow.com/questions/839899/how-do-i-calculate-a-point-on-a-circle-s-circumference
        // The parametric equation for a circle is
        // https://en.wikipedia.org/wiki/Circle#Equations
        // x = originX + radius * cos(angle)
        // y = originY + radius * sin(angle)

        let radians = CGFloat(angle.radians) - .pi/2
        let cosAngle = cos(radians)
        let sinAngle = sin(radians)

        let expectedPoint = CGPoint(
            x: circle.midX + (circle.radius - margin) * cosAngle,
            y: circle.midY + (circle.radius - margin) * sinAngle
        )

        let pointInCircleFromAngle = CGPoint.inCircle(circle, for: angle, margin: margin)
        XCTAssertEqual(expectedPoint.x, pointInCircleFromAngle.x, accuracy: 0.01)
        XCTAssertEqual(expectedPoint.y, pointInCircleFromAngle.y, accuracy: 0.01)
    }

    func testCGPointExtensionPointInCircleFromAngleFortyFiveDegreesWithMarginRecentered() {
        let decenteredCenter = CGPoint(x: 20, y: 30)
        let circle = CGRect.circle(center: decenteredCenter, radius: 50)
        let margin: CGFloat = 15.0
        let angle = Angle(degrees: 45)

        // https://stackoverflow.com/questions/839899/how-do-i-calculate-a-point-on-a-circle-s-circumference
        // The parametric equation for a circle is
        // https://en.wikipedia.org/wiki/Circle#Equations
        // x = originX + radius * cos(angle)
        // y = originY + radius * sin(angle)

        let radians = CGFloat(angle.radians) - .pi/2
        let cosAngle = cos(radians)
        let sinAngle = sin(radians)

        let expectedPoint = CGPoint(
            x: circle.midX + (circle.radius - margin) * cosAngle,
            y: circle.midY + (circle.radius - margin) * sinAngle
        )

        let pointInCircleFromAngle = CGPoint.inCircle(circle, for: angle, margin: margin)
        XCTAssertEqual(expectedPoint.x, pointInCircleFromAngle.x, accuracy: 0.01)
        XCTAssertEqual(expectedPoint.y, pointInCircleFromAngle.y, accuracy: 0.01)
    }
}
