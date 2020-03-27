import XCTest
@testable import SwiftClockUI
import SwiftUI

class CGRectExtensionCircleTests: XCTestCase {
    func testCenter() {
        let center = CGPoint(x: 30, y: 30)
        let circle = CGRect.circle(center: center, radius: 60)
        XCTAssertEqual(circle.center, center)
    }

    func testRadius() {
        let radius: CGFloat = 60
        let circle = CGRect.circle(center: CGPoint(x: 30, y: 30), radius: radius)
        XCTAssertEqual(circle.radius, radius)
    }
}
