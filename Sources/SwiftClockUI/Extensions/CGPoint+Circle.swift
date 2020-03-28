import SwiftUI

extension CGPoint {
    static func inCircle(_ circle: CGRect, for angle: Angle, margin: CGFloat = 0.0) -> Self {
        let radians = CGFloat(angle.radians) - .pi/2
        return CGPoint(
            x: circle.midX + (circle.radius - margin) * cos(radians),
            y: circle.midY + (circle.radius - margin) * sin(radians)
        )
    }
}

// TODO: this extension shouldn't be in this file
extension Angle {
    // TODO: add unit tests
    static func inCircle(for point: CGPoint, circleCenter: CGPoint) -> Self {
        Angle(radians: Double(atan2(
            point.y - circleCenter.y,
            point.x - circleCenter.x
        )))
    }
}
