import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class PathExtensionCircleTests: XCTestCase {
    #if !os(macOS)
    func testCenter() {
        let circles = CirclesTest()
            .stroke()
            .padding()
        assertSnapshot(matching: circles, as: .default)
    }
    #endif

    struct CirclesTest: Shape {
        func path(in rect: CGRect) -> Path {
            let radius = rect.radius * 1/3
            let firstCircleCenter = CGPoint(x: rect.minX + radius, y: rect.midY)
            let secondCircleCenter = CGPoint(x: rect.maxX - radius, y: rect.midY)
            let thirdCircleCenter = CGPoint(x: rect.midX, y: rect.midY - radius * 2)

            var path = Path()
            path.addCircle(CGRect.circle(center: firstCircleCenter, radius: radius))
            path.addCircle(CGRect.circle(center: secondCircleCenter, radius: radius))
            path.addCircle(CGRect.circle(center: thirdCircleCenter, radius: radius))
            return path
        }
    }
}
